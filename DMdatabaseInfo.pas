unit DMdatabaseInfo;

interface

uses
  System.SysUtils, System.Classes, Data.DB, DBAccess, PgAccess, MemDS;

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
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule2: TDataModule2;

implementation


{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDataModule2.DataModuleDestroy(Sender: TObject);
begin
  pgqGetLoggedInUser.Free;
  pgcDBconnection.Free;
end;

end.
