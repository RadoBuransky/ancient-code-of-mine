object FormZastavka: TFormZastavka
  Left = 445
  Top = 126
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Zastávka'
  ClientHeight = 121
  ClientWidth = 137
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDefault
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Image: TImage
    Left = 60
    Top = 34
    Width = 16
    Height = 16
  end
  object ComboBox: TComboBox
    Left = 8
    Top = 8
    Width = 121
    Height = 21
    Style = csDropDownList
    DropDownCount = 5
    ItemHeight = 13
    TabOrder = 0
  end
  object TrackBar: TTrackBar
    Left = 8
    Top = 56
    Width = 121
    Height = 17
    Max = 1
    Orientation = trHorizontal
    Frequency = 1
    Position = 0
    SelEnd = 0
    SelStart = 0
    TabOrder = 1
    ThumbLength = 15
    TickMarks = tmBoth
    TickStyle = tsNone
  end
  object ButtonZobrazit: TButton
    Left = 32
    Top = 88
    Width = 75
    Height = 25
    Caption = '&Zobrazi >>'
    TabOrder = 2
    OnClick = ButtonZobrazitClick
  end
end
