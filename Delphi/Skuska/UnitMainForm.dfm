object MainForm: TMainForm
  Left = 223
  Top = 105
  Width = 544
  Height = 343
  Caption = 'Skuska'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 521
    Height = 145
    Caption = 'Server'
    TabOrder = 0
    object Memo1: TMemo
      Left = 8
      Top = 16
      Width = 193
      Height = 121
      ScrollBars = ssVertical
      TabOrder = 0
    end
    object Memo3: TMemo
      Left = 216
      Top = 16
      Width = 217
      Height = 121
      ScrollBars = ssVertical
      TabOrder = 1
    end
  end
  object GroupBox2: TGroupBox
    Left = 7
    Top = 160
    Width = 521
    Height = 145
    Caption = 'Client'
    TabOrder = 1
    object Memo2: TMemo
      Left = 8
      Top = 16
      Width = 193
      Height = 121
      ScrollBars = ssVertical
      TabOrder = 0
    end
    object Memo4: TMemo
      Left = 216
      Top = 16
      Width = 217
      Height = 121
      ScrollBars = ssVertical
      TabOrder = 1
    end
  end
  object CSocket: TClientSocket
    Active = False
    ClientType = ctBlocking
    Host = 'localhost'
    Port = 10000
    Left = 495
    Top = 176
  end
  object SSocket: TServerSocket
    Active = True
    Port = 10000
    ServerType = stThreadBlocking
    OnGetThread = SSocketGetThread
    Left = 496
    Top = 24
  end
end
