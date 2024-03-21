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
    pgqCheckExistingUser: TPgQuery;
    dscShowGroups: TDataSource;
    pgqGetGroups: TPgQuery;
    pgqGetGroupsgro_id: TIntegerField;
    pgqGetGroupsgro_naam: TStringField;
    pgqGetGroupsgro_igenaar: TIntegerField;
    pgqGetGroupsgro_aangemaakt: TDateTimeField;
    pgqGetGroupsgro_del: TBooleanField;
    pcPages: TPageControl;
    tbsUserOverview: TTabSheet;
    Label3: TLabel;
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
    Label6: TLabel;
    edtEditUserName: TEdit;
    edtEditStoreName: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    edtEditUserEmail: TEdit;
    edtEditUserTelephone: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    edtEditUserNickName: TEdit;
    AdvSmoothButton3: TAdvSmoothButton;
    sbtnEditUser: TAdvSmoothButton;
    lblEditUserError: TLabel;
    edtEditUserPassword: TEdit;
    Label12: TLabel;
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
    AdvSmoothPanel1: TAdvSmoothPanel;
    pgqGetGroupsgro_profielfoto: TBlobField;
    pgqGetGroupsgro_beschrijving: TMemoField;
    imgAddUserProfilePicture: TImage;
    sbtnAddUserProfilePicture: TAdvSmoothButton;
    Label19: TLabel;
    Label20: TLabel;
    sbtnEditUserProfilePicture: TAdvSmoothButton;
    imgEditProfilePicture: TImage;
    sbtnRefreshGroup: TAdvSmoothButton;
    sbtnRefreshUser: TAdvSmoothButton;

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
  private
    { Private declarations }
    DBConnection : TPgConnection;
    DBLoggedInUser, getGroup: TPgQuery;
    RemovedUsersList: TStringList;

    procedure RefreshUserOverView;
    procedure RefreshGroupOverView;
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
  pgqAddUser.Connection := DataModule2.pgcDBconnection;

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


          pgqAddUser.SQL.Text := '';
          pgqAddUser.SQL.Add('SELECT * FROM tbl_gebruikers');
          pgqAddUser.Open;
          pgqAddUser.Append;
          pgqAddUser.FieldByName('gbr_naam').AsString := Trim(edtUserName.Text);
          pgqAddUser.FieldByName('gbr_winkelnaam').AsString := Trim(edtUserStoreName.Text);
          pgqAddUser.FieldByName('gbr_tel').AsString := Trim(edtUserTelephone.Text);
          pgqAddUser.FieldByName('gbr_email').AsString := Trim(edtUserEmail.Text);
          pgqAddUser.FieldByName('gbr_nicknaam').AsString := Trim(edtUserNickName.Text);
          pgqAddUser.FieldByName('gbr_wachtwoord').AsString := HashString('Test123');

          AStream := TMemoryStream.Create;
          imgAddUserProfilePicture.Picture.SaveToStream(AStream);
          BlobField := pgqAddUser.FieldByName('gbr_profielfoto') as TBlobField;
          BlobField.LoadFromStream(AStream);

//          pgqAddUser.SQL.Text := '';
//          pgqAddUser.SQL.Add('INSERT INTO tbl_gebruikers(gbr_naam, gbr_winkelnaam, gbr_tel, gbr_email, gbr_nicknaam, gbr_wachtwoord, gbr_profielfoto)');
//          pgqAddUser.SQL.Add('VALUES (:userName, :userStoreName, :userTel, :userEmail, :userNickname, :userPassword, :userProfilePicture)');
//          pgqAddUser.ParamByName('userName').AsString := Trim(edtUserName.Text);
//          pgqAddUser.ParamByName('userStoreName').AsString := Trim(edtUserStoreName.Text);
//          pgqAddUser.ParamByName('userTel').AsString := Trim(edtUserTelephone.Text);
//          pgqAddUser.ParamByName('userEmail').AsString := Trim(edtUserEmail.Text);
//          pgqAddUser.ParamByName('userNickname').AsString := Trim(edtUserNickName.Text);
//          pgqAddUser.ParamByName('userPassword').AsString := HashString('Test123');

