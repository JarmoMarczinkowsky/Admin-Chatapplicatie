unit AdminDashboard;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, System.RegularExpressions,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Graphics, AdvUtil, Vcl.Grids, AdvObj, BaseGrid,
  AdvGrid, DBAdvGrid, Vcl.ExtCtrls, Data.DB, MemDS, DBAccess, PgAccess,
  AdvSmoothButton, Vcl.StdCtrls, Vcl.ComCtrls, DMdatabaseInfo, AdvSmoothListBox;

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
    advShowUsers: TDBAdvGrid;
    sbtnAddUser: TAdvSmoothButton;
    sbtnDeleteUser: TAdvSmoothButton;
    edtUserName: TEdit;
    lblName: TLabel;
    edtUserStoreName: TEdit;
    lblStoreName: TLabel;
    Label1: TLabel;
    edtUserEmail: TEdit;
    lblEmail: TLabel;
    edtUserTelephone: TEdit;
    lblTelephone: TLabel;
    edtUserNickName: TEdit;
    lblNickname: TLabel;
    AdvSmoothButton1: TAdvSmoothButton;
    AdvSmoothButton2: TAdvSmoothButton;
    pcPages: TPageControl;
    tbsUserOverview: TTabSheet;
    Label3: TLabel;
    tbsAddUser: TTabSheet;
    lblAddUserError: TLabel;
    pgqCheckExistingUser: TPgQuery;
    pgqAddUser: TPgQuery;
    tbsGroupOverview: TTabSheet;
    tbsAddGroup: TTabSheet;
    edtGroupName: TEdit;
    Label4: TLabel;
    edtGroupDescription: TEdit;
    lblAddGroupError: TLabel;
    Label2: TLabel;
    AdvSmoothButton4: TAdvSmoothButton;
    AdvSmoothButton3: TAdvSmoothButton;
    Label9: TLabel;
    advShowGroups: TDBAdvGrid;
    sbtnAddGroup: TAdvSmoothButton;
    sbtnDeleteGroup: TAdvSmoothButton;
    dscShowGroups: TDataSource;
    pgqGetGroups: TPgQuery;
    pgqGetGroupsgro_id: TIntegerField;
    pgqGetGroupsgro_naam: TStringField;
    pgqGetGroupsgro_igenaar: TIntegerField;
    pgqGetGroupsgro_aangemaakt: TDateTimeField;
    pgqGetGroupsgro_del: TBooleanField;
    AdvSmoothButton5: TAdvSmoothButton;
    Image1: TImage;
    slsbUser: TAdvSmoothListBox;
    edtAddGroupSearchUser: TEdit;
    sbtnAddUserToGroup: TAdvSmoothButton;
    pgqAddGroupSearchUser: TPgQuery;

    procedure FormShow(Sender: TObject);
    procedure sbtnAddUserClick(Sender: TObject);
    procedure AdvSmoothButton2Click(Sender: TObject);
    procedure AdvSmoothButton1Click(Sender: TObject);
    procedure pcPagesChange(Sender: TObject);
    procedure sbtnAddGroupClick(Sender: TObject);
    procedure sbtnAddUserToGroupClick(Sender: TObject);
  private
    { Private declarations }
    DBConnection : TPgConnection;
    DBLoggedInUser: TPgQuery;
    procedure RefreshUserOverView;
    procedure RefreshGroupOverView;
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

procedure TForm2.AdvSmoothButton2Click(Sender: TObject);
begin
  pcPages.ActivePage := tbsUserOverview;
end;

procedure TForm2.FormShow(Sender: TObject);
begin
  DBConnection := DataModule2.pgcDBconnection;
  DBLoggedInUser := DataModule2.pgqGetUser;

  RefreshUserOverView;
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
    slsbUser.Items.Clear;
    pgqGetUsers.First;
    
    for i := 1 to pgqGetUsers.RecordCount do
    begin
      with slsbUser.Items.Add do
      begin
        Caption := pgqGetUsersgbr_naam.Text;
        pgqGetUsers.Next;      
      end;
    end;

  end;
end;

procedure TForm2.RefreshUserOverView;
begin
  pgqGetUsers.SQL.Text := '';
  pgqGetUsers.SQL.Add('SELECT * FROM tbl_gebruikers');
  pgqGetUsers.Open;

  advShowUsers.Refresh;

end;

procedure TForm2.RefreshGroupOverView;
begin
  pgqGetGroups.SQL.Text := '';
  pgqGetGroups.SQL.Add('SELECT * FROM tbl_groepen');
  pgqGetGroups.Open;

  advShowUsers.Refresh;
end;

procedure TForm2.sbtnAddGroupClick(Sender: TObject);
begin
  pcPages.ActivePage := tbsAddGroup;
  lblAddGroupError.Caption := '';
end;

procedure TForm2.sbtnAddUserClick(Sender: TObject);
var
  i: integer;
begin
  pcPages.ActivePage := tbsAddUser;
end;

procedure TForm2.sbtnAddUserToGroupClick(Sender: TObject);
var
  i: integer;
begin
  lblAddUserError.Caption := '';

  slsbUser.Items.Clear;
  pgqAddGroupSearchUser.SQL.Text := '';
  pgqAddGroupSearchUser.SQL.Add('SELECT * FROM tbl_gebruikers');
  pgqAddGroupSearchUser.SQL.Add('WHERE LOWER(gbr_nicknaam)=:user');
  pgqAddGroupSearchUser.SQL.Add('OR LOWER(gbr_email)=:user');
  pgqAddGroupSearchUser.ParamByName('user').AsString := LowerCase(edtAddGroupSearchUser.Text);
  pgqAddGroupSearchUser.Open;

  pgqAddGroupSearchUser.First;
  for i := 1 to pgqAddGroupSearchUser.RecordCount do
  begin
    with slsbUser.Items.Add do
    begin
      Caption := pgqAddGroupSearchUser.FieldByName('gbr_naam').AsString;
      pgqAddGroupSearchUser.Next;
    end;
  end;
end;

end.
