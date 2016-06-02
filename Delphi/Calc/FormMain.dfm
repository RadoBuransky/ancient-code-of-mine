object MainForm: TMainForm
  Left = 106
  Top = 93
  Width = 684
  Height = 469
  Caption = 'Calculator 1.00'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter2: TSplitter
    Left = 0
    Top = 331
    Width = 676
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    Beveled = True
    MinSize = 1
    ResizeStyle = rsLine
  end
  object Splitter1: TSplitter
    Left = 169
    Top = 0
    Width = 3
    Height = 331
    Cursor = crHSplit
    Beveled = True
    Color = clBtnFace
    MinSize = 1
    ParentColor = False
  end
  object TreeView: TTreeView
    Left = 0
    Top = 0
    Width = 169
    Height = 331
    Align = alLeft
    Constraints.MinWidth = 1
    Indent = 19
    TabOrder = 0
    Items.Data = {
      03000000220000000000000000000000FFFFFFFFFFFFFFFF0000000000000000
      0946756E6374696F6E73210000000000000000000000FFFFFFFFFFFFFFFF0000
      0000000000000850726F6772616D731D0000000000000000000000FFFFFFFFFF
      FFFFFF00000000000000000444617461}
  end
  object Notebook1: TNotebook
    Left = 172
    Top = 0
    Width = 504
    Height = 331
    Align = alClient
    TabOrder = 1
    object TPage
      Left = 0
      Top = 0
      Caption = 'Default'
      object ScrollBox1: TScrollBox
        Left = 0
        Top = 0
        Width = 504
        Height = 331
        Align = alClient
        TabOrder = 0
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 334
    Width = 676
    Height = 108
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object Edit1: TEdit
      Left = 8
      Top = 8
      Width = 201
      Height = 21
      TabOrder = 0
    end
    object Button1: TButton
      Left = 248
      Top = 8
      Width = 25
      Height = 25
      Caption = '7'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Microsoft Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
    object Button2: TButton
      Left = 273
      Top = 8
      Width = 25
      Height = 25
      Caption = '8'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
    end
    object Button3: TButton
      Left = 298
      Top = 8
      Width = 25
      Height = 25
      Caption = '9'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
    end
    object Button4: TButton
      Left = 248
      Top = 33
      Width = 25
      Height = 25
      Caption = '4'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
    end
    object Button5: TButton
      Left = 273
      Top = 33
      Width = 25
      Height = 25
      Caption = '5'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
    end
    object Button6: TButton
      Left = 298
      Top = 58
      Width = 25
      Height = 25
      Caption = '3'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
    end
    object Button7: TButton
      Left = 273
      Top = 58
      Width = 25
      Height = 25
      Caption = '2'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 7
    end
    object Button8: TButton
      Left = 248
      Top = 58
      Width = 25
      Height = 25
      Caption = '1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 8
    end
    object Button9: TButton
      Left = 298
      Top = 33
      Width = 25
      Height = 25
      Caption = '6'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 9
    end
    object Button10: TButton
      Left = 248
      Top = 83
      Width = 25
      Height = 25
      Caption = '0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 10
    end
    object Button11: TButton
      Left = 273
      Top = 83
      Width = 25
      Height = 25
      Caption = '+/-'
      TabOrder = 11
    end
    object Button12: TButton
      Left = 298
      Top = 83
      Width = 25
      Height = 25
      Caption = ','
      TabOrder = 12
    end
    object Button13: TButton
      Left = 216
      Top = 8
      Width = 25
      Height = 24
      Caption = '='
      TabOrder = 13
    end
    object RadioGroup1: TRadioGroup
      Left = 8
      Top = 32
      Width = 233
      Height = 33
      Columns = 4
      ItemIndex = 1
      Items.Strings = (
        'Hex'
        'Dec'
        'Oct'
        'Bin')
      TabOrder = 14
    end
    object RadioGroup2: TRadioGroup
      Left = 8
      Top = 72
      Width = 233
      Height = 33
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'Deg'
        'Rad'
        'Grad')
      TabOrder = 15
    end
    object Button14: TButton
      Left = 330
      Top = 8
      Width = 25
      Height = 25
      Caption = '/'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 16
    end
    object Button15: TButton
      Left = 330
      Top = 33
      Width = 25
      Height = 25
      Caption = '*'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 17
    end
    object Button16: TButton
      Left = 330
      Top = 58
      Width = 25
      Height = 25
      Caption = '-'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 18
    end
    object Button17: TButton
      Left = 330
      Top = 83
      Width = 25
      Height = 25
      Caption = '+'
      TabOrder = 19
    end
    object Button18: TButton
      Left = 355
      Top = 8
      Width = 25
      Height = 25
      Caption = '('
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 20
    end
    object Button19: TButton
      Left = 355
      Top = 83
      Width = 25
      Height = 25
      Caption = 'Ans'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 21
    end
    object Button20: TButton
      Left = 355
      Top = 33
      Width = 25
      Height = 25
      Caption = ')'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 22
    end
    object Button21: TButton
      Left = 355
      Top = 58
      Width = 25
      Height = 25
      Caption = 'Exp'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 23
    end
    object Button22: TButton
      Left = 386
      Top = 8
      Width = 25
      Height = 25
      Caption = 'sin'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 24
    end
    object Button23: TButton
      Left = 386
      Top = 33
      Width = 25
      Height = 25
      Caption = 'cos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 25
    end
    object Button24: TButton
      Left = 386
      Top = 58
      Width = 25
      Height = 25
      Caption = 'tan'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 26
    end
    object Button26: TButton
      Left = 411
      Top = 8
      Width = 38
      Height = 25
      Caption = 'arcsin'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 27
    end
    object Button28: TButton
      Left = 411
      Top = 33
      Width = 38
      Height = 25
      Caption = 'arccos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 28
    end
    object Button29: TButton
      Left = 411
      Top = 58
      Width = 38
      Height = 25
      Caption = 'arctan'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 29
    end
    object Button25: TButton
      Left = 455
      Top = 8
      Width = 34
      Height = 25
      Caption = 'x^2'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 30
    end
    object Button27: TButton
      Left = 455
      Top = 33
      Width = 34
      Height = 25
      Caption = 'x^3'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 31
    end
    object Button30: TButton
      Left = 455
      Top = 58
      Width = 34
      Height = 25
      Caption = '1/x'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 32
    end
    object Button31: TButton
      Left = 455
      Top = 83
      Width = 34
      Height = 25
      Caption = 'x^1/2'
      TabOrder = 33
    end
    object Button32: TButton
      Left = 489
      Top = 8
      Width = 33
      Height = 25
      Caption = 'x^1/3'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 34
    end
    object Button33: TButton
      Left = 489
      Top = 83
      Width = 33
      Height = 25
      Caption = 'x!'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 35
    end
    object Button34: TButton
      Left = 489
      Top = 33
      Width = 33
      Height = 25
      Caption = 'x^y'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 36
    end
    object Button35: TButton
      Left = 489
      Top = 58
      Width = 33
      Height = 25
      Caption = 'x^1/y'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 37
    end
    object Button36: TButton
      Left = 527
      Top = 8
      Width = 25
      Height = 25
      Caption = 'log'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 38
    end
    object Button37: TButton
      Left = 527
      Top = 33
      Width = 25
      Height = 25
      Caption = 'ln'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 39
    end
    object Button40: TButton
      Left = 552
      Top = 8
      Width = 33
      Height = 25
      Caption = '10^x'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 40
    end
    object Button42: TButton
      Left = 552
      Top = 33
      Width = 33
      Height = 25
      Caption = 'e^x'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 41
    end
    object Button38: TButton
      Left = 591
      Top = 8
      Width = 25
      Height = 25
      Caption = 'pi'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 42
    end
    object Button39: TButton
      Left = 591
      Top = 33
      Width = 25
      Height = 25
      Caption = 'e'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 43
    end
    object Button41: TButton
      Left = 623
      Top = 8
      Width = 25
      Height = 25
      Caption = '->A'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 44
    end
    object Button43: TButton
      Left = 623
      Top = 33
      Width = 25
      Height = 25
      Caption = '->B'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 45
    end
    object Button44: TButton
      Left = 623
      Top = 58
      Width = 25
      Height = 25
      Caption = '->C'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 46
    end
    object Button45: TButton
      Left = 623
      Top = 83
      Width = 25
      Height = 25
      Caption = '->D'
      TabOrder = 47
    end
    object Button46: TButton
      Left = 648
      Top = 8
      Width = 25
      Height = 25
      Caption = 'A->'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 48
    end
    object Button47: TButton
      Left = 648
      Top = 83
      Width = 25
      Height = 25
      Caption = 'D->'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 49
    end
    object Button48: TButton
      Left = 648
      Top = 33
      Width = 25
      Height = 25
      Caption = 'B->'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 50
    end
    object Button49: TButton
      Left = 648
      Top = 58
      Width = 25
      Height = 25
      Caption = 'C->'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 51
    end
  end
end
