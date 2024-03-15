unit AdminDashboard;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, System.RegularExpressions,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Graphics, AdvUtil, Vcl.Grids, AdvObj, BaseGrid,
  AdvGrid, DBAdvGrid, Vcl.ExtCtrls, Data.DB, MemDS, DBAccess, PgAccess,
  AdvSmoothButton, Vcl.StdCtrls, Vcl.ComCtrls, DMdatabaseInfo, AdvSmoothListBox,
  Vcl.DBGrids;

type
  TForm2 = class(TForm)
    Panel1: TPanel;
    pnlLeft: TPanel;
    dscShowUsers: TDataSource;
    pgqGetUsers: TPgQuery;
    pgqGetUsersgbr_id: TIntegerField;
    pgqGetUsersgbr_naam: TStringField;
    pgqGetUsersgbr_winkelnaam: TStringField;
    pgqGetUsersgbr_tel: TStringField;
    pgqGetUsersgbr_email: TStringField;
    pgqGetUsersgbr_nicknaam: TStringField;
    pgqGetUsersgbr_wachtwoord: TStringField;
    pgqCheckExistingUser: TPgQuery;
    pgqAddUser: TPgQuery;
    dscShowGroups: TDataSource;
    pgqGetGroups: TPgQuery;
    pgqGetGroupsgro_id: TIntegerField;
    pgqGetGroupsgro_naam: TStringField;
    pgqGetGroupsgro_igenaar: TIntegerField;
    pgqGetGroupsgro_aangemaakt: TDateTimeField;
    pgqGetGroupsgro_del: TBooleanField;
    pgqAddGroupSearchUser: TPgQuery;
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
    Label9: TLabel;
    sbtnGoToAddGroup: TAdvSmoothButton;
    sbtnDeleteGroup: TAdvSmoothButton;
    tbsAddGroup: TTabSheet;
    Label4: TLabel;
    lblAddGroupError: TLabel;
    Label2: TLabel;
    Image1: TImage;
    Label5: TLabel;
    edtGroupName: TEdit;
    edtGroupDescription: TEdit;
    sbtnBackToGroupOverview: TAdvSmoothButton;
    sbtnAddGroup: TAdvSmoothButton;
    AdvSmoothButton5: TAdvSmoothButton;
    slsbUser: TAdvSmoothListBox;
    edtAddGroupSearchUser: TEdit;
    sbtnAddUserToGroup: TAdvSmoothButton;
    slsbGroupAddedUsers: TAdvSmoothListBox;
    sbtnagSearchUser: TAdvSmoothButton;
    cboxGroupOwner: TComboBox;
    sgrGroups: TStringGrid;
    pgqDelete: TPgQuery;
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
    pgqAddGroup: TPgQuery;
    pgqGroepsleden: TPgQuery;
    Label13: TLabel;
    tbsEditGroup: TTabSheet;
    AdvSmoothButton6: TAdvSmoothButton;
    sbtnEditGroupProfilePicture: TAdvSmoothButton;
    cboxEditGroupOwner: TComboBox;
    Edit1: TEdit;
    Edit2: TEdit;
    edtEditGroupName: TEdit;
    Image2: TImage;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    sbtnEditGroup: TAdvSmoothButton;
    AdvSmoothButton9: TAdvSmoothButton;
    AdvSmoothButton10: TAdvSmoothButton;
    AdvSmoothButton11: TAdvSmoothButton;
    slsbEditGroupUsers: TAdvSmoothListBox;
    slsbEditSearchUser: TAdvSmoothListBox;
    cbxGroupDeleted: TCheckBox;
    Label1: TLabel;
    pgqCheckExistingGroup: TPgQuery;
    PgSQL1: TPgSQL;

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
  private
    { Private declarations }
    DBConnection : TPgConnection;
    DBLoggedInUser, getGroup: TPgQuery;
    procedure RefreshUserOverView;
    procedure RefreshGroupOverView;
    procedure AddItemToSearchListBox;
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation
//  uses DMdatabaseInfo;

{$R *.dfm}

procedure TForm2.AdvSmoothButton1Click(Sender: TObject);

begin
  lblAddUserError.Caption := '';

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
          pgqAddUser.FieldByName('gbr_wachtwoord').AsString := 'Test123';
          pgqAddUser.Post;
        end
        else
        begin
          lblAddUserError.Caption := 'Email of gebruikersnaam is al in gebruik';
        end;
      end
      else lblAddUserError.Caption := 'Telefoonnummer is niet correct geformatteerd';
    end
    else lblAddUserError.Caption := 'Emailadres is niet correct geformatteerd';
  end
  else
  begin
    lblAddUserError.Caption := 'Vul alle velden in';
  end;
end;

