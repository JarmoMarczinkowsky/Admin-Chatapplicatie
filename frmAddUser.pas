unit frmAddUser;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, System.RegularExpressions,
  Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, AdvSmoothButton,
  Vcl.StdCtrls, Data.DB, MemDS, DBAccess, PgAccess;

type
  TForm3 = class(TForm)
    lblName: TLabel;
    edtUserName: TEdit;
    lblStoreName: TLabel;
    edtUserStoreName: TEdit;
    lblEmail: TLabel;
    edtUserEmail: TEdit;
    lblTelephone: TLabel;
    edtUserTelephone: TEdit;
    lblNickname: TLabel;
    edtUserNickName: TEdit;
    Label19: TLabel;
    sbtnAddUserProfilePicture: TAdvSmoothButton;
    imgAddUserProfilePicture: TImage;
    sbtnAddUser: TAdvSmoothButton;
    sbtnBackToUserOverview: TAdvSmoothButton;
    lblAddUserError: TLabel;
    edtUserPassword: TEdit;
    lblUserPassword: TLabel;
    procedure sbtnAddUserProfilePictureClick(Sender: TObject);
    procedure sbtnAddUserClick(Sender: TObject);
    procedure sbtnBackToUserOverviewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
//    function HashString(const Input: string): string;
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation
  uses DMdatabaseInfo;

{$R *.dfm}

procedure TForm3.sbtnAddUserClick(Sender: TObject);
var
  pgqAddUser: TPgQuery;
  AStream : TMemoryStream;
begin
  pgqAddUser := TPgQuery.Create(nil);

  with DataModule2 do
  begin
    pgqAddUser.Connection := pgcDBconnection;

    lblAddUserError.Caption := '';
    lblAddUserError.Font.Color := RGB(220, 20, 60);

    if((Length(edtUserName.Text) > 0) AND
    (Length(edtUserStoreName.Text) > 0) AND
    (Length(edtUserEmail.Text) > 0) AND
    (Length(edtUserTelephone.Text) > 0) AND
    (Length(edtUserNickName.Text) > 0)) then
    begin
      if(TRegEx.IsMatch(edtUserEmail.Text, '[^@ \t\r\n]+@[^@ \t\r\n]+\.[^@ \t\r\n]+')) then
      begin
        if(TRegEx.IsMatch(edtUserTelephone.Text, '^[0-9+\-]{10,}$')) then
        begin
          pgqCheckExistingUser.SQL.Text := '';
          pgqCheckExistingUser.SQL.Add('SELECT * FROM tbl_gebruikers');
          pgqCheckExistingUser.SQL.Add('WHERE LOWER(gbr_email)=:CheckDuplicateEmail');
          pgqCheckExistingUser.SQL.Add('OR LOWER(gbr_nicknaam)=:CheckDuplicateUserName');
          pgqCheckExistingUser.ParamByName('CheckDuplicateEmail').AsString := LowerCase(edtUserEmail.Text);
          pgqCheckExistingUser.ParamByName('CheckDuplicateUserName').AsString := LowerCase(edtUserNickName.Text);
          pgqCheckExistingUser.Open;

          if(pgqCheckExistingUser.RecordCount = 0) then
          begin
            pgqCheckExistingUser.Close;

            pgqAddUser.SQL.Text := '';
            pgqAddUser.SQL.Text := 'INSERT INTO tbl_gebruikers (gbr_naam, gbr_winkelnaam, gbr_tel, gbr_email, gbr_nicknaam, gbr_wachtwoord, gbr_profielfoto)';
            pgqAddUser.SQL.Add('VALUES (:username, :userStoreName, :userTel, :userEmail, :userNickname, :userPassword, :userProfilePicture)');

  //          pgqAddUser.SQL.Text := '';
  //          pgqAddUser.SQL.Add('SELECT * FROM tbl_gebruikers');
  //          pgqAddUser.Open;
  //          pgqAddUser.Append;
            pgqAddUser.ParamByName('username').AsString := Trim(edtUserName.Text);
            pgqAddUser.ParamByName('userStoreName').AsString := Trim(edtUserStoreName.Text);
            pgqAddUser.ParamByName('userTel').AsString := Trim(edtUserTelephone.Text);
            pgqAddUser.ParamByName('userEmail').AsString := Trim(edtUserEmail.Text);
            pgqAddUser.ParamByName('userNickname').AsString := Trim(edtUserNickName.Text);

            if(edtUserPassword.Text = '') then pgqAddUser.ParamByName('userPassword').AsString := HashString('Test123')
            else pgqAddUser.ParamByName('userPassword').AsString := HashString(edtUserPassword.Text);

            AStream := TMemoryStream.Create;
            imgAddUserProfilePicture.Picture.SaveToStream(AStream);

            pgqAddUser.ParamByName('userProfilePicture').LoadFromStream(AStream, ftGraphic);
  //          BlobField := pgqAddUser.FieldByName('gbr_profielfoto') as TBlobField;
  //          BlobField.LoadFromStream(AStream);

            pgqAddUser.Execute;

            if(pgqAddUser.Active) then pgqAddUser.Close;
            AStream.Free;

            lblAddUserError.Font.Color := clGreen;
            lblAddUserError.Caption := 'Gebruiker ' +  Trim(edtUserNickName.Text) + ' succesvol toegevoegd';

            edtUserName.Text := '';
            edtUserStoreName.Text := '';
            edtUserTelephone.Text := '';
            edtUserNickName.Text := '';
            edtUserEmail.Text := '';
            imgAddUserProfilePicture.Picture := nil;

            Self.Close;
          end
          else
          begin
            lblAddUserError.Caption := 'Email of gebruikersnaam is al in gebruik';
          end;
        end
        else lblAddUserError.Caption := 'Telefoonnummer is niet correct geformatteerd' + #13#10 +
        'Formaat: 10 characters minimaal, alleen '+ #39 + '+' + #39 + ', ' + #39 + '-' + #39 + #13#10 + ' en cijfers 0-9 zijn toegestaan';
      end
      else lblAddUserError.Caption := 'Emailadres is niet correct geformatteerd';
    end
    else
    begin
      lblAddUserError.Caption := 'Vul alle velden in';
    end;
  end;
