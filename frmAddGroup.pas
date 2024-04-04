unit frmAddGroup;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Data.DB,
  AdvSmoothListBox, AdvSmoothButton, MemDS, DBAccess, PgAccess;

type
  TfrmGroupAdd = class(TForm)
    Label2: TLabel;
    edtGroupName: TEdit;
    edtAddGroupSearchUser: TEdit;
    sbtnagSearchUser: TAdvSmoothButton;
    Label4: TLabel;
    edtGroupDescription: TEdit;
    slsbUser: TAdvSmoothListBox;
    sbtnAddUserToGroup: TAdvSmoothButton;
    Label5: TLabel;
    cboxGroupOwner: TComboBox;
    slsbGroupAddedUsers: TAdvSmoothListBox;
    sbtnRemoveUserFromGroup: TAdvSmoothButton;
    sbtnAddGroupProfile: TAdvSmoothButton;
    imgAddGroupProfile: TImage;
    Label13: TLabel;
    sbtnAddGroup: TAdvSmoothButton;
    sbtnBackToGroupOverview: TAdvSmoothButton;
    lblAddGroupError: TLabel;
    procedure FormShow(Sender: TObject);
    procedure sbtnBackToGroupOverviewClick(Sender: TObject);
    procedure sbtnAddGroupProfileClick(Sender: TObject);
    procedure sbtnAddGroupClick(Sender: TObject);
    procedure sbtnagSearchUserClick(Sender: TObject);
    procedure sbtnAddUserToGroupClick(Sender: TObject);
    procedure sbtnRemoveUserFromGroupClick(Sender: TObject);
  private
    { Private declarations }
    procedure AddUserToGroup(selectedGroupId: integer);
  public
    { Public declarations }
  end;

var
  frmGroupAdd: TfrmGroupAdd;

implementation
  uses DMdatabaseInfo;

{$R *.dfm}

procedure TfrmGroupAdd.FormShow(Sender: TObject);
var
  i: integer;
begin
  cboxGroupOwner.Items.Clear;
  slsbGroupAddedUsers.Items.Clear;
  edtGroupName.Text := '';
  edtGroupDescription.Text := '';
  edtAddGroupSearchUser.Text := '';
  imgAddGroupProfile.Picture := nil;

  frmGroupAdd.Left := (frmGroupAdd.Monitor.Width  - frmGroupAdd.Width)  div 2;
  frmGroupAdd.Top  := (frmGroupAdd.Monitor.Height - frmGroupAdd.Height) div 2;

  with DataModule2 do
  begin
    cboxGroupOwner.Items.Add(pgqGetLoggedInUser.FieldByName('gbr_nicknaam').AsString);
    cboxGroupOwner.ItemIndex := 0;

    if(slsbUser.Items.Count = 0) then
    begin
      pgqGetUsers.SQL.Text := 'SELECT * FROM tbl_gebruikers WHERE gbr_del = false ORDER BY gbr_nicknaam';
      pgqGetUsers.Open;

      for i := 1 to pgqGetUsers.RecordCount do
      begin
        with slsbUser.Items.Add do
        begin
          Caption := pgqGetUsers.FieldByName('gbr_nicknaam').AsString;
        end;

        pgqGetUsers.Next;
      end;
    end;
  end;

  lblAddGroupError.Caption := '';
end;

procedure TfrmGroupAdd.sbtnAddGroupClick(Sender: TObject);
var
  idLastCreatedGroup: integer;
  AStream: TMemoryStream;
