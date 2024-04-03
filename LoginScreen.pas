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
    Image1: TImage;    procedure sbtnLoginClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation
  uses DMdatabaseInfo, AdminDashboard;

{$R *.dfm}

procedure TfrmLogin.FormCreate(Sender: TObject);
begin
  lblError.Caption := '';
end;

procedure TfrmLogin.FormShow(Sender: TObject);
begin
  edtUser.SetFocus;
end;

procedure TfrmLogin.sbtnLoginClick(Sender: TObject);
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
        frmAdminDashboard.Show;
        frmLogin.Visible := false;
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

end.
