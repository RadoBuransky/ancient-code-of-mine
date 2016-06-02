object FormManager: TFormManager
  Left = 207
  Top = 34
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'PC PROMPT Manager'
  ClientHeight = 473
  ClientWidth = 506
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object ButtonOK: TButton
    Left = 424
    Top = 440
    Width = 75
    Height = 25
    Caption = '&OK'
    Default = True
    TabOrder = 0
    OnClick = ButtonOKClick
  end
  object StringGrid: TStringGrid
    Left = 8
    Top = 8
    Width = 409
    Height = 265
    ColCount = 4
    DefaultRowHeight = 16
    FixedCols = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing, goThumbTracking]
    TabOrder = 1
    OnDblClick = StringGridDblClick
    OnMouseDown = StringGridMouseDown
    OnSelectCell = StringGridSelectCell
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 312
    Width = 409
    Height = 153
    Caption = 'Informácie o vybranom súbore'
    TabOrder = 2
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 94
      Height = 13
      Caption = 'Adresa odberate¾a :'
    end
    object Memo: TMemo
      Left = 8
      Top = 32
      Width = 393
      Height = 113
      ScrollBars = ssBoth
      TabOrder = 0
    end
  end
  object ButtonOddel: TButton
    Left = 424
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Odde¾'
    Enabled = False
    TabOrder = 3
    OnClick = ButtonOddelClick
  end
  object ComboBoxF: TComboBox
    Left = 8
    Top = 280
    Width = 201
    Height = 22
    Style = csOwnerDrawFixed
    ItemHeight = 16
    TabOrder = 4
    OnChange = ComboBoxFChange
  end
  object ComboBoxP: TComboBox
    Left = 216
    Top = 280
    Width = 201
    Height = 22
    Style = csOwnerDrawFixed
    ItemHeight = 16
    TabOrder = 5
    OnChange = ComboBoxPChange
  end
  object ButtonSpoj: TButton
    Left = 424
    Top = 279
    Width = 75
    Height = 25
    Caption = 'Spoj'
    TabOrder = 6
    OnClick = ButtonSpojClick
  end
  object SaveDialog: TSaveDialog
    FileName = 'manager.mng'
    Filter = 'PC PROMPT manager|*.mng'
    Left = 744
    Top = 8
  end
end