//  BlobField: TBlobField;
//  getText: string;
//  getPosAdmin: integer;
begin
  lblAddGroupError.Font.Color := RGB(220, 20, 60);
  lblAddGroupError.Caption := '';

  with DataModule2 do
  begin
    if((Length(edtGroupName.Text) > 0)) then
    begin
      //gets the group owner associated by the name
      //so it can be used later for its id
      pgqCheckExistingUser.Close;
      if(pgqCheckExistingUser = nil) then
      begin
        pgqCheckExistingUser := TPgQuery.Create(nil);
        pgqCheckExistingUser.Connection := pgcDBconnection;
      end;
      pgqCheckExistingUser.SQL.Text := 'SELECT * FROM tbl_gebruikers WHERE gbr_nicknaam=:groupOwner';
      pgqCheckExistingUser.ParamByName('groupOwner').AsString := cboxGroupOwner.Text;
      pgqCheckExistingUser.Open;

      //prepares the sql statement to insert into groups table
      pgqGetGroups.SQL.Text := 'INSERT INTO tbl_groepen (gro_naam, gro_igenaar, gro_aangemaakt, gro_del, gro_beschrijving, gro_profielfoto)';
      pgqGetGroups.SQL.Add('VALUES (:groupName, :groupOwner, :groupCreated, :groupDeleted, :groupDescription, :groupProfilePicture)');
      pgqGetGroups.ParamByName('groupName').AsString := Trim(edtGroupName.Text);
      pgqGetGroups.ParamByName('groupOwner').AsInteger := StrToInt(Trim(pgqCheckExistingUser.FieldByName('gbr_id').AsString));
      pgqGetGroups.ParamByName('groupCreated').AsDateTime := now;
      pgqGetGroups.ParamByName('groupDeleted').AsBoolean := false;
      pgqGetGroups.ParamByName('groupDescription').AsString := Trim(edtGroupDescription.Text);

      //saves the image to a format that is used by the database
      AStream := TMemoryStream.Create;
      imgAddGroupProfile.Picture.SaveToStream(AStream);
      pgqGetGroups.ParamByName('groupProfilePicture').LoadFromStream(AStream, ftGraphic);

      //executes the insert sql statement and closes it to preserve memory
      pgqGetGroups.Execute;
      pgqGetGroups.Close;

      //gets last added group so it could be used for adding the group members to the correct table
      pgqGetGroups.SQL.Text := 'SELECT * FROM tbl_groepen ORDER BY gro_id DESC LIMIT 1';
      pgqGetGroups.Open;
      idLastCreatedGroup := pgqGetGroups.FieldByName('gro_id').AsInteger;
      pgqGetGroups.Close;

      //will add the user to the last added group
      AddUserToGroup(idLastCreatedGroup);

      //closes open tab when done
      Self.Close;
    end
    else lblAddGroupError.Caption := 'Vul een naam in in bij de groepsnaam';

  end;

end;

procedure TfrmGroupAdd.AddUserToGroup(selectedGroupId: integer);
var
  pgqGroepsLeden: TPgQuery;
  i: integer;
//  addedUserLB: TAdvSmoothListBox;
begin
  with DataModule2 do
  begin
    pgqGroepsLeden := TPgQuery.Create(nil);
    pgqGroepsLeden.Connection := pgcDBconnection;

    //loop through every user in bottom listbox
    for I := 1 to slsbGroupAddedUsers.Items.Count do
    begin
      //get user id from user table from the current user it is looping through
      //will be used later for adding to the group member table
      pgqCheckExistingUser.SQL.Text := '';
      pgqCheckExistingUser.SQL.Add('SELECT gbr_id FROM tbl_gebruikers');
      pgqCheckExistingUser.SQL.Add('WHERE LOWER(gbr_nicknaam)=:currentUser');
      pgqCheckExistingUser.ParamByName('currentUser').AsString := LowerCase(Trim(slsbGroupAddedUsers.Items[i - 1].Caption));
      pgqCheckExistingUser.Open;

      //inserts the group member into the table
      pgqGroepsLeden.SQL.Text := 'INSERT INTO tbl_groepleden (grl_gebruiker, grl_groep, grl_aangemaakt, grl_del)';
      pgqGroepsLeden.SQL.Add('VALUES (:userId, :groupId, :timeUserAdded, :groupMemberDeleted)');
      pgqGroepsleden.ParamByName('userId').AsInteger := pgqCheckExistingUser.FieldByName('gbr_id').AsInteger;
      pgqGroepsleden.ParamByName('groupId').AsInteger := selectedGroupId;
      pgqGroepsleden.ParamByName('timeUserAdded').AsDateTime := now;
      pgqGroepsleden.ParamByName('groupMemberDeleted').AsBoolean := false;
      pgqGroepsleden.Execute;
    end;

    if(pgqGroepsLeden.Active) then pgqGroepsLeden.Close;
    pgqCheckExistingUser.Close;
  end;

