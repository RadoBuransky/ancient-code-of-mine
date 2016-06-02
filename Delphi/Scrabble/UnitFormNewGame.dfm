object FormNewGame: TFormNewGame
  Left = 374
  Top = 230
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'New game'
  ClientHeight = 99
  ClientWidth = 252
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
  object ButtonOK: TButton
    Left = 168
    Top = 8
    Width = 75
    Height = 25
    Caption = '&OK'
    Default = True
    TabOrder = 0
    OnClick = ButtonOKClick
  end
  object RadioGroup: TRadioGroup
    Left = 8
    Top = 8
    Width = 145
    Height = 81
    Caption = 'Choose your opponent :'
    ItemIndex = 0
    Items.Strings = (
      'Human'
      'Computer')
    TabOrder = 1
  end
end
