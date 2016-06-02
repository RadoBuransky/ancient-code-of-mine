object HlavneOkno: THlavneOkno
  Left = 66
  Top = 108
  BorderStyle = bsSingle
  Caption = 'Pomocný program - KONTROLA ROZVRHOV'
  ClientHeight = 321
  ClientWidth = 682
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object ButtonZacni: TButton
    Left = 303
    Top = 8
    Width = 75
    Height = 25
    Caption = '&Zaèni'
    TabOrder = 0
    OnClick = ButtonZacniClick
  end
  object GroupBox: TGroupBox
    Left = 8
    Top = 40
    Width = 665
    Height = 273
    Caption = 'Štatistika'
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 136
      Height = 13
      Caption = 'Zoznam všetkých zastávok :'
    end
    object LabelPocetZastavok: TLabel
      Left = 200
      Top = 48
      Width = 80
      Height = 13
      Caption = 'Poèet zastávok :'
    end
    object LabelPocetLiniek: TLabel
      Left = 200
      Top = 32
      Width = 61
      Height = 13
      Caption = 'Poèet liniek :'
    end
    object Label2: TLabel
      Left = 200
      Top = 64
      Width = 35
      Height = 13
      Caption = 'Chyby :'
    end
    object MemoChyby: TMemo
      Left = 240
      Top = 64
      Width = 417
      Height = 201
      ScrollBars = ssBoth
      TabOrder = 0
    end
    object ListBox: TListBox
      Left = 8
      Top = 32
      Width = 185
      Height = 233
      ItemHeight = 13
      MultiSelect = True
      TabOrder = 1
    end
  end
end
