unit AdminDashboard;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvUtil, Vcl.Grids, AdvObj, BaseGrid,
  AdvGrid, DBAdvGrid, Vcl.ExtCtrls, Data.DB, MemDS, DBAccess, PgAccess,
  AdvSmoothButton;

type
  TForm2 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
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
    sbtnRetrieveUsers: TAdvSmoothButton;

    procedure FormShow(Sender: TObject);
    procedure sbtnRetrieveUsersClick(Sender: TObject);
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
end;

procedure TForm2.sbtnRetrieveUsersClick(Sender: TObject);
begin

  //ShowMessage('Records found: ' + IntToStr(pgqGetUsers.RecordCount));
end;

end.
