object Form1: TForm1
  Left = 37
  Top = -3
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'BlackBox'
  ClientHeight = 506
  ClientWidth = 757
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Board: TImage
    Left = 40
    Top = 48
    Width = 545
    Height = 393
    Constraints.MaxHeight = 600
    Constraints.MaxWidth = 600
    Constraints.MinHeight = 240
    Constraints.MinWidth = 240
    OnMouseDown = BoardMouseDown
    OnMouseUp = BoardMouseUp
  end
  object Label1: TLabel
    Left = 46
    Top = 7
    Width = 11
    Height = 24
    Caption = '0'
    Color = clBlack
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clRed
    Font.Height = -21
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object Label2: TLabel
    Left = 163
    Top = 7
    Width = 28
    Height = 24
    Caption = '0/4'
    Color = clBlack
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clLime
    Font.Height = -21
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object BitBtn1: TBitBtn
    Left = 111
    Top = 7
    Width = 34
    Height = 34
    Hint = 'New game'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    TabStop = False
    OnClick = BitBtn1Click
    Glyph.Data = {
      2E0A0000424D2E0A00000000000036000000280000001D0000001D0000000100
      180000000000F809000073120000731200000000000000000000B3B3B3B3B3B3
      B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B30000000000
      00000000000000000000000000000000B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3
      B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B300B3B3B3B3B3B3B3B3B3B3B3B3B3B3
      B3B3B3B3B3B3B3B3B3B300000000000000000000FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF000000000000000000B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3
      B3B3B3B3B3B3B3B3B300B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B300
      000000FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF000000B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3
      B300B3B3B3B3B3B3B3B3B3B3B3B3B3B3B300000000000000FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF000000000000B3B3B3B3B3B3B3B3B3B3B3B3B3B3B300B3B3B3B3B3B3
      B3B3B3B3B3B300000000FFFF00FFFF00FFFF00FFFF00FFFF00FFFF0000000000
      0000000000000000000000000000000000FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF000000B3B3B3B3B3B3B3B3B3B3B3B300B3B3B3B3B3B3B3B3B300000000FF
      FF00FFFF00FFFF00FFFF00FFFF00000000000000FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00000000000000FFFF00FFFF00FFFF00FFFF00FFFF000000
      B3B3B3B3B3B3B3B3B300B3B3B3B3B3B3B3B3B300000000FFFF00FFFF00FFFF00
      FFFF00000000FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00000000FFFF00FFFF00FFFF00FFFF000000B3B3B3B3B3B3B3B3
      B300B3B3B3B3B3B300000000FFFF00FFFF00FFFF00FFFF00000000FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00000000FFFF00FFFF00FFFF00FFFF000000B3B3B3B3B3B300B3B3B3000000
      00FFFF00FFFF00FFFF00FFFF00000000FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00000000
      FFFF00FFFF00FFFF00FFFF000000B3B3B300B3B3B300000000FFFF00FFFF00FF
      FF00000000FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00000000FFFF00FFFF
      00FFFF000000B3B3B300B3B3B300000000FFFF00FFFF00FFFF00000000FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00000000FFFF00FFFF00FFFF000000B3B3
      B30000000000FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF0000000000000000FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF0000000000000000FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF0000000000000000FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF0000
      000000000000FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF0000000000000000FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF0000000000000000FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00000000000000000000FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00000000000000000000FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00000000B3B3B300000000FFFF00FFFF00FFFF00FFFF00FFFF00
      000000FFFF00FFFF00FFFF00000000FFFF00FFFF00FFFF00FFFF00FFFF000000
      00FFFF00FFFF00FFFF00000000FFFF00FFFF00FFFF00FFFF00FFFF000000B3B3
      B300B3B3B300000000FFFF00FFFF00FFFF00FFFF00FFFF00000000FFFF00FFFF
      00FFFF00000000FFFF00FFFF00FFFF00FFFF00FFFF00000000FFFF00FFFF00FF
      FF00000000FFFF00FFFF00FFFF00FFFF00FFFF000000B3B3B300B3B3B3000000
      00FFFF00FFFF00FFFF00FFFF00FFFF00000000FFFF00FFFF00FFFF00000000FF
      FF00FFFF00FFFF00FFFF00FFFF00000000FFFF00FFFF00FFFF00000000FFFF00
      FFFF00FFFF00FFFF00FFFF000000B3B3B300B3B3B3B3B3B300000000FFFF00FF
      FF00FFFF00FFFF00FFFF00000000000000000000FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00000000000000000000FFFF00FFFF00FFFF00FFFF00FFFF
      000000B3B3B3B3B3B300B3B3B3B3B3B3B3B3B300000000FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF000000B3B3B3B3B3B3B3B3
      B300B3B3B3B3B3B3B3B3B300000000FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF000000B3B3B3B3B3B3B3B3B300B3B3B3B3B3B3
      B3B3B3B3B3B300000000FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF000000B3B3B3B3B3B3B3B3B3B3B3B300B3B3B3B3B3B3B3B3B3B3B3B3B3B3
      B300000000000000FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF000000000000B3B3B3B3B3B3
      B3B3B3B3B3B3B3B3B300B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B300
      000000FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF000000B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3
      B300B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3000000000000
      00000000FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF0000000000000000
      00B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B300B3B3B3B3B3B3
      B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B30000000000
      00000000000000000000000000000000B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3
      B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B300}
  end
  object BitBtn2: TBitBtn
    Left = 7
    Top = 7
    Width = 34
    Height = 34
    Hint = 'Done'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = BitBtn2Click
    Glyph.Data = {
      2E0A0000424D2E0A00000000000036000000280000001D0000001D0000000100
      180000000000F809000074120000741200000000000000000000B3B3B3B3B3B3
      B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B30000000000
      00000000000000000000000000000000B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3
      B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B300B3B3B3B3B3B3B3B3B3B3B3B3B3B3
      B3B3B3B3B3B3B3B3B3B300000000000000000000FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF000000000000000000B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3
      B3B3B3B3B3B3B3B3B300B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B300
      000000FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF000000B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3
      B300B3B3B3B3B3B3B3B3B3B3B3B3B3B3B300000000000000FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF000000000000B3B3B3B3B3B3B3B3B3B3B3B3B3B3B300B3B3B3B3B3B3
      B3B3B3B3B3B300000000FFFF00FFFF00FFFF00FFFF00FFFF00FFFF0000000000
      0000000000000000000000000000000000FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF000000B3B3B3B3B3B3B3B3B3B3B3B300B3B3B3B3B3B3B3B3B300000000FF
      FF00FFFF00FFFF00FFFF00FFFF00000000000000FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00000000000000FFFF00FFFF00FFFF00FFFF00FFFF000000
      B3B3B3B3B3B3B3B3B300B3B3B3B3B3B3B3B3B300000000FFFF00FFFF00FFFF00
      FFFF00000000FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00000000FFFF00FFFF00FFFF00FFFF000000B3B3B3B3B3B3B3B3
      B300B3B3B3B3B3B300000000FFFF00FFFF00FFFF00FFFF00000000FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00000000FFFF00FFFF00FFFF00FFFF000000B3B3B3B3B3B300B3B3B3000000
      00FFFF00FFFF00FFFF00FFFF00000000FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00000000
      FFFF00FFFF00FFFF00FFFF000000B3B3B300B3B3B300000000FFFF00FFFF00FF
      FF00000000FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00000000FFFF00FFFF
      00FFFF000000B3B3B300B3B3B300000000FFFF00FFFF00FFFF00000000FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00000000FFFF00FFFF00FFFF000000B3B3
      B30000000000FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF0000000000000000FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF0000000000000000FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF0000000000000000FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF0000
      000000000000FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF0000000000000000FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF0000000000000000FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00000000000000000000FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00000000000000FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00000000B3B3B300000000FFFF00FFFF00FFFF00FFFF00FFFF00
      000000FFFF00FFFF00FFFF00000000FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00000000000000000000FFFF00FFFF00FFFF00FFFF00FFFF00FFFF000000B3B3
      B300B3B3B300000000FFFF00FFFF00FFFF00FFFF00FFFF00000000FFFF00FFFF
      00FFFF00000000FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00000000FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF000000B3B3B300B3B3B3000000
      00FFFF00FFFF00FFFF00FFFF00FFFF00000000FFFF00FFFF00FFFF00000000FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00000000FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF000000B3B3B300B3B3B3B3B3B300000000FFFF00FF
      FF00FFFF00FFFF00FFFF00000000000000000000FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      000000B3B3B3B3B3B300B3B3B3B3B3B3B3B3B300000000FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF000000B3B3B3B3B3B3B3B3
      B300B3B3B3B3B3B3B3B3B300000000FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF000000B3B3B3B3B3B3B3B3B300B3B3B3B3B3B3
      B3B3B3B3B3B300000000FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF000000B3B3B3B3B3B3B3B3B3B3B3B300B3B3B3B3B3B3B3B3B3B3B3B3B3B3
      B300000000000000FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF000000000000B3B3B3B3B3B3
      B3B3B3B3B3B3B3B3B300B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B300
      000000FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF000000B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3
      B300B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3000000000000
      00000000FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF0000000000000000
      00B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B300B3B3B3B3B3B3
      B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B30000000000
      00000000000000000000000000000000B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3
      B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B300}
  end
  object MainMenu1: TMainMenu
    Top = 48
    object Game1: TMenuItem
      Caption = '&Game'
      object New1: TMenuItem
        Caption = '&New'
        ShortCut = 113
        OnClick = New1Click
      end
      object Giveup1: TMenuItem
        Caption = '&Give up'
        ShortCut = 16500
        OnClick = Giveup1Click
      end
      object Done1: TMenuItem
        Caption = '&Done'
        ShortCut = 116
        OnClick = Done1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Caption = 'E&xit'
        ShortCut = 121
        OnClick = Exit1Click
      end
    end
    object Setings1: TMenuItem
      Caption = '&Settings'
      object Size1: TMenuItem
        Caption = '&Size ...'
        object N8x81: TMenuItem
          Caption = '&8x8'
          Checked = True
          ShortCut = 117
          OnClick = N8x81Click
        end
        object N10x101: TMenuItem
          Caption = '1&0x10'
          ShortCut = 118
          OnClick = N10x101Click
        end
        object N12x121: TMenuItem
          Caption = '1&2x12'
          ShortCut = 119
          OnClick = N12x121Click
        end
      end
      object Balls1: TMenuItem
        Caption = '&Balls ...'
        object N41: TMenuItem
          Caption = '&4'
          Checked = True
          OnClick = N41Click
        end
        object N61: TMenuItem
          Caption = '&6'
          OnClick = N61Click
        end
        object N81: TMenuItem
          Caption = '&8'
          OnClick = N81Click
        end
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Tutorial1: TMenuItem
        Caption = '&Tutorial'
        OnClick = Tutorial1Click
      end
    end
  end
end