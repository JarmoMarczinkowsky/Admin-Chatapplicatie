unit frmInfoLog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmLogInfo = class(TForm)
    edtUsername: TEdit;
    lblUserName: TLabel;
    lblLogMessage: TLabel;
    edtLogMessage: TEdit;
    Label1: TLabel;
    edtDate: TEdit;
    Label2: TLabel;
    cbxReadLog: TCheckBox;
    memNote: TMemo;
    Label3: TLabel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogInfo: TfrmLogInfo;

implementation
  uses DMdatabaseInfo;

{$R *.dfm}

procedure TfrmLogInfo.FormShow(Sender: TObject);
begin
  Self.Top := (Monitor.Height - Self.Height) div 2;
  Self.Left := (Monitor.Width - Self.Width) div 2;

  with DataModule2 do
  begin
    edtUsername.Text := pgqGetSelectedLog.FieldByName('gbr_nicknaam').AsString;
    edtLogMessage.Text := pgqGetSelectedLog.FieldByName('log_bericht').AsString;
    edtDate.Text := pgqGetSelectedLog.FieldByName('log_aangemaakt').AsString;
    if(Length(pgqGetSelectedLog.FieldByName('log_notitie').AsString) > 0) then
    begin
      memNote.Lines.Text := pgqGetSelectedLog.FieldByName('log_notitie').AsString;
    end
    else
    begin
      memNote.Lines.Text := '(geen notitie gevonden)';
    end;

    cbxReadLog.Checked := pgqGetSelectedLog.FieldByName('log_gelezen').AsBoolean;
  end;
end;

end.
