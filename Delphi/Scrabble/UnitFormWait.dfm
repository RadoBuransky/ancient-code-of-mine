object FormWait: TFormWait
  Left = 298
  Top = 179
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Loading dictionary'
  ClientHeight = 60
  ClientWidth = 364
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 206
    Height = 13
    Caption = 'Loading dictionary, wait a moment please ...'
  end
  object ProgressBar: TProgressBar
    Left = 8
    Top = 32
    Width = 345
    Height = 16
    Min = 0
    Max = 100
    TabOrder = 0
  end
end
