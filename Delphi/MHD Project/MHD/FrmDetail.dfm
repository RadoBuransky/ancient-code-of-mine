object FormDetail: TFormDetail
  Left = 246
  Top = 103
  BorderStyle = bsSingle
  Caption = 'Podrobné vysvetlenie cesty'
  ClientHeight = 256
  ClientWidth = 536
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
  object ButtonOK: TButton
    Left = 230
    Top = 224
    Width = 75
    Height = 25
    Caption = '&OK'
    Default = True
    TabOrder = 0
    OnClick = ButtonOKClick
  end
  object Memo: TMemo
    Left = 8
    Top = 8
    Width = 521
    Height = 209
    BorderStyle = bsNone
    Color = clSilver
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHighlight
    Font.Height = -13
    Font.Name = 'Arial CE'
    Font.Style = [fsBold]
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
  end
end
