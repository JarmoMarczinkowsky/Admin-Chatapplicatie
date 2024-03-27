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
    tbsGroupOverview: TTabSheet;
    sbtnGoToAddGroup: TAdvSmoothButton;
    sbtnDeleteGroup: TAdvSmoothButton;
    sgrGroups: TStringGrid;
    sgrUsers: TStringGrid;
    sbtnGoToEditUser: TAdvSmoothButton;
    sbtnGoToEditGroup: TAdvSmoothButton;
    tbsOptions: TTabSheet;
    RzNumericEdit1: TRzNumericEdit;
    Label18: TLabel;
    sbtnCancelOptions: TAdvSmoothButton;
    sbtnChangeOption: TAdvSmoothButton;
    sbtnBackButton: TAdvSmoothButton;
    AdvSmoothMegaMenu1: TAdvSmoothMegaMenu;
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
    procedure pcPagesChange(Sender: TObject);
    procedure sbtnGoToAddGroupClick(Sender: TObject);
    procedure sbtnDeleteGroupClick(Sender: TObject);
    procedure sbtnDeleteUserClick(Sender: TObject);
    procedure sbtnGoToEditUserClick(Sender: TObject);
    procedure sgrGroupsDrawCell(Sender: TObject; ACol, ARow: LongInt;
      Rect: TRect; State: TGridDrawState);
    procedure sbtnGoToEditGroupClick(Sender: TObject);
    procedure AdvSmoothMegaMenu1MenuSubItemClick(Sender: TObject;
      Menu: TAdvSmoothMegaMenu; MenuItem: TAdvSmoothMegaMenuItem;
      Item: TGDIPMenuSectionItem; Text: string);
    procedure AdvSmoothMegaMenu1MenuItemClick(Sender: TObject;
      ItemIndex: Integer);
    procedure sbtnRefreshGroupClick(Sender: TObject);
    procedure sbtnRefreshUserClick(Sender: TObject);
    procedure sbtnLogOutClick(Sender: TObject);
    procedure tmrRemoveErrorTimer(Sender: TObject);
  private
    { Private declarations }
    getGroup: TPgQuery;
    RemovedUsersList: TStringList;
    timerCounter: integer;
    procedure RefreshUserOverView;
    procedure RefreshGroupOverView;
    procedure FillUserListbox(searchLB: TAdvSmoothListBox);
    function HashString(const Input: string): string;
    procedure AutoSizeCol(grid: TStringGrid; Column: integer);
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation
  uses frmAddUser, frmAddGroup, frmEditUser, frmEditGroup;

{$R *.dfm}

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
  else if (Text = 'Overzicht groepen') then pcPages.ActivePage := tbsGroupOverview
//  else if (Text = 'Groep aanmaken') then pcPages.ActivePage :=
  else if (Text = 'Uitloggen') then Self.Close;
end;

//procedure TForm2.sbtnBackToGroupOverviewClick(Sender: TObject);
//begin
//  if(pcPages.ActivePage = tbsEditGroup) then
//  begin
//    RemovedUsersList.Free;
//  end;
//  pcPages.ActivePage := tbsGroupOverview;
//end;

procedure TForm2.FormShow(Sender: TObject);
var 
  i, j: integer;
begin
  pcPages.ActivePage := tbsUserOverview;

  with DataModule2 do
  begin
    sgrUsers.ColCount := 6;
    sgrUsers.Cells[0, 0] := 'Id';
    sgrUsers.Cells[1, 0] := 'Naam';
    sgrUsers.Cells[2, 0] := 'Winkelnaam';
    sgrUsers.Cells[3, 0] := 'Telefoon';
    sgrUsers.Cells[4, 0] := 'Email';
    sgrUsers.Cells[5, 0] := 'Gebruikersnaam';

    sgrGroups.ColCount := 6;
    sgrGroups.Cells[0, 0] := 'Id';
    sgrGroups.Cells[1, 0] := 'Naam';
    sgrGroups.Cells[2, 0] := 'Eigenaar';
    sgrGroups.Cells[3, 0] := 'Aangemaakt';
    sgrGroups.Cells[4, 0] := 'Verwijderd';
    sgrGroups.Cells[5, 0] := 'Beschrijving';
  end;
