unit AdminDashboard;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, System.RegularExpressions, System.Hash,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Graphics, AdvUtil, Vcl.Grids, AdvObj, BaseGrid,
  AdvGrid, DBAdvGrid, Vcl.ExtCtrls, Data.DB, MemDS, DBAccess, PgAccess,
  AdvSmoothButton, Vcl.StdCtrls, Vcl.ComCtrls, DMdatabaseInfo, AdvSmoothListBox,
  Vcl.DBGrids, Vcl.Mask, RzEdit, GDIPMenu, AdvSmoothMegaMenu, AdvSmoothPanel;

type
  TForm2 = class(TForm)
    pcPages: TPageControl;
    tbsUserOverview: TTabSheet;
    sbtnAddUser: TAdvSmoothButton;
    sbtnDeleteUser: TAdvSmoothButton;
    tbsAddUser: TTabSheet;
    lblTelephone: TLabel;
    lblEmail: TLabel;
    lblName: TLabel;
    lblNickname: TLabel;
    lblStoreName: TLabel;
    lblAddUserError: TLabel;
    AdvSmoothButton1: TAdvSmoothButton;
    sbtnBackToUserOverview: TAdvSmoothButton;
    edtUserName: TEdit;
    edtUserStoreName: TEdit;
    edtUserTelephone: TEdit;
    edtUserNickName: TEdit;
    edtUserEmail: TEdit;
    tbsGroupOverview: TTabSheet;
    sbtnGoToAddGroup: TAdvSmoothButton;
    sbtnDeleteGroup: TAdvSmoothButton;
    tbsAddGroup: TTabSheet;
    Label4: TLabel;
    lblAddGroupError: TLabel;
    Label2: TLabel;
    imgAddGroupProfile: TImage;
    Label5: TLabel;
    edtGroupName: TEdit;
    edtGroupDescription: TEdit;
    sbtnBackToGroupOverview: TAdvSmoothButton;
    sbtnAddGroup: TAdvSmoothButton;
    sbtnAddGroupProfile: TAdvSmoothButton;
    slsbUser: TAdvSmoothListBox;
    edtAddGroupSearchUser: TEdit;
    sbtnAddUserToGroup: TAdvSmoothButton;
    slsbGroupAddedUsers: TAdvSmoothListBox;
    sbtnagSearchUser: TAdvSmoothButton;
    cboxGroupOwner: TComboBox;
    sgrGroups: TStringGrid;
    sgrUsers: TStringGrid;
    tbsEditUser: TTabSheet;
    lblEditUserName: TLabel;
    edtEditUserName: TEdit;
    edtEditStoreName: TEdit;
    lblEditUserStoreName: TLabel;
    lblEditUserEmail: TLabel;
    edtEditUserEmail: TEdit;
    edtEditUserTelephone: TEdit;
    lblEditUserTelephone: TLabel;
    lblEditUserUserName: TLabel;
    edtEditUserNickName: TEdit;
    AdvSmoothButton3: TAdvSmoothButton;
    sbtnEditUser: TAdvSmoothButton;
    lblEditUserError: TLabel;
    edtEditUserPassword: TEdit;
    lblEditUserPassword: TLabel;
    sbtnGoToEditUser: TAdvSmoothButton;
    sbtnGoToEditGroup: TAdvSmoothButton;
    sbtnRemoveUserFromGroup: TAdvSmoothButton;
    Label13: TLabel;
    tbsEditGroup: TTabSheet;
    sbtnEditGroupCancel: TAdvSmoothButton;
    sbtnEditGroupProfilePicture: TAdvSmoothButton;
    cboxEditGroupOwner: TComboBox;
    edtEditGroupSearch: TEdit;
    edtEditGroupDescription: TEdit;
    edtEditGroupName: TEdit;
    imgEditGroupProfile: TImage;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    lblEditGroupError: TLabel;
    sbtnEditGroup: TAdvSmoothButton;
    slsbEditAddUserToGroup: TAdvSmoothButton;
    sbtnEditSearchUser: TAdvSmoothButton;
    sbtnEditRemoveGroupUser: TAdvSmoothButton;
    slsbEditGroupUsers: TAdvSmoothListBox;
    slsbEditSearchUser: TAdvSmoothListBox;
    cbxGroupDeleted: TCheckBox;
    Label1: TLabel;
    tbsOptions: TTabSheet;
    RzNumericEdit1: TRzNumericEdit;
    Label18: TLabel;
    sbtnCancelOptions: TAdvSmoothButton;
    sbtnChangeOption: TAdvSmoothButton;
    sbtnBackButton: TAdvSmoothButton;
    AdvSmoothButton2: TAdvSmoothButton;
    AdvSmoothButton4: TAdvSmoothButton;
    AdvSmoothButton7: TAdvSmoothButton;
    sbtnBack: TAdvSmoothButton;
    AdvSmoothMegaMenu1: TAdvSmoothMegaMenu;
    imgAddUserProfilePicture: TImage;
    sbtnAddUserProfilePicture: TAdvSmoothButton;
    Label19: TLabel;
    lblEditUserProfilePicture: TLabel;
    sbtnEditUserProfilePicture: TAdvSmoothButton;
    imgEditProfilePicture: TImage;
    sbtnRefreshGroup: TAdvSmoothButton;
    sbtnRefreshUser: TAdvSmoothButton;
    sbtnLogOut: TAdvSmoothButton;
    lblUserOverviewAmount: TLabel;
    lblGroupOverviewAmount: TLabel;
    tmrRemoveError: TTimer;
    cbxShowDeletedUser: TCheckBox;
    cbxShowDeletedGroups: TCheckBox;

    procedure FormShow(Sender: TObject);
    procedure sbtnAddUserClick(Sender: TObject);
    procedure sbtnBackToUserOverviewClick(Sender: TObject);
    procedure AdvSmoothButton1Click(Sender: TObject);
    procedure pcPagesChange(Sender: TObject);
    procedure sbtnGoToAddGroupClick(Sender: TObject);
    procedure sbtnAddUserToGroupClick(Sender: TObject);
    procedure sbtnagSearchUserClick(Sender: TObject);
    procedure sbtnAddGroupClick(Sender: TObject);
    procedure sbtnDeleteGroupClick(Sender: TObject);
    procedure sbtnDeleteUserClick(Sender: TObject);
    procedure sbtnGoToEditUserClick(Sender: TObject);
    procedure sbtnEditUserClick(Sender: TObject);
    procedure sbtnRemoveUserFromGroupClick(Sender: TObject);
    procedure sgrGroupsDrawCell(Sender: TObject; ACol, ARow: LongInt;
      Rect: TRect; State: TGridDrawState);
    procedure sbtnGoToEditGroupClick(Sender: TObject);
    procedure sbtnBackToGroupOverviewClick(Sender: TObject);
    procedure sbtnEditGroupClick(Sender: TObject);
    procedure slsbEditAddUserToGroupClick(Sender: TObject);
    procedure sbtnEditSearchUserClick(Sender: TObject);
    procedure sbtnEditRemoveGroupUserClick(Sender: TObject);
    procedure AdvSmoothMegaMenu1MenuSubItemClick(Sender: TObject;
      Menu: TAdvSmoothMegaMenu; MenuItem: TAdvSmoothMegaMenuItem;
      Item: TGDIPMenuSectionItem; Text: string);
    procedure AdvSmoothMegaMenu1MenuItemClick(Sender: TObject;
      ItemIndex: Integer);
    procedure sbtnAddUserProfilePictureClick(Sender: TObject);
    procedure sbtnEditUserProfilePictureClick(Sender: TObject);
    procedure sbtnAddGroupProfileClick(Sender: TObject);
    procedure sbtnEditGroupProfilePictureClick(Sender: TObject);
    procedure sbtnRefreshGroupClick(Sender: TObject);
    procedure sbtnRefreshUserClick(Sender: TObject);
    procedure sbtnLogOutClick(Sender: TObject);
    procedure tmrRemoveErrorTimer(Sender: TObject);
  private
    { Private declarations }
