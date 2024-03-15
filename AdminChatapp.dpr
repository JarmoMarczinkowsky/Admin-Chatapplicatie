program AdminChatapp;

uses
  Vcl.Forms,
  LoginScreen in 'LoginScreen.pas' {Form1},
  AdminDashboard in 'AdminDashboard.pas' {Form2},
  DMdatabaseInfo in 'DMdatabaseInfo.pas' {DataModule2: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TDataModule2, DataModule2);
  Application.Run;
end.
