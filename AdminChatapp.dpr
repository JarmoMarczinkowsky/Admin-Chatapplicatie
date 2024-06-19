program AdminChatapp;

uses
  Vcl.Forms,
  LoginScreen in 'LoginScreen.pas' {frmLogin},
  AdminDashboard in 'AdminDashboard.pas' {frmAdminDashboard},
  DMdatabaseInfo in 'DMdatabaseInfo.pas' {DataModule2: TDataModule},
  frmAddUser in 'frmAddUser.pas' {frmUserAdd},
  frmEditUser in 'frmEditUser.pas' {frmUserEdit},
  frmAddGroup in 'frmAddGroup.pas' {frmGroupAdd},
  frmEditGroup in 'frmEditGroup.pas' {frmGroupEdit},
  frmInfoLog in 'frmInfoLog.pas' {frmLogInfo};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.ShowMainForm := false;
  Application.CreateForm(TDataModule2, DataModule2);
  Application.CreateForm(TfrmAdminDashboard, frmAdminDashboard);
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TfrmUserAdd, frmUserAdd);
  Application.CreateForm(TfrmUserEdit, frmUserEdit);
  Application.CreateForm(TfrmGroupAdd, frmGroupAdd);
  Application.CreateForm(TfrmGroupEdit, frmGroupEdit);
  Application.CreateForm(TfrmLogInfo, frmLogInfo);
  Application.Run;
end.
