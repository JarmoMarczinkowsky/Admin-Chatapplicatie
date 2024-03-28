unit frmEditGroup;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
  AdvSmoothListBox, AdvSmoothButton, MemDS, DBAccess, PgAccess;

type
  TfrmGroupEdit = class(TForm)
    Label15: TLabel;
    edtEditGroupName: TEdit;
    Label16: TLabel;
    edtEditGroupDescription: TEdit;
    edtEditGroupSearch: TEdit;
    sbtnEditSearchUser: TAdvSmoothButton;
    slsbEditAddUserToGroup: TAdvSmoothButton;
    slsbEditSearchUser: TAdvSmoothListBox;
    slsbEditGroupUsers: TAdvSmoothListBox;
    sbtnEditRemoveGroupUser: TAdvSmoothButton;
    imgEditGroupProfile: TImage;
    sbtnEditGroupProfilePicture: TAdvSmoothButton;
    cbxGroupDeleted: TCheckBox;
    cboxEditGroupOwner: TComboBox;
    Label17: TLabel;
    Label1: TLabel;
    Label14: TLabel;
    sbtnEditGroup: TAdvSmoothButton;
    sbtnEditGroupCancel: TAdvSmoothButton;
    lblEditGroupError: TLabel;
    procedure FormShow(Sender: TObject);
    procedure sbtnEditSearchUserClick(Sender: TObject);
    procedure slsbEditAddUserToGroupClick(Sender: TObject);
    procedure sbtnEditRemoveGroupUserClick(Sender: TObject);
    procedure sbtnEditGroupCancelClick(Sender: TObject);
    procedure sbtnEditGroupClick(Sender: TObject);
    procedure sbtnEditGroupProfilePictureClick(Sender: TObject);
  private
    { Private declarations }
    RemovedUsersList: TStringList;
    procedure FillListBox;
    procedure AddUserToGroup(selectedGroupId: integer);

  public
    { Public declarations }
  end;

var
  frmGroupEdit: TfrmGroupEdit;

implementation
  uses DMdatabaseInfo;

{$R *.dfm}

procedure TfrmGroupEdit.FormShow(Sender: TObject);
var
  selectedRowId, getUserId, i, getOwnerId: integer;
  stream: TStream;
  groupMemberName: string;
begin
  lblEditGroupError.Caption := '';
  edtEditGroupName.Text := '';
  edtEditGroupDescription.Text := '';
  cboxEditGroupOwner.Items.Clear;
  imgEditGroupProfile.Picture := nil;
  edtEditGroupSearch.Text := '';
  cbxGroupDeleted.Checked := false;
  slsbEditSearchUser.Items.Clear;
  slsbEditGroupUsers.Items.Clear;

  with DataModule2 do
  begin
    edtEditGroupName.Text := pgqGetSelectedGroup.FieldByName('gro_naam').AsString;
    edtEditGroupDescription.Text := pgqGetSelectedGroup.FieldByName('gro_beschrijving').AsString;
    cbxGroupDeleted.Checked := pgqGetSelectedGroup.FieldByName('gro_del').AsBoolean;
    stream := pgqGetSelectedGroup.CreateBlobStream(pgqGetSelectedGroup.FieldByName('gro_profielfoto'), bmRead);
    imgEditGroupProfile.Picture.LoadFromStream(stream);

    getOwnerId := pgqGetSelectedGroup.FieldByName('gro_igenaar').AsInteger;

    //get information from users table
    if(not Assigned(pgqGetSelectedGroupOwner)) then
    begin
      pgqGetSelectedGroupOwner := TPgQuery.Create(nil);
      pgqGetSelectedGroupOwner.Connection := pgcDBconnection;
    end;
    pgqGetSelectedGroupOwner.SQL.Text := 'SELECT * FROM tbl_gebruikers WHERE gbr_id=:groupOwner';
    pgqGetSelectedGroupOwner.ParamByName('groupOwner').AsInteger := getOwnerId;
    pgqGetSelectedGroupOwner.Open;

    cboxEditGroupOwner.Items.Add(pgqGetSelectedGroupOwner.FieldByName('gbr_nicknaam').AsString);
    cboxEditGroupOwner.ItemIndex := 0;
    pgqGetSelectedGroupOwner.Close;

    //loops through every found group members
    for i := 1 to pgqGetGroupMembers.RecordCount do
    begin
      pgqCheckExistingUser.SQL.Text := 'SELECT * FROM tbl_gebruikers WHERE gbr_id=:currentUserId';
      pgqCheckExistingUser.ParamByName('currentUserId').AsInteger := pgqGetGroupMembers.FieldByName('grl_gebruiker').AsInteger;
      pgqCheckExistingUser.Open;

      with slsbEditGroupUsers.Items.Add do
      begin
        Caption := pgqCheckExistingUser.FieldByName('gbr_nicknaam').AsString;
      end;

      //duplicate check for owner combobox
      if(cboxEditGroupOwner.Items.IndexOf(pgqCheckExistingUser.FieldByName('gbr_nicknaam').AsString) = -1) then
      begin
        cboxEditGroupOwner.Items.Add(pgqCheckExistingUser.FieldByName('gbr_nicknaam').AsString);
      end;

      pgqGetGroupMembers.Next;
    end;

    pgqGetGroupMembers.Close;

    if(cboxEditGroupOwner.Items.IndexOf(pgqGetLoggedInUser.FieldByName('gbr_nicknaam').AsString) = -1) then
    begin
      cboxEditGroupOwner.Items.Add(pgqGetLoggedInUser.FieldByName('gbr_nicknaam').AsString);
    end;

    if(not Assigned(RemovedUsersList)) then
    begin
      RemovedUsersList := TStringList.Create;
      RemovedUsersList.Duplicates := dupIgnore;
    end;


    FillListBox;

  end;

