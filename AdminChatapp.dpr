program AdminChatapp;

uses
  Vcl.Forms,
  LoginScreen in 'LoginScreen.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
