object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 378
  ClientWidth = 511
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object Label1: TLabel
    Left = 168
    Top = 139
    Width = 87
    Height = 15
    Caption = 'Username/Email'
  end
  object Label2: TLabel
    Left = 168
    Top = 192
    Width = 68
    Height = 15
    Caption = 'Wachtwoord'
  end
  object lblError: TLabel
    Left = 168
    Top = 331
    Width = 9
    Height = 15
    Caption = '...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object sbtnLogin: TAdvSmoothButton
    Left = 168
    Top = 272
    Width = 217
    Height = 35
    Appearance.Font.Charset = DEFAULT_CHARSET
    Appearance.Font.Color = clWhite
    Appearance.Font.Height = -12
    Appearance.Font.Name = 'Segoe UI'
    Appearance.Font.Style = [fsBold]
    Appearance.SimpleLayout = True
    Appearance.Rounding = 10
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
    Caption = 'Login'
    Color = 3023058
    ParentFont = False
    TabOrder = 0
    Version = '2.2.3.1'
    OnClick = sbtnLoginClick
    TMSStyle = 8
  end
  object edtUser: TEdit
    Left = 168
    Top = 160
    Width = 217
    Height = 23
    TabOrder = 1
  end
  object edtPassword: TEdit
    Left = 168
    Top = 213
    Width = 217
    Height = 23
    PasswordChar = #8226
    TabOrder = 2
  end
  object pgcDBconnection: TPgConnection
    Username = 'stage2'
    Server = '142.132.213.151'
    LoginPrompt = False
    Database = 'rchat'
    Connected = True
    Left = 88
    Top = 56
    EncryptedPassword = 'CDFFACFF8BFF9EFF98FF9AFFD5FF'
  end
  object pgqGetUser: TPgQuery
    Connection = pgcDBconnection
    Left = 208
    Top = 56
  end
end
