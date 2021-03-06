object MainForm: TMainForm
  Left = 1
  Top = 1
  BorderStyle = bsSingle
  Caption = 'MHDserver'
  ClientHeight = 524
  ClientWidth = 790
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object lgmPanel: TlgmPanel
    Left = 8
    Top = 8
    Width = 775
    Height = 145
    AlignPanel = alNone
    AllowMinimize = False
    Anchors = [akLeft, akTop, akRight]
    Moveable = False
    Title.Caption = 'Online clients'
    Title.BGColor = clGreen
    Title.TextColor = clWhite
    Title.GlyphPos = gpLeft
    object ListViewOnLine: TListView
      Left = 1
      Top = 18
      Width = 771
      Height = 124
      Align = alClient
      Columns = <
        item
          Caption = 'Name'
          Width = 150
        end
        item
          Caption = 'Company'
          Width = 100
        end
        item
          Caption = 'Serial number'
          Width = 100
        end
        item
          Caption = 'IP'
          Width = 80
        end
        item
          Caption = 'Last update'
          Width = 100
        end
        item
          Caption = 'Status'
          Width = 200
        end>
      ReadOnly = True
      RowSelect = True
      TabOrder = 1
      ViewStyle = vsReport
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 505
    Width = 790
    Height = 19
    Panels = <
      item
        Width = 100
      end
      item
        Width = 50
      end>
    SimplePanel = False
  end
  object lgmPanelFiles: TlgmPanel
    Left = 8
    Top = 160
    Width = 775
    Height = 335
    AlignPanel = alNone
    AllowMinimize = False
    Anchors = [akLeft, akTop, akRight, akBottom]
    Moveable = False
    Title.Caption = 'Files & updates'
    Title.BGColor = clNavy
    Title.TextColor = clWhite
    Title.GlyphPos = gpLeft
    object Label1: TLabel
      Left = 8
      Top = 28
      Width = 72
      Height = 13
      Caption = 'Active update :'
    end
    object TreeView: TTreeView
      Left = 8
      Top = 56
      Width = 679
      Height = 271
      Anchors = [akLeft, akTop, akRight, akBottom]
      Indent = 19
      ReadOnly = True
      RightClickSelect = True
      TabOrder = 1
    end
    object ComboBox: TComboBox
      Left = 88
      Top = 24
      Width = 599
      Height = 22
      Style = csOwnerDrawFixed
      Anchors = [akLeft, akTop, akRight]
      ItemHeight = 16
      TabOrder = 2
      OnChange = ComboBoxChange
    end
    object ButtonNew: TButton
      Left = 694
      Top = 56
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&New ...'
      TabOrder = 3
      OnClick = ButtonNewClick
    end
    object ButtonRemove: TButton
      Left = 694
      Top = 88
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Remove'
      TabOrder = 4
      OnClick = ButtonRemoveClick
    end
    object ButtonEdit: TButton
      Left = 694
      Top = 120
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Edit ...'
      TabOrder = 5
      OnClick = ButtonEditClick
    end
  end
  object MainMenu: TMainMenu
    Left = 760
    object Server1: TMenuItem
      Caption = '&Server'
      object Connect1: TMenuItem
        Caption = '&Connect'
        OnClick = Connect1Click
      end
    end
  end
  object SaveDialog: TSaveDialog
    DefaultExt = '*.ini'
    Filter = 'Update info file|*.ini'
    Left = 761
    Top = 185
  end
end
