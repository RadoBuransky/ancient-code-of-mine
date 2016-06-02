object FormTlacDodPonuka: TFormTlacDodPonuka
  Left = 113
  Top = 61
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Moûnosti tlaËenia ponuky'
  ClientHeight = 140
  ClientWidth = 345
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ButtonTlacit: TButton
    Left = 264
    Top = 8
    Width = 75
    Height = 25
    Caption = '&TlaËiù ...'
    Default = True
    TabOrder = 0
    OnClick = ButtonTlacitClick
  end
  object ButtonZrusit: TButton
    Left = 264
    Top = 72
    Width = 75
    Height = 25
    Caption = '&Zruöiù'
    TabOrder = 2
    OnClick = ButtonZrusitClick
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 241
    Height = 89
    Caption = 'VytlaËenÈ stÂpce'
    TabOrder = 3
    object CheckBox1: TCheckBox
      Left = 8
      Top = 16
      Width = 97
      Height = 17
      Caption = 'Komponenty'
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
    object CheckBox2: TCheckBox
      Left = 8
      Top = 32
      Width = 97
      Height = 17
      Caption = 'Model'
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
    object CheckBox3: TCheckBox
      Left = 8
      Top = 48
      Width = 97
      Height = 17
      Caption = 'SÈriovÈ ËÌsla'
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
    object CheckBox4: TCheckBox
      Left = 8
      Top = 64
      Width = 97
      Height = 17
      Caption = 'Z·ruka'
      Checked = True
      State = cbChecked
      TabOrder = 3
    end
  end
  object Button1: TButton
    Left = 264
    Top = 40
    Width = 75
    Height = 25
    Caption = 'TlaËiareÚ ...'
    TabOrder = 1
    OnClick = Button1Click
  end
  object ComboBoxFont: TComboBox
    Left = 8
    Top = 112
    Width = 241
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 4
  end
  object PrinterSetupDialog: TPrinterSetupDialog
    Left = 312
    Top = 104
  end
end