end;

procedure TfrmGroupEdit.FillListBox;
var
  i: integer;
begin
  with DataModule2 do
  begin
    if(slsbEditSearchUser.Items.Count = 0) then
    begin
      pgqGetUsers.SQL.Text := 'SELECT * FROM tbl_gebruikers WHERE gbr_del = false ORDER BY gbr_nicknaam';
      pgqGetUsers.Open;

      for i := 1 to pgqGetUsers.RecordCount do
      begin
        with slsbEditSearchUser.Items.Add do
        begin
          Caption := pgqGetUsers.FieldByName('gbr_nicknaam').AsString;
        end;
        pgqGetUsers.Next;
      end;
    end;
  end;
end;

procedure TfrmGroupEdit.sbtnEditGroupCancelClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmGroupEdit.sbtnEditGroupClick(Sender: TObject);
var
  pgqEditGroupMember, pgqGetDeletedUserId: TPgQuery;
  groupId, i: integer;
  AStream: TMemoryStream;
  BlobField: TBlobField;
begin
  with DataModule2 do
  begin
    pgqEditGroupMember := TPgQuery.Create(nil);
    pgqEditGroupMember.Connection := pgcDBconnection;

    pgqGetDeletedUserId := TPgQuery.Create(nil);
    pgqGetDeletedUserId.Connection := pgcDBconnection;

    lblEditGroupError.Caption := '';
    lblEditGroupError.Font.Color := RGB(220, 20, 60);

    groupId := pgqGetSelectedGroup.FieldByName('gro_id').AsInteger;

    for i := 1 to RemovedUsersList.Count do
    begin
      pgqGetDeletedUserId.SQL.Text := 'SELECT * FROM tbl_gebruikers';
      pgqGetDeletedUserId.SQL.Add('WHERE gbr_nicknaam = :currentUser');
      pgqGetDeletedUserId.ParamByName('currentUser').AsString := RemovedUsersList[i - 1];
      pgqGetDeletedUserId.Open;

      pgqEditGroupMember.SQL.Text := '';
      pgqEditGroupMember.SQL.Add('SELECT * FROM tbl_groepleden');
      pgqEditGroupMember.SQL.Add('WHERE grl_groep = :selectedGroup');
      pgqEditGroupMember.SQL.Add('AND grl_gebruiker = :currentUser');
      pgqEditGroupMember.ParamByName('selectedGroup').AsInteger := groupId;
      pgqEditGroupMember.ParamByName('currentUser').AsInteger := pgqGetDeletedUserId.FieldByName('gbr_id').AsInteger;
      pgqEditGroupMember.Open;

      pgqEditGroupMember.Edit;
      pgqEditGroupMember.FieldByName('grl_del').AsBoolean := True;
      pgqEditGroupMember.Post;
    end;

    AddUserToGroup(groupId);

  //  if(pgqGetDeletedUserId.Active) then pgqGetDeletedUserId.Close;
  //  if(pgqEditGroupMember.Active) then pgqEditGroupMember.Close;

    pgqCheckExistingUser.SQL.Text := 'SELECT gbr_id FROM tbl_gebruikers';
    pgqCheckExistingUser.SQL.Add('WHERE gbr_nicknaam=:newGroupOwner');
    pgqCheckExistingUser.ParamByName('newGroupOwner').AsString := cboxEditGroupOwner.Text;
    pgqCheckExistingUser.Open;

    pgqGetSelectedGroup.Edit;
    pgqGetSelectedGroup.FieldByName('gro_naam').AsString := edtEditGroupName.Text;
    pgqGetSelectedGroup.FieldByName('gro_beschrijving').AsString := edtEditGroupDescription.Text;
    pgqGetSelectedGroup.FieldByName('gro_igenaar').AsInteger := pgqCheckExistingUser.FieldByName('gbr_id').AsInteger;
    pgqGetSelectedGroup.FieldByName('gro_del').AsBoolean := cbxGroupDeleted.Checked;

    pgqCheckExistingUser.Close;

    //insert image into database
    AStream := TMemoryStream.Create;
    imgEditGroupProfile.Picture.SaveToStream(AStream);
    BlobField := pgqGetSelectedGroup.FieldByName('gro_profielfoto') as TBlobField;
    BlobField.LoadFromStream(AStream);

    pgqGetSelectedGroup.Post;

    RemovedUsersList.Clear;
    Self.Close;
  end;
