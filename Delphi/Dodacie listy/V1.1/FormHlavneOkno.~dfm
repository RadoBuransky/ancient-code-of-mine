object HlavneOkno: THlavneOkno
  Left = 196
  Top = 107
  BorderStyle = bsSingle
  Caption = 'Dodacie listy'
  ClientHeight = 420
  ClientWidth = 804
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
  object CisloDodacieho: TLabel
    Left = 132
    Top = 0
    Width = 536
    Height = 25
    Alignment = taCenter
    AutoSize = False
    BiDiMode = bdRightToLeft
    Caption = 'D2050543'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHighlight
    Font.Height = -20
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentBiDiMode = False
    ParentFont = False
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 401
    Width = 804
    Height = 19
    BiDiMode = bdLeftToRight
    Panels = <
      item
        Alignment = taCenter
        Width = 100
      end
      item
        Width = 50
      end>
    ParentBiDiMode = False
    SimplePanel = False
  end
  object GroupBoxDodavatel: TGroupBox
    Left = 24
    Top = 32
    Width = 361
    Height = 153
    Caption = 'Dod·vateæ'
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 24
      Width = 97
      Height = 13
      Caption = 'Adresa dod·vateæa :'
    end
    object Label2: TLabel
      Left = 16
      Top = 116
      Width = 24
      Height = 13
      Caption = 'I»O :'
    end
    object MemoDodavatel: TMemo
      Left = 120
      Top = 24
      Width = 225
      Height = 73
      ScrollBars = ssVertical
      TabOrder = 0
      OnChange = MemoDodavatelChange
    end
    object EditDodavatel: TEdit
      Left = 56
      Top = 112
      Width = 289
      Height = 21
      TabOrder = 1
      OnChange = EditDodavatelChange
    end
  end
  object GroupBoxOdberatel: TGroupBox
    Left = 416
    Top = 32
    Width = 361
    Height = 153
    Caption = 'Odberateæ'
    TabOrder = 1
    object Label3: TLabel
      Left = 16
      Top = 24
      Width = 94
      Height = 13
      Caption = 'Adresa odberateæa :'
    end
    object Label4: TLabel
      Left = 16
      Top = 116
      Width = 24
      Height = 13
      Caption = 'I»O :'
    end
    object MemoOdberatel: TMemo
      Left = 120
      Top = 24
      Width = 225
      Height = 73
      ScrollBars = ssVertical
      TabOrder = 0
      OnChange = MemoOdberatelChange
    end
    object EditOdberatel: TEdit
      Left = 56
      Top = 112
      Width = 289
      Height = 21
      TabOrder = 1
      OnChange = EditOdberatelChange
    end
  end
  object GroupBoxPolozky: TGroupBox
    Left = 24
    Top = 192
    Width = 753
    Height = 201
    Caption = 'Poloûky'
    TabOrder = 2
    object Label5: TLabel
      Left = 416
      Top = 24
      Width = 169
      Height = 13
      Caption = 'V˝robnÈ ËÌsla pre vybran˙ poloûku :'
    end
    object Label6: TLabel
      Left = 416
      Top = 172
      Width = 40
      Height = 13
      Caption = 'Z·ruka :'
    end
    object ListView: TListView
      Left = 16
      Top = 24
      Width = 377
      Height = 161
      Columns = <
        item
          AutoSize = True
          Caption = 'Text'
        end
        item
          Alignment = taCenter
          AutoSize = True
          Caption = 'Jednotka'
        end
        item
          Alignment = taCenter
          AutoSize = True
          Caption = 'Mnoûstvo'
        end>
      HideSelection = False
      ReadOnly = True
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
      OnSelectItem = ListViewSelectItem
    end
    object Memo: TMemo
      Left = 416
      Top = 40
      Width = 321
      Height = 121
      ScrollBars = ssVertical
      TabOrder = 1
      OnChange = MemoChange
      OnExit = MemoExit
    end
    object EditZaruka: TEdit
      Left = 464
      Top = 168
      Width = 33
      Height = 21
      TabOrder = 2
      OnChange = EditZarukaChange
      OnExit = EditZarukaExit
    end
  end
  object StringGridSpodok: TStringGrid
    Left = 24
    Top = 408
    Width = 753
    Height = 97
    ColCount = 4
    RowCount = 3
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing]
    TabOrder = 3
    OnSetEditText = StringGridSpodokSetEditText
    ColWidths = (
      64
      66
      64
      64)
  end
  object MainMenu: TMainMenu
    Left = 760
    object MainProgram: TMenuItem
      Caption = '&Program'
      object ProgramTlacit: TMenuItem
        Caption = '&TlaËiù ...'
        Enabled = False
        ShortCut = 16464
        OnClick = ProgramTlacitClick
      end
      object ProgramKoniec: TMenuItem
        Caption = '&Koniec'
        ShortCut = 16472
        OnClick = ProgramKoniecClick
      end
    end
    object MainDodacieListy: TMenuItem
      Caption = '&Dodacie listy'
      object DodacieNovy: TMenuItem
        Caption = '&Nov˝ ...'
        ShortCut = 16462
        OnClick = DodacieNovyClick
      end
      object DodacieOtvorit: TMenuItem
        Caption = '&Otvoriù ...'
        ShortCut = 16463
        OnClick = DodacieOtvoritClick
      end
      object DodacieUlozit: TMenuItem
        Caption = '&Uloûiù'
        Enabled = False
        ShortCut = 16467
        OnClick = DodacieUlozitClick
      end
      object DodacieUlozitAko: TMenuItem
        Caption = 'Uloûiù &ako ...'
        Enabled = False
        OnClick = DodacieUlozitAkoClick
      end
    end
    object Spolontext1: TMenuItem
      Caption = '&SpoloËn˝ text(1)'
      OnClick = Spolontext1Click
    end
  end
  object PrintDialog: TPrintDialog
    Left = 704
  end
  object SaveDialog: TSaveDialog
    DefaultExt = '*.dod'
    Filter = 'PC PROMPT dodacÌ list|*.dod'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Title = 'Uloûiù dodacÌ list'
    Left = 640
  end
  object OpenDialog: TOpenDialog
    DefaultExt = '*.dod'
    Filter = 'PC PROMPT dodacÌ list|*.dod'
    Title = 'Otvoriù dodacÌ list'
    Left = 568
  end
end
