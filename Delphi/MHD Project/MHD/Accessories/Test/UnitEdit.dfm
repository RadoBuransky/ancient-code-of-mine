object FormEdit: TFormEdit
  Left = 137
  Top = 109
  BorderStyle = bsSingle
  Caption = 'Edit update file'
  ClientHeight = 418
  ClientWidth = 669
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
  object lgmPanel1: TlgmPanel
    Left = 8
    Top = 8
    Width = 577
    Height = 209
    AlignPanel = alNone
    AllowMinimize = False
    Moveable = False
    Title.Caption = 'Rozvrhy'
    Title.BGColor = clGreen
    Title.TextColor = clWhite
    Title.GlyphPos = gpLeft
    object ListViewRozvrhy: TListView
      Left = 1
      Top = 18
      Width = 573
      Height = 188
      Align = alClient
      Columns = <
        item
          AutoSize = True
          Caption = 'Názov súboru'
        end>
      MultiSelect = True
      ReadOnly = True
      RowSelect = True
      PopupMenu = PopupMenuRoz
      TabOrder = 1
      ViewStyle = vsReport
    end
  end
  object ButtonOK: TButton
    Left = 592
    Top = 8
    Width = 75
    Height = 25
    Caption = '&OK'
    Default = True
    TabOrder = 1
    OnClick = ButtonOKClick
  end
  object ButtonCancel: TButton
    Left = 592
    Top = 40
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = ButtonCancelClick
  end
  object lgmPanel2: TlgmPanel
    Left = 8
    Top = 224
    Width = 577
    Height = 121
    AlignPanel = alNone
    AllowMinimize = False
    Moveable = False
    Title.Caption = 'Lístky'
    Title.BGColor = clNavy
    Title.TextColor = clWhite
    Title.GlyphPos = gpLeft
    object ListViewListky: TListView
      Left = 1
      Top = 18
      Width = 573
      Height = 100
      Align = alClient
      Columns = <
        item
          Caption = 'Dåžka'
          Width = 100
        end
        item
          Caption = 'Normálny'
          Width = 100
        end
        item
          Caption = 'Z¾avnený'
          Width = 100
        end>
      ReadOnly = True
      RowSelect = True
      PopupMenu = PopupMenuList
      TabOrder = 1
      ViewStyle = vsReport
    end
  end
  object lgmPanel3: TlgmPanel
    Left = 8
    Top = 352
    Width = 577
    Height = 57
    AlignPanel = alNone
    AllowMinimize = False
    Moveable = False
    Title.Caption = 'Zastávky'
    Title.BGColor = clMaroon
    Title.TextColor = clWhite
    Title.GlyphPos = gpLeft
    object EditZastavky: TEdit
      Left = 8
      Top = 24
      Width = 481
      Height = 21
      TabOrder = 1
    end
    object ButtonZastavky: TButton
      Left = 496
      Top = 24
      Width = 75
      Height = 25
      Caption = 'File ...'
      TabOrder = 2
      OnClick = ButtonZastavkyClick
    end
  end
  object PopupMenuRoz: TPopupMenu
    OnPopup = PopupMenuRozPopup
    Left = 553
    Top = 33
    object RozAddfiles: TMenuItem
      Caption = 'Add files ...'
      OnClick = RozAddfilesClick
    end
    object RozRemovefile: TMenuItem
      Caption = 'Remove file'
      OnClick = RozRemovefileClick
    end
  end
  object PopupMenuList: TPopupMenu
    OnPopup = PopupMenuListPopup
    Left = 553
    Top = 249
    object LisAddticket: TMenuItem
      Caption = 'Add ticket ...'
      OnClick = LisAddticketClick
    end
    object LisRemoveticket: TMenuItem
      Caption = 'Remove ticket'
      OnClick = LisRemoveticketClick
    end
  end
  object OpenDialog: TOpenDialog
    DefaultExt = '*.mhd'
    Filter = 'MHD data files|*.mhd'
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 521
    Top = 33
  end
  object OpenDialogZast: TOpenDialog
    DefaultExt = '*.txt'
    Filter = 'Zastavky file|*.txt'
    Left = 473
    Top = 377
  end
end
