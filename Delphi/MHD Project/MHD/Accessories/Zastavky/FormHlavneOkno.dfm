object HlavneOkno: THlavneOkno
  Left = 240
  Top = 115
  BorderStyle = bsSingle
  Caption = 
    'Mestsk· hromadn· doprava pre B R A T I S L A V U - Editor pozÌci' +
    'e zast·vok'
  ClientHeight = 406
  ClientWidth = 493
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object LabelY: TLabel
    Left = 648
    Top = 48
    Width = 26
    Height = 24
    Caption = 'Y :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -20
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LabelX: TLabel
    Left = 648
    Top = 16
    Width = 28
    Height = 24
    Caption = 'X :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -20
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ScrollBox: TScrollBox
    Left = 8
    Top = 24
    Width = 625
    Height = 521
    HorzScrollBar.Tracking = True
    VertScrollBar.Tracking = True
    TabOrder = 0
    object Image: TImage
      Left = 0
      Top = 0
      Width = 105
      Height = 105
      OnMouseDown = ImageMouseDown
      OnMouseMove = ImageMouseMove
    end
  end
  object CheckListBox: TCheckListBox
    Left = 640
    Top = 88
    Width = 153
    Height = 457
    ItemHeight = 13
    TabOrder = 1
    OnClick = CheckListBoxClick
  end
  object MainMenu1: TMainMenu
    Left = 416
    Top = 8
    object Sbor1: TMenuItem
      Caption = '&S˙bor'
      object Otvori1: TMenuItem
        Caption = 'Otvoriù ...'
      end
    end
  end
end
