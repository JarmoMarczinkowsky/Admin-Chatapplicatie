object frmUserAdd: TfrmUserAdd
  Left = 0
  Top = 0
  Caption = 'Voeg gebruiker toe'
  ClientHeight = 332
  ClientWidth = 347
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsStayOnTop
  OnShow = FormShow
  DesignSize = (
    347
    332)
  TextHeight = 15
  object lblName: TLabel
    Left = 11
    Top = 19
    Width = 32
    Height = 15
    Caption = 'Naam'
  end
  object lblStoreName: TLabel
    Left = 11
    Top = 48
    Width = 66
    Height = 15
    Caption = 'Winkelnaam'
  end
  object lblEmail: TLabel
    Left = 11
    Top = 77
    Width = 29
    Height = 15
    Caption = 'Email'
  end
  object lblTelephone: TLabel
    Left = 11
    Top = 106
    Width = 91
    Height = 15
    Caption = 'Telefoonnummer'
  end
  object lblNickname: TLabel
    Left = 11
    Top = 135
    Width = 86
    Height = 15
    Caption = 'Gebruikersnaam'
  end
  object Label19: TLabel
    Left = 11
    Top = 193
    Width = 56
    Height = 15
    Caption = 'Profielfoto'
  end
  object imgAddUserProfilePicture: TImage
    Left = 257
    Top = 190
    Width = 75
    Height = 75
    Anchors = [akLeft, akTop, akRight, akBottom]
    Proportional = True
    Stretch = True
  end
  object lblAddUserError: TLabel
    Left = 0
    Top = 250
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
  object lblUserPassword: TLabel
    Left = 11
    Top = 164
    Width = 68
    Height = 15
    Caption = 'Wachtwoord'
  end
  object edtUserName: TEdit
    Left = 131
    Top = 16
    Width = 201
    Height = 23
    TabOrder = 0
  end
  object edtUserStoreName: TEdit
    Left = 131
    Top = 45
    Width = 201
    Height = 23
    TabOrder = 1
  end
  object edtUserEmail: TEdit
    Left = 131
    Top = 74
    Width = 201
    Height = 23
    TabOrder = 2
  end
  object edtUserTelephone: TEdit
    Left = 131
    Top = 103
    Width = 201
    Height = 23
    TabOrder = 3
  end
  object edtUserNickName: TEdit
    Left = 131
    Top = 132
    Width = 201
    Height = 23
    TabOrder = 4
  end
  object sbtnAddUserProfilePicture: TAdvSmoothButton
    Left = 131
    Top = 190
    Width = 119
    Height = 27
    Anchors = [akTop, akRight]
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
    OnClick = sbtnAddUserProfilePictureClick
    TMSStyle = 8
  end
  object sbtnAddUser: TAdvSmoothButton
    Left = 0
    Top = 294
    Width = 125
    Height = 27
    Anchors = [akRight, akBottom]
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
    Caption = 'Toevoegen'
    Color = 13472847
    ParentFont = False
    TabOrder = 7
    Version = '2.2.3.1'
    OnClick = sbtnAddUserClick
    ExplicitTop = 287
    TMSStyle = 8
  end
  object sbtnBackToUserOverview: TAdvSmoothButton
    Left = 214
    Top = 294
    Width = 125
    Height = 27
    Anchors = [akRight, akBottom]
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
    Color = clCrimson
    ParentFont = False
    TabOrder = 8
    Version = '2.2.3.1'
    OnClick = sbtnBackToUserOverviewClick
    TMSStyle = 8
  end
  object edtUserPassword: TEdit
    Left = 131
    Top = 161
    Width = 201
    Height = 23
    PasswordChar = #8226
    TabOrder = 5
  end
end