end;

procedure TfrmGroupAdd.sbtnAddGroupProfileClick(Sender: TObject);
begin
  with TOpenDialog.Create(self) do
    try
      Caption := 'Open afbeelding';
      Filter := 'Image Files (*.jpg;*.jpeg;*.png)|*.jpg;*.jpeg;*.png';
      Options := [TOpenOption.ofPathMustExist, TOpenOption.ofPathMustExist];
      if (Execute) then imgAddGroupProfile.Picture.LoadFromFile(FileName);

    finally
      Free;
    end;
end;

procedure TfrmGroupAdd.sbtnAddUserToGroupClick(Sender: TObject);
var
  temp: integer;
begin

  if(slsbUser.Items.CountSelected > 0) then
  begin
    temp := slsbGroupAddedUsers.Items.IndexOfCaption(slsbUser.Items[slsbUser.SelectedItemIndex].Caption);
    if(temp = -1) then
    begin
      with slsbGroupAddedUsers.Items.Add do
      begin
        Caption := slsbUser.Items[slsbUser.SelectedItemIndex].Caption;
      end;

      if(cboxGroupOwner.Items.IndexOf(slsbUser.Items[slsbUser.SelectedItemIndex].Caption) = -1) then
        cboxGroupOwner.Items.Add(slsbUser.Items[slsbUser.SelectedItemIndex].Caption);
    end
    else lblAddGroupError.Caption := 'Gebruiker al in lijst';
  end;
end;

procedure TfrmGroupAdd.sbtnagSearchUserClick(Sender: TObject);
var
  i: integer;
  searchQuery: TPgQuery;
begin
  lblAddGroupError.Caption := '';

  searchQuery := TPgQuery.Create(nil);
  searchQuery.Connection := DataModule2.pgcDBconnection;

  slsbUser.Items.Clear;
  searchQuery.SQL.Text := '';
  searchQuery.SQL.Add('SELECT * FROM tbl_gebruikers');
  if(Length(edtAddGroupSearchUser.Text) > 0) then
  begin
    searchQuery.SQL.Add('WHERE LOWER(gbr_nicknaam) LIKE :user');
    searchQuery.SQL.Add('OR LOWER(gbr_email)=:user');
    searchQuery.SQL.Add('OR LOWER(gbr_naam)=:user');
    searchQuery.SQL.Add('ORDER BY gbr_nicknaam');
    searchQuery.ParamByName('user').AsString := #37 + LowerCase(edtAddGroupSearchUser.Text) + #37;
  end
  else searchQuery.SQL.Add('ORDER BY gbr_nicknaam');
  searchQuery.Open;

  searchQuery.First;
  for i := 1 to searchQuery.RecordCount do
  begin
    with slsbUser.Items.Add do
    begin
      Caption := searchQuery.FieldByName('gbr_nicknaam').AsString;
      searchQuery.Next;
    end;
  end;

  searchQuery.Close;
end;

procedure TfrmGroupAdd.sbtnBackToGroupOverviewClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmGroupAdd.sbtnRemoveUserFromGroupClick(Sender: TObject);
var
  indexDeletedUser, i: integer;
  getText: string;
begin
  if(slsbGroupAddedUsers.Items.Count > 0) then
  begin
    if(slsbGroupAddedUsers.Items.CountSelected > 0) then
    begin
      getText := slsbGroupAddedUsers.Items[slsbGroupAddedUsers.SelectedItemIndex].Caption;
      indexDeletedUser := cboxGroupOwner.Items.IndexOf(getText);
    end;

    if(getText = cboxGroupOwner.Text) then
    begin
      for i := 1 to cboxGroupOwner.Items.Count do
      begin
        if(i - 1 <> indexDeletedUser) then
        begin
          cboxGroupOwner.ItemIndex := i - 1;
          break;
        end;
      end;
    end;

    slsbGroupAddedUsers.Items.Delete(slsbGroupAddedUsers.SelectedItemIndex);

    if(getText <> DataModule2.pgqGetLoggedInUser.FieldByName('gbr_nicknaam').AsString) then
      if(indexDeletedUser <> -1) then cboxGroupOwner.Items.Delete(indexDeletedUser);

  end;

end;

end.