//          AStream := TMemoryStream.Create;
//          imgAddUserProfilePicture.Picture.SaveToStream(AStream);
//          pgqAddUser.ParamByName('userProfilePicture').LoadFromStream(AStream, ftGraphic);

          pgqAddUser.Post;
          AStream.Free;

//          pgqAddUser.Post;
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
  else if (Text = 'Groep aanmaken') then pcPages.ActivePage := tbsAddGroup;
       


end;

procedure TForm2.sbtnBackToGroupOverviewClick(Sender: TObject);
begin
  if(pcPages.ActivePage = tbsEditGroup) then
  begin
    RemovedUsersList.Clear;
  end;

  RefreshGroupOverView;
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
  DBConnection := DataModule2.pgcDBconnection;
  DBLoggedInUser := DataModule2.pgqGetLoggedInUser;

  slsbGroupAddedUsers.Items.Clear;

  pcPages.ActivePage := tbsUserOverview;
  cboxGroupOwner.Items.Add(DataModule2.pgqGetLoggedInUser.FieldByName('gbr_nicknaam').AsString);
  cboxGroupOwner.ItemIndex := 0;
  cboxEditGroupOwner.Items.Add(DataModule2.pgqGetLoggedInUser.FieldByName('gbr_nicknaam').AsString);
  cboxEditGroupOwner.ItemIndex := 0;

  RefreshUserOverView;

  RefreshGroupOverView;

  lblAddGroupError.Caption := '';
  lblEditUserError.Caption := '';
    
  slsbUser.Items.Clear;
  slsbEditSearchUser.Items.Clear;

  DataModule2.pgqGetUsers.First;

  for i := 1 to DataModule2.pgqGetUsers.RecordCount do
  begin
    with slsbUser.Items.Add do
    begin
      Caption := DataModule2.pgqGetUsersgbr_nicknaam.Text;
    end;

    with slsbEditSearchUser.Items.Add do
    begin
      Caption := DataModule2.pgqGetUsersgbr_nicknaam.Text;
    end;

    DataModule2.pgqGetUsers.Next;
  end;

  lblAddUserError.Caption := '';
  lblAddGroupError.Caption := '';
  lblEditUserError.Caption := '';
  lblEditGroupError.Caption := '';

  RemovedUsersList := TStringList.Create;
  RemovedUsersList.Duplicates := dupIgnore;
end;

procedure TForm2.pcPagesChange(Sender: TObject);
var
  i: integer;
begin
  if(pcPages.ActivePage = tbsUserOverview) then
  begin
    RefreshUserOverView;
  end
  else if(pcPages.ActivePage = tbsGroupOverview) then
  begin
    RefreshGroupOverView;
  end
  else if (pcPages.ActivePage = tbsAddGroup) then
  begin
//    slsbUser.Items.Clear;
//    pgqGetUsers.First;
//    
//    for i := 1 to pgqGetUsers.RecordCount do
//    begin
//      with slsbUser.Items.Add do
//      begin
//        Caption := pgqGetUsersgbr_naam.Text;
//        pgqGetUsers.Next;      
//      end;
//    end;

  end;
end;

procedure TForm2.RefreshUserOverView;
var 
  i: integer;
begin
  DataModule2.pgqGetUsers.SQL.Text := '';
  DataModule2.pgqGetUsers.SQL.Add('SELECT * FROM tbl_gebruikers ORDER BY gbr_id');
  DataModule2.pgqGetUsers.Open;