//    DBConnection : TPgConnection;
    getGroup: TPgQuery;
    RemovedUsersList: TStringList;

    timerCounter: integer;

    procedure RefreshUserOverView;
    procedure RefreshGroupOverView;
    procedure FillUserListbox(searchLB: TAdvSmoothListBox);
    procedure AddItemToSearchListBox(commando: string);
    procedure GroupSearchUser(sender: string);
    procedure RemoveUserFromGroup(command: string);

    procedure AddUserToGroup(command: string; selectedGroupId: integer);

    function HashString(const Input: string): string;
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation
//  uses DMdatabaseInfo;
  uses frmAddUser, frmAddGroup, frmEditUser, frmEditGroup;

{$R *.dfm}

procedure TForm2.AdvSmoothButton1Click(Sender: TObject);
var
  pgqAddUser: TPgQuery;
  testHash : string;
  AStream : TMemoryStream;
  BlobField: TBlobField;

//  stream: TMemoryStream;
//  niceBytes: TBytes;
begin
  pgqAddUser := TPgQuery.Create(nil);

  with DataModule2 do
  begin
    pgqAddUser.Connection := pgcDBconnection;
    timerCounter := 0;

    lblAddUserError.Caption := '';
    lblAddUserError.Font.Color := RGB(220, 20, 60);

    if((Length(edtUserName.Text) > 0) AND
    (Length(edtUserStoreName.Text) > 0) AND
    (Length(edtUserEmail.Text) > 0) AND
    (Length(edtUserTelephone.Text) > 0) AND
    (Length(edtUserNickName.Text) > 0)) then
    begin
      if(TRegEx.IsMatch(edtUserEmail.Text, '[^@ \t\r\n]+@[^@ \t\r\n]+\.[^@ \t\r\n]+')) then
      begin
        if(TRegEx.IsMatch(edtUserTelephone.Text, '^[0-9+\-]{10,}$')) then
        begin
          pgqCheckExistingUser.SQL.Text := '';
          pgqCheckExistingUser.SQL.Add('SELECT * FROM tbl_gebruikers');
          pgqCheckExistingUser.SQL.Add('WHERE LOWER(gbr_email)=:CheckDuplicateEmail');
          pgqCheckExistingUser.SQL.Add('OR LOWER(gbr_nicknaam)=:CheckDuplicateUserName');
          pgqCheckExistingUser.ParamByName('CheckDuplicateEmail').AsString := LowerCase(edtUserEmail.Text);
          pgqCheckExistingUser.ParamByName('CheckDuplicateUserName').AsString := LowerCase(edtUserNickName.Text);
          pgqCheckExistingUser.Open;

          if(pgqCheckExistingUser.RecordCount = 0) then
          begin
            pgqCheckExistingUser.Close;

            pgqAddUser.SQL.Text := '';
            pgqAddUser.SQL.Text := 'INSERT INTO tbl_gebruikers (gbr_naam, gbr_winkelnaam, gbr_tel, gbr_email, gbr_nicknaam, gbr_wachtwoord, gbr_profielfoto)';
            pgqAddUser.SQL.Add('VALUES (:username, :userStoreName, :userTel, :userEmail, :userNickname, :userPassword, :userProfilePicture)');

  //          pgqAddUser.SQL.Text := '';
  //          pgqAddUser.SQL.Add('SELECT * FROM tbl_gebruikers');
  //          pgqAddUser.Open;
  //          pgqAddUser.Append;
            pgqAddUser.ParamByName('username').AsString := Trim(edtUserName.Text);
            pgqAddUser.ParamByName('userStoreName').AsString := Trim(edtUserStoreName.Text);
            pgqAddUser.ParamByName('userTel').AsString := Trim(edtUserTelephone.Text);
            pgqAddUser.ParamByName('userEmail').AsString := Trim(edtUserEmail.Text);
            pgqAddUser.ParamByName('userNickname').AsString := Trim(edtUserNickName.Text);
            pgqAddUser.ParamByName('userPassword').AsString := HashString('Test123');


            AStream := TMemoryStream.Create;
            imgAddUserProfilePicture.Picture.SaveToStream(AStream);

            pgqAddUser.ParamByName('userProfilePicture').LoadFromStream(AStream, ftGraphic);
  //          BlobField := pgqAddUser.FieldByName('gbr_profielfoto') as TBlobField;
  //          BlobField.LoadFromStream(AStream);

            pgqAddUser.Execute;
            pgqAddUser.Free;
            AStream.Free;

            lblAddUserError.Font.Color := clGreen;
            lblAddUserError.Caption := 'Gebruiker ' +  Trim(edtUserNickName.Text) + ' succesvol toegevoegd';

            edtUserName.Text := '';
            edtUserStoreName.Text := '';
            edtUserTelephone.Text := '';
            edtUserNickName.Text := '';
            edtUserEmail.Text := '';
            imgAddUserProfilePicture.Picture := nil;
          end
          else
          begin
            lblAddUserError.Caption := 'Email of gebruikersnaam is al in gebruik';
          end;
        end
        else lblAddUserError.Caption := 'Telefoonnummer is niet correct geformatteerd' + #13#10 +
        'Formaat: 10 characters minimaal, alleen '+ #39 + '+' + #39 + ', ' + #39 + '-' + #39 + ' en cijfers 0-9 zijn toegestaan';
      end
      else lblAddUserError.Caption := 'Emailadres is niet correct geformatteerd';
    end
    else
    begin
      lblAddUserError.Caption := 'Vul alle velden in';
    end;
  end;

  tmrRemoveError.Enabled := true;
end;

procedure TForm2.AdvSmoothMegaMenu1MenuItemClick(Sender: TObject;
  ItemIndex: Integer);
