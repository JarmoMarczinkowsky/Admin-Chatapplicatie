object frmGroupAdd: TfrmGroupAdd
  Left = 0
  Top = 0
  Caption = 'Voeg groep toe'
  ClientHeight = 402
  ClientWidth = 628
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsStayOnTop
  OnShow = FormShow
  DesignSize = (
    628
    402)
  TextHeight = 15
  object Label2: TLabel
    Left = 8
    Top = 19
    Width = 32
    Height = 15
    Caption = 'Naam'
  end
  object Label4: TLabel
    Left = 8
    Top = 48
    Width = 64
    Height = 15
    Caption = 'Beschrijving'
  end
  object Label5: TLabel
    Left = 8
    Top = 154
    Width = 45
    Height = 15
    Caption = 'Eigenaar'
  end
  object imgAddGroupProfile: TImage
    Left = 221
    Top = 180
    Width = 75
    Height = 75
    Proportional = True
    Stretch = True
  end
  object Label13: TLabel
    Left = 8
    Top = 183
    Width = 56
    Height = 15
    Caption = 'Profielfoto'
  end
  object lblAddGroupError: TLabel
    Left = 8
    Top = 346
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
  object edtGroupName: TEdit
    Left = 96
    Top = 16
    Width = 200
    Height = 23
    TabOrder = 0
  end
  object edtAddGroupSearchUser: TEdit
    Left = 336
    Top = 16
    Width = 200
    Height = 23
    Anchors = [akTop, akRight]
    TabOrder = 4
    ExplicitLeft = 334
  end
  object sbtnagSearchUser: TAdvSmoothButton
    Left = 541
    Top = 16
    Width = 65
    Height = 23
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
    Caption = 'Zoek'
    Color = 12698049
    TabOrder = 5
    Version = '2.2.3.1'
    OnClick = sbtnagSearchUserClick
    ExplicitLeft = 539
    TMSStyle = 8
  end
  object edtGroupDescription: TEdit
    Left = 96
    Top = 45
    Width = 200
    Height = 100
    AutoSize = False
    TabOrder = 1
  end
  object slsbUser: TAdvSmoothListBox
    Left = 335
    Top = 45
    Width = 200
    Height = 151
    Cursor = crDefault
    Fill.Color = clWhite
    Fill.ColorMirror = clNone
    Fill.ColorMirrorTo = clNone
    Fill.GradientType = gtSolid
    Fill.GradientMirrorType = gtSolid
    Fill.BorderColor = 11184810
    Fill.Rounding = 0
    Fill.ShadowOffset = 0
    Fill.Glow = gmNone
    Items = <>
    ItemAppearance.FillAlternate.Color = clWhite
    ItemAppearance.FillAlternate.ColorTo = clNone
    ItemAppearance.FillAlternate.ColorMirror = clNone
    ItemAppearance.FillAlternate.ColorMirrorTo = clNone
    ItemAppearance.FillAlternate.GradientType = gtVertical
    ItemAppearance.FillAlternate.GradientMirrorType = gtVertical
    ItemAppearance.FillAlternate.BorderColor = clNone
    ItemAppearance.FillAlternate.Rounding = 0
    ItemAppearance.FillAlternate.ShadowOffset = 0
    ItemAppearance.FillAlternate.Glow = gmNone
    ItemAppearance.Fill.Color = clWhite
    ItemAppearance.Fill.ColorTo = clNone
    ItemAppearance.Fill.ColorMirror = clNone
    ItemAppearance.Fill.ColorMirrorTo = clNone
    ItemAppearance.Fill.GradientType = gtVertical
    ItemAppearance.Fill.GradientMirrorType = gtVertical
    ItemAppearance.Fill.BorderColor = clNone
    ItemAppearance.Fill.Rounding = 0
    ItemAppearance.Fill.ShadowOffset = 0
    ItemAppearance.Fill.Glow = gmNone
    ItemAppearance.FillSelected.Color = 15917525
    ItemAppearance.FillSelected.ColorTo = clNone
    ItemAppearance.FillSelected.ColorMirror = clNone
    ItemAppearance.FillSelected.ColorMirrorTo = clNone
    ItemAppearance.FillSelected.GradientType = gtVertical
    ItemAppearance.FillSelected.GradientMirrorType = gtVertical
    ItemAppearance.FillSelected.BorderColor = 15917525
    ItemAppearance.FillSelected.Rounding = 0
    ItemAppearance.FillSelected.ShadowOffset = 0
    ItemAppearance.FillSelected.Glow = gmNone
    ItemAppearance.FillSelected.GlowGradientColor = clNone
    ItemAppearance.FillSelectedAlternate.Color = 15917525
    ItemAppearance.FillSelectedAlternate.ColorTo = clNone
    ItemAppearance.FillSelectedAlternate.ColorMirror = clNone
    ItemAppearance.FillSelectedAlternate.ColorMirrorTo = clNone
    ItemAppearance.FillSelectedAlternate.GradientType = gtVertical
    ItemAppearance.FillSelectedAlternate.GradientMirrorType = gtVertical
    ItemAppearance.FillSelectedAlternate.BorderColor = 15917525
    ItemAppearance.FillSelectedAlternate.Rounding = 0
    ItemAppearance.FillSelectedAlternate.ShadowOffset = 0
    ItemAppearance.FillSelectedAlternate.Glow = gmNone
    ItemAppearance.FillSelectedAlternate.GlowGradientColor = clNone
    ItemAppearance.FillDisabled.Color = clWhite
    ItemAppearance.FillDisabled.ColorTo = clNone
    ItemAppearance.FillDisabled.ColorMirror = clNone
    ItemAppearance.FillDisabled.ColorMirrorTo = clNone
    ItemAppearance.FillDisabled.GradientType = gtVertical
    ItemAppearance.FillDisabled.GradientMirrorType = gtVertical
    ItemAppearance.FillDisabled.BorderColor = 13948116
    ItemAppearance.FillDisabled.Rounding = 0
    ItemAppearance.FillDisabled.ShadowOffset = 0
    ItemAppearance.FillDisabled.Glow = gmNone
    ItemAppearance.ProgressAppearance.BackGroundFill.ColorMirror = clNone
    ItemAppearance.ProgressAppearance.BackGroundFill.ColorMirrorTo = clNone
    ItemAppearance.ProgressAppearance.BackGroundFill.GradientType = gtVertical
    ItemAppearance.ProgressAppearance.BackGroundFill.GradientMirrorType = gtSolid
    ItemAppearance.ProgressAppearance.BackGroundFill.BorderColor = clNone
    ItemAppearance.ProgressAppearance.BackGroundFill.Rounding = 0
    ItemAppearance.ProgressAppearance.BackGroundFill.ShadowOffset = 0
    ItemAppearance.ProgressAppearance.BackGroundFill.Glow = gmNone
    ItemAppearance.ProgressAppearance.ProgressFill.ColorMirror = clNone
    ItemAppearance.ProgressAppearance.ProgressFill.ColorMirrorTo = clNone
    ItemAppearance.ProgressAppearance.ProgressFill.GradientType = gtVertical
    ItemAppearance.ProgressAppearance.ProgressFill.GradientMirrorType = gtSolid
    ItemAppearance.ProgressAppearance.ProgressFill.BorderColor = clNone
    ItemAppearance.ProgressAppearance.ProgressFill.Rounding = 0
    ItemAppearance.ProgressAppearance.ProgressFill.ShadowOffset = 0
    ItemAppearance.ProgressAppearance.ProgressFill.Glow = gmNone
    ItemAppearance.ProgressAppearance.Font.Charset = DEFAULT_CHARSET
    ItemAppearance.ProgressAppearance.Font.Color = clWindowText
    ItemAppearance.ProgressAppearance.Font.Height = -11
    ItemAppearance.ProgressAppearance.Font.Name = 'Segoe UI'
    ItemAppearance.ProgressAppearance.Font.Style = []
    ItemAppearance.ProgressAppearance.ProgressFont.Charset = DEFAULT_CHARSET
    ItemAppearance.ProgressAppearance.ProgressFont.Color = clWindowText
    ItemAppearance.ProgressAppearance.ProgressFont.Height = -11
    ItemAppearance.ProgressAppearance.ProgressFont.Name = 'Segoe UI'
    ItemAppearance.ProgressAppearance.ProgressFont.Style = []
    ItemAppearance.ProgressAppearance.ValueFormat = '%.0f%%'
    ItemAppearance.ButtonAppearance.Font.Charset = DEFAULT_CHARSET
    ItemAppearance.ButtonAppearance.Font.Color = clWindowText
    ItemAppearance.ButtonAppearance.Font.Height = -15
    ItemAppearance.ButtonAppearance.Font.Name = 'Segoe UI'
    ItemAppearance.ButtonAppearance.Font.Style = []
    ItemAppearance.ButtonAppearance.SimpleLayout = False
    ItemAppearance.InfoFill.ColorMirror = clNone
    ItemAppearance.InfoFill.ColorMirrorTo = clNone
    ItemAppearance.InfoFill.GradientType = gtVertical
    ItemAppearance.InfoFill.GradientMirrorType = gtSolid
    ItemAppearance.InfoFill.BorderColor = clNone
    ItemAppearance.InfoFill.Rounding = 0
    ItemAppearance.InfoFill.ShadowOffset = 0
    ItemAppearance.InfoFill.Glow = gmNone
    ItemAppearance.InfoFillSelected.ColorMirror = clNone
    ItemAppearance.InfoFillSelected.ColorMirrorTo = clNone
    ItemAppearance.InfoFillSelected.GradientType = gtVertical
    ItemAppearance.InfoFillSelected.GradientMirrorType = gtSolid
    ItemAppearance.InfoFillSelected.BorderColor = clNone
    ItemAppearance.InfoFillSelected.Rounding = 0
    ItemAppearance.InfoFillSelected.ShadowOffset = 0
    ItemAppearance.InfoFillSelected.Glow = gmNone
    ItemAppearance.InfoFillDisabled.ColorMirror = clNone
    ItemAppearance.InfoFillDisabled.ColorMirrorTo = clNone
    ItemAppearance.InfoFillDisabled.GradientType = gtVertical
    ItemAppearance.InfoFillDisabled.GradientMirrorType = gtSolid
    ItemAppearance.InfoFillDisabled.BorderColor = clNone
    ItemAppearance.InfoFillDisabled.Rounding = 0
    ItemAppearance.InfoFillDisabled.ShadowOffset = 0
    ItemAppearance.InfoFillDisabled.Glow = gmNone
    ItemAppearance.DeleteButtonCaption = 'Delete'
    ItemAppearance.DeleteButtonFont.Charset = DEFAULT_CHARSET
    ItemAppearance.DeleteButtonFont.Color = clWhite
    ItemAppearance.DeleteButtonFont.Height = -11
    ItemAppearance.DeleteButtonFont.Name = 'Segoe UI'
    ItemAppearance.DeleteButtonFont.Style = [fsBold]
    LookupBar.ColorTo = clNone
    LookupBar.DisabledFont.Charset = DEFAULT_CHARSET
    LookupBar.DisabledFont.Color = clSilver
    LookupBar.DisabledFont.Height = -11
    LookupBar.DisabledFont.Name = 'Segoe UI'
    LookupBar.DisabledFont.Style = []
    LookupBar.Font.Charset = DEFAULT_CHARSET
    LookupBar.Font.Color = clBlack
    LookupBar.Font.Height = -11
    LookupBar.Font.Name = 'Segoe UI'
    LookupBar.Font.Style = []
    LookupBar.Visible = False
    Sections.Font.Charset = DEFAULT_CHARSET
    Sections.Font.Color = clWindowText
    Sections.Font.Height = -11
    Sections.Font.Name = 'Segoe UI'
    Sections.Font.Style = []
    Sections.BorderColor = clBlack
    SelectedItemIndex = -1
    Header.Fill.Color = clWhite
    Header.Fill.ColorTo = clNone
    Header.Fill.ColorMirror = clNone
    Header.Fill.ColorMirrorTo = clNone
    Header.Fill.GradientType = gtVertical
    Header.Fill.GradientMirrorType = gtSolid
    Header.Fill.BorderColor = 12895944
    Header.Fill.Rounding = 0
    Header.Fill.ShadowOffset = 0
    Header.Fill.Glow = gmNone
    Header.Caption = 'Header'
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = 4474440
    Header.Font.Height = -13
    Header.Font.Name = 'Segoe UI'
    Header.Font.Style = []
    Header.Visible = False
    Filter.Fill.Color = clWhite
    Filter.Fill.ColorMirror = clNone
    Filter.Fill.ColorMirrorTo = clNone
    Filter.Fill.GradientType = gtSolid
    Filter.Fill.GradientMirrorType = gtSolid
    Filter.Fill.BorderColor = 12895944
    Filter.Fill.Rounding = 0
    Filter.Fill.ShadowOffset = 0
    Filter.Fill.Glow = gmNone
    Filter.Font.Charset = DEFAULT_CHARSET
    Filter.Font.Color = clWindowText
    Filter.Font.Height = -15
    Filter.Font.Name = 'Segoe UI'
    Filter.Font.Style = []
    Footer.Fill.Color = clWhite
    Footer.Fill.ColorTo = clNone
    Footer.Fill.ColorMirror = clNone
    Footer.Fill.ColorMirrorTo = clNone
    Footer.Fill.GradientType = gtVertical
    Footer.Fill.GradientMirrorType = gtSolid
    Footer.Fill.BorderColor = 12895944
    Footer.Fill.Rounding = 0
    Footer.Fill.ShadowOffset = 0
    Footer.Fill.Glow = gmNone
    Footer.Caption = 'Footer'
    Footer.Font.Charset = DEFAULT_CHARSET
    Footer.Font.Color = 4474440
    Footer.Font.Height = -13
    Footer.Font.Name = 'Segoe UI'
    Footer.Font.Style = []
    Footer.Visible = False
    DefaultItem.Caption = 'Item 0'
    DefaultItem.CaptionFont.Charset = DEFAULT_CHARSET
    DefaultItem.CaptionFont.Color = clWindowText
    DefaultItem.CaptionFont.Height = -11
    DefaultItem.CaptionFont.Name = 'Segoe UI'
    DefaultItem.CaptionFont.Style = []
    DefaultItem.CaptionSelectedFont.Charset = DEFAULT_CHARSET
    DefaultItem.CaptionSelectedFont.Color = clWindowText
    DefaultItem.CaptionSelectedFont.Height = -11
    DefaultItem.CaptionSelectedFont.Name = 'Segoe UI'
    DefaultItem.CaptionSelectedFont.Style = []
    DefaultItem.InfoFont.Charset = DEFAULT_CHARSET
    DefaultItem.InfoFont.Color = clWindowText
    DefaultItem.InfoFont.Height = -11
    DefaultItem.InfoFont.Name = 'Segoe UI'
    DefaultItem.InfoFont.Style = []
    DefaultItem.InfoSelectedFont.Charset = DEFAULT_CHARSET
    DefaultItem.InfoSelectedFont.Color = clWindowText
    DefaultItem.InfoSelectedFont.Height = -11
    DefaultItem.InfoSelectedFont.Name = 'Segoe UI'
    DefaultItem.InfoSelectedFont.Style = []
    DefaultItem.NotesFont.Charset = DEFAULT_CHARSET
    DefaultItem.NotesFont.Color = clWindowText
    DefaultItem.NotesFont.Height = -11
    DefaultItem.NotesFont.Name = 'Segoe UI'
    DefaultItem.NotesFont.Style = []
    DefaultItem.NotesSelectedFont.Charset = DEFAULT_CHARSET
    DefaultItem.NotesSelectedFont.Color = clWindowText
    DefaultItem.NotesSelectedFont.Height = -11
    DefaultItem.NotesSelectedFont.Name = 'Segoe UI'
    DefaultItem.NotesSelectedFont.Style = []
    DefaultItem.ProgressMaximum = 100.000000000000000000
    Categories = <>
    Anchors = [akTop, akRight]
    TabOrder = 6
    ExplicitLeft = 333
    TMSStyle = 0
  end
  object sbtnAddUserToGroup: TAdvSmoothButton
    Left = 542
    Top = 45
    Width = 67
    Height = 23
    Anchors = [akTop, akRight]
    Appearance.Font.Charset = DEFAULT_CHARSET
    Appearance.Font.Color = clWindowText
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
    Caption = '+'
    Color = 6612379
    ParentFont = False
    TabOrder = 7
    Version = '2.2.3.1'
    OnClick = sbtnAddUserToGroupClick
    ExplicitLeft = 540
    TMSStyle = 8
  end
  object cboxGroupOwner: TComboBox
    Left = 96
    Top = 151
    Width = 200
    Height = 23
    Style = csDropDownList
    TabOrder = 2
  end
  object slsbGroupAddedUsers: TAdvSmoothListBox
    Left = 336
    Top = 202
    Width = 200
    Height = 151
    Cursor = crDefault
    Fill.Color = clWhite
    Fill.ColorMirror = clNone
    Fill.ColorMirrorTo = clNone
    Fill.GradientType = gtSolid
    Fill.GradientMirrorType = gtSolid
    Fill.BorderColor = 11184810
    Fill.Rounding = 0
    Fill.ShadowOffset = 0
    Fill.Glow = gmNone
    Items = <>
    ItemAppearance.FillAlternate.Color = clWhite
    ItemAppearance.FillAlternate.ColorTo = clNone
    ItemAppearance.FillAlternate.ColorMirror = clNone
    ItemAppearance.FillAlternate.ColorMirrorTo = clNone
    ItemAppearance.FillAlternate.GradientType = gtVertical
    ItemAppearance.FillAlternate.GradientMirrorType = gtVertical
    ItemAppearance.FillAlternate.BorderColor = clNone
    ItemAppearance.FillAlternate.Rounding = 0
    ItemAppearance.FillAlternate.ShadowOffset = 0
    ItemAppearance.FillAlternate.Glow = gmNone
    ItemAppearance.Fill.Color = clWhite
    ItemAppearance.Fill.ColorTo = clNone
    ItemAppearance.Fill.ColorMirror = clNone
    ItemAppearance.Fill.ColorMirrorTo = clNone
    ItemAppearance.Fill.GradientType = gtVertical
    ItemAppearance.Fill.GradientMirrorType = gtVertical
    ItemAppearance.Fill.BorderColor = clNone
    ItemAppearance.Fill.Rounding = 0
    ItemAppearance.Fill.ShadowOffset = 0
    ItemAppearance.Fill.Glow = gmNone
    ItemAppearance.FillSelected.Color = 15917525
    ItemAppearance.FillSelected.ColorTo = clNone
    ItemAppearance.FillSelected.ColorMirror = clNone
    ItemAppearance.FillSelected.ColorMirrorTo = clNone
    ItemAppearance.FillSelected.GradientType = gtVertical
    ItemAppearance.FillSelected.GradientMirrorType = gtVertical
    ItemAppearance.FillSelected.BorderColor = 15917525
    ItemAppearance.FillSelected.Rounding = 0
    ItemAppearance.FillSelected.ShadowOffset = 0
    ItemAppearance.FillSelected.Glow = gmNone
    ItemAppearance.FillSelected.GlowGradientColor = clNone
    ItemAppearance.FillSelectedAlternate.Color = 15917525
    ItemAppearance.FillSelectedAlternate.ColorTo = clNone
    ItemAppearance.FillSelectedAlternate.ColorMirror = clNone
    ItemAppearance.FillSelectedAlternate.ColorMirrorTo = clNone
    ItemAppearance.FillSelectedAlternate.GradientType = gtVertical
    ItemAppearance.FillSelectedAlternate.GradientMirrorType = gtVertical
    ItemAppearance.FillSelectedAlternate.BorderColor = 15917525
    ItemAppearance.FillSelectedAlternate.Rounding = 0
    ItemAppearance.FillSelectedAlternate.ShadowOffset = 0
    ItemAppearance.FillSelectedAlternate.Glow = gmNone
    ItemAppearance.FillSelectedAlternate.GlowGradientColor = clNone
    ItemAppearance.FillDisabled.Color = clWhite
    ItemAppearance.FillDisabled.ColorTo = clNone
    ItemAppearance.FillDisabled.ColorMirror = clNone
    ItemAppearance.FillDisabled.ColorMirrorTo = clNone
    ItemAppearance.FillDisabled.GradientType = gtVertical
    ItemAppearance.FillDisabled.GradientMirrorType = gtVertical
    ItemAppearance.FillDisabled.BorderColor = 13948116
    ItemAppearance.FillDisabled.Rounding = 0
    ItemAppearance.FillDisabled.ShadowOffset = 0
    ItemAppearance.FillDisabled.Glow = gmNone
    ItemAppearance.ProgressAppearance.BackGroundFill.ColorMirror = clNone
    ItemAppearance.ProgressAppearance.BackGroundFill.ColorMirrorTo = clNone
    ItemAppearance.ProgressAppearance.BackGroundFill.GradientType = gtVertical
    ItemAppearance.ProgressAppearance.BackGroundFill.GradientMirrorType = gtSolid
    ItemAppearance.ProgressAppearance.BackGroundFill.BorderColor = clNone
    ItemAppearance.ProgressAppearance.BackGroundFill.Rounding = 0
    ItemAppearance.ProgressAppearance.BackGroundFill.ShadowOffset = 0
    ItemAppearance.ProgressAppearance.BackGroundFill.Glow = gmNone
    ItemAppearance.ProgressAppearance.ProgressFill.ColorMirror = clNone
    ItemAppearance.ProgressAppearance.ProgressFill.ColorMirrorTo = clNone
    ItemAppearance.ProgressAppearance.ProgressFill.GradientType = gtVertical
    ItemAppearance.ProgressAppearance.ProgressFill.GradientMirrorType = gtSolid
    ItemAppearance.ProgressAppearance.ProgressFill.BorderColor = clNone
    ItemAppearance.ProgressAppearance.ProgressFill.Rounding = 0
    ItemAppearance.ProgressAppearance.ProgressFill.ShadowOffset = 0
    ItemAppearance.ProgressAppearance.ProgressFill.Glow = gmNone
    ItemAppearance.ProgressAppearance.Font.Charset = DEFAULT_CHARSET
    ItemAppearance.ProgressAppearance.Font.Color = clWindowText
    ItemAppearance.ProgressAppearance.Font.Height = -11
    ItemAppearance.ProgressAppearance.Font.Name = 'Segoe UI'
    ItemAppearance.ProgressAppearance.Font.Style = []
    ItemAppearance.ProgressAppearance.ProgressFont.Charset = DEFAULT_CHARSET
    ItemAppearance.ProgressAppearance.ProgressFont.Color = clWindowText
    ItemAppearance.ProgressAppearance.ProgressFont.Height = -11
    ItemAppearance.ProgressAppearance.ProgressFont.Name = 'Segoe UI'
    ItemAppearance.ProgressAppearance.ProgressFont.Style = []
    ItemAppearance.ProgressAppearance.ValueFormat = '%.0f%%'
    ItemAppearance.ButtonAppearance.Font.Charset = DEFAULT_CHARSET
    ItemAppearance.ButtonAppearance.Font.Color = clWindowText
    ItemAppearance.ButtonAppearance.Font.Height = -15
    ItemAppearance.ButtonAppearance.Font.Name = 'Segoe UI'
    ItemAppearance.ButtonAppearance.Font.Style = []
    ItemAppearance.ButtonAppearance.SimpleLayout = False
    ItemAppearance.InfoFill.ColorMirror = clNone
    ItemAppearance.InfoFill.ColorMirrorTo = clNone
    ItemAppearance.InfoFill.GradientType = gtVertical
    ItemAppearance.InfoFill.GradientMirrorType = gtSolid
    ItemAppearance.InfoFill.BorderColor = clNone
    ItemAppearance.InfoFill.Rounding = 0
    ItemAppearance.InfoFill.ShadowOffset = 0
    ItemAppearance.InfoFill.Glow = gmNone
    ItemAppearance.InfoFillSelected.ColorMirror = clNone
    ItemAppearance.InfoFillSelected.ColorMirrorTo = clNone
    ItemAppearance.InfoFillSelected.GradientType = gtVertical
    ItemAppearance.InfoFillSelected.GradientMirrorType = gtSolid
    ItemAppearance.InfoFillSelected.BorderColor = clNone
    ItemAppearance.InfoFillSelected.Rounding = 0
    ItemAppearance.InfoFillSelected.ShadowOffset = 0
    ItemAppearance.InfoFillSelected.Glow = gmNone
    ItemAppearance.InfoFillDisabled.ColorMirror = clNone
    ItemAppearance.InfoFillDisabled.ColorMirrorTo = clNone
    ItemAppearance.InfoFillDisabled.GradientType = gtVertical
    ItemAppearance.InfoFillDisabled.GradientMirrorType = gtSolid
    ItemAppearance.InfoFillDisabled.BorderColor = clNone
    ItemAppearance.InfoFillDisabled.Rounding = 0
    ItemAppearance.InfoFillDisabled.ShadowOffset = 0
    ItemAppearance.InfoFillDisabled.Glow = gmNone
    ItemAppearance.DeleteButtonCaption = 'Delete'
    ItemAppearance.DeleteButtonFont.Charset = DEFAULT_CHARSET
    ItemAppearance.DeleteButtonFont.Color = clWhite
    ItemAppearance.DeleteButtonFont.Height = -11
    ItemAppearance.DeleteButtonFont.Name = 'Segoe UI'
    ItemAppearance.DeleteButtonFont.Style = [fsBold]
    LookupBar.ColorTo = clNone
    LookupBar.DisabledFont.Charset = DEFAULT_CHARSET
    LookupBar.DisabledFont.Color = clSilver
    LookupBar.DisabledFont.Height = -11
    LookupBar.DisabledFont.Name = 'Segoe UI'
    LookupBar.DisabledFont.Style = []
    LookupBar.Font.Charset = DEFAULT_CHARSET
    LookupBar.Font.Color = clBlack
    LookupBar.Font.Height = -11
    LookupBar.Font.Name = 'Segoe UI'
    LookupBar.Font.Style = []
    LookupBar.Visible = False
    Sections.Font.Charset = DEFAULT_CHARSET
    Sections.Font.Color = clWindowText
    Sections.Font.Height = -11
    Sections.Font.Name = 'Segoe UI'
    Sections.Font.Style = []
    Sections.BorderColor = clBlack
    SelectedItemIndex = -1
    Header.Fill.Color = clWhite
    Header.Fill.ColorTo = clNone
    Header.Fill.ColorMirror = clNone
    Header.Fill.ColorMirrorTo = clNone
    Header.Fill.GradientType = gtVertical
    Header.Fill.GradientMirrorType = gtSolid
    Header.Fill.BorderColor = 12895944
    Header.Fill.Rounding = 0
    Header.Fill.ShadowOffset = 0
    Header.Fill.Glow = gmNone
    Header.Caption = 'Header'
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = 4474440
    Header.Font.Height = -13
    Header.Font.Name = 'Segoe UI'
    Header.Font.Style = []
    Header.Visible = False
    Filter.Fill.Color = clWhite
    Filter.Fill.ColorMirror = clNone
    Filter.Fill.ColorMirrorTo = clNone
    Filter.Fill.GradientType = gtSolid
    Filter.Fill.GradientMirrorType = gtSolid
    Filter.Fill.BorderColor = 12895944
    Filter.Fill.Rounding = 0
    Filter.Fill.ShadowOffset = 0
    Filter.Fill.Glow = gmNone
    Filter.Font.Charset = DEFAULT_CHARSET
    Filter.Font.Color = clWindowText
    Filter.Font.Height = -15
    Filter.Font.Name = 'Segoe UI'
    Filter.Font.Style = []
    Footer.Fill.Color = clWhite
    Footer.Fill.ColorTo = clNone
    Footer.Fill.ColorMirror = clNone
    Footer.Fill.ColorMirrorTo = clNone
    Footer.Fill.GradientType = gtVertical
    Footer.Fill.GradientMirrorType = gtSolid
    Footer.Fill.BorderColor = 12895944
    Footer.Fill.Rounding = 0
    Footer.Fill.ShadowOffset = 0
    Footer.Fill.Glow = gmNone
    Footer.Caption = 'Footer'
    Footer.Font.Charset = DEFAULT_CHARSET
    Footer.Font.Color = 4474440
    Footer.Font.Height = -13
    Footer.Font.Name = 'Segoe UI'
    Footer.Font.Style = []
    Footer.Visible = False
    DefaultItem.Caption = 'Item 0'
    DefaultItem.CaptionFont.Charset = DEFAULT_CHARSET
    DefaultItem.CaptionFont.Color = clWindowText
    DefaultItem.CaptionFont.Height = -11
    DefaultItem.CaptionFont.Name = 'Segoe UI'
    DefaultItem.CaptionFont.Style = []
    DefaultItem.CaptionSelectedFont.Charset = DEFAULT_CHARSET
    DefaultItem.CaptionSelectedFont.Color = clWindowText
    DefaultItem.CaptionSelectedFont.Height = -11
    DefaultItem.CaptionSelectedFont.Name = 'Segoe UI'
    DefaultItem.CaptionSelectedFont.Style = []
    DefaultItem.InfoFont.Charset = DEFAULT_CHARSET
    DefaultItem.InfoFont.Color = clWindowText
    DefaultItem.InfoFont.Height = -11
    DefaultItem.InfoFont.Name = 'Segoe UI'
    DefaultItem.InfoFont.Style = []
    DefaultItem.InfoSelectedFont.Charset = DEFAULT_CHARSET
    DefaultItem.InfoSelectedFont.Color = clWindowText
    DefaultItem.InfoSelectedFont.Height = -11
    DefaultItem.InfoSelectedFont.Name = 'Segoe UI'
    DefaultItem.InfoSelectedFont.Style = []
    DefaultItem.NotesFont.Charset = DEFAULT_CHARSET
    DefaultItem.NotesFont.Color = clWindowText
    DefaultItem.NotesFont.Height = -11
    DefaultItem.NotesFont.Name = 'Segoe UI'
    DefaultItem.NotesFont.Style = []
    DefaultItem.NotesSelectedFont.Charset = DEFAULT_CHARSET
    DefaultItem.NotesSelectedFont.Color = clWindowText
    DefaultItem.NotesSelectedFont.Height = -11
    DefaultItem.NotesSelectedFont.Name = 'Segoe UI'
    DefaultItem.NotesSelectedFont.Style = []
    DefaultItem.ProgressMaximum = 100.000000000000000000
    Categories = <>
    Anchors = [akTop, akRight]
    TabOrder = 8
    ExplicitLeft = 334
    TMSStyle = 0
  end
  object sbtnRemoveUserFromGroup: TAdvSmoothButton
    Left = 541
    Top = 202
    Width = 67
    Height = 23
    Anchors = [akTop, akRight]
    Appearance.Font.Charset = DEFAULT_CHARSET
    Appearance.Font.Color = clWindowText
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
    Caption = '-'
    Color = 4210943
    ParentFont = False
    TabOrder = 9
    Version = '2.2.3.1'
    OnClick = sbtnRemoveUserFromGroupClick
    ExplicitLeft = 539
    TMSStyle = 8
  end
  object sbtnAddGroupProfile: TAdvSmoothButton
    Left = 96
    Top = 180
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
    TabOrder = 3
    Version = '2.2.3.1'
    OnClick = sbtnAddGroupProfileClick
    TMSStyle = 8
  end
  object sbtnAddGroup: TAdvSmoothButton
    Left = 8
    Top = 367
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
    Caption = 'Toevoegen'
    Color = 13472847
    ParentFont = False
    TabOrder = 10
    Version = '2.2.3.1'
    OnClick = sbtnAddGroupClick
    ExplicitTop = 359
    TMSStyle = 8
  end
  object sbtnBackToGroupOverview: TAdvSmoothButton
    Left = 487
    Top = 367
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
    TabOrder = 11
    Version = '2.2.3.1'
    OnClick = sbtnBackToGroupOverviewClick
    ExplicitLeft = 485
    ExplicitTop = 359
    TMSStyle = 8
  end
end
