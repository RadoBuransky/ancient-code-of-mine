object ZakList: TZakList
  Left = 100
  Top = 33
  BorderStyle = bsSingle
  Caption = 'Nov˝ z·kazkov˝ list'
  ClientHeight = 464
  ClientWidth = 649
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 288
    Top = 12
    Width = 86
    Height = 13
    Caption = 'Z·kazkov˝ list Ë. :'
  end
  object Label2: TLabel
    Left = 8
    Top = 12
    Width = 54
    Height = 13
    Caption = 'Odberateæ :'
  end
  object Label3: TLabel
    Left = 8
    Top = 124
    Width = 89
    Height = 13
    Caption = 'Objedn·vka ËÌslo :'
  end
  object Label4: TLabel
    Left = 288
    Top = 92
    Width = 70
    Height = 13
    Caption = 'D·tum prijatia :'
  end
  object Label5: TLabel
    Left = 288
    Top = 124
    Width = 75
    Height = 13
    Caption = 'VybavenÈ dÚa :'
  end
  object EditCislo: TEdit
    Left = 384
    Top = 8
    Width = 169
    Height = 21
    Color = clInactiveBorder
    Enabled = False
    TabOrder = 8
  end
  object MemoOdber: TMemo
    Left = 104
    Top = 40
    Width = 169
    Height = 73
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object EditObjCislo: TEdit
    Left = 104
    Top = 120
    Width = 169
    Height = 21
    TabOrder = 1
  end
  object EditDatPrij: TEdit
    Left = 368
    Top = 88
    Width = 185
    Height = 21
    TabOrder = 2
  end
  object EditVybDna: TEdit
    Left = 368
    Top = 120
    Width = 185
    Height = 21
    TabOrder = 3
  end
  object RadioGroup: TRadioGroup
    Left = 288
    Top = 40
    Width = 265
    Height = 41
    Caption = 'Z·ruka'
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      '¡no'
      'Nie')
    TabOrder = 4
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 150
    Width = 265
    Height = 305
    Caption = 'PrÌjem'
    TabOrder = 5
    object Label6: TLabel
      Left = 8
      Top = 16
      Width = 80
      Height = 13
      BiDiMode = bdLeftToRight
      Caption = 'Druh zariadenia :'
      ParentBiDiMode = False
    end
    object Label7: TLabel
      Left = 8
      Top = 112
      Width = 73
      Height = 13
      Caption = 'Popis poruchy :'
    end
    object Label8: TLabel
      Left = 8
      Top = 208
      Width = 69
      Height = 13
      Caption = 'PrÌsluöenstvo :'
    end
    object MemoDruh: TMemo
      Left = 8
      Top = 32
      Width = 249
      Height = 73
      TabOrder = 0
    end
    object MemoPris: TMemo
      Left = 8
      Top = 224
      Width = 249
      Height = 73
      TabOrder = 2
    end
    object MemoPopis: TMemo
      Left = 8
      Top = 128
      Width = 249
      Height = 73
      TabOrder = 1
    end
  end
  object GroupBox2: TGroupBox
    Left = 288
    Top = 150
    Width = 265
    Height = 305
    Caption = 'V˝daj'
    TabOrder = 6
    object Label9: TLabel
      Left = 8
      Top = 16
      Width = 70
      Height = 13
      BiDiMode = bdLeftToRight
      Caption = 'Popis v˝konu :'
      ParentBiDiMode = False
    end
    object Label11: TLabel
      Left = 8
      Top = 208
      Width = 69
      Height = 13
      Caption = 'PrÌsluöenstvo :'
    end
    object MemoPopVykonu: TMemo
      Left = 8
      Top = 32
      Width = 249
      Height = 169
      TabOrder = 0
    end
    object MemoPrisV: TMemo
      Left = 8
      Top = 224
      Width = 249
      Height = 73
      TabOrder = 1
    end
  end
  object ButtonSave: TButton
    Left = 568
    Top = 8
    Width = 75
    Height = 25
    Caption = '&Uloûiù'
    Default = True
    TabOrder = 7
    OnClick = ButtonSaveClick
  end
  object ButtonOpen: TButton
    Left = 568
    Top = 48
    Width = 75
    Height = 25
    Caption = '&Otvoriù ...'
    TabOrder = 9
    OnClick = ButtonOpenClick
  end
  object ButtonPrint: TButton
    Left = 568
    Top = 88
    Width = 75
    Height = 25
    Caption = '&TlaËiù ...'
    Enabled = False
    TabOrder = 10
    OnClick = ButtonPrintClick
  end
  object ButtonCancel: TButton
    Left = 568
    Top = 128
    Width = 75
    Height = 25
    Caption = '&Zruöiù'
    TabOrder = 11
    OnClick = ButtonCancelClick
  end
  object ComboBox: TComboBox
    Left = 104
    Top = 8
    Width = 169
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 12
    OnChange = ComboBoxChange
  end
  object PrintDialog: TPrintDialog
    Left = 616
    Top = 200
  end
  object OpenDialog: TOpenDialog
    DefaultExt = '*.zak'
    Filter = 'Z·kazkov˝ list|*.zak'
    Options = [ofReadOnly, ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Title = 'Otvoriù z·kazkov˝ list'
    Left = 616
    Top = 232
  end
end
