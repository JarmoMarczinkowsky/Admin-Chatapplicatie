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

    //start clearing the boxes
//    edtGroupName.Text := '';
//    edtGroupDescription.Text := '';
//    imgAddGroupProfile.Picture := nil;
//    cboxGroupOwner.ItemIndex := 0;

    //clears the added users list
//    slsbGroupAddedUsers.Items.Clear;
//    getPosAdmin := cboxGroupOwner.Items.IndexOf(DataModule2.pgqGetLoggedInUser.FieldByName('gbr_nicknaam').AsString);
//
//    if(getPosAdmin > -1) then
//    begin
//      amountOfItems := cboxGroupOwner.Items.Count;
//
//      for I := 1 to amountOfItems do
//      begin
//        if( i - 1 = getPosAdmin) then continue
//        else cboxGroupOwner.Items.Delete(i - 1);
//      end;
//    end;
//
//    lblAddGroupError.Font.Color := clGreen;
//    lblAddGroupError.Caption := 'Groep succesvol toegevoegd';

    //closes open tab when done
    Self.Close;
  end;
end;

procedure TfrmGroupAdd.AddUserToGroup(selectedGroupId: integer);
var
  pgqGroepsLeden, pgqCheckDuplicateUser: TPgQuery;
  i: integer;
//  addedUserLB: TAdvSmoothListBox;
  userIsDuplicate, deletedUserStatus: boolean;
begin
  deletedUserStatus := false;
  pgqGroepsLeden := TPgQuery.Create(nil);
  pgqCheckDuplicateUser := TPgQuery.Create(nil);

  pgqGroepsLeden.Connection := DataModule2.pgcDBconnection;
  pgqCheckDuplicateUser.Connection := DataModule2.pgcDBconnection;

  userIsDuplicate := false;


  pgqGroepsleden.SQL.Text := 'SELECT * FROM tbl_groepleden';
  pgqGroepsleden.Open;
  for I := 1 to slsbGroupAddedUsers.Items.Count do
  begin
    DataModule2.pgqCheckExistingUser.SQL.Text := '';
    DataModule2.pgqCheckExistingUser.SQL.Add('SELECT gbr_id FROM tbl_gebruikers');
    DataModule2.pgqCheckExistingUser.SQL.Add('WHERE LOWER(gbr_nicknaam)=:currentUser');
    DataModule2.pgqCheckExistingUser.ParamByName('currentUser').AsString := LowerCase(Trim(slsbGroupAddedUsers.Items[i - 1].Caption));
    DataModule2.pgqCheckExistingUser.Open;

    if(userIsDuplicate = true) then
    begin
      deletedUserStatus := pgqCheckDuplicateUser.FieldByName('grl_del').AsBoolean;
      if(deletedUserStatus = true) then
      begin
        pgqCheckDuplicateUser.Edit;
        pgqCheckDuplicateUser.FieldByName('grl_del').AsBoolean := false;
        pgqCheckDuplicateUser.Post;
      end;
    end
    else if(userIsDuplicate = false) then
    begin
      pgqGroepsleden.Append;
      pgqGroepsleden.FieldByName('grl_gebruiker').AsInteger := DataModule2.pgqCheckExistingUser.FieldByName('gbr_id').AsInteger;
      pgqGroepsleden.FieldByName('grl_groep').AsInteger := selectedGroupId;
      pgqGroepsleden.FieldByName('grl_aangemaakt').AsDateTime := now;
      pgqGroepsleden.FieldByName('grl_del').AsBoolean := false;
      pgqGroepsleden.Post;
    end;
  end;

  pgqCheckDuplicateUser.Free;
  pgqGroepsLeden.Free;
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
//  searchLB, addedUsersLB: TAdvSmoothListBox;
//  errorLBL: TLabel;
//  groupOwnerCBOX: TComboBox;
begin

//  if(commando = 'add') then
//  begin
//    searchLB := slsbUser;
//    addedUsersLB := slsbGroupAddedUsers;
//    errorLBL := lblAddGroupError;
//    groupOwnerCBOX := cboxGroupOwner;
//  end;

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

//      if(commando = 'edit') then
//      begin
//        editDuplicateLocation := RemovedUsersList.IndexOf(slsbUser.Items[slsbUser.SelectedItemIndex].Caption);
//
//        if(editDuplicateLocation > -1) then
//        begin
//          RemovedUsersList.Delete(editDuplicateLocation);
//        end;
//      end;
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

  searchQuery.Free;
end;

procedure TfrmGroupAdd.sbtnBackToGroupOverviewClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmGroupAdd.sbtnRemoveUserFromGroupClick(Sender: TObject);
var
  indexDeletedUser, editDuplicateLocation: integer;
  getText: string;
//  searchLB, addedUsersLB: TAdvSmoothListBox;
//  ownerCBOX: TComboBox;
begin
//  if(command = 'add') then
//  begin
//    searchLB := slsbUser;
//    addedUsersLB := slsbGroupAddedUsers;
//    ownerCBOX := cboxGroupOwner;
//  end;

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