end;

procedure TForm3.FormShow(Sender: TObject);
var
  getWIdth, getHieght: integer;
begin
  lblAddUserError.Caption := '';

  getWIdth:= self.Width;
  getHieght := Self.Height;

  Form3.PixelsPerInch := 96;

  Form3.Left := (Form3.Monitor.Width  - Form3.Width)  div 2;
  Form3.Top  := (Form3.Monitor.Height - Form3.Height) div 2;
end;

procedure TForm3.sbtnAddUserProfilePictureClick(Sender: TObject);
var
//  testing: TBitmap;
  getFile: TFileStream;
  getSize: Double;
begin
//  testing := TBitmap.Create;

  with TOpenDialog.Create(self) do
  try
    Caption := 'Open afbeelding';
    Filter := 'Image Files (*.jpg;*.jpeg;*.png)|*.jpg;*.jpeg;*.png';
    Options := [TOpenOption.ofPathMustExist, TOpenOption.ofPathMustExist];
    if (Execute) then
    begin
      getFile := TFileStream.Create(FileName, fmOpenRead or fmShareDenyNone);
      getSize := Round(getFile.Size / 1048576);

      if(getSize < 2) then
      begin
        imgAddUserProfilePicture.Picture.LoadFromFile(FileName);
      end
      else lblAddUserError.Caption :=  'Afbeelding is te groot (moet kleiner dan 2 mb zijn)';
    end;

  finally
    Free;
  end;
end;

procedure TForm3.sbtnBackToUserOverviewClick(Sender: TObject);
begin
  Self.Close;
end;

end.