begin
  if(ItemIndex = 0) then pcPages.ActivePage := tbsUserOverview
  else if (ItemIndex = 1) then pcPages.ActivePage := tbsGroupOverview
  else if (ItemIndex = 2) then pcPages.ActivePage := tbsOptions;

end;

procedure TForm2.AdvSmoothMegaMenu1MenuSubItemClick(Sender: TObject;
  Menu: TAdvSmoothMegaMenu; MenuItem: TAdvSmoothMegaMenuItem;
  Item: TGDIPMenuSectionItem; Text: string);
begin
  if (Text = 'Overzicht gebruikers') then pcPages.ActivePage := tbsUserOverview
  else if (Text = 'Gebruiker aanmaken') then pcPages.ActivePage := tbsAddUser
  else if (Text = 'Overzicht groepen') then pcPages.ActivePage := tbsGroupOverview
  else if (Text = 'Groep aanmaken') then pcPages.ActivePage := tbsAddGroup
  else if (Text = 'Uitloggen') then Self.Close;
end;

procedure TForm2.sbtnBackToGroupOverviewClick(Sender: TObject);
begin
  if(pcPages.ActivePage = tbsEditGroup) then
  begin
    RemovedUsersList.Free;
  end;

//  RefreshGroupOverView;
  pcPages.ActivePage := tbsGroupOverview;
end;

procedure TForm2.sbtnBackToUserOverviewClick(Sender: TObject);
begin
  pcPages.ActivePage := tbsUserOverview;
end;

procedure TForm2.FormShow(Sender: TObject);
var 
  i, j: integer;
begin
//  DBConnection := DataModule2.pgcDBconnection;

  slsbGroupAddedUsers.Items.Clear;

  pcPages.ActivePage := tbsUserOverview;

  with DataModule2 do
  begin
    cboxGroupOwner.Items.Add(pgqGetLoggedInUser.FieldByName('gbr_nicknaam').AsString);
    cboxGroupOwner.ItemIndex := 0;
    cboxEditGroupOwner.Items.Add(pgqGetLoggedInUser.FieldByName('gbr_nicknaam').AsString);
    cboxEditGroupOwner.ItemIndex := 0;

    sgrUsers.ColCount := 6;
    sgrUsers.Cells[0, 0] := 'Id';
    sgrUsers.Cells[1, 0] := 'Naam';
    sgrUsers.Cells[2, 0] := 'Winkelnaam';
    sgrUsers.Cells[3, 0] := 'Telefoon';
    sgrUsers.Cells[4, 0] := 'Email';
    sgrUsers.Cells[5, 0] := 'Gebruikersnaam';

    //RefreshUserOverView;

    sgrGroups.ColCount := 6;
    sgrGroups.Cells[0, 0] := 'Id';
    sgrGroups.Cells[1, 0] := 'Naam';
    sgrGroups.Cells[2, 0] := 'Eigenaar';
    sgrGroups.Cells[3, 0] := 'Aangemaakt';
    sgrGroups.Cells[4, 0] := 'Verwijderd';
    sgrGroups.Cells[5, 0] := 'Beschrijving';

    //RefreshGroupOverView;

    lblAddGroupError.Caption := '';
    lblEditUserError.Caption := '';
    lblAddGroupError.Caption := '';
    lblEditUserError.Caption := '';

    slsbUser.Items.Clear;
    slsbEditSearchUser.Items.Clear;
  end;

  lblAddUserError.Caption := '';
  lblAddGroupError.Caption := '';
  lblEditUserError.Caption := '';
  lblEditGroupError.Caption := '';

end;

procedure TForm2.pcPagesChange(Sender: TObject);
var
  i: integer;
begin
  if(pcPages.ActivePage = tbsUserOverview) then
  begin
    //RefreshUserOverView;
    Self.Caption := 'Gebruikersoverzicht';
  end
  else if(pcPages.ActivePage = tbsGroupOverview) then
  begin
    //RefreshGroupOverView;
    Self.Caption := 'Groepenoverzicht';
  end
  else if (pcPages.ActivePage = tbsOptions) then
  begin
    Self.Caption := 'Opties';
  end;
//  else if (pcPages.ActivePage = tbsAddGroup) then
//  begin
//    //getusers = empty if not updated database
//    FillUserListbox(slsbUser);
//
//  end
//  else if (pcPages.ActivePage = tbsEditGroup) then
//  begin
//    //getusers = empty if not updated database
//    FillUserListbox(slsbEditSearchUser);
//
//
//    RemovedUsersList := TStringList.Create;
//    RemovedUsersList.Duplicates := dupIgnore;
//  end;
end;

procedure TForm2.RefreshUserOverView;
var 
  i: integer;
begin
  with DataModule2 do
  begin
    if(cbxShowDeletedUser.Checked) then pgqGetUsers.SQL.Text := 'SELECT * FROM tbl_gebruikers ORDER BY gbr_id'
    else pgqGetUsers.SQL.Text := 'SELECT * FROM tbl_gebruikers WHERE gbr_del = false ORDER BY gbr_id';
    pgqGetUsers.Open;

  //  advShowUsers.Refresh;
    sgrUsers.BeginUpdate;

    sgrUsers.RowCount := DataModule2.pgqGetUsers.RecordCount + 1;

    for i := 1 to DataModule2.pgqGetUsers.RecordCount do
    begin
      sgrUsers.Cells[0, i] := pgqGetUsers.FieldByName('gbr_id').AsString;
      sgrUsers.Cells[1, i] := pgqGetUsers.FieldByName('gbr_naam').AsString;
      sgrUsers.Cells[2, i] := pgqGetUsers.FieldByName('gbr_winkelnaam').AsString;
      sgrUsers.Cells[3, i] := pgqGetUsers.FieldByName('gbr_tel').AsString;
      sgrUsers.Cells[4, i] := pgqGetUsers.FieldByName('gbr_email').AsString;
      sgrUsers.Cells[5, i] := pgqGetUsers.FieldByName('gbr_nicknaam').AsString;
      sgrUsers.Cells[6, i] := pgqGetUsers.FieldByName('gbr_wachtwoord').AsString;

      pgqGetUsers.Next;

    end;
    sgrUsers.EndUpdate;

    lblUserOverviewAmount.Caption := Format('%d gebruikers gevonden', [pgqGetUsers.RecordCount]);
    pgqGetUsers.Free;

  end;
end;

procedure TForm2.RefreshGroupOverView;
var
  i: integer;
