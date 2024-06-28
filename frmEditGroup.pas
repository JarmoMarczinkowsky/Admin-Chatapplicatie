unit frmEditGroup;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, System.Threading, System.IOUtils,
  Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
  AdvSmoothListBox, AdvSmoothButton, MemDS, DBAccess, PgAccess,
  AdvSmoothComboBox;

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
    procedure edtEditGroupSearchKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    RemovedUsersList: TStringList;
    fileExtension: string;
    procedure FillListBox;
    procedure AddUserToGroup(selectedGroupId: integer);
    procedure SearchForUser;

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
  i, getOwnerId: integer;
  stream: TStream;
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

  frmGroupEdit.Left := (frmGroupEdit.Monitor.Width  - frmGroupEdit.Width)  div 2;
  frmGroupEdit.Top  := (frmGroupEdit.Monitor.Height - frmGroupEdit.Height) div 2;

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

    TTask.Run(
      procedure
      begin
        try
          pgqGetSelectedGroupOwner.SQL.Text := 'SELECT * FROM tbl_gebruikers WHERE gbr_id=:groupOwner';
          pgqGetSelectedGroupOwner.ParamByName('groupOwner').AsInteger := getOwnerId;
          pgqGetSelectedGroupOwner.Open;

        finally
          cboxEditGroupOwner.Items.Add(pgqGetSelectedGroupOwner.FieldByName('gbr_nicknaam').AsString);
          cboxEditGroupOwner.ItemIndex := 0;
          pgqGetSelectedGroupOwner.Close;

        end;
      end

    );

    slsbEditGroupUsers.BeginUpdate;
    //loops through every found group members
    for i := 1 to pgqGetGroupMembers.RecordCount do
    begin
      pgqCheckExistingUser.SQL.Text := 'SELECT * FROM tbl_gebruikers WHERE gbr_id=:currentUserId';
      pgqCheckExistingUser.ParamByName('currentUserId').AsInteger := pgqGetGroupMembers.FieldByName('grl_gebruiker').AsInteger;
      pgqCheckExistingUser.Open;

      with slsbEditGroupUsers.Items.Add do
      begin
        Caption := pgqCheckExistingUser.FieldByName('gbr_nicknaam').AsString;
        Tag := pgqCheckExistingUser.FieldByName('gbr_id').AsInteger;
      end;

      //duplicate check for owner combobox
      if(cboxEditGroupOwner.Items.IndexOf(pgqCheckExistingUser.FieldByName('gbr_nicknaam').AsString) = -1) then
      begin
        cboxEditGroupOwner.Items.Add(pgqCheckExistingUser.FieldByName('gbr_nicknaam').AsString);
      end;

      pgqGetGroupMembers.Next;
    end;
    slsbEditGroupUsers.EndUpdate;

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

procedure TfrmGroupEdit.edtEditGroupSearchKeyPress(Sender: TObject;
  var Key: Char);