procedure TForm2.sbtnBackToGroupOverviewClick(Sender: TObject);
begin
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
  DBLoggedInUser := DataModule2.pgqGetUser;

  slsbGroupAddedUsers.Items.Clear;

  pcPages.ActivePage := tbsUserOverview;
  cboxGroupOwner.Text := DataModule2.pgqGetUser.FieldByName('gbr_nicknaam').AsString;

  RefreshUserOverView;

  RefreshGroupOverView;

  lblAddGroupError.Caption := '';
  lblEditUserError.Caption := '';
    
  slsbUser.Items.Clear;
  slsbEditSearchUser.Items.Clear;

  pgqGetUsers.First;
    
  for i := 1 to pgqGetUsers.RecordCount do
  begin
    with slsbUser.Items.Add do
    begin
      Caption := pgqGetUsersgbr_nicknaam.Text;
    end;

    with slsbEditSearchUser.Items.Add do
    begin
      Caption := pgqGetUsersgbr_nicknaam.Text;
    end;

    pgqGetUsers.Next;
  end;
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
  pgqGetUsers.SQL.Text := '';
  pgqGetUsers.SQL.Add('SELECT * FROM tbl_gebruikers ORDER BY gbr_id');
  pgqGetUsers.Open;

//  advShowUsers.Refresh;

  sgrUsers.ColCount := 6;
  sgrUsers.RowCount := pgqGetUsers.RecordCount + 1;

  sgrUsers.Cells[0, 0] := 'Id';
  sgrUsers.Cells[1, 0] := 'Naam';
  sgrUsers.Cells[2, 0] := 'Winkelnaam';
  sgrUsers.Cells[3, 0] := 'Telefoon';
  sgrUsers.Cells[4, 0] := 'Email';
  sgrUsers.Cells[5, 0] := 'Gebruikersnaam';

  for i := 1 to pgqGetUsers.RecordCount do
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

end;

procedure TForm2.RefreshGroupOverView;
var
  i: integer;
begin
  pgqGetGroups.SQL.Text := 'SELECT * FROM tbl_groepen ORDER BY gro_id';
  pgqGetGroups.Open;

  pgqGetGroups.First;

  sgrGroups.ColCount := 5;
  sgrGroups.RowCount := pgqGetGroups.RecordCount + 1;
  
  sgrGroups.Cells[0, 0] := 'Id';
  sgrGroups.Cells[1, 0] := 'Naam';
  sgrGroups.Cells[2, 0] := 'Eigenaar';
  sgrGroups.Cells[3, 0] := 'Aangemaakt';
  sgrGroups.Cells[4, 0] := 'Verwijderd';
   
  for i := 1 to pgqGetGroups.RecordCount do
  begin
    sgrGroups.Cells[0, i] := pgqGetGroups.FieldByName('gro_id').AsString;
    sgrGroups.Cells[1, i] := pgqGetGroups.FieldByName('gro_naam').AsString;
    sgrGroups.Cells[2, i] := pgqGetGroups.FieldByName('gro_igenaar').AsString;
    sgrGroups.Cells[3, i] := pgqGetGroups.FieldByName('gro_aangemaakt').AsString;
    sgrGroups.Cells[4, i] := pgqGetGroups.FieldByName('gro_del').AsString;

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
begin
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
    pgqGetGroups.Post;
    pgqGetGroups.Close;
    pgqGetGroups.SQL.Text := 'SELECT * FROM tbl_groepen';
    pgqGetGroups.Open;
    pgqGetGroups.Last;
    idLastCreatedGroup := pgqGetGroups.FieldByName('gro_id').AsInteger;
    pgqGetGroups.Close;

    //adds the users to the group
    pgqGroepsleden.SQL.Text := 'SELECT * FROM tbl_groepleden';
    pgqGroepsleden.Open;
//    pgqGroepsleden.Append;
    for I := 1 to slsbGroupAddedUsers.Items.Count do
    begin
      pgqCheckExistingUser.SQL.Text := '';
      pgqCheckExistingUser.SQL.Add('SELECT gbr_id FROM tbl_gebruikers');
      pgqCheckExistingUser.SQL.Add('WHERE LOWER(gbr_nicknaam)=:currentUser');
      pgqCheckExistingUser.ParamByName('currentUser').AsString := LowerCase(Trim(slsbGroupAddedUsers.Items[i - 1].Caption));
      pgqCheckExistingUser.Open;

      pgqGroepsleden.Append;
      pgqGroepsleden.FieldByName('grl_gebruiker').AsInteger := pgqCheckExistingUser.FieldByName('gbr_id').AsInteger;
      pgqGroepsleden.FieldByName('grl_groep').AsInteger := idLastCreatedGroup; //placeholder
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
end;

procedure TForm2.sbtnAddUserToGroupClick(Sender: TObject);
begin
  AddItemToSearchListBox;
end;

procedure TForm2.AddItemToSearchListBox;
var
  i, temp: integer;