end;

procedure TfrmGroupEdit.sbtnEditGroupProfilePictureClick(Sender: TObject);
begin
  with TOpenDialog.Create(self) do
  try
    Caption := 'Open afbeelding';
    Filter := 'Image Files (*.jpg;*.jpeg;*.png)|*.jpg;*.jpeg;*.png';
    Options := [TOpenOption.ofPathMustExist, TOpenOption.ofPathMustExist];
    if (Execute) then imgEditGroupProfile.Picture.LoadFromFile(FileName);

  finally
    Free;
  end;
end;

procedure TfrmGroupEdit.sbtnEditRemoveGroupUserClick(Sender: TObject);
var
  indexDeletedUser, editDuplicateLocation, i: integer;
  getText: string;
  searchLB, addedUsersLB: TAdvSmoothListBox;
begin
  if(slsbEditGroupUsers.Items.CountSelected > 0) then
  begin
    getText := slsbEditGroupUsers.Items[slsbEditGroupUsers.SelectedItemIndex].Caption;
    indexDeletedUser := cboxEditGroupOwner.Items.IndexOf(getText);

    if(getText = cboxEditGroupOwner.Text) then
    begin
      for i := 1 to cboxEditGroupOwner.Items.Count do
      begin
        if(i - 1 <> indexDeletedUser) then
        begin
          cboxEditGroupOwner.ItemIndex := i - 1;
          break;
        end;
      end;
    end;

    editDuplicateLocation := RemovedUsersList.IndexOf(getText);

    if(editDuplicateLocation = -1) then
    begin
      RemovedUsersList.Add(getText);
    end;
  end;

  slsbEditGroupUsers.Items.Delete(slsbEditGroupUsers.SelectedItemIndex);

  if(getText <> DataModule2.pgqGetLoggedInUser.FieldByName('gbr_nicknaam').AsString) then
    if(indexDeletedUser <> -1) then cboxEditGroupOwner.Items.Delete(indexDeletedUser);
end;

procedure TfrmGroupEdit.sbtnEditSearchUserClick(Sender: TObject);
var
  i: integer;
  searchQuery: TPgQuery;
  searchLB: TAdvSmoothListBox;
  searchBar: TEdit;
begin
  lblEditGroupError.Caption := '';

  searchQuery := TPgQuery.Create(nil);
  searchQuery.Connection := DataModule2.pgcDBconnection;

  slsbEditSearchUser.Items.Clear;
  searchQuery.SQL.Text := 'SELECT * FROM tbl_gebruikers';
  if(Length(edtEditGroupSearch.Text) > 0) then
  begin
    searchQuery.SQL.Add('WHERE LOWER(gbr_nicknaam) LIKE :user');
    searchQuery.SQL.Add('OR LOWER(gbr_email)=:user');
    searchQuery.SQL.Add('OR LOWER(gbr_naam)=:user');
    searchQuery.SQL.Add('ORDER BY gbr_nicknaam');
    searchQuery.ParamByName('user').AsString := #37 + LowerCase(edtEditGroupSearch.Text) + #37;
  end
  else searchQuery.SQL.Add('ORDER BY gbr_nicknaam');
  searchQuery.Open;

  searchQuery.First;
  for i := 1 to searchQuery.RecordCount do
  begin
    with slsbEditSearchUser.Items.Add do
    begin
      Caption := searchQuery.FieldByName('gbr_nicknaam').AsString;
      searchQuery.Next;
    end;
  end;

  searchQuery.Close;
