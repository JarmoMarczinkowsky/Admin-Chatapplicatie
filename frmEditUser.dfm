object frmUserEdit: TfrmUserEdit
  Left = 0
  Top = 0
  Caption = 'Wijzig gebruiker'
  ClientHeight = 441
  ClientWidth = 432
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnShow = FormShow
  TextHeight = 15
  object lblEditUserName: TLabel
    Left = 56
    Top = 59
    Width = 32
    Height = 15
    Caption = 'Naam'
  end
  object lblEditUserStoreName: TLabel
    Left = 56
    Top = 88
    Width = 66
    Height = 15
    Caption = 'Winkelnaam'
  end
  object lblEditUserEmail: TLabel
    Left = 56
    Top = 117
    Width = 29
    Height = 15
    Caption = 'Email'
  end
  object lblEditUserTelephone: TLabel
    Left = 56
    Top = 146
    Width = 91
    Height = 15
    Caption = 'Telefoonnummer'
  end
  object lblEditUserUserName: TLabel
    Left = 56
    Top = 175
    Width = 86
    Height = 15
    Caption = 'Gebruikersnaam'
  end
  object lblEditUserPassword: TLabel
    Left = 56
    Top = 204
    Width = 68
    Height = 15
    Caption = 'Wachtwoord'
  end
  object lblEditUserProfilePicture: TLabel
    Left = 56
    Top = 233
    Width = 56
    Height = 15
    Caption = 'Profielfoto'
  end
  object imgEditProfilePicture: TImage
    Left = 301
    Top = 230
    Width = 75
    Height = 75
    Stretch = True
  end
  object lblEditUserError: TLabel
    Left = 56
    Top = 392
    Width = 28
    Height = 15
    Caption = 'Error'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clCrimson
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object edtEditUserName: TEdit
    Left = 176
    Top = 56
    Width = 200
    Height = 23
    TabOrder = 0
  end
  object edtEditStoreName: TEdit
    Left = 176
    Top = 85
    Width = 200
    Height = 23
    TabOrder = 1
  end
  object edtEditUserEmail: TEdit
    Left = 176
    Top = 114
    Width = 200
    Height = 23
    TabOrder = 2
  end
  object edtEditUserTelephone: TEdit
    Left = 176
    Top = 143
    Width = 200
    Height = 23
    TabOrder = 3
  end
  object edtEditUserNickName: TEdit
    Left = 176
    Top = 172
    Width = 200
    Height = 23
    TabOrder = 4
  end
  object edtEditUserPassword: TEdit
    Left = 176
    Top = 201
    Width = 200
    Height = 23
    PasswordChar = #8226
    TabOrder = 5
  end
  object sbtnEditUserProfilePicture: TAdvSmoothButton
    Left = 176
    Top = 230
    Width = 119
    Height = 27
    Appearance.SimpleLayout = True
    Appearance.Rounding = 5
    Status.Caption = '0'
    Status.Appearance.Fill.Color = clRed
    Status.Appearance.Fill.ColorMirror = clNone
    Status.Appearance.Fill.ColorMirrorTo = clNone
    Status.Appearance.Fill.GradientType = gtSolid
    Status.Appearance.Fill.GradientMirrorType = gtSolid
    Status.Appearance.Fill.BorderColor = clGray
    Status.Appearance.Fill.Rounding = 0
    Status.Appearance.Fill.ShadowOffset = 0
    Status.Appearance.Fill.Glow = gmNone
    Status.Appearance.Font.Charset = DEFAULT_CHARSET
    Status.Appearance.Font.Color = clWhite
    Status.Appearance.Font.Height = -11
    Status.Appearance.Font.Name = 'Segoe UI'
    Status.Appearance.Font.Style = []
    Caption = 'Upload bestand'
    Color = 12698049
    TabOrder = 6
    Version = '2.2.3.1'
    OnClick = sbtnEditUserProfilePictureClick
    TMSStyle = 8
  end
  object sbtnEditUser: TAdvSmoothButton
    Left = 56
    Top = 333
    Width = 125
    Height = 27
    Appearance.Font.Charset = DEFAULT_CHARSET
    Appearance.Font.Color = clWhite
    Appearance.Font.Height = -12
    Appearance.Font.Name = 'Segoe UI'
    Appearance.Font.Style = [fsBold]
    Appearance.SimpleLayout = True
    Appearance.Rounding = 5
    Status.Caption = '0'
    Status.Appearance.Fill.Color = clRed
    Status.Appearance.Fill.ColorMirror = clNone
    Status.Appearance.Fill.ColorMirrorTo = clNone
    Status.Appearance.Fill.GradientType = gtSolid
    Status.Appearance.Fill.GradientMirrorType = gtSolid
    Status.Appearance.Fill.BorderColor = clGray
    Status.Appearance.Fill.Rounding = 0
    Status.Appearance.Fill.ShadowOffset = 0
    Status.Appearance.Fill.Glow = gmNone
    Status.Appearance.Font.Charset = DEFAULT_CHARSET
    Status.Appearance.Font.Color = clWhite
    Status.Appearance.Font.Height = -11
    Status.Appearance.Font.Name = 'Segoe UI'
    Status.Appearance.Font.Style = []
    Caption = 'Aanpassen'
    Color = 13472847
    ParentFont = False
    TabOrder = 7
    Version = '2.2.3.1'
    OnClick = sbtnEditUserClick
    TMSStyle = 8
  end
  object AdvSmoothButton3: TAdvSmoothButton
    Left = 187
    Top = 333
    Width = 125
    Height = 27
    Appearance.Font.Charset = DEFAULT_CHARSET
    Appearance.Font.Color = clWhite
    Appearance.Font.Height = -12
    Appearance.Font.Name = 'Segoe UI'
    Appearance.Font.Style = [fsBold]
    Appearance.SimpleLayout = True
    Appearance.Rounding = 5
    Status.Caption = '0'
    Status.Appearance.Fill.Color = clRed
    Status.Appearance.Fill.ColorMirror = clNone
    Status.Appearance.Fill.ColorMirrorTo = clNone
    Status.Appearance.Fill.GradientType = gtSolid
    Status.Appearance.Fill.GradientMirrorType = gtSolid
    Status.Appearance.Fill.BorderColor = clGray
    Status.Appearance.Fill.Rounding = 0
    Status.Appearance.Fill.ShadowOffset = 0
    Status.Appearance.Fill.Glow = gmNone
    Status.Appearance.Font.Charset = DEFAULT_CHARSET
    Status.Appearance.Font.Color = clWhite
    Status.Appearance.Font.Height = -11
    Status.Appearance.Font.Name = 'Segoe UI'
    Status.Appearance.Font.Style = []
    Caption = 'Annuleren'
    Color = 16764551
    ParentFont = False
    TabOrder = 8
    Version = '2.2.3.1'
    OnClick = AdvSmoothButton3Click
    TMSStyle = 8
  end
end
