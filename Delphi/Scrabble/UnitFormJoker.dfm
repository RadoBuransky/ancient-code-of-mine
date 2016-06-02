object FormJoker: TFormJoker
  Left = 272
  Top = 165
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Joker'
  ClientHeight = 39
  ClientWidth = 336
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
    Top = 12
    Width = 112
    Height = 13
    Caption = 'Enter joker letter value :'
  end
  object Edit: TEdit
    Left = 128
    Top = 8
    Width = 121
    Height = 21
    TabOrder = 0
    OnChange = EditChange
  end
  object Button1: TButton
    Left = 256
    Top = 6
    Width = 75
    Height = 25
    Caption = '&OK'
    Default = True
    TabOrder = 1
    OnClick = Button1Click
  end
end
