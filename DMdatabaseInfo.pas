unit DMdatabaseInfo;

interface

uses
  System.SysUtils, System.Classes, Data.DB, DBAccess, PgAccess, MemDS, System.Hash,
  Vcl.ExtCtrls;

type
  TDataModule2 = class(TDataModule)
    pgcDBconnection: TPgConnection;
    pgqGetLoggedInUser: TPgQuery;
    pgqDelete: TPgQuery;
    pgqGetUsers: TPgQuery;
    pgqGetUsersgbr_id: TIntegerField;
    pgqGetUsersgbr_naam: TStringField;
    pgqGetUsersgbr_winkelnaam: TStringField;
    pgqGetUsersgbr_tel: TStringField;
    pgqGetUsersgbr_email: TStringField;
    pgqGetUsersgbr_nicknaam: TStringField;
    pgqGetUsersgbr_wachtwoord: TStringField;
    pgqGetGroups: TPgQuery;
    pgqGetGroupsgro_id: TIntegerField;
    pgqGetGroupsgro_naam: TStringField;
    pgqGetGroupsgro_igenaar: TIntegerField;
    pgqGetGroupsgro_aangemaakt: TDateTimeField;
    pgqGetGroupsgro_del: TBooleanField;
    pgqGetGroupsgro_profielfoto: TBlobField;
    pgqGetGroupsgro_beschrijving: TMemoField;
    pgqCheckExistingUser: TPgQuery;
    pgqGetSelectedGroup: TPgQuery;
    pgqGetSelectedGroupOwner: TPgQuery;
    pgqGetGroupMembers: TPgQuery;
    tmrLogin: TTimer;
    procedure DataModuleDestroy(Sender: TObject);
    function HashString(const Input: string): string;
    procedure pgcDBconnectionAfterDisconnect(Sender: TObject);
    procedure tmrLoginTimer(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule2: TDataModule2;

implementation
  uses LoginScreen, AdminDashboard;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

Function TDataModule2.HashString(const Input: string): string;
begin
  Result := THashSHA2.GetHashString(Input, THashSHA2.TSHA2Version.SHA256);
end;

procedure TDataModule2.pgcDBconnectionAfterDisconnect(Sender: TObject);
begin
  pgcDBconnection.Open;
end;

procedure TDataModule2.tmrLoginTimer(Sender: TObject);
begin
  tmrLogin.Enabled := false;

  frmAdminDashboard.Visible := false;
  frmLogin.Show;
  frmLogin.Visible := true;

end;

procedure TDataModule2.DataModuleCreate(Sender: TObject);
begin
  if(not pgcDBconnection.Connected) then pgcDBconnection.Open;
end;

procedure TDataModule2.DataModuleDestroy(Sender: TObject);
begin
  pgqGetLoggedInUser.Free;
  pgcDBconnection.Free;
end;

end.
