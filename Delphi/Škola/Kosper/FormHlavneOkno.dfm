object HlavneOkno: THlavneOkno
  Left = 192
  Top = 107
  Width = 299
  Height = 134
  Caption = 'Spoèítanie èísiel : 1 + 1/2 + 1/3 + 1/4 + 1/5 + 1/6 + ...'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ButtonStart: TButton
    Left = 208
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 0
    OnClick = ButtonStartClick
  end
  object Memo: TMemo
    Left = 8
    Top = 8
    Width = 185
    Height = 89
    ScrollBars = ssVertical
    TabOrder = 1
  end
end
