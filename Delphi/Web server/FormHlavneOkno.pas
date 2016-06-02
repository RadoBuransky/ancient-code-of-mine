unit FormHlavneOkno;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, ScktComp,
  StdCtrls;

type
  THlavneOkno = class(TForm)
    ButtonZapniSa: TButton;
    Memo: TMemo;
    ButtonClient: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonZapniSaClick(Sender: TObject);
    procedure ButtonClientClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type
  TServer = class(TServerSocket)
    procedure ClientWrite(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientConnect(Sender: TObject; Socket: TCustomWinSocket);
  end;

  TClient = class(TClientSocket)
  end;

var
  HlavneOkno: THlavneOkno;
  Server : TServer;
  Client : TClient;

implementation

{$R *.DFM}

{ S E R V E R }

procedure TServer.ClientWrite;
begin
  HlavneOkno.Memo.Lines.Add( 'OnWrite' );
end;

procedure TServer.ClientRead;
begin
  HlavneOkno.Memo.Lines.Add( 'OnRead' );
end;

procedure TServer.ClientConnect;
begin
  HlavneOkno.Memo.Lines.Add( 'OnConnect' );
end;

procedure THlavneOkno.FormCreate(Sender: TObject);
begin
  {Server}

  Server := TServer.Create( HlavneOkno );

  Server.ServerType := stNonBlocking;
  Server.Port := 80;

  Server.Service := 'http';

  Server.OnClientWrite := Server.ClientWrite;
  Server.OnClientRead := Server.ClientRead;
  Server.OnClientConnect := Server.ClientConnect;

  Server.SetActive( True );

  {Client}

  Client := TClient.Create( HlavneOkno );

  Client.SetClientType( ctNonBlocking );
  Client.Host := 'pcprompt';
  Client.Address := '127.0.0.1';
  Client.Port := 80;

  Client.Service := 'http';
end;

procedure THlavneOkno.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Client.Free;
  Server.Free;
end;

procedure THlavneOkno.ButtonZapniSaClick(Sender: TObject);
begin
  Server.Open;
  Memo.Lines.Add( 'Pripojil som sa!' );
  Memo.Lines.Add( Server.Socket.LocalHost );
end;

{ C L I E N T }

procedure THlavneOkno.ButtonClientClick(Sender: TObject);
begin
  Client.Open;
end;

end.
