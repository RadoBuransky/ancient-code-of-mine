object Form1: TForm1
  Left = 233
  Top = 140
  Width = 471
  Height = 305
  Caption = 'Test'
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
  object LabelOD: TLabel
    Left = 16
    Top = 16
    Width = 41
    Height = 30
    Caption = 'OD'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Arial CE'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LabelDO: TLabel
    Left = 16
    Top = 56
    Width = 41
    Height = 30
    Caption = 'DO'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Arial CE'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ButtonStart: TButton
    Left = 384
    Top = 16
    Width = 75
    Height = 25
    Caption = '&Štart'
    Default = True
    TabOrder = 0
    OnClick = ButtonStartClick
  end
  object Memo: TMemo
    Left = 8
    Top = 96
    Width = 449
    Height = 177
    TabOrder = 1
  end
end
