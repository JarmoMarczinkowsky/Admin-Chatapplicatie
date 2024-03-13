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
  object sbtnLogin: TAdvSmoothButton
    Left = 168
    Top = 272
    Width = 217
    Height = 35
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
    TabOrder = 0
    Version = '2.2.3.1'
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
end
