{ Inicializacia spojenia :

  (S) -> 'CLIENTINFO'
  (C) -> 'CLIENTINFOBEGINname|company|serial|lastupdate|CLIENTINFOEND'

  Session info

  (S) -> 'SESSIONBEGIN1|1|1|newdate|SESSIONEND'
  (C) -> 'SESSIONOK'

  File rozvrh

  (S) -> 'FILEBEGINrozvrh|filename|data|FILEEND'
  (C) -> 'FILEOK'

  File listok

  (S) -> 'FILEBEGINlistok|min|norm|zlav|FILEEND'
  (C) -> 'FILEOK'

  File zastavky

  (S) -> 'FILEBEGINzastavky|data|FILEEND'
  (C) -> 'FILEOK'
 }


unit ClassMHDserver;

interface

uses Classes, ScktComp, Winsock, SKonstanty;

type TClient = class;
     TMHDServer = class;

     TClientStatus = ( csNone, // default
                       csConnecting, // ked sa client prave pripojil
                       csGettingInfo, // po pripojeni si od neho vyziadam nejake info
                       csBeginingSession, // inicializacia prenosu suborov
                       csSendingFile, // posielanie suboru
                       csFileOK, // subor odoslany
                       csFinished, // vsetko islo OK a skoncil som
                       csTransferError); // error

     TClientInfo = record
       Name : string;
       Company : string;
       Serial : string;
       IP : string;
       LastUpdate : string;
       Status : string;
     end;

     TFileType = (ftNone,ftRozvrh,ftListok,ftZastavky);

     TFile = record
       FileType : TFileType;
       Index : integer;
       Data : WideString;
     end;

     TMHDClientConnect = procedure( Sender : TClient; Info : TClientInfo ) of object;
     TMHDClientDisconnect = procedure( Sender : TClient ) of object;
     TStatusEvent = procedure( Sender : TClient ) of object;

     TClient = class
     private
       ServerClient : TServerClientWinSocket;

       SendingFile : TFile;

       FStatus : TClientStatus;
       FMHDClientConnect : TMHDClientConnect;
       FMHDClientDisconnect : TMHDClientDisconnect;
       FStatusEvent : TStatusEvent;

       procedure SetStatus( Value : TClientStatus );

       procedure RequestClientInfo;
       procedure GetClientInfo;
       procedure RequestSessionAccept;
       procedure GetSessionAccept;
       procedure GetFileOK;
       procedure SendNextFile;
         function GetNextRozvrh( Index : integer ) : WideString;
         function GetNextListok( Index : integer ) : WideString;
         function GetNextZastavky : WideString;
       procedure SendFinish;

       procedure SocketEvent( Sender: TObject; Socket: TCustomWinSocket; SocketEvent: TSocketEvent );
       procedure SocketError( Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer );
       procedure StartWriting;
       procedure StartReading;

       property Status : TClientStatus read FStatus write SetStatus;
     public
       ClientInfo : TClientInfo;

       constructor Create( ClientSocket: TServerClientWinSocket );

       property OnMHDClientConnect : TMHDClientConnect read FMHDClientConnect write FMHDClientConnect;
       property OnMHDClientDisconnect : TMHDClientDisconnect read FMHDClientDisconnect write FMHDClientDisconnect;
       property OnStatusChange : TStatusEvent read FStatusEvent write FStatusEvent;
     end;



     TListItemEvent = procedure( Sender : TObject; ClientIndex : integer ) of object;

     TMHDserver = class
     private
       Server : TServerSocket;
       FActive : boolean;
       FMHDClientConnect : TMHDClientConnect;
       FMHDClientDisconnect : TMHDClientDisconnect;
       FOnListChange : TNotifyEvent;
       FOnListItemChange : TListItemEvent;

       procedure SetActive( Value : boolean );
       procedure GetSocket(Sender: TObject; Socket: TSocket; var ClientSocket: TServerClientWinSocket);
       procedure MHDClientConnect( Sender : TClient; Info : TClientInfo );
       procedure MHDClientDisconnect( Sender : TClient );
       procedure MHDClientStatusChange( Sender : TClient );

       property OnMHDClientConnect : TMHDClientConnect read FMHDClientConnect write FMHDClientConnect;
       property OnMHDClientDisconnect : TMHDClientDisconnect read FMHDClientDisconnect write FMHDClientDisconnect;
     public
       Clients : TList;

       constructor Create;
       destructor Destroy; override;

       property Active : boolean read FActive write SetActive;
       property OnListChange : TNotifyEvent read FOnListChange write FOnListChange;
       property OnListItemChange : TListItemEvent read FOnListItemChange write FOnListItemChange;
     end;

var MHDserver : TMHDserver;

