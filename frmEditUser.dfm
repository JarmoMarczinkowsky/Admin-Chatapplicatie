object frmUserEdit: TfrmUserEdit
  Left = 0
  Top = 0
  Caption = 'Wijzig gebruiker'
  ClientHeight = 317
  ClientWidth = 342
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsStayOnTop
  OnShow = FormShow
  DesignSize = (
    342
    317)
  TextHeight = 15
  object lblEditUserName: TLabel
    Left = 8
    Top = 19
    Width = 32
    Height = 15
    Caption = 'Naam'
  end
  object lblEditUserStoreName: TLabel
    Left = 8
    Top = 48
    Width = 66
    Height = 15
    Caption = 'Winkelnaam'
  end
  object lblEditUserEmail: TLabel
    Left = 8
    Top = 77
    Width = 29
    Height = 15
    Caption = 'Email'
  end
  object lblEditUserTelephone: TLabel
    Left = 8
    Top = 106
    Width = 91
    Height = 15
    Caption = 'Telefoonnummer'
  end
  object lblEditUserUserName: TLabel
    Left = 8
    Top = 135
    Width = 86
    Height = 15
    Caption = 'Gebruikersnaam'
  end
  object lblEditUserPassword: TLabel
    Left = 8
    Top = 164
    Width = 68
    Height = 15
    Caption = 'Wachtwoord'
  end
  object lblEditUserProfilePicture: TLabel
    Left = 8
    Top = 193
    Width = 56
    Height = 15
    Caption = 'Profielfoto'
  end
  object imgEditProfilePicture: TImage
    Left = 253
    Top = 190
    Width = 69
    Height = 71
    Anchors = [akLeft, akTop, akRight, akBottom]
    Proportional = True
    Stretch = True
    ExplicitWidth = 75
    ExplicitHeight = 75
  end
  object lblEditUserError: TLabel
    Left = 8
    Top = 261
    Width = 28
    Height = 15
    Anchors = [akLeft, akBottom]
    Caption = 'Error'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clCrimson
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    ExplicitTop = 299
  end
  object edtEditUserName: TEdit
    Left = 128
    Top = 16
    Width = 194
    Height = 23
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
    ExplicitWidth = 192
  end
  object edtEditStoreName: TEdit
    Left = 128
    Top = 45
    Width = 194
    Height = 23
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
    ExplicitWidth = 192
  end
  object edtEditUserEmail: TEdit
    Left = 128
    Top = 74
    Width = 194
    Height = 23
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 2
    ExplicitWidth = 192
  end
  object edtEditUserTelephone: TEdit
    Left = 128
    Top = 103
    Width = 194
    Height = 23
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 3
    ExplicitWidth = 192
  end
  object edtEditUserNickName: TEdit
    Left = 128
    Top = 132
    Width = 194
    Height = 23
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 4
    ExplicitWidth = 192
  end
  object edtEditUserPassword: TEdit
    Left = 128
    Top = 161
    Width = 194
    Height = 23
    Anchors = [akLeft, akTop, akRight]
    PasswordChar = #8226
    TabOrder = 5
    ExplicitWidth = 192
  end
  object sbtnEditUserProfilePicture: TAdvSmoothButton
    Left = 128
    Top = 190
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
    Left = 8
    Top = 282
    Width = 125
    Height = 27
    Anchors = [akLeft, akBottom]
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
    ExplicitTop = 274
    TMSStyle = 8
  end
  object AdvSmoothButton3: TAdvSmoothButton
    Left = 201
    Top = 282
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
    OnClick = AdvSmoothButton3Click
    ExplicitLeft = 199
    ExplicitTop = 274
    TMSStyle = 8
  end
end