begin
  with DataModule2 do
  begin
    if(cbxShowDeletedGroups.Checked) then
      pgqGetGroups.SQL.Text := 'SELECT * FROM tbl_groepen ORDER BY gro_id'
    else
      pgqGetGroups.SQL.Text := 'SELECT * FROM tbl_groepen WHERE gro_del = false ORDER BY gro_id';
    pgqGetGroups.Open;

    sgrGroups.BeginUpdate;
    sgrGroups.RowCount := DataModule2.pgqGetGroups.RecordCount + 1;

    for i := 1 to pgqGetGroups.RecordCount do
    begin
      sgrGroups.Cells[0, i] := pgqGetGroups.FieldByName('gro_id').AsString;
      sgrGroups.Cells[1, i] := pgqGetGroups.FieldByName('gro_naam').AsString;
      sgrGroups.Cells[2, i] := pgqGetGroups.FieldByName('gro_igenaar').AsString;
      sgrGroups.Cells[3, i] := pgqGetGroups.FieldByName('gro_aangemaakt').AsString;
      sgrGroups.Cells[4, i] := pgqGetGroups.FieldByName('gro_del').AsString;
      sgrGroups.Cells[5, i] := pgqGetGroups.FieldByName('gro_beschrijving').AsString;

      pgqGetGroups.Next;
    end;
    sgrGroups.EndUpdate;

    lblGroupOverviewAmount.Caption := Format('%d groepen gevonden', [DataModule2.pgqGetGroups.RecordCount]);
    pgqGetGroups.Free;


  end;


end;

procedure TForm2.sbtnGoToAddGroupClick(Sender: TObject);
var
  i: integer;
begin
//  FillUserListbox(slsbUser);
//
//  slsbGroupAddedUsers.Items.Clear;
//  pcPages.ActivePage := tbsAddGroup;
//  lblAddGroupError.Caption := '';
  frmGroupAdd.Show;

end;

procedure TForm2.FillUserListbox(searchLB: TAdvSmoothListBox);
var
  i: integer;
begin
  searchLB.Items.Clear;

  with DataModule2 do
  begin
    if(pgqGetUsers.RecordCount < 1) then
    begin
      pgqGetUsers.SQL.Text := 'SELECT * FROM tbl_gebruikers';
      pgqGetUsers.Open;
    end
    else
      pgqGetUsers.First;

    for i := 1 to pgqGetUsers.RecordCount do
    begin
      with searchLB.Items.Add do
      begin
        Caption := pgqGetUsers.FieldByName('gbr_nicknaam').AsString;
      end;

      DataModule2.pgqGetUsers.Next;
    end;

  end;

//  slsbGroupAddedUsers.Items.Clear;
//  slsbEditGroupUsers.Items.Clear;
end;

procedure TForm2.sbtnAddGroupClick(Sender: TObject);
var
  i, idLastCreatedGroup, indexDeletedUser, amountOfItems: integer;
//  pgqGroepsLeden: TPgQuery;
  AStream: TMemoryStream;
  BlobField: TBlobField;
  getText: string;
  getPosAdmin: integer;
begin
//  pgqGroepsLeden := TPgQuery.Create(nil);
//  pgqGroepsLeden.Connection := DataModule2.pgcDBconnection;
  lblAddGroupError.Font.Color := RGB(220, 20, 60);
  lblAddGroupError.Caption := '';

  if((Length(edtGroupName.Text) > 0)) then
  begin
    //creates the group
    DataModule2.pgqCheckExistingUser.Close;
    DataModule2.pgqCheckExistingUser.SQL.Text := 'SELECT * FROM tbl_gebruikers WHERE gbr_nicknaam=:groupOwner';
    DataModule2.pgqCheckExistingUser.ParamByName('groupOwner').AsString := cboxGroupOwner.Text;
    DataModule2.pgqCheckExistingUser.Open;

    DataModule2.pgqGetGroups.SQL.Text := 'INSERT INTO tbl_groepen (gro_naam, gro_igenaar, gro_aangemaakt, gro_del, gro_beschrijving, gro_profielfoto)';
    DataModule2.pgqGetGroups.SQL.Add('VALUES (:groupName, :groupOwner, :groupCreated, :groupDeleted, :groupDescription, :groupProfilePicture)');

    DataModule2.pgqGetGroups.ParamByName('groupName').AsString := Trim(edtGroupName.Text);
    DataModule2.pgqGetGroups.ParamByName('groupOwner').AsInteger := StrToInt(Trim(DataModule2.pgqCheckExistingUser.FieldByName('gbr_id').AsString));
    DataModule2.pgqGetGroups.ParamByName('groupCreated').AsDateTime := now;
    DataModule2.pgqGetGroups.ParamByName('groupDeleted').AsBoolean := false;
    DataModule2.pgqGetGroups.ParamByName('groupDescription').AsString := Trim(edtGroupDescription.Text);

    AStream := TMemoryStream.Create;
    imgAddGroupProfile.Picture.SaveToStream(AStream);
    DataModule2.pgqGetGroups.ParamByName('groupProfilePicture').LoadFromStream(AStream, ftGraphic);
//    BlobField := DataModule2.pgqGetGroups.FieldByName('gro_profielfoto') as TBlobField;
//    BlobField.LoadFromStream(AStream);
    DataModule2.pgqGetGroups.Execute;
    DataModule2.pgqGetGroups.Close;

    DataModule2.pgqGetGroups.SQL.Text := 'SELECT * FROM tbl_groepen ORDER BY gro_id DESC LIMIT 1';
    DataModule2.pgqGetGroups.Open;
    idLastCreatedGroup := DataModule2.pgqGetGroups.FieldByName('gro_id').AsInteger;
    DataModule2.pgqGetGroups.Close;

    AddUserToGroup('add', idLastCreatedGroup);

    //start clearing the boxes
    edtGroupName.Text := '';
    edtGroupDescription.Text := '';
    imgAddGroupProfile.Picture := nil;
    cboxGroupOwner.ItemIndex := 0;

    //clears the added users list
    slsbGroupAddedUsers.Items.Clear;
    getPosAdmin := cboxGroupOwner.Items.IndexOf(DataModule2.pgqGetLoggedInUser.FieldByName('gbr_nicknaam').AsString);

    if(getPosAdmin > -1) then
    begin
      amountOfItems := cboxGroupOwner.Items.Count;

      for I := 1 to amountOfItems do
      begin
        if( i - 1 = getPosAdmin) then continue
        else cboxGroupOwner.Items.Delete(i - 1);
      end;
    end;

//      getText := slsbGroupAddedUsers.Items[0].Caption;
//      indexDeletedUser := cboxGroupOwner.Items.IndexOf(getText);
//      if(indexDeletedUser <> -1) then cboxGroupOwner.Items.Delete(indexDeletedUser);
//      slsbGroupAddedUsers.Items.Delete(0);


    lblAddGroupError.Font.Color := clGreen;
    lblAddGroupError.Caption := 'Groep succesvol toegevoegd';
  end;
end;

procedure TForm2.sbtnAddGroupProfileClick(Sender: TObject);
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

procedure TForm2.AddUserToGroup(command: string; selectedGroupId: integer);
var
  pgqGroepsLeden, pgqCheckDuplicateUser: TPgQuery;
  i: integer;
  addedUserLB: TAdvSmoothListBox;
  userIsDuplicate, deletedUserStatus: boolean;

