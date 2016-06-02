object FormMain: TFormMain
  Left = 230
  Top = 108
  Width = 544
  Height = 375
  Caption = 'SQL - skuska'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Query: TQuery
    DatabaseName = 'PcPrompt'
    Left = 8
    Top = 8
  end
  object Table: TTable
    DatabaseName = 'PcPrompt'
    Left = 40
    Top = 8
  end
end
