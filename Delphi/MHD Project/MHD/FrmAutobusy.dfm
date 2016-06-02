object FormAutobusy: TFormAutobusy
  Left = 290
  Top = 124
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Autobusy'
  ClientHeight = 226
  ClientWidth = 145
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ComboBox: TComboBox
    Left = 8
    Top = 8
    Width = 129
    Height = 21
    Hint = 'Zoznam spojov'
    Style = csDropDownList
    DropDownCount = 5
    ItemHeight = 13
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnChange = ComboBoxChange
  end
  object CheckBox: TCheckBox
    Left = 8
    Top = 200
    Width = 129
    Height = 17
    Hint = 'Zobraziù spoj na mape'
    Caption = '&Zobraziù na mape'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = CheckBoxClick
  end
  object TrackBar: TTrackBar
    Left = 8
    Top = 40
    Width = 129
    Height = 17
    Hint = 'Smer'
    LineSize = 0
    Max = 1
    Orientation = trHorizontal
    ParentShowHint = False
    PageSize = 0
    Frequency = 1
    Position = 0
    SelEnd = 0
    SelStart = 0
    ShowHint = True
    TabOrder = 2
    ThumbLength = 15
    TickMarks = tmBoth
    TickStyle = tsNone
    OnChange = TrackBarChange
  end
  object ListView: TListView
    Left = 8
    Top = 72
    Width = 129
    Height = 121
    Hint = 'N·zvy zast·vok'
    Columns = <
      item
        AutoSize = True
      end>
    HideSelection = False
    ReadOnly = True
    ParentShowHint = False
    ShowColumnHeaders = False
    ShowHint = True
    TabOrder = 3
    ViewStyle = vsReport
    OnDblClick = ListViewDblClick
    OnSelectItem = ListViewSelectItem
  end
end
