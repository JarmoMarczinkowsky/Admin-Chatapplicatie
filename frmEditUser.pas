unit frmEditUser;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, System.RegularExpressions, System.IOUtils,
  Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, AdvSmoothButton,
  Data.DB,
  Vcl.StdCtrls, MemDS, DBAccess, PgAccess;

type
  TfrmUserEdit = class(TForm)
    lblEditUserName: TLabel;
    edtEditUserName: TEdit;
    lblEditUserStoreName: TLabel;
    edtEditStoreName: TEdit;
    lblEditUserEmail: TLabel;
    edtEditUserEmail: TEdit;
    lblEditUserTelephone: TLabel;
    edtEditUserTelephone: TEdit;
    lblEditUserUserName: TLabel;
    edtEditUserNickName: TEdit;
    lblEditUserPassword: TLabel;
    edtEditUserPassword: TEdit;
    lblEditUserProfilePicture: TLabel;
    sbtnEditUserProfilePicture: TAdvSmoothButton;
    imgEditProfilePicture: TImage;
    sbtnEditUser: TAdvSmoothButton;
    AdvSmoothButton3: TAdvSmoothButton;
    lblEditUserError: TLabel;
    cbxUserDeleted: TCheckBox;
    Verwijderd: TLabel;
    procedure FormShow(Sender: TObject);
    procedure sbtnEditUserProfilePictureClick(Sender: TObject);
    procedure AdvSmoothButton3Click(Sender: TObject);
    procedure sbtnEditUserClick(Sender: TObject);
  private
    { Private declarations }
    fileExtension: string;
  public
    { Public declarations }
  end;

var
  frmUserEdit: TfrmUserEdit;

implementation
  uses DMdatabaseInfo, AdminDashboard;

{$R *.dfm}

procedure TfrmUserEdit.AdvSmoothButton3Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmUserEdit.FormShow(Sender: TObject);
var
  stream: TStream;
  getStringStream: TStringStream;
  getString: string;

begin
  lblEditUserError.Caption := '';
  fileExtension := '';

  with DataModule2 do
    begin
      edtEditUserName.Text := pgqCheckExistingUser.FieldByName('gbr_naam').AsString;
      edtEditStoreName.Text := pgqCheckExistingUser.FieldByName('gbr_winkelnaam').AsString;
      edtEditUserTelephone.Text := pgqCheckExistingUser.FieldByName('gbr_tel').AsString;
      edtEditUserEmail.Text := pgqCheckExistingUser.FieldByName('gbr_email').AsString;
      edtEditUserNickName.Text := pgqCheckExistingUser.FieldByName('gbr_nicknaam').AsString;
      cbxUserDeleted.Checked := pgqCheckExistingUser.FieldByName('gbr_del').AsBoolean;
      edtEditUserPassword.Text := '';

      //gives error when loading user with david bowie image
      //loads image from database to TImage
      stream := pgqCheckExistingUser.CreateBlobStream(pgqCheckExistingUser.FieldByName('gbr_profielfoto'), bmRead);

      stream.Position := 0;
      imgEditProfilePicture.Picture.LoadFromStream(stream);

      frmUserEdit.Left := (frmUserEdit.Monitor.Width  - frmUserEdit.Width)  div 2;
      frmUserEdit.Top  := (frmUserEdit.Monitor.Height - frmUserEdit.Height) div 2;
    end;
end;

procedure TfrmUserEdit.sbtnEditUserClick(Sender: TObject);
var
  BlobField: TBlobField;
  AStream: TMemoryStream;
  pgqDuplicateNameCheck : TPgQuery;
