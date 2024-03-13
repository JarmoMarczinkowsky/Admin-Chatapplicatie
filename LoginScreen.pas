unit LoginScreen;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  StrUtils,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, AdvSmoothButton, Data.DB,
  DBAccess, PgAccess, MemDS;

type
  TForm1 = class(TForm)
    sbtnLogin: TAdvSmoothButton;
    edtUser: TEdit;
    edtPassword: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    pgcDBconnection: TPgConnection;
    pgqGetUser: TPgQuery;
    lblError: TLabel;
    procedure sbtnLoginClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  lblError.Caption := '';
end;

procedure TForm1.sbtnLoginClick(Sender: TObject);
begin
  pgcDBconnection.Open;

  if((Length(edtUser.Text) > 0) AND (Length(edtPassword.Text) > 0)) then
  begin

    pgqGetUser.SQL.Text := '';
    pgqGetUser.SQL.Add('SELECT * FROM tbl_gebruikers');

    if(ContainsText(edtUser.Text, '@')) then
    begin
      pgqGetUser.SQL.Add('WHERE LOWER(gbr_email)=:user');
    end
    else
    begin
      pgqGetUser.SQL.Add('WHERE LOWER(gbr_nicknaam)=:user');
    end;

    pgqGetUser.SQL.Add('AND gbr_wachtwoord=:password');
    pgqGetUser.ParamByName('user').AsString := Trim(LowerCase(edtUser.Text));
    pgqGetUser.ParamByName('password').AsString := edtPassword.Text;
    pgqGetUser.Open;

    if(pgqGetUser.RecordCount > 0) then
    begin
      ShowMessage('Succes');
    end
    else
    begin
      lblError.Caption := 'Username of wachtwoord is incorrect';
    end;

  end
  else
  begin
    lblError.Caption := 'Gebruikersnaam of wachtwoord is leeg';
  end;

end;

end.