//  advShowUsers.Refresh;

  sgrUsers.ColCount := 6;
  sgrUsers.RowCount := DataModule2.pgqGetUsers.RecordCount + 1;

  sgrUsers.Cells[0, 0] := 'Id';
  sgrUsers.Cells[1, 0] := 'Naam';
  sgrUsers.Cells[2, 0] := 'Winkelnaam';
  sgrUsers.Cells[3, 0] := 'Telefoon';
  sgrUsers.Cells[4, 0] := 'Email';
  sgrUsers.Cells[5, 0] := 'Gebruikersnaam';

  for i := 1 to DataModule2.pgqGetUsers.RecordCount do
  begin
    sgrUsers.Cells[0, i] := DataModule2.pgqGetUsers.FieldByName('gbr_id').AsString;
    sgrUsers.Cells[1, i] := DataModule2.pgqGetUsers.FieldByName('gbr_naam').AsString;
    sgrUsers.Cells[2, i] := DataModule2.pgqGetUsers.FieldByName('gbr_winkelnaam').AsString;
    sgrUsers.Cells[3, i] := DataModule2.pgqGetUsers.FieldByName('gbr_tel').AsString;
    sgrUsers.Cells[4, i] := DataModule2.pgqGetUsers.FieldByName('gbr_email').AsString;
    sgrUsers.Cells[5, i] := DataModule2.pgqGetUsers.FieldByName('gbr_nicknaam').AsString;
    sgrUsers.Cells[6, i] := DataModule2.pgqGetUsers.FieldByName('gbr_wachtwoord').AsString;

    DataModule2.pgqGetUsers.Next;

  end;

end;

procedure TForm2.RefreshGroupOverView;
var
  i: integer;
begin
  pgqGetGroups.SQL.Text := 'SELECT * FROM tbl_groepen ORDER BY gro_id';
  pgqGetGroups.Open;

  pgqGetGroups.First;

  sgrGroups.ColCount := 6;
  sgrGroups.RowCount := pgqGetGroups.RecordCount + 1;
  
  sgrGroups.Cells[0, 0] := 'Id';
  sgrGroups.Cells[1, 0] := 'Naam';
  sgrGroups.Cells[2, 0] := 'Eigenaar';
  sgrGroups.Cells[3, 0] := 'Aangemaakt';
  sgrGroups.Cells[4, 0] := 'Verwijderd';
  sgrGroups.Cells[5, 0] := 'Beschrijving';
   
  for i := 1 to pgqGetGroups.RecordCount do
  begin
    sgrGroups.Cells[0, i] := pgqGetGroups.FieldByName('gro_id').AsString;
    sgrGroups.Cells[1, i] := pgqGetGroups.FieldByName('gro_naam').AsString;
    sgrGroups.Cells[2, i] := pgqGetGroups.FieldByName('gro_igenaar').AsString;
    sgrGroups.Cells[3, i] := pgqGetGroups.FieldByName('gro_aangemaakt').AsString;
    sgrGroups.Cells[4, i] := pgqGetGroups.FieldByName('gro_del').AsString;
//    sgrGroups.Cells[5, i] := pgqGetGroups.FieldByName('gro_beschrijving').AsString;
    sgrGroups.Cells[5, i] := pgqGetGroups.FieldByName('gro_beschrijving').AsString;


    pgqGetGroups.Next;
  end;

  
end;

procedure TForm2.sbtnGoToAddGroupClick(Sender: TObject);
var
  i: integer;
begin
  pcPages.ActivePage := tbsAddGroup;
  lblAddGroupError.Caption := '';

  
end;

procedure TForm2.sbtnAddGroupClick(Sender: TObject);
var
  i, idLastCreatedGroup: integer;
//  pgqGroepsLeden: TPgQuery;
  AStream: TMemoryStream;
  BlobField: TBlobField;
