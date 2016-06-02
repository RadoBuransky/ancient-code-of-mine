object FormOtvoritPon: TFormOtvoritPon
  Left = 189
  Top = 107
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Otvoriù ponuku'
  ClientHeight = 271
  ClientWidth = 538
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
  object LabelAdr: TLabel
    Left = 8
    Top = 16
    Width = 15
    Height = 13
    Caption = 'C:\'
  end
  object ButtonAdr: TButton
    Left = 456
    Top = 10
    Width = 75
    Height = 25
    Caption = 'Adres·r ...'
    TabOrder = 0
    OnClick = ButtonAdrClick
  end
  object ButtonOK: TButton
    Left = 148
    Top = 232
    Width = 75
    Height = 25
    Caption = '&OK'
    Default = True
    Enabled = False
    TabOrder = 1
    OnClick = ButtonOKClick
  end
  object ButtonZrusit: TButton
    Left = 316
    Top = 232
    Width = 75
    Height = 25
    Caption = '&Zruöiù'
    TabOrder = 2
    OnClick = ButtonZrusitClick
  end
  object ListView: TListView
    Left = 8
    Top = 40
    Width = 521
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
    HideSelection = False
    ReadOnly = True
    RowSelect = True
    SortType = stText
    TabOrder = 3
    ViewStyle = vsReport
    OnDblClick = ListViewDblClick
    OnSelectItem = ListViewSelectItem
  end
end