begin
  deletedUserStatus := false;
  pgqGroepsLeden := TPgQuery.Create(nil);
  pgqCheckDuplicateUser := TPgQuery.Create(nil);

  pgqGroepsLeden.Connection := DataModule2.pgcDBconnection;
  pgqCheckDuplicateUser.Connection := DataModule2.pgcDBconnection;

  userIsDuplicate := false;

  if(command = 'add') then
  begin
    addedUserLB := slsbGroupAddedUsers;

  end
  else if (command = 'edit') then
  begin
    addedUserLB := slsbEditGroupUsers;
  end;

  pgqGroepsleden.SQL.Text := 'SELECT * FROM tbl_groepleden';
  pgqGroepsleden.Open;
  for I := 1 to addedUserLB.Items.Count do
  begin
    DataModule2.pgqCheckExistingUser.SQL.Text := '';
    DataModule2.pgqCheckExistingUser.SQL.Add('SELECT gbr_id FROM tbl_gebruikers');
    DataModule2.pgqCheckExistingUser.SQL.Add('WHERE LOWER(gbr_nicknaam)=:currentUser');
    DataModule2.pgqCheckExistingUser.ParamByName('currentUser').AsString := LowerCase(Trim(addedUserLB.Items[i - 1].Caption));
    DataModule2.pgqCheckExistingUser.Open;

    if(command = 'edit') then
    begin
      pgqCheckDuplicateUser.SQL.Text := 'SELECT * FROM tbl_groepleden';
      pgqCheckDuplicateUser.SQL.Add('WHERE grl_groep = :currentGroup');
      pgqCheckDuplicateUser.SQL.Add('AND grl_gebruiker = :currentUser');
      pgqCheckDuplicateUser.ParamByName('currentGroup').AsInteger := selectedGroupId;
      pgqCheckDuplicateUser.ParamByName('currentUser').AsInteger := DataModule2.pgqCheckExistingUser.FieldByName('gbr_id').AsInteger;
      pgqCheckDuplicateUser.Open;

      if(pgqCheckDuplicateUser.RecordCount > 0) then userIsDuplicate := true
      else userIsDuplicate := false;
    end;

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

procedure TForm2.sbtnAddUserClick(Sender: TObject);
var
  i: integer;
begin
  Form3.Show;
end;

procedure TForm2.sbtnAddUserProfilePictureClick(Sender: TObject);
var
  testing: TBitmap;
begin
  testing := TBitmap.Create;


  with TOpenDialog.Create(self) do
  try
    Caption := 'Open afbeelding';
    Filter := 'Image Files (*.jpg;*.jpeg;*.png)|*.jpg;*.jpeg;*.png';
    Options := [TOpenOption.ofPathMustExist, TOpenOption.ofPathMustExist];
    if (Execute) then imgAddUserProfilePicture.Picture.LoadFromFile(FileName);

  finally
    Free;
  end;
end;

procedure TForm2.sbtnAddUserToGroupClick(Sender: TObject);
var
  chosenListBox: TAdvSmoothListBox;
  senderName: TAdvSmoothButton;
begin
  AddItemToSearchListBox('add');
end;

procedure TForm2.AddItemToSearchListBox(commando: string);
var
  i, temp, editDuplicateLocation: integer;
  searchLB, addedUsersLB: TAdvSmoothListBox;
  errorLBL: TLabel;
  groupOwnerCBOX: TComboBox;

begin

  if(commando = 'add') then
  begin
    searchLB := slsbUser;
    addedUsersLB := slsbGroupAddedUsers;
    errorLBL := lblAddGroupError;
    groupOwnerCBOX := cboxGroupOwner;
  end
  else if (commando = 'edit') then
  begin
    searchLB := slsbEditSearchUser;
    addedUsersLB := slsbEditGroupUsers;
    errorLBL := lblEditGroupError;
    groupOwnerCBOX := cboxEditGroupOwner
  end;

  if(searchLB.Items.CountSelected > 0) then
  begin
    temp := addedUsersLB.Items.IndexOfCaption(searchLB.Items[searchLB.SelectedItemIndex].Caption);
    if(temp = -1) then
    begin
      with addedUsersLB.Items.Add do
      begin
        Caption := searchLB.Items[searchLB.SelectedItemIndex].Caption;
      end;

      if(groupOwnerCBOX.Items.IndexOf(searchLB.Items[searchLB.SelectedItemIndex].Caption) = -1) then
        groupOwnerCBOX.Items.Add(searchLB.Items[searchLB.SelectedItemIndex].Caption);

      if(commando = 'edit') then
      begin
        editDuplicateLocation := RemovedUsersList.IndexOf(searchLB.Items[searchLB.SelectedItemIndex].Caption);

        if(editDuplicateLocation > -1) then
        begin
          RemovedUsersList.Delete(editDuplicateLocation);
        end;
      end;
    end
    else errorLBL.Caption := 'Gebruiker al in lijst';
  end;

//  for i := 1 to searchLB.Items.Count do
//  begin
//    if(searchLB.Items[i - 1].Selected) then //if its selected...
//    begin
//      temp := addedUsersLB.Items.IndexOfCaption(searchLB.Items[i-1].Caption);
//      if(temp = -1) then
//      begin
//        with addedUsersLB.Items.Add do
//        begin
//          Caption := searchLB.Items[i - 1].Caption;
//        end;
//
//        groupOwnerCBOX.Items.Add(searchLB.Items[i - 1].Caption);
//
//        if(commando = 'edit') then
//        begin
//          editDuplicateLocation := RemovedUsersList.IndexOf(searchLB.Items[i - 1].Caption);
//
//          if(editDuplicateLocation > -1) then
//          begin
//            RemovedUsersList.Delete(editDuplicateLocation);
//          end;
//        end;
//
//      end
//      else errorLBL.Caption := 'Gebruiker al in lijst';
//    end;
//  end;
end;

procedure TForm2.sbtnagSearchUserClick(Sender: TObject);
var
  i: integer;
begin
  lblAddGroupError.Caption := '';

  GroupSearchUser('add');
end;

procedure TForm2.GroupSearchUser(sender: string);
var
  i: integer;
  tempQuery: TPgQuery;
  searchLB: TAdvSmoothListBox;
  searchBar: TEdit;
