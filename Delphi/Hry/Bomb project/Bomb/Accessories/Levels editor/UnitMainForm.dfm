object MainForm: TMainForm
  Left = 192
  Top = 115
  AutoScroll = False
  Caption = 'Levels editor'
  ClientHeight = 317
  ClientWidth = 536
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 71
    Height = 13
    Caption = 'Názov levelu : '
  end
  object Label2: TLabel
    Left = 8
    Top = 32
    Width = 72
    Height = 13
    Caption = 'Poèet ståpcov :'
  end
  object Label3: TLabel
    Left = 8
    Top = 56
    Width = 72
    Height = 13
    Caption = 'Poèet riadkov :'
  end
  object ScrollBox: TScrollBox
    Left = 104
    Top = 192
    Width = 689
    Height = 273
    TabOrder = 0
    object Image1: TImage
      Left = 0
      Top = 0
      Width = 432
      Height = 266
    end
  end
  object EditNazov: TEdit
    Left = 80
    Top = 4
    Width = 321
    Height = 21
    TabOrder = 1
  end
  object EditCols: TEdit
    Left = 88
    Top = 28
    Width = 121
    Height = 21
    TabOrder = 2
  end
  object EditRows: TEdit
    Left = 88
    Top = 52
    Width = 121
    Height = 21
    TabOrder = 3
  end
  object ListViewWalls: TListView
    Left = 8
    Top = 80
    Width = 390
    Height = 105
    Columns = <
      item
        Caption = 'Walls'
        Width = 200
      end>
    TabOrder = 4
    ViewStyle = vsReport
  end
  object ListView1: TListView
    Left = 400
    Top = 80
    Width = 390
    Height = 105
    Columns = <
      item
        Caption = 'Creatures'
        Width = 200
      end>
    TabOrder = 5
    ViewStyle = vsReport
  end
  object MainMenu: TMainMenu
    Left = 768
    object MainFile: TMenuItem
      Caption = '&File'
      object FileNew: TMenuItem
        Caption = '&New'
        ShortCut = 16462
      end
      object FileOpen: TMenuItem
        Caption = '&Open ...'
        ShortCut = 16463
      end
      object FileSave: TMenuItem
        Caption = '&Save'
        ShortCut = 16467
      end
      object FileSaveAs: TMenuItem
        Caption = 'Save &as ...'
      end
      object FileExit: TMenuItem
        Caption = 'E&xit'
        ShortCut = 16472
      end
    end
  end
end