begin
//  pgqGroepsLeden := TPgQuery.Create(nil);
//  pgqGroepsLeden.Connection := DataModule2.pgcDBconnection;

  if((Length(edtGroupName.Text) > 0)) then
  begin
    //creates the group
    pgqCheckExistingUser.Close;
    pgqCheckExistingUser.SQL.Text := 'SELECT * FROM tbl_gebruikers WHERE gbr_nicknaam=:groupOwner';
    pgqCheckExistingUser.ParamByName('groupOwner').AsString := cboxGroupOwner.Text;
    pgqGetGroups.Options.ReturnParams := true;
    pgqCheckExistingUser.Open;

    pgqGetGroups.Append;
    pgqGetGroups.FieldByName('gro_naam').AsString := Trim(edtGroupName.Text);
    pgqGetGroups.FieldByName('gro_igenaar').AsInteger := StrToInt(Trim(pgqCheckExistingUser.FieldByName('gbr_id').AsString));
    pgqGetGroups.FieldByName('gro_aangemaakt').AsDateTime := now;
    pgqGetGroups.FieldByName('gro_del').AsBoolean := false;
    pgqGetGroups.FieldByName('gro_beschrijving').AsString := Trim(edtGroupDescription.Text);
    AStream := TMemoryStream.Create;
    imgAddGroupProfile.Picture.SaveToStream(AStream);
    BlobField := pgqGetGroups.FieldByName('gro_profielfoto') as TBlobField;
    BlobField.LoadFromStream(AStream);
    pgqGetGroups.Post;

    pgqGetGroups.Close;
    pgqGetGroups.SQL.Text := 'SELECT * FROM tbl_groepen';
    pgqGetGroups.Open;
    pgqGetGroups.Last;
    idLastCreatedGroup := pgqGetGroups.FieldByName('gro_id').AsInteger;
    pgqGetGroups.Close;

    AddUserToGroup('add', idLastCreatedGroup);

    //adds the users to the group
//    pgqGroepsleden.SQL.Text := 'SELECT * FROM tbl_groepleden';
//    pgqGroepsleden.Open;
////    pgqGroepsleden.Append;
//    for I := 1 to slsbGroupAddedUsers.Items.Count do
//    begin
//      pgqCheckExistingUser.SQL.Text := '';
//      pgqCheckExistingUser.SQL.Add('SELECT gbr_id FROM tbl_gebruikers');
//      pgqCheckExistingUser.SQL.Add('WHERE LOWER(gbr_nicknaam)=:currentUser');
//      pgqCheckExistingUser.ParamByName('currentUser').AsString := LowerCase(Trim(slsbGroupAddedUsers.Items[i - 1].Caption));
//      pgqCheckExistingUser.Open;
//
//      pgqGroepsleden.Append;
//      pgqGroepsleden.FieldByName('grl_gebruiker').AsInteger := pgqCheckExistingUser.FieldByName('gbr_id').AsInteger;
//      pgqGroepsleden.FieldByName('grl_groep').AsInteger := idLastCreatedGroup; //placeholder
//      pgqGroepsleden.FieldByName('grl_aangemaakt').AsDateTime := now;
//      pgqGroepsleden.FieldByName('grl_del').AsBoolean := false;
//
//      pgqGroepsleden.Post;
//    end;



  end;

end;

procedure TForm2.sbtnAddGroupProfileClick(Sender: TObject);
begin
  with TOpenDialog.Create(self) do
    try
      Caption := 'Open afbeelding';
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
  userIsDuplicate: boolean;
