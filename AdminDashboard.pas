unit AdminDashboard;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvUtil, Vcl.Grids, AdvObj, BaseGrid,
  AdvGrid, DBAdvGrid, Vcl.ExtCtrls, Data.DB, MemDS, DBAccess, PgAccess,
  AdvSmoothButton, Vcl.StdCtrls, Vcl.ComCtrls;

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

    procedure FormShow(Sender: TObject);
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
  uses LoginScreen;

{$R *.dfm}

procedure TForm2.FormShow(Sender: TObject);
begin
  DBConnection := Form1.pgcDBconnection;
  DBLoggedInUser := Form1.pgqGetUser;

  pgqGetUsers.SQL.Text := '';
  pgqGetUsers.SQL.Add('SELECT * FROM tbl_gebruikers');
  pgqGetUsers.Open;

  advShowUsers.Refresh;

  pnlLeft.BringToFront;
  pnlLeft.Visible := true;
end;

end.
