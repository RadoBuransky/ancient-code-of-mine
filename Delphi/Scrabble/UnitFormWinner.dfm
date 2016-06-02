object FormWinner: TFormWinner
  Left = 220
  Top = 109
  BorderStyle = bsDialog
  Caption = 'And the winner is ...'
  ClientHeight = 173
  ClientWidth = 415
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
    Left = 0
    Top = 0
    Width = 414
    Height = 72
    Alignment = taCenter
    AutoSize = False
    Caption = 'Comp 1 : 9999'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = 72
    Font.Name = 'Arial Black'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = -1
    Top = 72
    Width = 414
    Height = 72
    Alignment = taCenter
    AutoSize = False
    Caption = 'Player 1 : 9999'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = 72
    Font.Name = 'Arial Black'
    Font.Style = []
    ParentFont = False
  end
  object Button1: TButton
    Left = 170
    Top = 144
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = Button1Click
  end
end