begin
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
    pgqCheckExistingUser.SQL.Text := '';
    pgqCheckExistingUser.SQL.Add('SELECT gbr_id FROM tbl_gebruikers');
    pgqCheckExistingUser.SQL.Add('WHERE LOWER(gbr_nicknaam)=:currentUser');
    pgqCheckExistingUser.ParamByName('currentUser').AsString := LowerCase(Trim(addedUserLB.Items[i - 1].Caption));
    pgqCheckExistingUser.Open;

    if(command = 'edit') then
    begin
      pgqCheckDuplicateUser.SQL.Text := '';
      pgqCheckDuplicateUser.SQL.Add('SELECT * FROM tbl_groepleden');
      pgqCheckDuplicateUser.SQL.Add('WHERE grl_groep = :currentGroup');
      pgqCheckDuplicateUser.SQL.Add('AND grl_gebruiker = :currentUser');
      pgqCheckDuplicateUser.ParamByName('currentGroup').AsInteger := selectedGroupId;
      pgqCheckDuplicateUser.ParamByName('currentUser').AsInteger := pgqCheckExistingUser.FieldByName('gbr_id').AsInteger;
      pgqCheckDuplicateUser.Open;

      if(pgqCheckDuplicateUser.RecordCount > 0) then userIsDuplicate := true
      else userIsDuplicate := false;
    end;

    if(userIsDuplicate = false) then
    begin
      pgqGroepsleden.Append;
      pgqGroepsleden.FieldByName('grl_gebruiker').AsInteger := pgqCheckExistingUser.FieldByName('gbr_id').AsInteger;
      pgqGroepsleden.FieldByName('grl_groep').AsInteger := selectedGroupId;
      pgqGroepsleden.FieldByName('grl_aangemaakt').AsDateTime := now;
      pgqGroepsleden.FieldByName('grl_del').AsBoolean := false;
      pgqGroepsleden.Post;
    end;
  end;

end;

procedure TForm2.sbtnAddUserClick(Sender: TObject);
var
  i: integer;
begin
  pcPages.ActivePage := tbsAddUser;
  edtUserName.Text := '';
  edtUserStoreName.Text := '';
  edtUserTelephone.Text := '';
  edtUserNickName.Text := '';
  edtUserEmail.Text := '';
end;

procedure TForm2.sbtnAddUserProfilePictureClick(Sender: TObject);
begin
  with TOpenDialog.Create(self) do
  try
    Caption := 'Open afbeelding';
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

  for i := 1 to searchLB.Items.Count do
  begin
    if(searchLB.Items[i - 1].Selected) then //if its selected...
    begin
      temp := addedUsersLB.Items.IndexOfCaption(searchLB.Items[i-1].Caption);
      if(temp = -1) then
      begin
        with addedUsersLB.Items.Add do
        begin
          Caption := searchLB.Items[i - 1].Caption;
        end;

        groupOwnerCBOX.Items.Add(searchLB.Items[i - 1].Caption);

        if(commando = 'edit') then
        begin
          editDuplicateLocation := RemovedUsersList.IndexOf(searchLB.Items[i - 1].Caption);

          if(editDuplicateLocation > -1) then
          begin
            RemovedUsersList.Delete(editDuplicateLocation);
          end;
        end;
        
      end
      else errorLBL.Caption := 'Gebruiker al in lijst';
    end;
  end;
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
  selectedRowId := sgrGroups.Row;
  getGroupId := StrToInt(sgrGroups.Cells[0, selectedRowId]);

  DataModule2.pgqDelete.SQL.Text := 'SELECT * FROM tbl_groepen WHERE gro_id=:selectedId';
  DataModule2.pgqDelete.ParamByName('selectedId').AsInteger := getGroupId;
  DataModule2.pgqDelete.Open;
  DataModule2.pgqDelete.Edit;
  DataModule2.pgqDelete.FieldByName('gro_del').AsBoolean := true;
  DataModule2.pgqDelete.Post;
//  pgqDelete.SQL.Text := 'DELETE FROM tbl_groepen WHERE gro_id=:SelectedId';
//  pgqDelete.ParamByName('SelectedId').AsInteger := getGroupId;
//  pgqDelete.Execute;

  RefreshGroupOverView;
end;

procedure TForm2.sbtnDeleteUserClick(Sender: TObject);
var 
  selectedRowId, getUserId: integer;