implementation

uses SysUtils, ClassUpdates;

//==============================================================================
//==============================================================================
//
//                                  C L I E N T
//
//==============================================================================
//==============================================================================

//==============================================================================
//                                    Constructor
//==============================================================================

constructor TClient.Create( ClientSocket : TServerClientWinSocket );
begin
  inherited Create;
  ServerClient := ClientSocket;
  ServerClient.OnSocketEvent := SocketEvent;
  ServerClient.OnErrorEvent := SocketError;
  Status := csConnecting;
end;

//==============================================================================
//                                Properties
//==============================================================================

procedure TClient.SetStatus( Value : TClientStatus );
begin
  if (FStatus = Value) then exit;
  FStatus := Value;

  case FStatus of
    csNone : ClientInfo.Status := 'Unknown status';
    csConnecting : ClientInfo.Status := 'Connecting ...';
    csGettingInfo : ClientInfo.Status := 'Getting client info ...';
    csBeginingSession : ClientInfo.Status := 'Initializing file transfer ...';
    csSendingFile : ClientInfo.Status := 'Sending file ...';
    csFileOK : ClientInfo.Status := 'File sent';
    csFinished : ClientInfo.Status := 'Transfer finished';
    csTransferError : ClientInfo.Status := 'Transfer error!';
  end;

  if (Assigned( OnStatusChange )) then OnStatusChange( Self );

  case FStatus of
    csGettingInfo : RequestClientInfo;
    csBeginingSession : RequestSessionAccept;
    csSendingFile : SendNextFile;
    csFileOK : Status := csSendingFile;
    csFinished : SendFinish;
  end;
end;

//==============================================================================
//  Reading / Writing
//==============================================================================

procedure TClient.StartWriting;
begin
  case Status of
    csConnecting : Status := csGettingInfo;
  end;
end;

procedure TClient.StartReading;
begin
  case Status of
    csGettingInfo : GetClientInfo;
    csSendingFile : GetFileOK;
    csBeginingSession : GetSessionAccept;
  end;
end;

//==============================================================================
//  Client Info
//==============================================================================

procedure TClient.RequestClientInfo;
begin
  ServerClient.SendText( 'CLIENTINFO' );
end;

procedure TClient.GetClientInfo;
var Data : string;
    Zac, Kon : integer;
    I : integer;

    S : string;
    sy, sm, sd : integer;
    cy, cm, cd : integer;
begin
  Data := ServerClient.ReceiveText;

  Zac := Pos( 'CLIENTINFOBEGIN' , Data );
  Kon := Pos( 'CLIENTINFOEND' , Data );

  if (Zac = 0) or
     (Kon = 0) then
    begin
      Status := csTransferError;
      exit;
    end;

  I := Zac+Length( 'CLIENTINFOBEGIN' );

  // Name :
  ClientInfo.Name := '';
  while (Data[I] <> '|') do
    begin
      ClientInfo.Name := ClientInfo.Name + Data[I];
      Inc( I );
    end;

  // Company :
  Inc( I );
  ClientInfo.Company := '';
  while (Data[I] <> '|') do
    begin
      ClientInfo.Company := ClientInfo.Company + Data[I];
      Inc( I );
    end;

  // Serial :
  Inc( I );
  ClientInfo.Serial := '';
  while (Data[I] <> '|') do
    begin
      ClientInfo.Serial := ClientInfo.Serial + Data[I];
      Inc( I );
    end;

  // Last update :
  Inc( I );
  ClientInfo.LastUpdate := '';
  while (Data[I] <> '|') do
    begin
      ClientInfo.LastUpdate := ClientInfo.LastUpdate + Data[I];
      Inc( I );
    end;

  // Je update potrebny ?

  // Ziadne novsie data neexistuju
  if (Updates.Active = -1) then
    begin
      Status := csFinished;
      exit;
    end;

  // Datum aktualneho (serverovskeho) update
  S := TUpdateItem( Updates.Items[Updates.Active] ).Datum;
  sd := StrToInt( S[1]+S[2] );
  sm := StrToInt( S[3]+S[4] );
  sy := StrToInt( S[5]+S[6]+S[7]+S[8] );

  // Datum posledneho update u klienta
  S := ClientInfo.LastUpdate;
  cd := StrToInt( S[1]+S[2] );
  cm := StrToInt( S[3]+S[4] );
  cy := StrToInt( S[5]+S[6]+S[7]+S[8] );

  // Klientovsky update je aktualny
  if (cy > sy) or
     ((cy = sy) and
      (cm > sm)) or
     ((cy = sy) and
      (cm = sm) and
      (cd >= sd)) then
    begin
      Status := csFinished;
      exit;
    end;

  // Treba spravit update
  Status := csBeginingSession;