begin
  with DataModule2 do
  begin
    lblEditUserError.Font.Color := RGB(220, 20, 60);
    lblEditUserError.Caption := '';

    if((Length(edtEditUserName.Text) > 0) AND
    (Length(edtEditStoreName.Text) > 0) AND
    (Length(edtEditUserEmail.Text) > 0) AND
    (Length(edtEditUserTelephone.Text) > 0) AND
    (Length(edtEditUserNickName.Text) > 0)) then
    begin
      if(TRegEx.IsMatch(edtEditUserEmail.Text, '[^@ \t\r\n]+@[^@ \t\r\n]+\.[^@ \t\r\n]+')) then
      begin
        if(TRegEx.IsMatch(edtEditUserTelephone.Text, '^[0-9+\-]{10,}$')) then
        begin
          pgqDuplicateNameCheck := TPgQuery.Create(nil);
          pgqDuplicateNameCheck.Connection := pgcDBconnection;

          pgqDuplicateNameCheck.SQL.Text := 'SELECT * FROM tbl_gebruikers';
          pgqDuplicateNameCheck.SQL.Add('WHERE (LOWER(gbr_email)=:CheckDuplicateEmail');
          pgqDuplicateNameCheck.SQL.Add('OR LOWER(gbr_nicknaam)=:CheckDuplicateUserName)');
          pgqDuplicateNameCheck.SQL.Add('AND NOT gbr_id=:selectedUserId');

          pgqDuplicateNameCheck.ParamByName('CheckDuplicateEmail').AsString := LowerCase(edtEditUserEmail.Text);
          pgqDuplicateNameCheck.ParamByName('CheckDuplicateUserName').AsString := LowerCase(edtEditUserNickName.Text);
          pgqDuplicateNameCheck.ParamByName('selectedUserId').AsInteger := pgqCheckExistingUser.FieldByName('gbr_id').AsInteger;
          pgqDuplicateNameCheck.Open;

          if(pgqDuplicateNameCheck.RecordCount = 0) then
          begin
            pgqCheckExistingUser.Edit;
            pgqCheckExistingUser.FieldByName('gbr_naam').AsString := edtEditUserName.Text;
            pgqCheckExistingUser.FieldByName('gbr_winkelnaam').AsString := edtEditStoreName.Text;
            pgqCheckExistingUser.FieldByName('gbr_email').AsString := edtEditUserEmail.Text;
            pgqCheckExistingUser.FieldByName('gbr_tel').AsString := edtEditUserTelephone.Text;
            pgqCheckExistingUser.FieldByName('gbr_nicknaam').AsString := edtEditUserNickName.Text;
            pgqCheckExistingUser.FieldByName('gbr_del').AsBoolean := cbxUserDeleted.Checked;

            AStream := TMemoryStream.Create;
            AStream.Position := 0;
            imgEditProfilePicture.Picture.SaveToStream(AStream);

            BlobField := pgqCheckExistingUser.FieldByName('gbr_profielfoto') as TBlobField;
            BlobField.LoadFromStream(AStream);

            pgqCheckExistingUser.FieldByName('gbr_pf_ext').AsString := fileExtension;

            if(Length(edtEditUserPassword.Text) > 0) then
            begin
              pgqCheckExistingUser.FieldByName('gbr_wachtwoord').AsString := HashString(edtEditUserPassword.Text);
            end;

            pgqCheckExistingUser.Post;

            pgqDuplicateNameCheck.Free;
            Self.Close;
          end
          else
          begin
            lblEditUserError.Caption := 'Email of gebruikersnaam is al in gebruik';
            pgqDuplicateNameCheck.Free;
          end;
        end
        else lblEditUserError.Caption := 'Telefoonnummer is niet correct geformatteerd' + #13#10 +
        'Formaat: 10 characters minimaal, alleen '+ #39 + '+' + #39 + ', ' + #39 + '-' + #39 + #13#10 + ' en cijfers 0-9 zijn toegestaan';
      end
      else lblEditUserError.Caption := 'Emailadres is niet correct geformatteerd';
    end
    else
    begin
      lblEditUserError.Caption := 'Vul alle velden in';
    end;

  end;
end;

procedure TfrmUserEdit.sbtnEditUserProfilePictureClick(Sender: TObject);
var
  getPic: TMemoryStream;
begin
  with TOpenDialog.Create(self) do
  try
    Filter := 'Image Files (*.jpg;*.jpeg;*.png)|*.jpg;*.jpeg;*.png';
    Options := [TOpenOption.ofPathMustExist, TOpenOption.ofPathMustExist];
    if (Execute) then imgEditProfilePicture.Picture.LoadFromFile(FileName);
    begin
      fileExtension := LowerCase(TPath.GetExtension(FileName));
    end;
  finally
    Free;
  end;
end;

end.
