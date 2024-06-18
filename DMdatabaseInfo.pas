unit DMdatabaseInfo;

interface

uses
  System.SysUtils, System.Classes, Data.DB, DBAccess, PgAccess, MemDS, System.Hash,
  Vcl.ExtCtrls, MemData, Vcl.Forms, Vcl.Dialogs, Winapi.Windows;

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
    pgqGetSelectedLog: TPgQuery;
    pgqGetAllLogs: TPgQuery;
    procedure DataModuleDestroy(Sender: TObject);
    function HashString(const Input: string): string;
    procedure tmrLoginTimer(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure pgcDBconnectionConnectionLost(Sender: TObject;
      Component: TComponent; ConnLostCause: TConnLostCause;
      var RetryMode: TRetryMode);
    procedure pgcDBconnectionAfterDisconnect(Sender: TObject);
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
  ShowMessage('Disconnected');
end;

procedure TDataModule2.pgcDBconnectionConnectionLost(Sender: TObject;
  Component: TComponent; ConnLostCause: TConnLostCause;
  var RetryMode: TRetryMode);
var
  userChoice : integer;
  getChoice : string;
begin
  userChoice := Application.MessageBox(PWideChar('Geen verbinding gevonden, wil je opnieuw verbinding maken?') , 'Geen verbinding gevonden', MB_OKCANCEL );
  if(userChoice = 1) then getChoice := 'ok'
  else if userchoice = 2 then getChoice := 'cancel';

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
