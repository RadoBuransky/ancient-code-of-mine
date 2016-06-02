object HlavneOkno: THlavneOkno
  Left = 192
  Top = 103
  BorderStyle = bsSingle
  Caption = 'I N T E R N E T O V › tarifik·tor'
  ClientHeight = 348
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
  object ButtonPripojit: TButton
    Left = 448
    Top = 16
    Width = 75
    Height = 25
    Caption = '&Pripojiù'
    TabOrder = 0
    OnClick = ButtonPripojitClick
  end
  object Memo: TMemo
    Left = 32
    Top = 16
    Width = 305
    Height = 305
    TabOrder = 1
  end
  object ClientSocket: TClientSocket
    Active = False
    ClientType = ctNonBlocking
    Port = 80
    OnConnecting = ClientSocketConnecting
    OnConnect = ClientSocketConnect
    OnDisconnect = ClientSocketDisconnect
    OnError = ClientSocketError
    Left = 392
    Top = 16
  end
end
