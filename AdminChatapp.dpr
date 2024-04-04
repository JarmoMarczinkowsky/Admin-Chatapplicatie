program AdminChatapp;

uses
  Vcl.Forms,
  LoginScreen in 'LoginScreen.pas' {frmLogin},
  AdminDashboard in 'AdminDashboard.pas' {frmAdminDashboard},
  DMdatabaseInfo in 'DMdatabaseInfo.pas' {DataModule2: TDataModule},
  frmAddUser in 'frmAddUser.pas' {frmUserAdd},
  frmEditUser in 'frmEditUser.pas' {frmUserEdit},
  frmAddGroup in 'frmAddGroup.pas' {frmGroupAdd},
  frmEditGroup in 'frmEditGroup.pas' {frmGroupEdit};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TfrmAdminDashboard, frmAdminDashboard);
  Application.CreateForm(TDataModule2, DataModule2);
  Application.CreateForm(TfrmUserAdd, frmUserAdd);
  Application.CreateForm(TfrmUserEdit, frmUserEdit);
  Application.CreateForm(TfrmGroupAdd, frmGroupAdd);
  Application.CreateForm(TfrmGroupEdit, frmGroupEdit);
  Application.Run;
end.