end;

procedure TClient.RequestSessionAccept;
var Data : string;
begin
  Data := 'SESSIONBEGIN';

  // Pocet novych rozvrhov
  Data := Data + IntToStr( TUpdateItem( Updates.Items[ Updates.Active ] ).RozvrhyFiles.Count )+'|';

  // Pocet novych listkov
  Data := Data + IntToStr( Length( TUpdateItem( Updates.Items[ Updates.Active ] ).Listky ) )+'|';

  // Novy subor so zastavkami
  if (TUpdateItem( Updates.Items[ Updates.Active ] ).ZastavkyFile = '') then
    Data := Data + '0|'
      else
    Data := Data + '1|';

  Data := Data + TUpdateItem( Updates.Items[ Updates.Active ] ).Datum + '|';

  Data := Data + 'SESSIONEND';

  ServerClient.SendText( Data );
end;

procedure TClient.GetSessionAccept;
var Data : string;
begin
  Data := ServerClient.ReceiveText;
  if (Data <> 'SESSIONOK') then
    begin
      Status := csTransferError;
      exit;
    end;

  SendingFile.FileType := ftNone;
  Status := csSendingFile;
end;

procedure TClient.GetFileOK;
var Data : string;
begin
  Data := ServerClient.ReceiveText;
  if (Data <> 'FILEOK') then
    begin
      Status := csTransferError;
      exit;
    end;

  Status := csFileOK;
end;

function TClient.GetNextRozvrh( Index : integer ) : WideString;
var F : textfile;
    S : string;
begin
  Result := 'FILEBEGINrozvrh|'+ExtractFileName( TUpdateItem( Updates.Items[Updates.Active] ).RozvrhyFiles[Index] )+'|';

  AssignFile( F , TUpdateItem( Updates.Items[Updates.Active] ).RozvrhyFiles[Index] );
  {$I-}
  Reset( F );
  {$I+}
  if (IOResult <> 0) then
    begin
      Result := Result + 'ERROR|FILEEND';
      exit;
    end;

  while not EoF( F ) do
    begin
      Readln( F , S );
      Result := Result + S +#13#10;
    end;

  Result := Result + '|FILEEND';

  CloseFile( F );
end;

function TClient.GetNextListok( Index : integer ) : WideString;
begin
  Result := 'FILEBEGINlistok|';
  Result := Result + IntToStr( TUpdateItem( Updates.Items[Updates.Active] ).Listky[Index].Min )+'|';
  Result := Result + IntToStr( TUpdateItem( Updates.Items[Updates.Active] ).Listky[Index].Norm )+'|';
  Result := Result + IntToStr( TUpdateItem( Updates.Items[Updates.Active] ).Listky[Index].Zlav )+'|';
  Result := Result + 'FILEEND';
end;

function TClient.GetNextZastavky : WideString;
var F : textfile;
    S : string;
begin
  Result := 'FILEBEGINzastavky|';

  AssignFile( F , TUpdateItem( Updates.Items[Updates.Active] ).ZastavkyFile );
  {$I-}
  Reset( F );
  {$I+}
  if (IOResult <> 0) then
    begin
      Result := Result + 'ERROR|FILEEND';
      exit;
    end;

  while not EoF( F ) do
    begin
      Readln( F , S );
      Result := Result + S +#13#10;
    end;

  Result := Result + '|FILEEND';

  CloseFile( F );
end;

procedure TClient.SendNextFile;
var NewType : TFileType;
    NewIndex : integer;
