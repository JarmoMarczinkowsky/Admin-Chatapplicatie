program AdminChatapp;

uses
  Vcl.Forms,
  LoginScreen in 'LoginScreen.pas' {Form1},
  AdminDashboard in 'AdminDashboard.pas' {Form2},
  DMdatabaseInfo in 'DMdatabaseInfo.pas' {DataModule2: TDataModule},
  frmAddUser in 'frmAddUser.pas' {Form3},
  frmEditUser in 'frmEditUser.pas' {frmUserEdit},
  frmAddGroup in 'frmAddGroup.pas' {frmGroupAdd};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TDataModule2, DataModule2);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TfrmUserEdit, frmUserEdit);
  Application.CreateForm(TfrmGroupAdd, frmGroupAdd);
  Application.Run;
end.
