object frmLogInfo: TfrmLogInfo
  Left = 0
  Top = 0
  ClientHeight = 275
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
    275)
  TextHeight = 15
  object lblUserName: TLabel
    Left = 8
    Top = 32
    Width = 86
    Height = 15
    Caption = 'Gebruikersnaam'
  end
  object lblLogMessage: TLabel
    Left = 8
    Top = 61
    Width = 75
    Height = 15
    Caption = 'Soort melding'
  end
  object Label1: TLabel
    Left = 8
    Top = 90
    Width = 36
    Height = 15
    Caption = 'Datum'
  end
  object Label2: TLabel
    Left = 8
    Top = 119
    Width = 41
    Height = 15
    Caption = 'Gelezen'
  end
  object Label3: TLabel
    Left = 8
    Top = 148
    Width = 36
    Height = 15
    Caption = 'Notitie'
  end
  object edtUsername: TEdit
    Left = 114
    Top = 29
    Width = 247
    Height = 23
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
  end
  object edtLogMessage: TEdit
    Left = 114
    Top = 58
    Width = 247
    Height = 23
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
  end
  object edtDate: TEdit
    Left = 114
    Top = 87
    Width = 247
    Height = 23
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 2
  end
  object cbxReadLog: TCheckBox
    Left = 114
    Top = 119
    Width = 23
    Height = 17
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 3
  end
  object memNote: TMemo
    Left = 114
    Top = 145
    Width = 247
    Height = 120
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 4
  end
end
