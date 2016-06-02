object FormMain: TFormMain
  Left = 287
  Top = 105
  Width = 544
  Height = 375
  Caption = 'File Transfer Protocol'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar: TStatusBar
    Left = 0
    Top = 505
    Width = 793
    Height = 19
    Panels = <
      item
        Alignment = taCenter
        Text = 'Disconnected'
        Width = 100
      end
      item
        Alignment = taCenter
        Width = 150
      end
      item
        Text = 'Bytes sent :'
        Width = 200
      end
      item
        Text = 'Bytes recieved :'
        Width = 200
      end
      item
        Width = 50
      end>
    SimplePanel = False
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 0
    Width = 473
    Height = 153
    Caption = 'Local machine'
    TabOrder = 1
    object DriveComboBox: TDriveComboBox
      Left = 16
      Top = 22
      Width = 209
      Height = 19
      DirList = DirectoryListBox
      TabOrder = 0
      TextCase = tcUpperCase
    end
    object DirectoryListBox: TDirectoryListBox
      Left = 16
      Top = 48
      Width = 209
      Height = 97
      FileList = FileListBox
      ItemHeight = 16
      TabOrder = 1
    end
    object FileListBox: TFileListBox
      Left = 232
      Top = 24
      Width = 233
      Height = 121
      ItemHeight = 16
      MultiSelect = True
      ShowGlyphs = True
      TabOrder = 2
    end
  end
  object ListView: TListView
    Left = 488
    Top = 0
    Width = 305
    Height = 465
    Columns = <
      item
        AutoSize = True
        Caption = 'File or directory'
      end
      item
        AutoSize = True
        Caption = 'Action'
      end>
    ReadOnly = True
    TabOrder = 2
    ViewStyle = vsReport
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 160
    Width = 473
    Height = 345
    Caption = 'FTP server :'
    TabOrder = 3
    object TreeView: TTreeView
      Left = 16
      Top = 16
      Width = 217
      Height = 281
      Indent = 19
      ParentShowHint = False
      PopupMenu = PopupMenu1
      ReadOnly = True
      RightClickSelect = True
      ShowHint = False
      TabOrder = 0
      OnDeletion = TreeViewDeletion
      Items.Data = {
        010000001F0000000000000000000000FFFFFFFFFFFFFFFF0000000008000000
        065365727665721A0000000000000000000000FFFFFFFFFFFFFFFF0000000003
        00000001611B0000000000000000000000FFFFFFFFFFFFFFFF00000000010000
        000261611C0000000000000000000000FFFFFFFFFFFFFFFF0000000000000000
        036161611B0000000000000000000000FFFFFFFFFFFFFFFF0000000000000000
        0261621B0000000000000000000000FFFFFFFFFFFFFFFF000000000000000002
        61631A0000000000000000000000FFFFFFFFFFFFFFFF00000000030000000162
        1B0000000000000000000000FFFFFFFFFFFFFFFF00000000000000000262611B
        0000000000000000000000FFFFFFFFFFFFFFFF00000000000000000262621B00
        00000000000000000000FFFFFFFFFFFFFFFF00000000010000000262631C0000
        000000000000000000FFFFFFFFFFFFFFFF0000000000000000036263611A0000
        000000000000000000FFFFFFFFFFFFFFFF000000000000000001631A00000000
        00000000000000FFFFFFFFFFFFFFFF000000000000000001641A000000000000
        0000000000FFFFFFFFFFFFFFFF000000000000000001651A0000000000000000
        000000FFFFFFFFFFFFFFFF000000000000000001661A00000000000000000000
        00FFFFFFFFFFFFFFFF000000000000000001671A0000000000000000000000FF
        FFFFFFFFFFFFFF00000000000000000168}
    end
    object ButtonGetAllFiles: TButton
      Left = 80
      Top = 304
      Width = 75
      Height = 25
      Caption = '&Get all files'
      Enabled = False
      TabOrder = 1
      OnClick = ButtonGetAllFilesClick
    end
  end
  object ButtonStart: TButton
    Left = 608
    Top = 480
    Width = 75
    Height = 25
    Caption = '&Start'
    TabOrder = 4
    OnClick = ButtonStartClick
  end
  object MainMenu: TMainMenu
    Left = 768
    Top = 504
    object MainConnect: TMenuItem
      Caption = '&Connect'
      OnClick = MainConnectClick
    end
  end
  object NMFTP: TNMFTP
    Port = 21
    ReportLevel = 0
    OnDisconnect = NMFTPDisconnect
    OnConnect = NMFTPConnect
    OnPacketRecvd = NMFTPPacketRecvd
    OnPacketSent = NMFTPPacketSent
    OnError = NMFTPError
    Vendor = 2411
    ParseList = False
    ProxyPort = 0
    Passive = False
    FirewallType = FTUser
    FWAuthenticate = False
    Left = 736
    Top = 504
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 208
    Top = 184
    object Delete: TMenuItem
      Caption = '&Delete'
      OnClick = DeleteClick
    end
  end
end
