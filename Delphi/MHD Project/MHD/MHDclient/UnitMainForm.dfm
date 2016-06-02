object MainForm: TMainForm
  Left = 155
  Top = 54
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'MHD aktualiz·cia d·t'
  ClientHeight = 288
  ClientWidth = 625
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lgmPanel1: TlgmPanel
    Left = 8
    Top = 8
    Width = 529
    Height = 241
    AlignPanel = alNone
    AllowMinimize = False
    Moveable = False
    Title.Caption = 'AktualizovanÈ s˙bory'
    Title.BGColor = clGreen
    Title.TextColor = clWhite
    Title.GlyphPos = gpLeft
    object ListView: TListView
      Left = 0
      Top = 16
      Width = 527
      Height = 223
      Columns = <
        item
          Caption = '»Ìslo'
          Width = 35
        end
        item
          Caption = 'Typ s˙boru'
          Width = 80
        end
        item
          Caption = 'Popis s˙boru'
          Width = 300
        end
        item
          Caption = 'Stav'
          Width = 100
        end>
      ReadOnly = True
      RowSelect = True
      TabOrder = 1
      TabStop = False
      ViewStyle = vsReport
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 269
    Width = 625
    Height = 19
    Panels = <
      item
        Text = 'Odpojen˝'
        Width = 200
      end
      item
        Width = 50
      end>
    SimplePanel = False
  end
  object ButtonCancel: TButton
    Left = 544
    Top = 8
    Width = 75
    Height = 25
    Caption = '&Zruöiù'
    TabOrder = 0
  end
end
