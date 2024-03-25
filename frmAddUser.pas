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
    AdvSmoothButton1: TAdvSmoothButton;
    sbtnBackToUserOverview: TAdvSmoothButton;
    lblAddUserError: TLabel;
    PgQuery1: TPgQuery;
    procedure sbtnAddUserProfilePictureClick(Sender: TObject);
    procedure AdvSmoothButton1Click(Sender: TObject);
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

procedure TForm3.AdvSmoothButton1Click(Sender: TObject);
var
  pgqAddUser: TPgQuery;
  testHash : string;
  AStream : TMemoryStream;
  BlobField: TBlobField;

//  stream: TMemoryStream;
//  niceBytes: TBytes;
begin
  pgqAddUser := TPgQuery.Create(nil);

  with DataModule2 do
  begin
    pgqAddUser.Connection := pgcDBconnection;
//    timerCounter := 0;

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
            pgqAddUser.ParamByName('userPassword').AsString := HashString('Test123');


            AStream := TMemoryStream.Create;
            imgAddUserProfilePicture.Picture.SaveToStream(AStream);

            pgqAddUser.ParamByName('userProfilePicture').LoadFromStream(AStream, ftGraphic);
  //          BlobField := pgqAddUser.FieldByName('gbr_profielfoto') as TBlobField;
  //          BlobField.LoadFromStream(AStream);

            pgqAddUser.Execute;
            pgqAddUser.Free;
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
        'Formaat: 10 characters minimaal, alleen '+ #39 + '+' + #39 + ', ' + #39 + '-' + #39 + ' en cijfers 0-9 zijn toegestaan';
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
begin
  lblAddUserError.Caption := '';
end;

procedure TForm3.sbtnAddUserProfilePictureClick(Sender: TObject);
var
  testing: TBitmap;
begin
  testing := TBitmap.Create;

  with TOpenDialog.Create(self) do
  try
    Caption := 'Open afbeelding';
    Filter := 'Image Files (*.jpg;*.jpeg;*.png)|*.jpg;*.jpeg;*.png';
    Options := [TOpenOption.ofPathMustExist, TOpenOption.ofPathMustExist];
    if (Execute) then imgAddUserProfilePicture.Picture.LoadFromFile(FileName);

  finally
    Free;
  end;
end;

procedure TForm3.sbtnBackToUserOverviewClick(Sender: TObject);
begin
  Self.Close;
end;

end.
