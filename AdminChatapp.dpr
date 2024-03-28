program AdminChatapp;

uses
  Vcl.Forms,
  LoginScreen in 'LoginScreen.pas' {Form1},
  AdminDashboard in 'AdminDashboard.pas' {frmAdminDashboard},
  DMdatabaseInfo in 'DMdatabaseInfo.pas' {DataModule2: TDataModule},
  frmAddUser in 'frmAddUser.pas' {Form3},
  frmEditUser in 'frmEditUser.pas' {frmUserEdit},
  frmAddGroup in 'frmAddGroup.pas' {frmGroupAdd},
  frmEditGroup in 'frmEditGroup.pas' {frmGroupEdit};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfrmAdminDashboard, frmAdminDashboard);
  Application.CreateForm(TDataModule2, DataModule2);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TfrmUserEdit, frmUserEdit);
  Application.CreateForm(TfrmGroupAdd, frmGroupAdd);
  Application.CreateForm(TfrmGroupEdit, frmGroupEdit);
  Application.Run;
end.