end;

procedure TForm2.pcPagesChange(Sender: TObject);
var
  i: integer;
begin
  if(pcPages.ActivePage = tbsUserOverview) then
  begin
    Self.Caption := 'Gebruikersoverzicht';
  end
  else if(pcPages.ActivePage = tbsGroupOverview) then
  begin
    Self.Caption := 'Groepenoverzicht';
  end
  else if (pcPages.ActivePage = tbsOptions) then
  begin
    Self.Caption := 'Opties';
  end;
end;

procedure TForm2.RefreshUserOverView;
var 
  i: integer;
begin
  with DataModule2 do
  begin
    if(pgqGetUsers = nil) then
    begin
      pgqGetUsers := TPgQuery.Create(nil);
      pgqGetUsers.Connection := pgcDBconnection;
    end;

    if(cbxShowDeletedUser.Checked) then pgqGetUsers.SQL.Text := 'SELECT * FROM tbl_gebruikers ORDER BY gbr_id'
    else pgqGetUsers.SQL.Text := 'SELECT * FROM tbl_gebruikers WHERE gbr_del = false ORDER BY gbr_id';
    pgqGetUsers.Open;

    sgrUsers.BeginUpdate;
    sgrUsers.RowCount := pgqGetUsers.RecordCount + 1;

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

    for i := 0 to sgrUsers.ColCount - 1 do
    AutoSizeCol(sgrUsers, i);

    sgrUsers.EndUpdate;

    lblUserOverviewAmount.Caption := Format('%d gebruikers gevonden', [pgqGetUsers.RecordCount]);
//    DataModule2.pgqGetUsers.Free;
//    DataModule2.pgqGetUsers := nil;
    pgqGetUsers.Close;
  end;
end;

procedure TForm2.AutoSizeCol(Grid: TStringGrid;
Column: integer);
var
  i, W, WMax: integer;
begin
  WMax := 0;
  for i := 0 to (Grid.RowCount - 1) do begin
    W := Grid.Canvas.TextWidth(Grid.Cells[Column, i]);
    if W > WMax then
      WMax := W;
  end;
  Grid.ColWidths[Column] := WMax + 5;
end;

procedure TForm2.RefreshGroupOverView;
var
  i: integer;
begin
  with DataModule2 do
  begin
    if(pgqGetGroups = nil) then
    begin
      pgqGetGroups := TPgQuery.Create(nil);
      pgqGetGroups.Connection := pgcDBconnection;
    end;

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

    for i := 0 to sgrGroups.ColCount - 1 do
      AutoSizeCol(sgrGroups, i);

    sgrGroups.EndUpdate;

    lblGroupOverviewAmount.Caption := Format('%d groepen gevonden', [DataModule2.pgqGetGroups.RecordCount]);

    pgqGetGroups.Close;
//    pgqGetGroups.Free;
//    pgqGetGroups := nil;
  end;
end;

procedure TForm2.sbtnGoToAddGroupClick(Sender: TObject);
var
  i: integer;
begin
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
end;

procedure TForm2.sbtnAddUserClick(Sender: TObject);
var
  i: integer;
begin
  Form3.Show;
end;

procedure TForm2.sbtnDeleteGroupClick(Sender: TObject);
var
  selectedRowId, getGroupId, userChoice: integer;
  currGroup: string;
