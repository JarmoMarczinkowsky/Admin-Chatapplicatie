unit frmEditUser;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, System.RegularExpressions,
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
    procedure FormShow(Sender: TObject);
    procedure sbtnEditUserProfilePictureClick(Sender: TObject);
    procedure AdvSmoothButton3Click(Sender: TObject);
    procedure sbtnEditUserClick(Sender: TObject);
  private
    { Private declarations }
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
begin
  lblEditUserError.Caption := '';

  with DataModule2 do
    begin
      edtEditUserName.Text := pgqCheckExistingUser.FieldByName('gbr_naam').AsString;
      edtEditStoreName.Text := pgqCheckExistingUser.FieldByName('gbr_winkelnaam').AsString;
      edtEditUserTelephone.Text := pgqCheckExistingUser.FieldByName('gbr_tel').AsString;
      edtEditUserEmail.Text := pgqCheckExistingUser.FieldByName('gbr_email').AsString;
      edtEditUserNickName.Text := pgqCheckExistingUser.FieldByName('gbr_nicknaam').AsString;
      edtEditUserPassword.Text := '';

      //loads image from database to TImage
//      stream := pgqCheckExistingUser.CreateBlobStream(pgqCheckExistingUser.FieldByName('gbr_profielfoto'), bmRead);
      stream := pgqCheckExistingUser.CreateBlobStream(pgqCheckExistingUser.FieldByName('gbr_profielfoto'), bmRead);
      imgEditProfilePicture.Picture.LoadFromStream(stream);
    end;
end;

procedure TfrmUserEdit.sbtnEditUserClick(Sender: TObject);
var
  BlobField: TBlobField;
  AStream: TMemoryStream;
  pgqDuplicateNameCheck : TPgQuery;
begin
  pgqDuplicateNameCheck := TPgQuery.Create(nil);
  pgqDuplicateNameCheck.Connection := DataModule2.pgcDBconnection;

  lblEditUserError.Font.Color := RGB(220, 20, 60);
  lblEditUserError.Caption := '';

//  DataModule2.pgqCheckExistingUser.Close;

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
        pgqDuplicateNameCheck.Close;

        pgqDuplicateNameCheck.SQL.Text := '';
        pgqDuplicateNameCheck.SQL.Add('SELECT * FROM tbl_gebruikers');
        pgqDuplicateNameCheck.SQL.Add('WHERE (LOWER(gbr_email)=:CheckDuplicateEmail');
        pgqDuplicateNameCheck.SQL.Add('OR LOWER(gbr_nicknaam)=:CheckDuplicateUserName)');
        pgqDuplicateNameCheck.SQL.Add('AND NOT gbr_id=:selectedUserId');

        pgqDuplicateNameCheck.ParamByName('CheckDuplicateEmail').AsString := LowerCase(edtEditUserEmail.Text);
        pgqDuplicateNameCheck.ParamByName('CheckDuplicateUserName').AsString := LowerCase(edtEditUserNickName.Text);
        pgqDuplicateNameCheck.ParamByName('selectedUserId').AsInteger := DataModule2.pgqCheckExistingUser.FieldByName('gbr_id').AsInteger;
        pgqDuplicateNameCheck.Open;

        if(pgqDuplicateNameCheck.RecordCount = 0) then
        begin
          DataModule2.pgqCheckExistingUser.Edit;
          DataModule2.pgqCheckExistingUser.FieldByName('gbr_naam').AsString := edtEditUserName.Text;
          DataModule2.pgqCheckExistingUser.FieldByName('gbr_winkelnaam').AsString := edtEditStoreName.Text;
          DataModule2.pgqCheckExistingUser.FieldByName('gbr_email').AsString := edtEditUserEmail.Text;
          DataModule2.pgqCheckExistingUser.FieldByName('gbr_tel').AsString := edtEditUserTelephone.Text;
          DataModule2.pgqCheckExistingUser.FieldByName('gbr_nicknaam').AsString := edtEditUserNickName.Text;

          AStream := TMemoryStream.Create;
          imgEditProfilePicture.Picture.SaveToStream(AStream);
          BlobField := DataModule2.pgqCheckExistingUser.FieldByName('gbr_profielfoto') as TBlobField;
          BlobField.LoadFromStream(AStream);

          if(Length(edtEditUserPassword.Text) > 0) then
          begin
            DataModule2.pgqCheckExistingUser.FieldByName('gbr_wachtwoord').AsString := DataModule2.HashString(edtEditUserPassword.Text);
          end;

          DataModule2.pgqCheckExistingUser.Post;
//          lblEditUserError.Caption := 'Gebruiker succesvol aangepast';
//          lblEditUserError.Font.Color := clGreen;

          Self.Close;
        end
        else
        begin
          lblEditUserError.Caption := 'Email of gebruikersnaam is al in gebruik';
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

  pgqDuplicateNameCheck.Free;
end;

procedure TfrmUserEdit.sbtnEditUserProfilePictureClick(Sender: TObject);
begin
  with TOpenDialog.Create(self) do
    try
      Caption := 'Open afbeelding';
      Filter := 'Image Files (*.jpg;*.jpeg;*.png)|*.jpg;*.jpeg;*.png';
      Options := [TOpenOption.ofPathMustExist, TOpenOption.ofPathMustExist];
      if (Execute) then imgEditProfilePicture.Picture.LoadFromFile(FileName);

    finally
      Free;
    end;
end;

end.
