unit AdminDashboard;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, System.RegularExpressions,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Graphics, AdvUtil, Vcl.Grids, AdvObj, BaseGrid,
  AdvGrid, DBAdvGrid, Vcl.ExtCtrls, Data.DB, MemDS, DBAccess, PgAccess,
  AdvSmoothButton, Vcl.StdCtrls, Vcl.ComCtrls, DMdatabaseInfo;

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
    edtName: TEdit;
    lblName: TLabel;
    edtStoreName: TEdit;
    lblStoreName: TLabel;
    Label1: TLabel;
    edtEmail: TEdit;
    lblEmail: TLabel;
    edtTelephone: TEdit;
    lblTelephone: TLabel;
    edtUserName: TEdit;
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

    procedure FormShow(Sender: TObject);
    procedure sbtnAddUserClick(Sender: TObject);
    procedure AdvSmoothButton2Click(Sender: TObject);
    procedure AdvSmoothButton1Click(Sender: TObject);
  private
    { Private declarations }
    DBConnection : TPgConnection;
    DBLoggedInUser: TPgQuery;
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
  if((Length(edtName.Text) > 0) AND
  (Length(edtStoreName.Text) > 0) AND
  (Length(edtEmail.Text) > 0) AND
  (Length(edtTelephone.Text) > 0) AND
  (Length(edtUserName.Text) > 0)) then
  begin
    if(TRegEx.IsMatch(edtEmail.Text, '[^@ \t\r\n]+@[^@ \t\r\n]+\.[^@ \t\r\n]+')) then
    begin
      if(TRegEx.IsMatch(edtTelephone.Text, '^[0-9+\-]{10,}$')) then
      begin
        pgqCheckExistingUser.SQL.Text := '';
        pgqCheckExistingUser.SQL.Add('SELECT * FROM tbl_gebruikers');
        pgqCheckExistingUser.SQL.Add('WHERE LOWER(gbr_email)=:CheckDuplicateEmail');
        pgqCheckExistingUser.SQL.Add('OR LOWER(gbr_nicknaam)=:CheckDuplicateUserName');
        pgqCheckExistingUser.ParamByName('CheckDuplicateEmail').AsString := LowerCase(edtEmail.Text);
        pgqCheckExistingUser.ParamByName('CheckDuplicateUserName').AsString := LowerCase(edtUserName.Text);
        pgqCheckExistingUser.Open;

        if(pgqCheckExistingUser.RecordCount = 0) then
        begin
          pgqAddUser.SQL.Text := '';
          pgqAddUser.SQL.Add('SELECT * FROM tbl_gebruikers');
          pgqAddUser.Open;
          pgqAddUser.Append;
          pgqAddUser.FieldByName('gbr_naam').AsString := Trim(edtName.Text);
          pgqAddUser.FieldByName('gbr_winkelnaam').AsString := Trim(edtStoreName.Text);
          pgqAddUser.FieldByName('gbr_tel').AsString := Trim(edtTelephone.Text);
          pgqAddUser.FieldByName('gbr_email').AsString := Trim(edtEmail.Text);
          pgqAddUser.FieldByName('gbr_nicknaam').AsString := Trim(edtUserName.Text);
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

  pgqGetUsers.SQL.Text := '';
  pgqGetUsers.SQL.Add('SELECT * FROM tbl_gebruikers');
  pgqGetUsers.Open;

  advShowUsers.Refresh;

  pnlLeft.BringToFront;
  pnlLeft.Visible := true;
end;

procedure TForm2.sbtnAddUserClick(Sender: TObject);
begin
  lblAddUserError.Caption := '';
  pcPages.ActivePage := tbsAddUser;
end;

end.
