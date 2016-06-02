object MainForm: TMainForm
  Left = 192
  Top = 107
  BorderStyle = bsSingle
  Caption = 'Bubble sort'
  ClientHeight = 305
  ClientWidth = 512
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Image: TImage
    Left = 8
    Top = 8
    Width = 417
    Height = 289
  end
  object ButtonStart: TButton
    Left = 432
    Top = 272
    Width = 75
    Height = 25
    Caption = '&Štart'
    Default = True
    TabOrder = 0
    OnClick = ButtonStartClick
  end
end
