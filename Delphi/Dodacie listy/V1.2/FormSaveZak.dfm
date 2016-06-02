object FormZakazSave: TFormZakazSave
  Left = 251
  Top = 96
  BorderStyle = bsSingle
  Caption = 'Adresár pre uloženie zákazkového listu'
  ClientHeight = 197
  ClientWidth = 365
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
    Top = 176
    Width = 137
    Height = 13
    Caption = 'C:\Delphi\Dodacie listy\V1.2'
  end
  object DirectoryListBox: TDirectoryListBox
    Left = 8
    Top = 32
    Width = 265
    Height = 137
    DirLabel = Label1
    ItemHeight = 16
    TabOrder = 0
  end
  object DriveComboBox: TDriveComboBox
    Left = 8
    Top = 8
    Width = 265
    Height = 19
    DirList = DirectoryListBox
    TabOrder = 1
  end
  object ButtonOK: TButton
    Left = 280
    Top = 8
    Width = 75
    Height = 25
    Caption = '&OK'
    Default = True
    TabOrder = 2
    OnClick = ButtonOKClick
  end
  object ButtonCancel: TButton
    Left = 280
    Top = 40
    Width = 75
    Height = 25
    Caption = '&Cancel'
    TabOrder = 3
    OnClick = ButtonCancelClick
  end
end