begin
  if(sender = 'add') then
  begin
    searchLB := slsbUser;
    searchBar := edtAddGroupSearchUser;
  end
  else if (sender = 'edit') then
  begin
    searchLB := slsbEditSearchUser;
    searchBar := edtEditGroupSearch;
  end;
  //TODO: Fix empty search not showing every user

  lblAddUserError.Caption := '';

  tempQuery := TPgQuery.Create(nil);
  tempQuery.Connection := DataModule2.pgcDBconnection;

  searchLB.Items.Clear;
  tempQuery.SQL.Text := '';
  tempQuery.SQL.Add('SELECT * FROM tbl_gebruikers');
  if(Length(searchBar.Text) > 0) then
  begin
    tempQuery.SQL.Add('WHERE LOWER(gbr_nicknaam) LIKE :user');
    tempQuery.SQL.Add('OR LOWER(gbr_email)=:user');
    tempQuery.SQL.Add('OR LOWER(gbr_naam)=:user');
    tempQuery.SQL.Add('ORDER BY gbr_nicknaam');
    tempQuery.ParamByName('user').AsString := #37 + LowerCase(searchBar.Text) + #37;
  end
  else tempQuery.SQL.Add('ORDER BY gbr_nicknaam');
  tempQuery.Open;

  tempQuery.First;
  for i := 1 to tempQuery.RecordCount do
  begin
    with searchLB.Items.Add do
    begin
      Caption := tempQuery.FieldByName('gbr_nicknaam').AsString;
      tempQuery.Next;
    end;
  end;

  tempQuery.Free;
end;

procedure TForm2.sbtnDeleteGroupClick(Sender: TObject);
var
  selectedRowId, getGroupId: integer;
begin
  if(sgrGroups.Cells[0, 1] <> '') then
  begin
    selectedRowId := sgrGroups.Row;
    getGroupId := StrToInt(sgrGroups.Cells[0, selectedRowId]);

    DataModule2.pgqDelete.SQL.Text := 'SELECT * FROM tbl_groepen WHERE gro_id=:selectedId';
    DataModule2.pgqDelete.ParamByName('selectedId').AsInteger := getGroupId;
    DataModule2.pgqDelete.Open;
    DataModule2.pgqDelete.Edit;
    DataModule2.pgqDelete.FieldByName('gro_del').AsBoolean := true;
    DataModule2.pgqDelete.Post;

    RefreshGroupOverView;
  end;

end;

procedure TForm2.sbtnDeleteUserClick(Sender: TObject);
var 
  selectedRowId, getUserId, userChoice: integer;
  currUser: string;
begin
  selectedRowId := sgrUsers.Row;

  if(sgrUsers.Cells[0, 1] <> '') then
  begin
    getUserId := StrToInt(sgrUsers.Cells[0, selectedRowId]);

    with DataModule2 do
    begin
      pgqDelete.SQL.Text := 'SELECT * FROM tbl_gebruikers WHERE gbr_id=:selectedId';
      pgqDelete.ParamByName('SelectedId').AsInteger := getUserId;
      pgqDelete.Open;

      currUser := pgqDelete.FieldByName('gbr_nicknaam').AsString;
      userChoice := Application.MessageBox('Weet je zeker dat je deze gebruiker wilt verwijderen?' , 'Bevestig verwijderverzoek', MB_OKCANCEL );

      if(userChoice = 1) then
      begin
        pgqDelete.Edit;
        pgqDelete.FieldByName('gbr_del').AsBoolean := true;
        pgqDelete.Post;
      end;
    end;

    RefreshUserOverView;
  end;

//  else if (userChoice = 2) then
//  begin
//    ShowMessage('Resultaat 1');
//  end;


//  DataModule2.pgqDelete.SQL.Text := 'DELETE FROM tbl_gebruikers WHERE gbr_id=:SelectedId';
//  DataModule2.pgqDelete.ParamByName('SelectedId').AsInteger := getUserId;
//  DataModule2.pgqDelete.Execute;



end;

procedure TForm2.sbtnEditGroupClick(Sender: TObject);
var
  pgqEditGroupMember, pgqGetDeletedUserId: TPgQuery;
  groupId, i: integer;
  AStream: TMemoryStream;
  BlobField: TBlobField;
begin
  pgqEditGroupMember := TPgQuery.Create(nil);
  pgqGetDeletedUserId := TPgQuery.Create(nil);
  pgqEditGroupMember.Connection := DataModule2.pgcDBconnection;
  pgqGetDeletedUserId.Connection := DataModule2.pgcDBconnection;

  lblEditGroupError.Caption := '';
  lblEditGroupError.Font.Color := RGB(220, 20, 60);

  groupId := getGroup.FieldByName('gro_id').AsInteger;

  for i := 1 to RemovedUsersList.Count do
  begin
    pgqGetDeletedUserId.SQL.Text := '';
    pgqGetDeletedUserId.SQL.Add('SELECT * FROM tbl_gebruikers');
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

    pgqGetDeletedUserId.Close;
    pgqEditGroupMember.Close;

  end;
  AddUserToGroup('edit', groupId);

  pgqGetDeletedUserId.Free;
  pgqEditGroupMember.Free;

  getGroup.Edit;
  getGroup.FieldByName('gro_naam').AsString := edtEditGroupName.Text;
  getGroup.FieldByName('gro_beschrijving').AsString := edtEditGroupDescription.Text;

  //insert image into database
  AStream := TMemoryStream.Create;
  imgEditGroupProfile.Picture.SaveToStream(AStream);
  BlobField := getGroup.FieldByName('gro_profielfoto') as TBlobField;
  BlobField.LoadFromStream(AStream);

  getGroup.Post;

  RemovedUsersList.Clear;
  //RefreshGroupOverView;
  RemovedUsersList.Free;
  pcPages.ActivePage := tbsGroupOverview;

end;

procedure TForm2.sbtnEditGroupProfilePictureClick(Sender: TObject);
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

procedure TForm2.sbtnEditRemoveGroupUserClick(Sender: TObject);
begin
  RemoveUserFromGroup('edit');
end;

procedure TForm2.sbtnEditSearchUserClick(Sender: TObject);
begin
  GroupSearchUser('edit');
end;

procedure TForm2.sbtnEditUserClick(Sender: TObject);
var
  BlobField: TBlobField;
  AStream: TMemoryStream;
  pgqDuplicateNameCheck : TPgQuery;
begin
  pgqDuplicateNameCheck := TPgQuery.Create(nil);
  pgqDuplicateNameCheck.Connection := DataModule2.pgcDBconnection;

  tmrRemoveError.Enabled := false;

  lblEditUserError.Font.Color := RGB(220, 20, 60);
  lblEditUserError.Caption := '';

