unit frmAddGroup;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, System.Threading, System.IOUtils,
  Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Data.DB,
  AdvSmoothListBox, AdvSmoothButton, MemDS, DBAccess, PgAccess, AdvCombo,
  ColCombo, AdvSmoothComboBox;

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
    procedure edtAddGroupSearchUserKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    fileExtension: string;
    procedure AddUserToGroup(selectedGroupId: integer);
    procedure SearchForUser;
  public
    { Public declarations }
  end;

var
  frmGroupAdd: TfrmGroupAdd;

implementation
  uses DMdatabaseInfo;

{$R *.dfm}

procedure TfrmGroupAdd.edtAddGroupSearchUserKeyPress(Sender: TObject;
  var Key: Char);
begin
  if(Key = #13) then SearchForUser;
end;

procedure TfrmGroupAdd.FormShow(Sender: TObject);
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
      TTask.Run(
      procedure
      var
        i: integer;
      begin
        try
          Screen.Cursor := crHourGlass;
          pgqGetUsers.SQL.Text := 'SELECT * FROM tbl_gebruikers WHERE gbr_del = false ORDER BY gbr_nicknaam';
          pgqGetUsers.Open;
        finally
          slsbUser.BeginUpdate;
          for i := 1 to pgqGetUsers.RecordCount do
          begin
            with slsbUser.Items.Add do
            begin
              Caption := FirstCharUpperCase(pgqGetUsers.FieldByName('gbr_nicknaam').AsString);
              Tag := pgqGetUsers.FieldByName('gbr_id').AsInteger;
            end;
            pgqGetUsers.Next;
          end;

          slsbUser.EndUpdate;
          Screen.Cursor := crDefault;
        end;
      end);
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
      pgqCheckExistingUser.SQL.Text := 'SELECT * FROM tbl_gebruikers';
      pgqCheckExistingUser.SQL.Add('WHERE gbr_nicknaam=:groupOwner');
      pgqCheckExistingUser.ParamByName('groupOwner').AsString := cboxGroupOwner.Text;
      pgqCheckExistingUser.Open;

      //prepares the sql statement to insert into groups table
      pgqGetGroups.SQL.Text := 'INSERT INTO tbl_groepen (gro_naam, gro_igenaar, gro_aangemaakt, gro_del, gro_beschrijving, gro_pf_ext, gro_profielfoto)';
      pgqGetGroups.SQL.Add('VALUES (:groupName, :groupOwner, :groupCreated, :groupDeleted, :groupDescription, :groupProfileExtension, :groupProfilePicture)');
      pgqGetGroups.SQL.Add('RETURNING *');
      pgqGetGroups.ParamByName('groupName').AsString := Trim(edtGroupName.Text);
      pgqGetGroups.ParamByName('groupOwner').AsInteger := StrToInt(Trim(pgqCheckExistingUser.FieldByName('gbr_id').AsString));
      pgqGetGroups.ParamByName('groupCreated').AsDateTime := now;
      pgqGetGroups.ParamByName('groupDeleted').AsBoolean := false;
      pgqGetGroups.ParamByName('groupDescription').AsString := Trim(edtGroupDescription.Text);
      pgqGetGroups.ParamByName('groupProfileExtension').AsString := fileExtension;

      //saves the image to a format that is used by the database
      AStream := TMemoryStream.Create;
      try
        imgAddGroupProfile.Picture.SaveToStream(AStream);
        pgqGetGroups.ParamByName('groupProfilePicture').LoadFromStream(AStream, ftBlob);

        //executes the insert sql statement and closes it to preserve memory
        pgqGetGroups.Open;
        idLastCreatedGroup := pgqGetGroups.FieldByName('gro_id').AsInteger;
        pgqGetGroups.Close;

        //will add the user to the last added group
        AddUserToGroup(idLastCreatedGroup);

      finally
        AStream.Free;
      end;

      //closes open tab when done
      Self.Close;
    end
    else lblAddGroupError.Caption := 'Vul een naam in in bij de groepsnaam';

  end;

end;

procedure TfrmGroupAdd.AddUserToGroup(selectedGroupId: integer);
var
//  pgqGroepsLeden: TPgQuery;
  i: integer;
//  addedUserLB: TAdvSmoothListBox;
begin
  with DataModule2 do
  begin
//    pgqGroepsLeden := TPgQuery.Create(nil);
//    pgqGroepsLeden.Connection := pgcDBconnection;

    //loop through every user in bottom listbox
    for I := 1 to slsbGroupAddedUsers.Items.Count do
    begin
      //inserts the group member into the table
      pgqGroepsLeden.SQL.Text := 'INSERT INTO tbl_groepleden (grl_gebruiker, grl_groep, grl_aangemaakt, grl_del)';
      pgqGroepsLeden.SQL.Add('VALUES (:userId, :groupId, :timeUserAdded, :groupMemberDeleted)');
      pgqGroepsleden.ParamByName('userId').AsInteger := slsbGroupAddedUsers.Items[i - 1].Tag; {pgqCheckExistingUser.FieldByName('gbr_id').AsInteger;}
      pgqGroepsleden.ParamByName('groupId').AsInteger := selectedGroupId;
      pgqGroepsleden.ParamByName('timeUserAdded').AsDateTime := now;
      pgqGroepsleden.ParamByName('groupMemberDeleted').AsBoolean := false;
      pgqGroepsleden.Execute;
    end;

    if(pgqGroepsLeden.Active) then pgqGroepsLeden.Close;
    if(pgqCheckExistingUser.Active) then pgqCheckExistingUser.Close;
  end;

end;

procedure TfrmGroupAdd.sbtnAddGroupProfileClick(Sender: TObject);
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
          imgAddGroupProfile.Picture.LoadFromFile(FileName);
        end
        else lblAddGroupError.Caption := 'Afbeelding is te groot (max 2 mb)';
      end;

    finally
      Free;
    end;
end;

procedure TfrmGroupAdd.sbtnAddUserToGroupClick(Sender: TObject);
var
  temp, location: integer;
begin
  if(slsbUser.Items.CountSelected > 0) then
  begin
    temp := slsbGroupAddedUsers.Items.IndexOfCaption(slsbUser.Items[slsbUser.SelectedItemIndex].Caption);
    if(temp = -1) then
    begin
      with slsbGroupAddedUsers.Items.Add do
      begin
        Caption := slsbUser.Items[slsbUser.SelectedItemIndex].Caption;
        Tag := slsbUser.Items[slsbUser.SelectedItemIndex].Tag;
      end;

      if(cboxGroupOwner.Items.IndexOf(slsbUser.Items[slsbUser.SelectedItemIndex].Caption) = -1) then
        cboxGroupOwner.Items.Add(slsbUser.Items[slsbUser.SelectedItemIndex].Caption);

      //add to combobox when it isn't already in the list
//      location := scboxGroupOwner.Items.IndexOf(slsbUser.Items[slsbUser.SelectedItemIndex].Caption);
//      if(location = -1) then
//      begin
//        with scboxGroupOwner.ComboItems.Add do
//        begin
//          Caption := slsbUser.Items[slsbUser.SelectedItemIndex].Caption;
//          Tag := slsbUser.Items[slsbUser.SelectedItemIndex].Tag;
//        end;
//      end;

    end
    else lblAddGroupError.Caption := 'Gebruiker al in lijst';
  end;
end;

procedure TfrmGroupAdd.sbtnagSearchUserClick(Sender: TObject);
begin
  SearchForUser;
end;

procedure TfrmGroupAdd.SearchForUser;
var
  i: integer;
begin
    lblAddGroupError.Caption := '';

  with DataModule2 do
  begin
    slsbUser.Items.Clear;

    if(Length(edtAddGroupSearchUser.Text) > 0) then
    begin
      pgqSearchUser.SQL.Text := 'SELECT * FROM tbl_gebruikers';
      pgqSearchUser.SQL.Add('WHERE LOWER(gbr_nicknaam) LIKE :user');
      pgqSearchUser.SQL.Add('OR LOWER(gbr_email)=:user');
      pgqSearchUser.SQL.Add('OR LOWER(gbr_naam)=:user');
      pgqSearchUser.SQL.Add('ORDER BY gbr_nicknaam');
      pgqSearchUser.ParamByName('user').AsString := #37 + LowerCase(edtAddGroupSearchUser.Text) + #37;
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
      with slsbUser.Items.Add do
      begin
        Caption := FirstCharUpperCase(pgqSearchUser.FieldByName('gbr_nicknaam').AsString);
        Tag := pgqSearchUser.FieldByName('gbr_id').AsInteger;
        pgqSearchUser.Next;
      end;
    end;

    pgqSearchUser.Close;
  end;
end;

procedure TfrmGroupAdd.sbtnBackToGroupOverviewClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmGroupAdd.sbtnRemoveUserFromGroupClick(Sender: TObject);
var
  indexDeletedUser, i, j, test: integer;
  getText: string;
  getLocation: TPoint;
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
      //select random item so it does not select the deleted row
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
