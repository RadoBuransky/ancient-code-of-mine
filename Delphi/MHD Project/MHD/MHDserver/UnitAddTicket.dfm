object FormAddTicket: TFormAddTicket
  Left = 338
  Top = 138
  BorderStyle = bsDialog
  Caption = 'Pridanie novÈho lÌstka'
  ClientHeight = 103
  ClientWidth = 292
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 12
    Width = 59
    Height = 13
    Caption = 'DÂûka (min) :'
  end
  object Label2: TLabel
    Left = 8
    Top = 44
    Width = 50
    Height = 13
    Caption = 'ObyËajn˝ :'
  end
  object Label3: TLabel
    Left = 8
    Top = 76
    Width = 52
    Height = 13
    Caption = 'Zæavnen˝ :'
  end
  object Edit1: TEdit
    Left = 72
    Top = 8
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object Edit2: TEdit
    Left = 72
    Top = 40
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object Edit3: TEdit
    Left = 72
    Top = 72
    Width = 121
    Height = 21
    TabOrder = 2
  end
  object ButtonOK: TButton
    Left = 208
    Top = 8
    Width = 75
    Height = 25
    Caption = '&OK'
    Default = True
    TabOrder = 3
    OnClick = ButtonOKClick
  end
  object ButtonZrusit: TButton
    Left = 208
    Top = 40
    Width = 75
    Height = 25
    Caption = '&Zruöiù'
    TabOrder = 4
    OnClick = ButtonZrusitClick
  end
end
