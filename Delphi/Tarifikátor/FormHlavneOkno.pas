unit FormHlavneOkno;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ScktComp, StdCtrls;

type
  THlavneOkno = class(TForm)
    ButtonPripojit: TButton;
    ClientSocket: TClientSocket;
    Memo: TMemo;
    procedure ButtonPripojitClick(Sender: TObject);
    procedure ClientSocketConnecting(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocketConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocketDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocketError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  HlavneOkno: THlavneOkno;

implementation

{$R *.DFM}

procedure THlavneOkno.ButtonPripojitClick(Sender: TObject);
begin
  if ClientSocket.Active then
    begin
      ButtonPripojit.Caption := '&Pripojiù';
      ClientSocket.Close;
    end
      else
    begin
      ButtonPripojit.Caption := '&Odpojiù';
      ClientSocket.Address := 'http://www.zoznam.sk/';
      ClientSocket.Open;
    end;
end;

procedure THlavneOkno.ClientSocketConnecting(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  Memo.Lines.Add('Conecting ...');
end;

procedure THlavneOkno.ClientSocketConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  Memo.Lines.Add('Connected.');
end;

procedure THlavneOkno.ClientSocketDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  Memo.Lines.Add('Disconnected.');
end;

procedure THlavneOkno.ClientSocketError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
  Memo.Lines.Add('Error');
end;

end.
