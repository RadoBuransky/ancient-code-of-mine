object FormChars: TFormChars
  Left = 209
  Top = 141
  BorderStyle = bsSingle
  Caption = 'OCR characters'
  ClientHeight = 234
  ClientWidth = 536
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Image: TImage
    Left = 368
    Top = 8
    Width = 81
    Height = 73
  end
  object ButtonOK: TButton
    Left = 456
    Top = 8
    Width = 75
    Height = 25
    Caption = '&OK'
    Default = True
    TabOrder = 0
    OnClick = ButtonOKClick
  end
  object ListView: TListView
    Left = 8
    Top = 8
    Width = 353
    Height = 217
    Columns = <
      item
        Caption = 'Char'
      end
      item
        Caption = 'Bitmap file name'
        Width = 200
      end>
    HideSelection = False
    ReadOnly = True
    RowSelect = True
    TabOrder = 1
    ViewStyle = vsReport
    OnSelectItem = ListViewSelectItem
  end
  object ButtonAdd: TButton
    Left = 456
    Top = 168
    Width = 75
    Height = 25
    Caption = 'Add char ...'
    TabOrder = 2
    OnClick = ButtonAddClick
  end
  object ButtonRmv: TButton
    Left = 456
    Top = 200
    Width = 75
    Height = 25
    Caption = 'Remove char'
    Enabled = False
    TabOrder = 3
    OnClick = ButtonRmvClick
  end
end