begin
  if(sgrGroups.Cells[0, 1] <> '') then
  begin
    selectedRowId := sgrGroups.Row;
    getGroupId := StrToInt(sgrGroups.Cells[0, selectedRowId]);

    with DataModule2 do
    begin
      pgqDelete.SQL.Text := 'SELECT * FROM tbl_groepen WHERE gro_id=:selectedId';
      pgqDelete.ParamByName('selectedId').AsInteger := getGroupId;
      pgqDelete.Open;

      currGroup := pgqDelete.FieldByName('gro_naam').AsString;

      userChoice := Application.MessageBox(PWideChar('Weet je zeker dat je ' + currGroup + ' wilt verwijderen?') , 'Bevestig verwijderverzoek', MB_OKCANCEL );
      if(userChoice = 1) then
      begin
        if(pgqDelete.ParamByName('gbr_del').AsBoolean) then ShowMessage(currGroup + ' is al verwijderd')
        else
        begin
          pgqDelete.Edit;
          pgqDelete.FieldByName('gbr_del').AsBoolean := true;
          pgqDelete.Post;
        end;
      end;
    end;
//    RefreshGroupOverView;
  end;

end;

procedure TForm2.sbtnDeleteUserClick(Sender: TObject);
var 
  selectedRowId, getUserId, userChoice: integer;
  currUser, myText: string;
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
      userChoice := Application.MessageBox(PWideChar('Weet je zeker dat je ' + currUser + ' wilt verwijderen?') , 'Bevestig verwijderverzoek', MB_OKCANCEL );

      if(userChoice = 1) then
      begin
        if(pgqDelete.ParamByName('gbr_del').AsBoolean) then ShowMessage(currUser + ' is al verwijderd')
        else
        begin
          pgqDelete.Edit;
          pgqDelete.FieldByName('gbr_del').AsBoolean := true;
          pgqDelete.Post;
        end;
      end;
    end;
//    RefreshUserOverView;
  end;
end;

procedure TForm2.sbtnGoToEditGroupClick(Sender: TObject);
var
  selectedRowId, getGroupId, i: integer;
  stream: TStream;
begin
  if(sgrGroups.Cells[0, 1] <> '') then
  begin
    selectedRowId := sgrGroups.Row;
    getGroupId := StrToInt(sgrGroups.Cells[0, selectedRowId]);

    //gets row with selected group
    with DataModule2 do
    begin
//      DataModule2.pgqGetGroupMembers := nil;
//      if(DataModule2.pgqGetGroupMembers = nil) then
//      begin
      pgqGetGroupMembers := TPgQuery.Create(nil);
      pgqGetGroupMembers.Connection := DataModule2.pgcDBconnection;
//      end;
      pgqGetGroupMembers.SQL.Text := 'SELECT * FROM tbl_groepleden';
      pgqGetGroupMembers.SQL.Add('WHERE grl_groep=:selectedGroup');
      pgqGetGroupMembers.SQL.Add('AND grl_del = false');
      pgqGetGroupMembers.ParamByName('selectedGroup').AsInteger := getGroupId;
      pgqGetGroupMembers.Open;

//      DataModule2.pgqGetSelectedGroup := nil;
//      if(DataModule2.pgqGetSelectedGroup = nil) then
//      begin
      pgqGetSelectedGroup := TPgQuery.Create(nil);
      pgqGetSelectedGroup.Connection := DataModule2.pgcDBconnection;
//      end;
      pgqGetSelectedGroup.SQL.Text := 'SELECT * FROM tbl_groepen WHERE gro_id=:selectedGroup';
      pgqGetSelectedGroup.ParamByName('selectedGroup').AsInteger := getGroupId;
      pgqGetSelectedGroup.Open;

      frmGroupEdit.Show;
    end;
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

    end;

    frmUserEdit.Show;
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

procedure TForm2.tmrRemoveErrorTimer(Sender: TObject);
begin

  timerCounter := timerCounter + 1;

  if(timerCounter > 8) then
  begin
    tmrRemoveError.Enabled := false;
  end;
end;

Function TForm2.HashString(const Input: string): string;
begin
  Result := THashSHA2.GetHashString(Input, THashSHA2.TSHA2Version.SHA256);
end;

end.
