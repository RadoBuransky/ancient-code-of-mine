object DodaciKFakture: TDodaciKFakture
  Left = 218
  Top = 106
  BorderStyle = bsDialog
  Caption = 'Vytvorenie novÈho dodacieho listu k fakt˙re'
  ClientHeight = 311
  ClientWidth = 530
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ComboBox: TComboBox
    Left = 232
    Top = 30
    Width = 201
    Height = 21
    ItemHeight = 13
    TabOrder = 0
  end
  object ButtonOK: TButton
    Left = 155
    Top = 272
    Width = 75
    Height = 25
    Caption = '&OK'
    Default = True
    TabOrder = 1
    OnClick = ButtonOKClick
  end
  object ButtonZrusit: TButton
    Left = 299
    Top = 272
    Width = 75
    Height = 25
    Caption = '&Zruöiù'
    TabOrder = 2
    OnClick = ButtonZrusitClick
  end
  object RadioButton1: TRadioButton
    Left = 8
    Top = 32
    Width = 225
    Height = 17
    Caption = 'Vytvorenie dodacieho listu k fakt˙re ËÌslo :'
    Checked = True
    TabOrder = 3
    TabStop = True
    OnClick = RadioButton1Click
  end
  object RadioButton2: TRadioButton
    Left = 8
    Top = 56
    Width = 193
    Height = 17
    Caption = 'Vytvorenie dodacieho list k ponuke :'
    TabOrder = 4
    OnClick = RadioButton2Click
  end
  object ListView: TListView
    Left = 9
    Top = 88
    Width = 512
    Height = 177
    Columns = <
      item
        Caption = 'N·zov s˙boru'
        Width = 100
      end
      item
        Caption = 'Adresa'
        Width = 280
      end
      item
        Alignment = taCenter
        Caption = 'D·tum'
        Width = 70
      end
      item
        Alignment = taCenter
        Caption = 'DodacÌ'
      end>
    Enabled = False
    HideSelection = False
    ReadOnly = True
    RowSelect = True
    SortType = stText
    TabOrder = 5
    ViewStyle = vsReport
    OnDblClick = ListViewDblClick
    OnSelectItem = ListViewSelectItem
  end
  object ButtonAdr: TButton
    Left = 448
    Top = 56
    Width = 75
    Height = 25
    Caption = 'Adres·r ...'
    Enabled = False
    TabOrder = 6
    OnClick = ButtonAdrClick
  end
  object RadioButton3: TRadioButton
    Left = 8
    Top = 8
    Width = 201
    Height = 17
    Caption = 'Vytvorenie ËistÈho dodacieho listu'
    TabOrder = 7
    OnClick = RadioButton3Click
  end
end