begin
  for i := 1 to slsbUser.Items.Count do
  begin
    if(slsbUser.Items[i - 1].Selected) then
    begin
      temp := slsbGroupAddedUsers.Items.IndexOfCaption(slsbUser.Items[i-1].Caption);
      if(temp = -1) then
      begin
        with slsbGroupAddedUsers.Items.Add do
        begin
          Caption := slsbUser.Items[i - 1].Caption;
        end;

        cboxGroupOwner.Items.Add(slsbUser.Items[i - 1].Caption);
      end
      else lblAddGroupError.Caption := 'Gebruiker al in lijst';
    end;
  end;
end;

procedure TForm2.sbtnagSearchUserClick(Sender: TObject);
var
  i: integer;
begin
  lblAddUserError.Caption := '';

  slsbUser.Items.Clear;
  pgqAddGroupSearchUser.SQL.Text := '';
  pgqAddGroupSearchUser.SQL.Add('SELECT * FROM tbl_gebruikers');
  pgqAddGroupSearchUser.SQL.Add('WHERE LOWER(gbr_nicknaam)=:user');
  pgqAddGroupSearchUser.SQL.Add('OR LOWER(gbr_email)=:user');
  pgqAddGroupSearchUser.SQL.Add('OR LOWER(gbr_naam)=:user');
  pgqAddGroupSearchUser.ParamByName('user').AsString := LowerCase(edtAddGroupSearchUser.Text);
  pgqAddGroupSearchUser.Open;

  pgqAddGroupSearchUser.First;
  for i := 1 to pgqAddGroupSearchUser.RecordCount do
  begin
    with slsbUser.Items.Add do
    begin
      Caption := pgqAddGroupSearchUser.FieldByName('gbr_nicknaam').AsString;
      pgqAddGroupSearchUser.Next;
    end;
  end;
end;

procedure TForm2.sbtnDeleteGroupClick(Sender: TObject);
var
  selectedRowId, getGroupId: integer;
begin
  selectedRowId := sgrGroups.Row;
  getGroupId := StrToInt(sgrGroups.Cells[0, selectedRowId]);

  pgqDelete.SQL.Text := 'SELECT * FROM tbl_groepen WHERE gro_id=:selectedId';
  pgqDelete.ParamByName('selectedId').AsInteger := getGroupId;
  pgqDelete.Open;
  pgqDelete.Edit;
  pgqDelete.FieldByName('gro_del').AsBoolean := true;
  pgqDelete.Post;
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

  pgqDelete.SQL.Text := 'DELETE FROM tbl_gebruikers WHERE gbr_id=:SelectedId';
  pgqDelete.ParamByName('SelectedId').AsInteger := getUserId;
  pgqDelete.Execute;

  RefreshUserOverView;

end;

procedure TForm2.sbtnEditGroupClick(Sender: TObject);
begin
  getGroup.Edit;
  getGroup.FieldByName('gro_naam').AsString := edtEditGroupName.Text;
  getGroup.Post;
end;

procedure TForm2.sbtnEditUserClick(Sender: TObject);
begin
  pgqCheckExistingUser.Edit;
  pgqCheckExistingUser.FieldByName('gbr_naam').AsString := edtEditUserName.Text;
  pgqCheckExistingUser.FieldByName('gbr_winkelnaam').AsString := edtEditStoreName.Text;
  pgqCheckExistingUser.FieldByName('gbr_email').AsString := edtEditUserEmail.Text;
  pgqCheckExistingUser.FieldByName('gbr_tel').AsString := edtEditUserTelephone.Text;
  pgqCheckExistingUser.FieldByName('gbr_nicknaam').AsString := edtEditUserNickName.Text;

  if(Length(edtEditUserPassword.Text) > 0) then 
  begin
    pgqCheckExistingUser.FieldByName('gbr_wachtwoord').AsString := edtEditUserPassword.Text;
  end;

  pgqCheckExistingUser.Post;

  lblEditUserError.Caption := 'Gelukt';
end;

procedure TForm2.sbtnGoToEditGroupClick(Sender: TObject);
var
  selectedRowId, getUserId, i: integer;
  getSelectedGroup, getSelectedGroupOwner : TPgQuery;
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
  cbxGroupDeleted.Checked := getGroup.FieldByName('gro_del').AsBoolean;

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

  pcPages.ActivePage := tbsEditUser;

    
end;

procedure TForm2.sbtnRemoveUserFromGroupClick(Sender: TObject);
var
  indexDeletedUser: integer;
  getText: string;
begin
  if(slsbGroupAddedUsers.Items.CountSelected > 0) then
  begin
    getText := slsbGroupAddedUsers.Items[slsbGroupAddedUsers.SelectedItemIndex].Caption;
    indexDeletedUser := cboxGroupOwner.Items.IndexOf(getText);

    slsbGroupAddedUsers.Items.Delete(slsbGroupAddedUsers.SelectedItemIndex);
    cboxGroupOwner.Items.Delete(indexDeletedUser);
  end;

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

end.