begin
  selectedRowId := sgrUsers.Row;
  getUserId := StrToInt(sgrUsers.Cells[0, selectedRowId]);

  DataModule2.pgqDelete.SQL.Text := 'DELETE FROM tbl_gebruikers WHERE gbr_id=:SelectedId';
  DataModule2.pgqDelete.ParamByName('SelectedId').AsInteger := getUserId;
  DataModule2.pgqDelete.Execute;

  RefreshUserOverView;

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

    pgqGetDeletedUserId.Free;
    pgqEditGroupMember.Free;

    AddUserToGroup('edit', groupId);
  end;

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
  RefreshGroupOverView;
  pcPages.ActivePage := tbsGroupOverview;

end;

procedure TForm2.sbtnEditGroupProfilePictureClick(Sender: TObject);
begin
  with TOpenDialog.Create(self) do
  try
    Caption := 'Open afbeelding';
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
begin
  pgqCheckExistingUser.Edit;
  pgqCheckExistingUser.FieldByName('gbr_naam').AsString := edtEditUserName.Text;
  pgqCheckExistingUser.FieldByName('gbr_winkelnaam').AsString := edtEditStoreName.Text;
  pgqCheckExistingUser.FieldByName('gbr_email').AsString := edtEditUserEmail.Text;
  pgqCheckExistingUser.FieldByName('gbr_tel').AsString := edtEditUserTelephone.Text;
  pgqCheckExistingUser.FieldByName('gbr_nicknaam').AsString := edtEditUserNickName.Text;

  AStream := TMemoryStream.Create;
  imgEditProfilePicture.Picture.SaveToStream(AStream);
  BlobField := pgqCheckExistingUser.FieldByName('gbr_profielfoto') as TBlobField;
  BlobField.LoadFromStream(AStream);


//          pgqAddUser.ParamByName('userProfilePicture').LoadFromStream(AStream, ftGraphic);

  if(Length(edtEditUserPassword.Text) > 0) then
  begin
    pgqCheckExistingUser.FieldByName('gbr_wachtwoord').AsString := edtEditUserPassword.Text;
  end;

  pgqCheckExistingUser.Post;

  lblEditUserError.Caption := 'Gelukt';
end;

procedure TForm2.sbtnEditUserProfilePictureClick(Sender: TObject);
begin
  with TOpenDialog.Create(self) do
    try
      Caption := 'Open afbeelding';
      Options := [TOpenOption.ofPathMustExist, TOpenOption.ofPathMustExist];
      if (Execute) then imgEditProfilePicture.Picture.LoadFromFile(FileName);

    finally
      Free;
    end;
end;

procedure TForm2.sbtnGoToEditGroupClick(Sender: TObject);
var
  selectedRowId, getUserId, i: integer;
  getSelectedGroup, getSelectedGroupOwner : TPgQuery;
  stream: TStream;
