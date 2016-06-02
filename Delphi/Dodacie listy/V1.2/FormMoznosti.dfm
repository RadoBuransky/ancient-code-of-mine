object FormMozn: TFormMozn
  Left = 306
  Top = 217
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Moûnosti'
  ClientHeight = 312
  ClientWidth = 434
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
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl: TPageControl
    Left = 8
    Top = 8
    Width = 417
    Height = 265
    ActivePage = TabSheetHead
    TabOrder = 0
    object TabSheetText: TTabSheet
      Caption = 'SpoloËn˝ text'
      object LabelPath: TLabel
        Left = 8
        Top = 14
        Width = 3
        Height = 13
      end
      object ButtonFile: TButton
        Left = 328
        Top = 8
        Width = 75
        Height = 25
        Caption = 'Text ...'
        TabOrder = 0
        OnClick = ButtonFileClick
      end
      object Memo: TMemo
        Left = 8
        Top = 40
        Width = 393
        Height = 185
        Enabled = False
        ScrollBars = ssBoth
        TabOrder = 1
        OnExit = MemoExit
      end
    end
    object TabSheetHead: TTabSheet
      Caption = 'HlaviËka'
      ImageIndex = 1
      object LabelBMP: TLabel
        Left = 8
        Top = 14
        Width = 3
        Height = 13
      end
      object Label1: TLabel
        Left = 280
        Top = 212
        Width = 70
        Height = 13
        Caption = 'V˝öka (pixels) :'
      end
      object Label2: TLabel
        Left = 280
        Top = 188
        Width = 66
        Height = 13
        Caption = 'äÌrka (pixels) :'
      end
      object ButtonBMP: TButton
        Left = 328
        Top = 8
        Width = 75
        Height = 25
        Caption = 'BMP ...'
        TabOrder = 0
        OnClick = ButtonBMPClick
      end
      object EditS: TEdit
        Left = 352
        Top = 184
        Width = 49
        Height = 21
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 1
      end
      object EditV: TEdit
        Left = 352
        Top = 208
        Width = 49
        Height = 21
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 2
      end
      object ScrollBox: TScrollBox
        Left = 8
        Top = 72
        Width = 393
        Height = 105
        TabOrder = 3
        object Image: TImage
          Left = 0
          Top = 0
          Width = 121
          Height = 125
          AutoSize = True
        end
      end
      object RadioGroup1: TRadioGroup
        Left = 8
        Top = 0
        Width = 241
        Height = 65
        Caption = 'SpÙsob tlaËenia hlaviËky'
        ItemIndex = 1
        Items.Strings = (
          'Orezaù hlaviËku'
          'PrispÙsobiù velkosù hlaviËky str·nke')
        TabOrder = 4
      end
    end
  end
  object ButtonOK: TButton
    Left = 180
    Top = 280
    Width = 75
    Height = 25
    Caption = '&OK'
    Default = True
    TabOrder = 1
    OnClick = ButtonOKClick
  end
  object OpenDialog: TOpenDialog
    Filter = 'Text file|*.txt'
    Left = 404
  end
end
