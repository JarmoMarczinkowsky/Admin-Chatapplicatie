unit LoginScreen;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  StrUtils,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, AdvSmoothButton, Data.DB,
  DBAccess, PgAccess, MemDS, Vcl.ExtCtrls, Vcl.Imaging.pngimage;

type
  TForm1 = class(TForm)
    sbtnLogin: TAdvSmoothButton;
    edtUser: TEdit;
    edtPassword: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    lblError: TLabel;
    Image1: TImage;
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
  uses DMdatabaseInfo, AdminDashboard;

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  lblError.Caption := '';
end;

procedure TForm1.sbtnLoginClick(Sender: TObject);
begin
  if(NOT DataModule2.pgcDBconnection.Connected) then DataModule2.pgcDBconnection.Open;

  if((Length(edtUser.Text) > 0) AND (Length(edtPassword.Text) > 0)) then
  begin

    DataModule2.pgqGetUser.SQL.Text := '';
    DataModule2.pgqGetUser.SQL.Add('SELECT * FROM tbl_gebruikers');

    if(ContainsText(edtUser.Text, '@')) then
    begin
      DataModule2.pgqGetUser.SQL.Add('WHERE LOWER(gbr_email)=:user');
    end
    else
    begin
      DataModule2.pgqGetUser.SQL.Add('WHERE LOWER(gbr_nicknaam)=:user');
    end;

    DataModule2.pgqGetUser.SQL.Add('AND gbr_wachtwoord=:password');
    DataModule2.pgqGetUser.ParamByName('user').AsString := Trim(LowerCase(edtUser.Text));
    DataModule2.pgqGetUser.ParamByName('password').AsString := edtPassword.Text;
    DataModule2.pgqGetUser.Open;

    if(DataModule2.pgqGetUser.RecordCount > 0) then
    begin
      Form2.Show;
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