begin
  getSelectedGroup := TPgQuery.Create(nil);
  getSelectedGroupOwner := TPgQuery.Create(nil);
  getGroup := TPgQuery.Create(nil);
  getSelectedGroup.Connection := DataModule2.pgcDBconnection;
  getSelectedGroupOwner.Connection := DataModule2.pgcDBconnection;
  getGroup.Connection := DataModule2.pgcDBconnection;

  selectedRowId := sgrGroups.Row;
  getUserId := StrToInt(sgrGroups.Cells[0, selectedRowId]);
  slsbEditGroupUsers.Items.Clear;

  //gets row with selected group
  getSelectedGroup.SQL.Text := '';
  getSelectedGroup.SQL.Add('SELECT * FROM tbl_groepleden');
  getSelectedGroup.SQL.Add('WHERE grl_groep=:selectedGroup');
  getSelectedGroup.ParamByName('selectedGroup').AsInteger := getUserId;
  getSelectedGroup.Open;

  getGroup.SQL.Text := 'SELECT * FROM tbl_groepen WHERE gro_id=:selectedGroup';
  getGroup.ParamByName('selectedGroup').AsInteger := getUserId;
  getGroup.Open;

  edtEditGroupName.Text := getGroup.FieldByName('gro_naam').AsString;
  edtEditGroupDescription.Text := getGroup.FieldByName('gro_beschrijving').AsString;
  cbxGroupDeleted.Checked := getGroup.FieldByName('gro_del').AsBoolean;
  stream := getGroup.CreateBlobStream(getGroup.FieldByName('gro_profielfoto'), bmRead);
  imgEditGroupProfile.Picture.LoadFromStream(stream);

  //tbl_gebruikers
  getSelectedGroupOwner.SQL.Text := 'SELECT * FROM tbl_gebruikers WHERE gbr_id=:groupOwner';
  getSelectedGroupOwner.ParamByName('groupOwner').AsInteger := getGroup.FieldByName('gro_igenaar').AsInteger;
  getSelectedGroupOwner.Open;

  cboxEditGroupOwner.Items.Add(getSelectedGroupOwner.FieldByName('gbr_nicknaam').AsString);
  cboxEditGroupOwner.ItemIndex := 0;
  getSelectedGroupOwner.Free;

  //get every row with the selected group
  for i := 1 to getSelectedGroup.RecordCount do
  begin
    with slsbEditGroupUsers.Items.Add do
    begin
      pgqCheckExistingUser.SQL.Text := 'SELECT * FROM tbl_gebruikers WHERE gbr_id=:currentUserId';
      pgqCheckExistingUser.ParamByName('currentUserId').AsInteger := getSelectedGroup.FieldByName('grl_gebruiker').AsInteger;
      pgqCheckExistingUser.Open;

      Caption := pgqCheckExistingUser.FieldByName('gbr_nicknaam').AsString;
    end;
    getSelectedGroup.Next;
  end;

  getSelectedGroup.Free;

  pcPages.ActivePage := tbsEditGroup;
end;

procedure TForm2.sbtnGoToEditUserClick(Sender: TObject);
var
  selectedRowId, getUserId: integer;
  stream: TStream;
begin
  selectedRowId := sgrUsers.Row;
  getUserId := StrToInt(sgrUsers.Cells[0, selectedRowId]);

  pgqCheckExistingUser.SQL.Text := '';
  pgqCheckExistingUser.SQL.Add('SELECT * FROM tbl_gebruikers');
  pgqCheckExistingUser.SQL.Add('WHERE gbr_id=:selectedId');
  pgqCheckExistingUser.ParamByName('selectedId').AsInteger := getUserId;
  pgqCheckExistingUser.Open;

  edtEditUserName.Text := pgqCheckExistingUser.FieldByName('gbr_naam').AsString;
  edtEditStoreName.Text := pgqCheckExistingUser.FieldByName('gbr_winkelnaam').AsString;
  edtEditUserTelephone.Text := pgqCheckExistingUser.FieldByName('gbr_tel').AsString;
  edtEditUserEmail.Text := pgqCheckExistingUser.FieldByName('gbr_email').AsString;
  edtEditUserNickName.Text := pgqCheckExistingUser.FieldByName('gbr_nicknaam').AsString;

  stream := pgqCheckExistingUser.CreateBlobStream(pgqCheckExistingUser.FieldByName('gbr_profielfoto'), bmRead);
  imgEditProfilePicture.Picture.LoadFromStream(stream);
//  imgEditProfilePicture.Picture



  pcPages.ActivePage := tbsEditUser;

    
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
//        RemovedUsersList.Delete(editDuplicateLocation);
        RemovedUsersList.Add(getText);
      end;
    end;
  end;

  addedUsersLB.Items.Delete(addedUsersLB.SelectedItemIndex);

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

Function TForm2.HashString(const Input: string): string;
begin
  Result := THashSHA2.GetHashString(Input, THashSHA2.TSHA2Version.SHA256);
end;

end.
