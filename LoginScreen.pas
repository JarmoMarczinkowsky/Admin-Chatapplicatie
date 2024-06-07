unit LoginScreen;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  StrUtils, System.Hash,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, AdvSmoothButton, Data.DB,
  DBAccess, PgAccess, MemDS, Vcl.ExtCtrls, Vcl.Imaging.pngimage;

type
  TfrmLogin = class(TForm)
    sbtnLogin: TAdvSmoothButton;
    edtUser: TEdit;
    edtPassword: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    lblError: TLabel;
    imgLogo: TImage;
    sbtnCancel: TAdvSmoothButton;    procedure sbtnLoginClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sbtnCancelClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure edtPasswordKeyPress(Sender: TObject; var Key: Char);
    procedure edtUserKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure _login;
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation
  uses DMdatabaseInfo, AdminDashboard;

{$R *.dfm}

procedure TfrmLogin.sbtnCancelClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmLogin.edtPasswordKeyPress(Sender: TObject; var Key: Char);
begin
  if(Key = #13) then _login;
end;

procedure TfrmLogin.edtUserKeyPress(Sender: TObject; var Key: Char);
begin
  if(Key = #13) then _login;
end;

procedure TfrmLogin.FormCreate(Sender: TObject);
begin
  lblError.Caption := '';

  DataModule2.tmrLogin.Enabled := true;
end;

procedure TfrmLogin.FormResize(Sender: TObject);
var
  widthOfRightSpace : integer;
begin
  imgLogo.Left := Round(Self.ClientWidth / 2 - imgLogo.Width / 2);
  if(edtPassword.Left <= edtUser.Left + edtUser.Width) then
  begin
  end;
end;

procedure TfrmLogin.FormShow(Sender: TObject);
begin
  edtUser.SetFocus;
end;

procedure TfrmLogin._login;
begin
  with DataModule2 do
  begin
    if(NOT pgcDBconnection.Connected) then pgcDBconnection.Open;

    if((Length(edtUser.Text) > 0) AND (Length(edtPassword.Text) > 0)) then
    begin
      pgqGetLoggedInUser.SQL.Text := 'SELECT * FROM tbl_gebruikers';

      if(ContainsText(edtUser.Text, '@')) then
      begin
        pgqGetLoggedInUser.SQL.Add('WHERE LOWER(gbr_email)=:user');
      end
      else
      begin
        pgqGetLoggedInUser.SQL.Add('WHERE LOWER(gbr_nicknaam)=:user');
      end;

      pgqGetLoggedInUser.SQL.Add('AND gbr_wachtwoord=:password');
      pgqGetLoggedInUser.ParamByName('user').AsString := Trim(LowerCase(edtUser.Text));
      pgqGetLoggedInUser.ParamByName('password').AsString := THashSHA2.GetHashString(edtPassword.Text, SHA256);
      pgqGetLoggedInUser.Open;

      if(pgqGetLoggedInUser.RecordCount > 0) then
      begin
        edtUser.Text := '';
        edtPassword.Text := '';
        frmAdminDashboard.StartUpApp;
        frmAdminDashboard.Visible := true;
        frmLogin.Close;
      end
      else
      begin
        if(ContainsText(edtUser.Text, '@')) then lblError.Caption := 'Email of wachtwoord is incorrect'
        else lblError.Caption := 'Gebruikersnaam of wachtwoord is incorrect';
      end;
    end //end of if
    else
    begin
      lblError.Caption := 'Gebruikersnaam of wachtwoord is leeg';
    end;
  end;
end;

procedure TfrmLogin.sbtnLoginClick(Sender: TObject);
begin
  _login;
end;

end.