begin
  NewType := SendingFile.FileType;
  NewIndex := 0;
  case SendingFile.FileType of
    ftNone : begin
      if (TUpdateItem( Updates.Items[Updates.Active] ).RozvrhyFiles.Count > 0) then
        begin
          NewType := ftRozvrh;
          NewIndex := 0;
        end
          else
      if (Length( TUpdateItem( Updates.Items[Updates.Active] ).Listky ) > 0) then
        begin
          NewType := ftListok;
          NewIndex := 0;
        end
          else
      if (TUpdateItem( Updates.Items[Updates.Active] ).ZastavkyFile <> '') then
        begin
          NewType := ftZastavky;
          NewIndex := 0;
        end
          else
        begin
          NewType := ftNone;
          Status := csFinished;
        end;
    end;

    ftRozvrh : begin
      if (SendingFile.Index < TUpdateItem( Updates.Items[Updates.Active] ).RozvrhyFiles.Count-1) then
        NewIndex := SendingFile.Index+1
          else
      if (Length( TUpdateItem( Updates.Items[Updates.Active] ).Listky ) > 0) then
        begin
          NewType := ftListok;
          NewIndex := 0;
        end
          else
      if (TUpdateItem( Updates.Items[Updates.Active] ).ZastavkyFile <> '') then
        begin
          NewType := ftZastavky;
          NewIndex := 0;
        end
          else
        begin
          NewType := ftNone;
          Status := csFinished;
        end;
    end;

    ftListok : begin
      if (SendingFile.Index < Length( TUpdateItem( Updates.Items[Updates.Active] ).Listky )-1) then
        NewIndex := SendingFile.Index+1
          else
      if (TUpdateItem( Updates.Items[Updates.Active] ).ZastavkyFile <> '') then
        begin
          NewType := ftZastavky;
          NewIndex := 0;
        end
          else
        begin
          NewType := ftNone;
          Status := csFinished;
        end;
    end;

    ftZastavky : begin
      NewType := ftNone;
      NewIndex := 0;
      Status := csFinished;
    end;
  end;

  SendingFile.FileType := NewType;
  SendingFile.Index := NewIndex;
  case NewType of
    ftNone : exit;
    ftRozvrh : SendingFile.Data := GetNextRozvrh( NewIndex );
    ftListok : SendingFile.Data := GetNextListok( NewIndex );
    ftZastavky : SendingFile.Data := GetNextZastavky;
  end;

  ServerClient.SendText( SendingFile.Data );
end;

procedure TClient.SendFinish;
begin
  ServerClient.SendText( 'FINISH' );
end;

procedure TClient.SocketError( Sender: TObject; Socket: TCustomWinSocket;
                               ErrorEvent: TErrorEvent; var ErrorCode: Integer );
begin
  ErrorCode := 0;
  Status := csTransferError;
end;

procedure TClient.SocketEvent( Sender: TObject; Socket: TCustomWinSocket;
                               SocketEvent: TSocketEvent);
begin
  case SocketEvent of
    seWrite : StartWriting;
    seRead : StartReading;
    seDisconnect : if Assigned( OnMHDClientDisconnect ) then OnMHDClientDisconnect( Self );
  end;
end;

//==============================================================================
//==============================================================================
//
//                                  S E R V E R
//
//==============================================================================
//==============================================================================

//==============================================================================
//                                    Constructor
//==============================================================================

constructor TMHDserver.Create;
begin
  inherited;
  FActive := False;
  Clients := TList.Create;
  OnMHDClientConnect := MHDClientConnect;
  OnMHDClientDisconnect := MHDClientDisconnect;

  Server := TServerSocket.Create( nil );
  with Server do
    begin
      Active := False;
      Port := 10000;
      ServerType := stNonBlocking;
      Service := '';
      ThreadCacheSize := 10;

      OnGetSocket := GetSocket;
    end;
end;

//==============================================================================
//                                    Destructor
//==============================================================================

destructor TMHDserver.Destroy;
var I : integer;
begin
  Server.Free;

  for I := 0 to Clients.Count-1 do
    TClient( Clients[I] ).Free;
  Clients.Free;
  inherited;
end;

//==============================================================================
//                                 Server properties
//==============================================================================

procedure TMHDServer.SetActive( Value : boolean );
begin
  if (FActive = Value) then exit;
  FActive := Value;

  Server.Active := FActive;
end;

//==============================================================================
//                                   Server events
//==============================================================================

procedure TMHDServer.MHDClientConnect( Sender : TClient; Info : TClientInfo );
begin
end;

procedure TMHDServer.MHDClientDisconnect( Sender : TClient );
var Cislo : integer;
begin
  Cislo := Clients.IndexOf( Sender );
  TClient( Clients[ Cislo ] ).Free;

  Clients.Delete( Cislo );
  if (Assigned( OnListChange )) then OnListChange( Self );
end;

procedure TMHDServer.MHDClientStatusChange( Sender : TClient );
var Cislo : integer;
begin
  Cislo := Clients.IndexOf( Sender );

  if (Assigned( OnListItemChange )) then OnListItemChange( Self , Cislo );
end;

procedure TMHDServer.GetSocket( Sender: TObject; Socket: TSocket;
                                var ClientSocket: TServerClientWinSocket );
var NEWClientSocket : TServerClientWinSocket;
    NEWClient : TClient;
begin
  NEWClientSocket := TServerClientWinSocket.Create( Socket , Server.Socket );
  ClientSocket := NEWClientSocket;

  NEWClient := TClient.Create( NEWClientSocket );
  NEWClient.OnMHDClientConnect := OnMHDClientConnect;
  NEWClient.OnMHDClientDisconnect := OnMHDClientDisconnect;
  NEWClient.OnStatusChange := MHDClientStatusChange;

  Clients.Add( NEWClient );
  if (Assigned( OnListChange )) then OnListChange( Self );
end;

end.

