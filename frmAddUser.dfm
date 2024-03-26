object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Form3'
  ClientHeight = 441
  ClientWidth = 438
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnShow = FormShow
  TextHeight = 15
  object lblName: TLabel
    Left = 56
    Top = 59
    Width = 32
    Height = 15
    Caption = 'Naam'
  end
  object lblStoreName: TLabel
    Left = 56
    Top = 88
    Width = 66
    Height = 15
    Caption = 'Winkelnaam'
  end
  object lblEmail: TLabel
    Left = 56
    Top = 117
    Width = 29
    Height = 15
    Caption = 'Email'
  end
  object lblTelephone: TLabel
    Left = 56
    Top = 146
    Width = 91
    Height = 15
    Caption = 'Telefoonnummer'
  end
  object lblNickname: TLabel
    Left = 56
    Top = 175
    Width = 86
    Height = 15
    Caption = 'Gebruikersnaam'
  end
  object Label19: TLabel
    Left = 56
    Top = 204
    Width = 56
    Height = 15
    Caption = 'Profielfoto'
  end
  object imgAddUserProfilePicture: TImage
    Left = 301
    Top = 201
    Width = 75
    Height = 75
    Stretch = True
  end
  object lblAddUserError: TLabel
    Left = 56
    Top = 360
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
  object edtUserName: TEdit
    Left = 176
    Top = 56
    Width = 200
    Height = 23
    TabOrder = 0
  end
  object edtUserStoreName: TEdit
    Left = 176
    Top = 85
    Width = 200
    Height = 23
    TabOrder = 1
  end
  object edtUserEmail: TEdit
    Left = 176
    Top = 114
    Width = 200
    Height = 23
    TabOrder = 2
  end
  object edtUserTelephone: TEdit
    Left = 176
    Top = 143
    Width = 200
    Height = 23
    TabOrder = 3
  end
  object edtUserNickName: TEdit
    Left = 176
    Top = 172
    Width = 200
    Height = 23
    TabOrder = 4
  end
  object sbtnAddUserProfilePicture: TAdvSmoothButton
    Left = 176
    Top = 201
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
    TabOrder = 5
    Version = '2.2.3.1'
    OnClick = sbtnAddUserProfilePictureClick
    TMSStyle = 8
  end
  object AdvSmoothButton1: TAdvSmoothButton
    Left = 56
    Top = 304
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
    Caption = 'Toevoegen'
    Color = 13472847
    ParentFont = False
    TabOrder = 6
    Version = '2.2.3.1'
    OnClick = AdvSmoothButton1Click
    TMSStyle = 8
  end
  object sbtnBackToUserOverview: TAdvSmoothButton
    Left = 187
    Top = 304
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
    TabOrder = 7
    Version = '2.2.3.1'
    OnClick = sbtnBackToUserOverviewClick
    TMSStyle = 8
  end
  object PgQuery1: TPgQuery
    Connection = DataModule2.pgcDBconnection
    Left = 328
    Top = 368
  end
end
