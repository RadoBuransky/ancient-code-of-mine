object MainForm: TMainForm
  Left = 244
  Top = 201
  Width = 237
  Height = 165
  Caption = 'Free memory'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GaugeGDI: TGauge
    Left = 120
    Top = 8
    Width = 100
    Height = 100
    BackColor = clBtnFace
    BorderStyle = bsNone
    ForeColor = clLime
    Kind = gkPie
    Progress = 0
  end
  object GaugeUser: TGauge
    Left = 8
    Top = 8
    Width = 100
    Height = 100
    BackColor = clBtnFace
    BorderStyle = bsNone
    ForeColor = clYellow
    Kind = gkPie
    Progress = 0
  end
  object Label1: TLabel
    Left = 22
    Top = 112
    Width = 72
    Height = 20
    Caption = 'Physical'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 142
    Top = 115
    Width = 56
    Height = 20
    Caption = 'Virtual'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Timer: TTimer
    Interval = 200
    OnTimer = TimerTimer
  end
end