end;

procedure TfrmGroupEdit.slsbEditAddUserToGroupClick(Sender: TObject);
var
  i, temp, editDuplicateLocation: integer;
begin
  if(slsbEditSearchUser.Items.CountSelected > 0) then
  begin
    temp := slsbEditGroupUsers.Items.IndexOfCaption(slsbEditSearchUser.Items[slsbEditSearchUser.SelectedItemIndex].Caption);
    if(temp = -1) then
    begin
      with slsbEditGroupUsers.Items.Add do
      begin
        Caption := slsbEditSearchUser.Items[slsbEditSearchUser.SelectedItemIndex].Caption;
      end;

      if(cboxEditGroupOwner.Items.IndexOf(slsbEditSearchUser.Items[slsbEditSearchUser.SelectedItemIndex].Caption) = -1) then
        cboxEditGroupOwner.Items.Add(slsbEditSearchUser.Items[slsbEditSearchUser.SelectedItemIndex].Caption);

      editDuplicateLocation := RemovedUsersList.IndexOf(slsbEditSearchUser.Items[slsbEditSearchUser.SelectedItemIndex].Caption);

      if(editDuplicateLocation > -1) then
      begin
        RemovedUsersList.Delete(editDuplicateLocation);
      end;

    end
    else lblEditGroupError.Caption := 'Gebruiker al in lijst';
  end;
end;

procedure TfrmGroupEdit.AddUserToGroup(selectedGroupId: integer);
var
  pgqGroepsLeden, pgqCheckDuplicateUser: TPgQuery;
  i: integer;
  userIsDuplicate, deletedUserStatus: boolean;
begin
  with DataModule2 do
  begin
    deletedUserStatus := false;

    pgqGroepsLeden := TPgQuery.Create(nil);
    pgqGroepsLeden.Connection := pgcDBconnection;

    pgqCheckDuplicateUser := TPgQuery.Create(nil);
    pgqCheckDuplicateUser.Connection := pgcDBconnection;

    userIsDuplicate := false;

    for I := 1 to slsbEditGroupUsers.Items.Count do
    begin
      pgqCheckExistingUser.SQL.Text := 'SELECT gbr_id FROM tbl_gebruikers';
      pgqCheckExistingUser.SQL.Add('WHERE LOWER(gbr_nicknaam)=:currentUser');
      pgqCheckExistingUser.ParamByName('currentUser').AsString := LowerCase(Trim(slsbEditGroupUsers.Items[i - 1].Caption));
      pgqCheckExistingUser.Open;

      pgqCheckDuplicateUser.SQL.Text := 'SELECT * FROM tbl_groepleden';
      pgqCheckDuplicateUser.SQL.Add('WHERE grl_groep = :currentGroup');
      pgqCheckDuplicateUser.SQL.Add('AND grl_gebruiker = :currentUser');
      pgqCheckDuplicateUser.ParamByName('currentGroup').AsInteger := selectedGroupId;
      pgqCheckDuplicateUser.ParamByName('currentUser').AsInteger := pgqCheckExistingUser.FieldByName('gbr_id').AsInteger;
      pgqCheckDuplicateUser.Open;

      if(pgqCheckDuplicateUser.RecordCount > 0) then userIsDuplicate := true
      else userIsDuplicate := false;

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
        pgqGroepsLeden.SQL.Text := 'INSERT INTO tbl_groepleden (grl_gebruiker, grl_groep, grl_aangemaakt, grl_del)';
        pgqGroepsLeden.SQL.Add('VALUES (:userId, :groupId, :timeUserAdded, :groupMemberDeleted)');
        pgqGroepsleden.ParamByName('userId').AsInteger := pgqCheckExistingUser.FieldByName('gbr_id').AsInteger;
        pgqGroepsleden.ParamByName('groupId').AsInteger := selectedGroupId;
        pgqGroepsleden.ParamByName('timeUserAdded').AsDateTime := now;
        pgqGroepsleden.ParamByName('groupMemberDeleted').AsBoolean := false;
        pgqGroepsleden.Execute;
      end;
    end;

    if(pgqCheckDuplicateUser.Active) then pgqCheckDuplicateUser.Close;
    if(pgqGroepsLeden.Active) then pgqGroepsLeden.Close;

  end;

end;

end.