begin
  if(Key = #13) then SearchForUser;
end;

procedure TfrmGroupEdit.FillListBox;
begin
  with DataModule2 do
  begin
    if(slsbEditSearchUser.Items.Count = 0) then
    begin
      TTask.Run(
      procedure
      begin
        try
          pgqGetUsers.SQL.Text := 'SELECT * FROM tbl_gebruikers WHERE gbr_del = false ORDER BY gbr_nicknaam';
          pgqGetUsers.Open;
        finally
          TThread.Synchronize(nil,
          procedure
          var
            i: integer;
          begin
            slsbEditSearchUser.BeginUpdate;
            for i := 1 to pgqGetUsers.RecordCount do
            begin
              with slsbEditSearchUser.Items.Add do
              begin
                Caption := pgqGetUsers.FieldByName('gbr_nicknaam').AsString;
                Tag := pgqGetUsers.FieldByName('gbr_id').AsInteger;
              end;
              pgqGetUsers.Next;
            end;
            slsbEditSearchUser.EndUpdate;
          end)
        end;
      end);
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
    try
      pgqEditGroupMember.Connection := pgcDBconnection;

//    pgqGetDeletedUserId := TPgQuery.Create(nil);
//    pgqGetDeletedUserId.Connection := pgcDBconnection;

      lblEditGroupError.Caption := '';
      lblEditGroupError.Font.Color := RGB(220, 20, 60);

      if(Length(edtEditGroupName.Text) = 0) then
      begin
        lblEditGroupError.Caption := 'Geen groepsnaam ingevoerd';
        Exit;
      end;

      groupId := pgqGetSelectedGroup.FieldByName('gro_id').AsInteger;

      for i := 1 to RemovedUsersList.Count do
      begin
        pgqEditGroupMember.SQL.Text := 'UPDATE tbl_groepleden';
        pgqEditGroupMember.SQL.Add('SET grl_del = True');
        pgqEditGroupMember.SQL.Add('WHERE grl_groep = :selectedGroup');
        pgqEditGroupMember.SQL.Add('AND grl_gebruiker = :currentUser');
        pgqEditGroupMember.ParamByName('selectedGroup').AsInteger := groupId;
        pgqEditGroupMember.ParamByName('currentUser').AsInteger := StrToInt(RemovedUsersList[i - 1]); {pgqGetDeletedUserId.FieldByName('gbr_id').AsInteger;}
        pgqEditGroupMember.Execute;
      end;

    finally
      pgqEditGroupMember.Free;
    end;

    AddUserToGroup(groupId);

    //gets id from group owner
    pgqCheckExistingUser.SQL.Text := 'SELECT gbr_id FROM tbl_gebruikers';
    pgqCheckExistingUser.SQL.Add('WHERE gbr_nicknaam=:newGroupOwner');
    pgqCheckExistingUser.ParamByName('newGroupOwner').AsString := cboxEditGroupOwner.Text;
    pgqCheckExistingUser.Open;

    //
    pgqGetSelectedGroup.Edit;
    pgqGetSelectedGroup.FieldByName('gro_naam').AsString := edtEditGroupName.Text;
    pgqGetSelectedGroup.FieldByName('gro_beschrijving').AsString := edtEditGroupDescription.Text;
    pgqGetSelectedGroup.FieldByName('gro_igenaar').AsInteger := pgqCheckExistingUser.FieldByName('gbr_id').AsInteger;
    pgqGetSelectedGroup.FieldByName('gro_del').AsBoolean := cbxGroupDeleted.Checked;
    pgqGetSelectedGroup.FieldByName('gro_pf_ext').AsString := fileExtension;

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
var
  getFile: TFileStream;
  strGetSize: string;
  getSize: double;
begin
  with TOpenDialog.Create(self) do
  try
    Caption := 'Open afbeelding';
    Filter := 'Image Files (*.jpg;*.jpeg;*.png)|*.jpg;*.jpeg;*.png';
    Options := [TOpenOption.ofPathMustExist, TOpenOption.ofPathMustExist];
    if (Execute) then
    begin
      getFile := TFileStream.Create(FileName, fmOpenRead or fmShareDenyNone);
      fileExtension := LowerCase(TPath.GetExtension(FileName));
      strGetSize := FormatFloat('0.00', getFile.Size / (1024 * 1024));
      getSize := StrToFloat(strGetSize);

      if(getSize < 5) then
      begin
        imgEditGroupProfile.Picture.LoadFromFile(FileName);
      end
      else lblEditGroupError.Caption := 'Afbeelding moet kleiner dan 5mb zijn';

    end;


  finally
    Free;
  end;
end;

procedure TfrmGroupEdit.sbtnEditRemoveGroupUserClick(Sender: TObject);
var
  indexDeletedUser, editDuplicateLocation, i: integer;
  getText: string;
begin
  if(slsbEditGroupUsers.Items.CountSelected > 0) then
  begin
    //get the caption of the currently selected group member
    //so it could get the position of the group member in the combobox
    getText := slsbEditGroupUsers.Items[slsbEditGroupUsers.SelectedItemIndex].Caption;
    indexDeletedUser := cboxEditGroupOwner.Items.IndexOf(getText);

    //if the selected user that you want to delete is also the group owner
    //go through the combobox and select the first instance that is not the group owner
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

    //checks if the id of the user you want to remove is already in the list
    editDuplicateLocation := RemovedUsersList.IndexOf(IntToStr(slsbEditGroupUsers.Items[slsbEditGroupUsers.SelectedItemIndex].Tag));

    //if it isn't in the list, it will be added to the list
    if(editDuplicateLocation = -1) then
    begin
      RemovedUsersList.Add(IntToStr(slsbEditGroupUsers.Items[slsbEditGroupUsers.SelectedItemIndex].Tag));
    end;
  end;

  slsbEditGroupUsers.Items.Delete(slsbEditGroupUsers.SelectedItemIndex);

  if(getText <> DataModule2.pgqGetLoggedInUser.FieldByName('gbr_nicknaam').AsString) then
    if(indexDeletedUser <> -1) then cboxEditGroupOwner.Items.Delete(indexDeletedUser);
end;

procedure TfrmGroupEdit.sbtnEditSearchUserClick(Sender: TObject);
begin
  SearchForUser;
end;

procedure TfrmGroupEdit.SearchForUser;
var
  i: integer;
begin
  lblEditGroupError.Caption := '';

  with DataModule2 do
  begin
    slsbEditSearchUser.Items.Clear;

    if(Length(edtEditGroupSearch.Text) > 0) then
    begin
      pgqSearchUser.SQL.Text := 'SELECT * FROM tbl_gebruikers';
      pgqSearchUser.SQL.Add('WHERE LOWER(gbr_nicknaam) LIKE :user');
      pgqSearchUser.SQL.Add('OR LOWER(gbr_email)=:user');
      pgqSearchUser.SQL.Add('OR LOWER(gbr_naam)=:user');
      pgqSearchUser.SQL.Add('ORDER BY gbr_nicknaam');
      pgqSearchUser.ParamByName('user').AsString := #37 + LowerCase(edtEditGroupSearch.Text) + #37;
    end
    else
    begin
      pgqSearchUser.SQL.Text := 'SELECT * FROM tbl_gebruikers';
      pgqSearchUser.SQL.Add('ORDER BY gbr_nicknaam');
    end;

    pgqSearchUser.Open;

    pgqSearchUser.First;
    for i := 1 to pgqSearchUser.RecordCount do
    begin
      with slsbEditSearchUser.Items.Add do
      begin
        Caption := FirstCharUpperCase(pgqSearchUser.FieldByName('gbr_nicknaam').AsString);
        Tag := pgqSearchUser.FieldByName('gbr_id').AsInteger;
      end;
      pgqSearchUser.Next;
    end;
    pgqSearchUser.Close;
  end;
end;

procedure TfrmGroupEdit.slsbEditAddUserToGroupClick(Sender: TObject);
var
  temp, editDuplicateLocation, edtSearchUserIndex: integer;
begin
  if(slsbEditSearchUser.Items.CountSelected > 0) then
  begin
    edtSearchUserIndex := slsbEditSearchUser.SelectedItemIndex;
    temp := slsbEditGroupUsers.Items.IndexOfCaption(slsbEditSearchUser.Items[edtSearchUserIndex].Caption);
    if(temp = -1) then
    begin
      with slsbEditGroupUsers.Items.Add do
      begin
        Caption := slsbEditSearchUser.Items[edtSearchUserIndex].Caption;
        Tag := slsbEditSearchUser.Items[edtSearchUserIndex].Tag;
      end;

      if(cboxEditGroupOwner.Items.IndexOf(slsbEditSearchUser.Items[edtSearchUserIndex].Caption) = -1) then
        cboxEditGroupOwner.Items.Add(slsbEditSearchUser.Items[edtSearchUserIndex].Caption);

//      editDuplicateLocation := RemovedUsersList.IndexOf(slsbEditSearchUser.Items[edtSearchUserIndex].Caption);
      editDuplicateLocation := RemovedUsersList.IndexOf(IntToStr(slsbEditSearchUser.Items[edtSearchUserIndex].Tag));

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
    try
      pgqGroepsLeden.Connection := pgcDBconnection;

      pgqCheckDuplicateUser := TPgQuery.Create(nil);
      try
        pgqCheckDuplicateUser.Connection := pgcDBconnection;

        userIsDuplicate := false;

        for I := 1 to slsbEditGroupUsers.Items.Count do
        begin
          pgqCheckDuplicateUser.SQL.Text := 'SELECT * FROM tbl_groepleden';
          pgqCheckDuplicateUser.SQL.Add('WHERE grl_groep = :currentGroup');
          pgqCheckDuplicateUser.SQL.Add('AND grl_gebruiker = :currentUser');
          pgqCheckDuplicateUser.ParamByName('currentGroup').AsInteger := selectedGroupId;
          pgqCheckDuplicateUser.ParamByName('currentUser').AsInteger := slsbEditGroupUsers.Items[i - 1].Tag; {pgqCheckExistingUser.FieldByName('gbr_id').AsInteger;}
          pgqCheckDuplicateUser.Open;

          if(pgqCheckDuplicateUser.RecordCount > 0) then userIsDuplicate := true
          else userIsDuplicate := false;

          if(userIsDuplicate = true) then
          begin
            deletedUserStatus := pgqCheckDuplicateUser.FieldByName('grl_del').AsBoolean;
            if(deletedUserStatus) then
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
            pgqGroepsleden.ParamByName('userId').AsInteger := slsbEditGroupUsers.Items[i - 1].Tag; {pgqCheckExistingUser.FieldByName('gbr_id').AsInteger;}
            pgqGroepsleden.ParamByName('groupId').AsInteger := selectedGroupId;
            pgqGroepsleden.ParamByName('timeUserAdded').AsDateTime := now;
            pgqGroepsleden.ParamByName('groupMemberDeleted').AsBoolean := false;
            pgqGroepsleden.Execute;
          end;
        end;
      finally
        pgqCheckDuplicateUser.Free;
      end;
    finally
      pgqGroepsLeden.Free;
    end;
  end;
end;
end.