//  DataModule2.pgqCheckExistingUser.Close;

  if((Length(edtEditUserName.Text) > 0) AND
  (Length(edtEditStoreName.Text) > 0) AND
  (Length(edtEditUserEmail.Text) > 0) AND
  (Length(edtEditUserTelephone.Text) > 0) AND
  (Length(edtEditUserNickName.Text) > 0)) then
  begin
    if(TRegEx.IsMatch(edtEditUserEmail.Text, '[^@ \t\r\n]+@[^@ \t\r\n]+\.[^@ \t\r\n]+')) then
    begin
      if(TRegEx.IsMatch(edtEditUserTelephone.Text, '^[0-9+\-]{10,}$')) then
      begin
        pgqDuplicateNameCheck.Close;

        pgqDuplicateNameCheck.SQL.Text := '';
        pgqDuplicateNameCheck.SQL.Add('SELECT * FROM tbl_gebruikers');
        pgqDuplicateNameCheck.SQL.Add('WHERE (LOWER(gbr_email)=:CheckDuplicateEmail');
        pgqDuplicateNameCheck.SQL.Add('OR LOWER(gbr_nicknaam)=:CheckDuplicateUserName)');
        pgqDuplicateNameCheck.SQL.Add('AND NOT gbr_id=:selectedUserId');

        pgqDuplicateNameCheck.ParamByName('CheckDuplicateEmail').AsString := LowerCase(edtEditUserEmail.Text);
        pgqDuplicateNameCheck.ParamByName('CheckDuplicateUserName').AsString := LowerCase(edtEditUserNickName.Text);
        pgqDuplicateNameCheck.ParamByName('selectedUserId').AsInteger := DataModule2.pgqCheckExistingUser.FieldByName('gbr_id').AsInteger;
        pgqDuplicateNameCheck.Open;

        if(pgqDuplicateNameCheck.RecordCount = 0) then
        begin


          DataModule2.pgqCheckExistingUser.Edit;
          DataModule2.pgqCheckExistingUser.FieldByName('gbr_naam').AsString := edtEditUserName.Text;
          DataModule2.pgqCheckExistingUser.FieldByName('gbr_winkelnaam').AsString := edtEditStoreName.Text;
          DataModule2.pgqCheckExistingUser.FieldByName('gbr_email').AsString := edtEditUserEmail.Text;
          DataModule2.pgqCheckExistingUser.FieldByName('gbr_tel').AsString := edtEditUserTelephone.Text;
          DataModule2.pgqCheckExistingUser.FieldByName('gbr_nicknaam').AsString := edtEditUserNickName.Text;

          AStream := TMemoryStream.Create;
          imgEditProfilePicture.Picture.SaveToStream(AStream);
          BlobField := DataModule2.pgqCheckExistingUser.FieldByName('gbr_profielfoto') as TBlobField;
          BlobField.LoadFromStream(AStream);

          if(Length(edtEditUserPassword.Text) > 0) then
          begin
            DataModule2.pgqCheckExistingUser.FieldByName('gbr_wachtwoord').AsString := HashString(edtEditUserPassword.Text);
          end;

          lblEditUserError.Caption := 'Gebruiker succesvol aangepast';
          lblEditUserError.Font.Color := clGreen;

          DataModule2.pgqCheckExistingUser.Post;
        end
        else
        begin
          lblEditUserError.Caption := 'Email of gebruikersnaam is al in gebruik';
        end;
      end
      else lblEditUserError.Caption := 'Telefoonnummer is niet correct geformatteerd' + #13#10 +
      'Formaat: 10 characters minimaal, alleen '+ #39 + '+' + #39 + ', ' + #39 + '-' + #39 + ' en cijfers 0-9 zijn toegestaan';
    end
    else lblEditUserError.Caption := 'Emailadres is niet correct geformatteerd';
  end
  else
  begin
    lblEditUserError.Caption := 'Vul alle velden in';
  end;

  tmrRemoveError.Enabled := true;
  pgqDuplicateNameCheck.Free;

end;

procedure TForm2.sbtnEditUserProfilePictureClick(Sender: TObject);
begin
  with TOpenDialog.Create(self) do
    try
      Caption := 'Open afbeelding';
      Filter := 'Image Files (*.jpg;*.jpeg;*.png)|*.jpg;*.jpeg;*.png';
      Options := [TOpenOption.ofPathMustExist, TOpenOption.ofPathMustExist];
      if (Execute) then imgEditProfilePicture.Picture.LoadFromFile(FileName);

    finally
      Free;
    end;
end;

procedure TForm2.sbtnGoToEditGroupClick(Sender: TObject);
var
  selectedRowId, getGroupId, i: integer;
//  getSelectedGroup, getSelectedGroupOwner : TPgQuery;
  stream: TStream;
begin
  //clears previous attempts
//  cboxEditGroupOwner.Items.Clear;
  FillUserListbox(slsbEditSearchUser);

  //creates list for deleting user from group
//  RemovedUsersList := TStringList.Create;
//  RemovedUsersList.Duplicates := dupIgnore;

  if(sgrGroups.Cells[0, 1] <> '') then
  begin
//    DataModule2.pgqGetSelectedGroup := TPgQuery.Create(nil);
//    DataModule2.pgqGetSelectedGroupOwner := TPgQuery.Create(nil);
//    getGroup := TPgQuery.Create(nil);
//    DataModule2.pgqGetSelectedGroup.Connection := DataModule2.pgcDBconnection;
//    DataModule2.pgqGetSelectedGroupOwner.Connection := DataModule2.pgcDBconnection;
//    getGroup.Connection := DataModule2.pgcDBconnection;

    selectedRowId := sgrGroups.Row;
    getGroupId := StrToInt(sgrGroups.Cells[0, selectedRowId]);
    slsbEditGroupUsers.Items.Clear;

    //gets row with selected group
    if(DataModule2.pgqGetGroupMembers = nil) then
    begin
      DataModule2.pgqGetGroupMembers := TPgQuery.Create(nil);
      DataModule2.pgqGetGroupMembers.Connection := DataModule2.pgcDBconnection;
    end;
    DataModule2.pgqGetGroupMembers.SQL.Text := 'SELECT * FROM tbl_groepleden';
    DataModule2.pgqGetGroupMembers.SQL.Add('WHERE grl_groep=:selectedGroup');
    DataModule2.pgqGetGroupMembers.SQL.Add('AND grl_del = false');
    DataModule2.pgqGetGroupMembers.ParamByName('selectedGroup').AsInteger := getGroupId;
    DataModule2.pgqGetGroupMembers.Open;

    if(DataModule2.pgqGetSelectedGroup = nil) then
    begin
      DataModule2.pgqGetSelectedGroup := TPgQuery.Create(nil);
      DataModule2.pgqGetSelectedGroup.Connection := DataModule2.pgcDBconnection;
    end;
    DataModule2.pgqGetSelectedGroup.SQL.Text := 'SELECT * FROM tbl_groepen WHERE gro_id=:selectedGroup';
    DataModule2.pgqGetSelectedGroup.ParamByName('selectedGroup').AsInteger := getGroupId;
    DataModule2.pgqGetSelectedGroup.Open;

    frmGroupEdit.Show;

