object FormConnect: TFormConnect
  Left = 233
  Top = 131
  BorderStyle = bsSingle
  Caption = 'Connect ...'
  ClientHeight = 138
  ClientWidth = 384
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 12
    Width = 98
    Height = 13
    Caption = 'Názov FTP servera :'
  end
  object Label2: TLabel
    Left = 280
    Top = 44
    Width = 25
    Height = 13
    Caption = 'Port :'
  end
  object Label3: TLabel
    Left = 16
    Top = 44
    Width = 81
    Height = 13
    Caption = 'Meno užívate¾a :'
  end
  object Label4: TLabel
    Left = 16
    Top = 76
    Width = 81
    Height = 13
    Caption = 'Heslo užívate¾a :'
  end
  object Label5: TLabel
    Left = 264
    Top = 76
    Width = 44
    Height = 13
    Caption = 'Timeout :'
  end
  object EditHost: TEdit
    Left = 120
    Top = 8
    Width = 249
    Height = 21
    TabOrder = 0
    Text = 'www.ba.telecom.sk'
  end
  object EditPort: TEdit
    Left = 312
    Top = 40
    Width = 57
    Height = 21
    TabOrder = 5
    Text = '21'
  end
  object EditUserName: TEdit
    Left = 104
    Top = 40
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'autoskol'
  end
  object EditPassword: TEdit
    Left = 104
    Top = 72
    Width = 121
    Height = 21
    PasswordChar = '*'
    TabOrder = 2
    Text = 'vvkfwxag'
  end
  object ButtonGO: TButton
    Left = 209
    Top = 104
    Width = 75
    Height = 25
    Caption = '&GO!'
    Default = True
    TabOrder = 3
    OnClick = ButtonGOClick
  end
  object ButtonCancel: TButton
    Left = 97
    Top = 104
    Width = 75
    Height = 25
    Caption = '&Cancel'
    TabOrder = 4
    OnClick = ButtonCancelClick
  end
  object EditTimeOut: TEdit
    Left = 312
    Top = 72
    Width = 57
    Height = 21
    TabOrder = 6
    Text = '5000'
  end
end
