object Form1: TForm1
  Left = 276
  Top = 192
  Width = 366
  Height = 100
  Caption = 'Form1'
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
  object Button1: TButton
    Left = 272
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Execute !'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 272
    Top = 40
    Width = 75
    Height = 25
    Caption = 'Exit'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Edit1: TEdit
    Left = 8
    Top = 8
    Width = 249
    Height = 21
    TabOrder = 2
    Text = 'SELECT * FROM Table0'
  end
end