//    edtEditGroupName.Text := getGroup.FieldByName('gro_naam').AsString;
//    edtEditGroupDescription.Text := getGroup.FieldByName('gro_beschrijving').AsString;
//    cbxGroupDeleted.Checked := getGroup.FieldByName('gro_del').AsBoolean;
//    stream := getGroup.CreateBlobStream(getGroup.FieldByName('gro_profielfoto'), bmRead);
//    imgEditGroupProfile.Picture.LoadFromStream(stream);
//
//    //get information from users table
//    DataModule2.pgqGetSelectedGroupOwner.SQL.Text := 'SELECT * FROM tbl_gebruikers WHERE gbr_id=:groupOwner';
//    DataModule2.pgqGetSelectedGroupOwner.ParamByName('groupOwner').AsInteger := getGroup.FieldByName('gro_igenaar').AsInteger;
//    DataModule2.pgqGetSelectedGroupOwner.Open;
//
//    cboxEditGroupOwner.Items.Add(DataModule2.pgqGetSelectedGroupOwner.FieldByName('gbr_nicknaam').AsString);
//    cboxEditGroupOwner.ItemIndex := 0;
//    DataModule2.pgqGetSelectedGroupOwner.Free;
//
//    //get every row with the selected group
//    for i := 1 to DataModule2.pgqGetSelectedGroup.RecordCount do
//    begin
//      with slsbEditGroupUsers.Items.Add do
//      begin
//        DataModule2.pgqCheckExistingUser.SQL.Text := 'SELECT * FROM tbl_gebruikers WHERE gbr_id=:currentUserId';
//        DataModule2.pgqCheckExistingUser.ParamByName('currentUserId').AsInteger := DataModule2.pgqGetSelectedGroup.FieldByName('grl_gebruiker').AsInteger;
//        DataModule2.pgqCheckExistingUser.Open;
//
//        Caption := DataModule2.pgqCheckExistingUser.FieldByName('gbr_nicknaam').AsString;
//      end;
//      cboxEditGroupOwner.Items.Add(DataModule2.pgqCheckExistingUser.FieldByName('gbr_nicknaam').AsString);
//      DataModule2.pgqGetSelectedGroup.Next;
//    end;
//
//    DataModule2.pgqGetSelectedGroup.Free;

//    pcPages.ActivePage := tbsEditGroup;
  end;
end;

procedure TForm2.sbtnGoToEditUserClick(Sender: TObject);
var
  selectedRowId, getUserId: integer;
  stream: TStream;
begin
  selectedRowId := sgrUsers.Row;

  if(sgrUsers.Cells[0, 1] <> '') then
  begin
    getUserId := StrToInt(sgrUsers.Cells[0, selectedRowId]);

    with DataModule2 do
    begin
      pgqCheckExistingUser.SQL.Text := '';
      pgqCheckExistingUser.SQL.Add('SELECT * FROM tbl_gebruikers');
      pgqCheckExistingUser.SQL.Add('WHERE gbr_id=:selectedId');
      pgqCheckExistingUser.ParamByName('selectedId').AsInteger := getUserId;
      pgqCheckExistingUser.Open;

//      edtEditUserName.Text := pgqCheckExistingUser.FieldByName('gbr_naam').AsString;
//      edtEditStoreName.Text := pgqCheckExistingUser.FieldByName('gbr_winkelnaam').AsString;
//      edtEditUserTelephone.Text := pgqCheckExistingUser.FieldByName('gbr_tel').AsString;
//      edtEditUserEmail.Text := pgqCheckExistingUser.FieldByName('gbr_email').AsString;
//      edtEditUserNickName.Text := pgqCheckExistingUser.FieldByName('gbr_nicknaam').AsString;
//
//      //loads image from database to TImage
//      stream := pgqCheckExistingUser.CreateBlobStream(pgqCheckExistingUser.FieldByName('gbr_profielfoto'), bmRead);
//      imgEditProfilePicture.Picture.LoadFromStream(stream);
    end;

    frmUserEdit.Show;
//    pcPages.ActivePage := tbsEditUser;

  end;



    
end;

procedure TForm2.sbtnLogOutClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TForm2.sbtnRefreshGroupClick(Sender: TObject);
begin
  RefreshGroupOverView;
end;

procedure TForm2.sbtnRefreshUserClick(Sender: TObject);
begin
  RefreshUserOverView;
end;

procedure TForm2.sbtnRemoveUserFromGroupClick(Sender: TObject);
begin
  RemoveUserFromGroup('add');
end;

procedure TForm2.RemoveUserFromGroup(command: string);
var
  indexDeletedUser, editDuplicateLocation: integer;
  getText: string;
  searchLB, addedUsersLB: TAdvSmoothListBox;
  ownerCBOX: TComboBox;
begin
  if(command = 'add') then
  begin
    searchLB := slsbUser;
    addedUsersLB := slsbGroupAddedUsers;
    ownerCBOX := cboxGroupOwner;
  end
  else if (command = 'edit') then
  begin
    searchLB := slsbEditSearchUser;
    addedUsersLB := slsbEditGroupUsers;
    ownerCBOX := cboxEditGroupOwner;
  end;

  if(addedUsersLB.Items.CountSelected > 0) then
  begin
    getText := addedUsersLB.Items[addedUsersLB.SelectedItemIndex].Caption;
    indexDeletedUser := ownerCBOX.Items.IndexOf(getText);

    if(command = 'edit') then
    begin
      editDuplicateLocation := RemovedUsersList.IndexOf(getText);

      if(editDuplicateLocation = -1) then
      begin
        RemovedUsersList.Add(getText);
      end;
    end;
  end;

  addedUsersLB.Items.Delete(addedUsersLB.SelectedItemIndex);

  if(getText <> DataModule2.pgqGetLoggedInUser.FieldByName('gbr_nicknaam').AsString) then
    if(indexDeletedUser <> -1) then ownerCBOX.Items.Delete(indexDeletedUser);
end;

procedure TForm2.sgrGroupsDrawCell(Sender: TObject; ACol, ARow: LongInt;
  Rect: TRect; State: TGridDrawState);
var
  AGrid : TStringGrid;
begin
  AGrid:=TStringGrid(Sender);

  if gdFixed in State then //if is fixed use the clBtnFace color
    AGrid.Canvas.Brush.Color := clBtnFace
  else
  if gdSelected in State then //if is selected use the clAqua color
    AGrid.Canvas.Brush.Color := rgb(176, 226, 255)
  else
    AGrid.Canvas.Brush.Color := clWindow;

  AGrid.Canvas.FillRect(Rect);
  AGrid.Canvas.TextOut(Rect.Left + 2, Rect.Top + 2, AGrid.Cells[ACol, ARow]);
end;

procedure TForm2.slsbEditAddUserToGroupClick(Sender: TObject);
begin
  AddItemToSearchListBox('edit');
end;

procedure TForm2.tmrRemoveErrorTimer(Sender: TObject);
begin

  timerCounter := timerCounter + 1;

  if(timerCounter > 8) then
  begin
    lblAddUserError.Caption := '';
    lblAddGroupError.Caption := '';
    lblEditUserError.Caption := '';
    lblEditGroupError.Caption := '';

    tmrRemoveError.Enabled := false;
  end;


end;

Function TForm2.HashString(const Input: string): string;
begin
  Result := THashSHA2.GetHashString(Input, THashSHA2.TSHA2Version.SHA256);
end;

end.
