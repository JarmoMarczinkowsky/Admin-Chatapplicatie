object frmLogInfo: TfrmLogInfo
  Left = 0
  Top = 0
  ClientHeight = 264
  ClientWidth = 376
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnShow = FormShow
  DesignSize = (
    376
    264)
  TextHeight = 15
  object lblUserName: TLabel
    Left = 8
    Top = 16
    Width = 86
    Height = 15
    Caption = 'Gebruikersnaam'
  end
  object lblLogMessage: TLabel
    Left = 8
    Top = 45
    Width = 75
    Height = 15
    Caption = 'Soort melding'
  end
  object Label1: TLabel
    Left = 8
    Top = 74
    Width = 36
    Height = 15
    Caption = 'Datum'
  end
  object Label2: TLabel
    Left = 8
    Top = 103
    Width = 41
    Height = 15
    Caption = 'Gelezen'
  end
  object Label3: TLabel
    Left = 8
    Top = 132
    Width = 36
    Height = 15
    Caption = 'Notitie'
  end
  object edtUsername: TEdit
    Left = 114
    Top = 13
    Width = 245
    Height = 23
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
  end
  object edtLogMessage: TEdit
    Left = 114
    Top = 42
    Width = 245
    Height = 23
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
  end
  object edtDate: TEdit
    Left = 114
    Top = 71
    Width = 245
    Height = 23
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 2
  end
  object cbxReadLog: TCheckBox
    Left = 114
    Top = 103
    Width = 21
    Height = 17
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 3
  end
  object memNote: TMemo
    Left = 114
    Top = 129
    Width = 245
    Height = 120
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 4
  end
end
