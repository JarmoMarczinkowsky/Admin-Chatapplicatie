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
    PgQuery1: TPgQuery;
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
  cboxGroupOwner.Items.Add(DataModule2.pgqGetLoggedInUser.FieldByName('gbr_nicknaam').AsString);
  cboxGroupOwner.ItemIndex := 0;

  with DataModule2 do
  begin
    if(pgqGetUsers.RecordCount < 1) then
    begin
      pgqGetUsers.SQL.Text := 'SELECT * FROM tbl_gebruikers ORDER BY gbr_nicknaam';
      pgqGetUsers.Open;
    end
    else
      pgqGetUsers.First;

    for i := 1 to pgqGetUsers.RecordCount do
    begin
      with slsbUser.Items.Add do
      begin
        Caption := pgqGetUsers.FieldByName('gbr_nicknaam').AsString;
      end;

      DataModule2.pgqGetUsers.Next;
    end;
  end;

  lblAddGroupError.Caption := '';
end;

procedure TfrmGroupAdd.sbtnAddGroupClick(Sender: TObject);
var
  i, idLastCreatedGroup, indexDeletedUser, amountOfItems: integer;
  AStream: TMemoryStream;
  BlobField: TBlobField;
  getText: string;
  getPosAdmin: integer;
begin
  lblAddGroupError.Font.Color := RGB(220, 20, 60);
  lblAddGroupError.Caption := '';

  if((Length(edtGroupName.Text) > 0)) then
  begin
    //gets the group owner associated by the name
    //so it can be used later for its id
    DataModule2.pgqCheckExistingUser.Close;
    if(DataModule2.pgqCheckExistingUser = nil) then
    begin
      DataModule2.pgqCheckExistingUser := TPgQuery.Create(nil);
      DataModule2.pgqCheckExistingUser.Connection := DataModule2.pgcDBconnection;
    end;
    DataModule2.pgqCheckExistingUser.SQL.Text := 'SELECT * FROM tbl_gebruikers WHERE gbr_nicknaam=:groupOwner';
    DataModule2.pgqCheckExistingUser.ParamByName('groupOwner').AsString := cboxGroupOwner.Text;
    DataModule2.pgqCheckExistingUser.Open;

    //prepares the sql statement to insert into groups table

    DataModule2.pgqGetGroups.SQL.Text := 'INSERT INTO tbl_groepen (gro_naam, gro_igenaar, gro_aangemaakt, gro_del, gro_beschrijving, gro_profielfoto)';
    DataModule2.pgqGetGroups.SQL.Add('VALUES (:groupName, :groupOwner, :groupCreated, :groupDeleted, :groupDescription, :groupProfilePicture)');
    DataModule2.pgqGetGroups.ParamByName('groupName').AsString := Trim(edtGroupName.Text);
    DataModule2.pgqGetGroups.ParamByName('groupOwner').AsInteger := StrToInt(Trim(DataModule2.pgqCheckExistingUser.FieldByName('gbr_id').AsString));
    DataModule2.pgqGetGroups.ParamByName('groupCreated').AsDateTime := now;
    DataModule2.pgqGetGroups.ParamByName('groupDeleted').AsBoolean := false;
    DataModule2.pgqGetGroups.ParamByName('groupDescription').AsString := Trim(edtGroupDescription.Text);

    //saves the image to a format that is used by the database
    AStream := TMemoryStream.Create;
    imgAddGroupProfile.Picture.SaveToStream(AStream);
    DataModule2.pgqGetGroups.ParamByName('groupProfilePicture').LoadFromStream(AStream, ftGraphic);

    //executes the insert sql statement and closes it to preserve memory
    DataModule2.pgqGetGroups.Execute;
    DataModule2.pgqGetGroups.Close;

    //gets last added group so it could be used for adding the group members to the correct table
    DataModule2.pgqGetGroups.SQL.Text := 'SELECT * FROM tbl_groepen ORDER BY gro_id DESC LIMIT 1';
    DataModule2.pgqGetGroups.Open;
    idLastCreatedGroup := DataModule2.pgqGetGroups.FieldByName('gro_id').AsInteger;
    DataModule2.pgqGetGroups.Close;

    //will add the user to the last added group
    AddUserToGroup(idLastCreatedGroup);

    //closes open tab when done
    Self.Close;
  end
  else lblAddGroupError.Caption := 'Vul een naam in in bij de groepsnaam';
end;

procedure TfrmGroupAdd.AddUserToGroup(selectedGroupId: integer);
var
  pgqGroepsLeden: TPgQuery;
  i: integer;
//  addedUserLB: TAdvSmoothListBox;
begin
  pgqGroepsLeden := TPgQuery.Create(nil);
  pgqGroepsLeden.Connection := DataModule2.pgcDBconnection;

  //loop through every user in bottom listbox
  for I := 1 to slsbGroupAddedUsers.Items.Count do
  begin
    //get user id from user table from the current user it is looping through
    //will be used later for adding to the group member table
    with DataModule2 do
    begin
      pgqCheckExistingUser.SQL.Text := '';
      pgqCheckExistingUser.SQL.Add('SELECT gbr_id FROM tbl_gebruikers');
      pgqCheckExistingUser.SQL.Add('WHERE LOWER(gbr_nicknaam)=:currentUser');
      pgqCheckExistingUser.ParamByName('currentUser').AsString := LowerCase(Trim(slsbGroupAddedUsers.Items[i - 1].Caption));
      pgqCheckExistingUser.Open;
    end;


    //inserts the group member into the table
    pgqGroepsLeden.SQL.Text := 'INSERT INTO tbl_groepleden (grl_gebruiker, grl_groep, grl_aangemaakt, grl_del)';
    pgqGroepsLeden.SQL.Add('VALUES (:userId, :groupId, :timeUserAdded, :groupMemberDeleted)');
    pgqGroepsleden.ParamByName('userId').AsInteger := DataModule2.pgqCheckExistingUser.FieldByName('gbr_id').AsInteger;
    pgqGroepsleden.ParamByName('groupId').AsInteger := selectedGroupId;
    pgqGroepsleden.ParamByName('timeUserAdded').AsDateTime := now;
    pgqGroepsleden.ParamByName('groupMemberDeleted').AsBoolean := false;
    pgqGroepsleden.Execute;
  end;

  if(pgqGroepsLeden.Active) then pgqGroepsLeden.Close;
  DataModule2.pgqCheckExistingUser.Close;
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
  i, temp, editDuplicateLocation: integer;
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

  if(not Assigned(searchQuery)) then
  begin
    searchQuery := TPgQuery.Create(nil);
    searchQuery.Connection := DataModule2.pgcDBconnection;
  end;

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
  indexDeletedUser, editDuplicateLocation: integer;
  getText: string;
begin
  if(slsbGroupAddedUsers.Items.CountSelected > 0) then
  begin
    getText := slsbGroupAddedUsers.Items[slsbGroupAddedUsers.SelectedItemIndex].Caption;
    indexDeletedUser := cboxGroupOwner.Items.IndexOf(getText);
  end;

  slsbGroupAddedUsers.Items.Delete(slsbGroupAddedUsers.SelectedItemIndex);

  if(getText <> DataModule2.pgqGetLoggedInUser.FieldByName('gbr_nicknaam').AsString) then
    if(indexDeletedUser <> -1) then cboxGroupOwner.Items.Delete(indexDeletedUser);
end;

end.
