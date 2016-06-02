object MainForm: TMainForm
  Left = 1
  Top = 3
  Width = 1027
  Height = 723
  Caption = 'Pc Prompt'
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
  object StatusBar: TStatusBar
    Left = 0
    Top = 658
    Width = 1019
    Height = 19
    Panels = <
      item
        Alignment = taCenter
        Text = 'NeuloûenÈ'
        Width = 100
      end
      item
        Width = 50
      end>
    SimplePanel = False
  end
  object Notebook: TNotebook
    Left = 8
    Top = 0
    Width = 1001
    Height = 654
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
    object TPage
      Left = 0
      Top = 0
      Caption = 'Dodaci'
      object GroupBox1: TGroupBox
        Left = 280
        Top = 0
        Width = 721
        Height = 484
        Anchors = [akLeft, akTop, akRight, akBottom]
        Caption = 'Zvolen· poloûka'
        TabOrder = 0
        object Label2: TLabel
          Left = 8
          Top = 20
          Width = 31
          Height = 13
          Caption = 'N·zov'
        end
        object Label3: TLabel
          Left = 8
          Top = 44
          Width = 44
          Height = 13
          Caption = 'Jednotka'
        end
        object Label4: TLabel
          Left = 8
          Top = 68
          Width = 46
          Height = 13
          Caption = 'Mnoûstvo'
        end
        object Label5: TLabel
          Left = 8
          Top = 92
          Width = 67
          Height = 13
          Caption = 'Z·ruËn· doba'
        end
        object Label1: TLabel
          Left = 8
          Top = 114
          Width = 61
          Height = 13
          Caption = 'SÈriovÈ ËÌsla'
        end
        object EditPolNaz: TEdit
          Left = 80
          Top = 16
          Width = 633
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
          OnChange = EditPolNazChange
        end
        object EditPolJed: TEdit
          Left = 80
          Top = 40
          Width = 633
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 1
          OnChange = EditPolJedChange
        end
        object EditPolMno: TEdit
          Left = 80
          Top = 64
          Width = 633
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 2
          OnChange = EditPolMnoChange
        end
        object EditPolZar: TEdit
          Left = 80
          Top = 88
          Width = 633
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 3
          OnChange = EditPolZarChange
        end
        object MemoPol: TMemo
          Left = 80
          Top = 112
          Width = 633
          Height = 360
          Anchors = [akLeft, akTop, akRight, akBottom]
          TabOrder = 4
          OnChange = MemoPolChange
        end
      end
      object GroupBox2: TGroupBox
        Left = 0
        Top = 0
        Width = 273
        Height = 484
        Anchors = [akLeft, akTop, akBottom]
        Caption = 'Zoznam poloûiek'
        TabOrder = 1
        object ListView: TListView
          Left = 8
          Top = 16
          Width = 257
          Height = 432
          Anchors = [akLeft, akTop, akBottom]
          Columns = <
            item
              Caption = 'N·zov'
              Width = 200
            end>
          HideSelection = False
          TabOrder = 0
          ViewStyle = vsReport
          OnDeletion = ListViewDeletion
          OnEdited = ListViewEdited
          OnEditing = ListViewEditing
          OnInsert = ListViewInsert
          OnSelectItem = ListViewSelectItem
        end
        object ButtonZozPri: TButton
          Left = 8
          Top = 453
          Width = 81
          Height = 25
          Anchors = [akLeft, akBottom]
          Caption = 'Pridaù'
          TabOrder = 1
          OnClick = ButtonZozPriClick
        end
        object ButtonZozZma: TButton
          Left = 96
          Top = 453
          Width = 81
          Height = 25
          Anchors = [akLeft, akBottom]
          Caption = 'Zmazaù'
          TabOrder = 2
          OnClick = ButtonZozZmaClick
        end
        object ButtonZozZmaVse: TButton
          Left = 184
          Top = 453
          Width = 81
          Height = 25
          Anchors = [akLeft, akBottom]
          Caption = 'Zmazaù vöetky'
          TabOrder = 3
          OnClick = ButtonZozZmaVseClick
        end
      end
      object GroupBox3: TGroupBox
        Left = 0
        Top = 487
        Width = 273
        Height = 165
        Anchors = [akLeft, akBottom]
        Caption = '⁄kony'
        TabOrder = 2
        object Label6: TLabel
          Left = 8
          Top = 20
          Width = 54
          Height = 13
          Caption = 'Kto vystavil'
        end
        object Label7: TLabel
          Left = 8
          Top = 44
          Width = 85
          Height = 13
          Caption = 'D·tum vystavenia'
        end
        object Label8: TLabel
          Left = 8
          Top = 68
          Width = 54
          Height = 13
          Caption = 'Kto schv·lil'
        end
        object Label9: TLabel
          Left = 8
          Top = 92
          Width = 85
          Height = 13
          Caption = 'D·tum schv·lenia'
        end
        object Label10: TLabel
          Left = 8
          Top = 116
          Width = 40
          Height = 13
          Caption = 'Kto prijal'
        end
        object Label11: TLabel
          Left = 8
          Top = 140
          Width = 64
          Height = 13
          BiDiMode = bdLeftToRight
          Caption = 'D·tum prijatia'
          ParentBiDiMode = False
        end
        object EditKtoVys: TEdit
          Left = 104
          Top = 16
          Width = 161
          Height = 21
          TabOrder = 0
          OnChange = EditKtoVysChange
        end
        object EditDatVys: TEdit
          Left = 104
          Top = 40
          Width = 161
          Height = 21
          TabOrder = 1
          OnChange = EditDatVysChange
        end
        object EditKtoSch: TEdit
          Left = 104
          Top = 64
          Width = 161
          Height = 21
          TabOrder = 2
          OnChange = EditKtoSchChange
        end
        object EditDatSch: TEdit
          Left = 104
          Top = 88
          Width = 161
          Height = 21
          TabOrder = 3
          OnChange = EditDatSchChange
        end
        object EditKtoPri: TEdit
          Left = 104
          Top = 112
          Width = 161
          Height = 21
          TabOrder = 4
          OnChange = EditKtoPriChange
        end
        object EditDatPri: TEdit
          Left = 104
          Top = 136
          Width = 161
          Height = 21
          TabOrder = 5
          OnChange = EditDatPriChange
        end
      end
      object GroupBox4: TGroupBox
        Left = 280
        Top = 487
        Width = 721
        Height = 165
        Anchors = [akLeft, akRight, akBottom]
        Caption = 'Odberateæ'
        TabOrder = 3
        object Label12: TLabel
          Left = 8
          Top = 18
          Width = 33
          Height = 13
          Caption = 'Adresa'
        end
        object Label13: TLabel
          Left = 8
          Top = 140
          Width = 18
          Height = 13
          Caption = 'I»O'
        end
        object Label14: TLabel
          Left = 312
          Top = 18
          Width = 36
          Height = 13
          Caption = 'Adres·r'
        end
        object MemoOdb: TMemo
          Left = 80
          Top = 16
          Width = 225
          Height = 117
          TabOrder = 0
          OnChange = MemoOdbChange
        end
        object EditOdbICO: TEdit
          Left = 80
          Top = 136
          Width = 225
          Height = 21
          TabOrder = 1
          OnChange = EditOdbICOChange
        end
        object ListBoxOdb: TListBox
          Left = 352
          Top = 16
          Width = 361
          Height = 141
          Anchors = [akLeft, akTop, akRight, akBottom]
          Color = clNone
          ItemHeight = 13
          Sorted = True
          TabOrder = 2
          OnClick = ListBoxOdbClick
          OnDblClick = ListBoxOdbDblClick
        end
        object ButtonOdb: TButton
          Left = 312
          Top = 35
          Width = 35
          Height = 25
          Caption = '< < <'
          Enabled = False
          TabOrder = 3
          OnClick = ButtonOdbClick
        end
      end
    end
  end
  object MainMenu: TMainMenu
    Left = 992
    object SuborMenu: TMenuItem
      Caption = '&S˙bor'
      object NovySubor: TMenuItem
        Caption = '&Nov˝ ...'
        object CistyDodaciList: TMenuItem
          Caption = 'DodacÌ list (Ëist˝)'
          OnClick = CistyDodaciListClick
        end
        object DodaciListKFakture: TMenuItem
          Caption = 'DodacÌ list (k fakt˙re)'
          OnClick = DodaciListKFaktureClick
        end
      end
      object OtvoritSubor: TMenuItem
        Caption = '&Otvoriù ...'
        ShortCut = 16463
        OnClick = OtvoritSuborClick
      end
      object UlozitSubor: TMenuItem
        Caption = '&Uloûiù ...'
        ShortCut = 16467
        OnClick = UlozitSuborClick
      end
      object UlozitAkoSubor: TMenuItem
        Caption = 'Uloûiù &ako ...'
        OnClick = UlozitAkoSuborClick
      end
      object Tlacit: TMenuItem
        Caption = '&TlaËiù ...'
        ShortCut = 16464
      end
      object Skoncit: TMenuItem
        Caption = '&SkonËiù'
        OnClick = SkoncitClick
      end
    end
    object NastrojeMenu: TMenuItem
      Caption = '&N·stroje'
      object MoznostiNastroje: TMenuItem
        Caption = '&Moûnosti ...'
      end
    end
  end
  object SaveDialog: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 960
  end
  object OpenDialog: TOpenDialog
    Left = 928
  end
end
