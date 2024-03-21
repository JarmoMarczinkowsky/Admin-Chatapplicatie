unit DMdatabaseInfo;

interface

uses
  System.SysUtils, System.Classes, Data.DB, DBAccess, PgAccess, MemDS;

type
  TDataModule2 = class(TDataModule)
    pgcDBconnection: TPgConnection;
    pgqGetLoggedInUser: TPgQuery;
    pgqDelete: TPgQuery;
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
