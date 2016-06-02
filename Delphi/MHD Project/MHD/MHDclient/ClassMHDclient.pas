unit ClassMHDclient;

interface

uses Classes, ScktComp, Controls, Konstanty;

type TStatus = ( csNone,
                 csConnecting,
                 csSendingInfo,
                 csAcceptingSession,
                 csAcceptSession,
                 csGettingFile,
                 csFileOK,
                 csFinish,
                 csTransferError );

     TSessionInfo = record
       Rozvrhy : integer;
       Listky : integer;
       Zastavky : integer;
       NewUpdate : string;
     end;

     TFileType = (ftNone,ftRozvrh,ftListok,ftZastavky);

     TRecievedFile = record
       FileType : TFileType;
       Data : WideString;
     end;

     TStatusEvent = procedure( Status : TStatus; StatusText : string ) of object;
     TSessionEvent = procedure( SessionInfo : TSessionInfo ) of object;
     TItemEvent = procedure( Typ : integer; Popis, Stav : string ) of object;

     TMHDclient = class
     private
       Client : TClientSocket;

       LongFile : boolean;
       LongData : WideString;
       RecievedFile : TRecievedFile;

       StatusText : string;
       SessionInfo : TSessionInfo;

       FStatus : TStatus;
       FOnStatusChange : TStatusEvent;
       FOnSessionBegin : TSessionEvent;
       FOnItemChange : TItemEvent;

       procedure SetStatus( Value : TStatus );

       procedure Connect( Sender: TObject; Socket: TCustomWinSocket );
       procedure MyRead( Sender: TObject; Socket: TCustomWinSocket );
       procedure MyWrite( Sender: TObject; Socket: TCustomWinSocket );
       procedure Error( Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer );

       procedure GetInfo;
       procedure SendInfo;
       procedure GetSessionInfo;
       procedure SendAcceptSession;
       procedure GetFile;
       procedure SaveFile;
         procedure SaveRozvrh( Data : WideString );
         procedure SaveListok( Data : WideString );
         procedure SaveZastavky( Data : WideString );
       procedure SendFileOK;
       procedure SaveLastUpdate;

       property Status : TStatus read FStatus write SetStatus;
     public
       constructor Create;
       destructor Destroy; override;

       property OnStatusChange : TStatusEvent read FOnStatusChange write FOnStatusChange;
       property OnSessionBegin : TSessionEvent read FOnSessionBegin write FOnSessionBegin;
       property OnItemChange : TItemEvent read FOnItemChange write FOnItemChange;
     end;

var MHDclient : TMHDclient;

implementation

uses SysUtils, Registry, Windows;

//==============================================================================
//==============================================================================
//
//                                  C L I E N T
//
//==============================================================================
//==============================================================================

constructor TMHDclient.Create;
begin
  inherited;

  Client := TClientSocket.Create( nil );
  with Client do
    begin
      Address := '';
      ClientType := ctNonBlocking;
      Host := SERVERINFO.Host;
      Port := SERVERINFO.Port;
      Service := '';

      OnConnect := Connect;
      OnRead := MyRead;
      OnWrite := MyWrite;
      OnError := Error;

      Active := True;
    end;
end;

//==============================================================================
//                                    Destructor
//==============================================================================

destructor TMHDclient.Destroy;
begin
  Client.Active := False;
  Client.Free;
  inherited;
end;

//==============================================================================
//                                    Properties
//==============================================================================

procedure TMHDClient.SetStatus( Value : TStatus );
begin
  if (Value = FStatus) then exit;
  FStatus := Value;

  case FStatus of
    csNone : StatusText := 'Neznámy stav';
    csConnecting : StatusText := 'Pripájanie ...';
    csSendingInfo : StatusText := 'Posielanie informácii ...';
    csAcceptingSession : StatusText := 'Prijímanie zoznamu súborov ...';
    csAcceptSession : StatusText := 'Zaèiatok prenosu ...';
    csGettingFile : StatusText := 'Prijímanie súboru ...';
    csFileOK : StatusText := 'Súbor prijatý';
    csFinish : StatusText := 'Aktualizácia dokonèená';
    csTransferError : StatusText := 'Chyba!';
  end;

  if (FStatus = csFinish) then SaveLastUpdate;

  if (Assigned( OnStatusChange )) then OnStatusChange( Status , StatusText );

  case FStatus of
    csSendingInfo : SendInfo;
    csAcceptSession : SendAcceptSession;
    csFileOK : SaveFile;
  end;
end;

//==============================================================================
//                                    Events
//==============================================================================

procedure TMHDClient.Connect( Sender: TObject; Socket: TCustomWinSocket );
begin
  Status := csConnecting;
end;

procedure TMHDClient.MyRead( Sender: TObject; Socket: TCustomWinSocket );
begin
  case Status of
    csConnecting : GetInfo;
    csSendingInfo : GetSessionInfo;
    csGettingFile : GetFile;
  end;
end;

procedure TMHDClient.MyWrite( Sender: TObject; Socket: TCustomWinSocket );
begin
  case Status of
    csFileOK : SendFileOK;
  end;
end;

procedure TMHDClient.Error( Sender: TObject; Socket: TCustomWinSocket;
                            ErrorEvent: TErrorEvent; var ErrorCode: Integer );
begin
  ErrorCode := 0;
  Status := csTransferError;
end;

//==============================================================================
//  Reading / Writing
//==============================================================================

procedure TMHDClient.GetInfo;
var Data : string;
begin
  Data := Client.Socket.ReceiveText;
  if (Data = 'CLIENTINFO') then Status := csSendingInfo
                           else Status := csTransferError;
end;

procedure TMHDClient.SendInfo;
var Data : string;
begin
  Data := 'CLIENTINFOBEGIN';
  Data := Data+CLIENTINFO.Name+'|';
  Data := Data+CLIENTINFO.Company+'|';
  Data := Data+CLIENTINFO.Serial+'|';
  Data := Data+CLIENTINFO.LastUpdate+'|';
  Data := Data+'CLIENTINFOEND';

  Client.Socket.SendText( Data );
end;

procedure TMHDClient.GetSessionInfo;
var Data : string;
    Zac, Kon : integer;
    I : integer;
    S : string;
begin
  Status := csAcceptingSession;

  Data := Client.Socket.ReceiveText;
  if (Data = 'FINISH') then
    begin
      SessionInfo.NewUpdate := CLIENTINFO.LastUpdate;
      Status := csFinish;
      exit;
    end;

  Zac := Pos( 'SESSIONBEGIN' , Data );
  Kon := Pos( 'SESSIONEND' , Data );
  if (Zac = 0) or
     (Kon = 0) then
    begin
      Status := csTransferError;
      exit;
    end;

  try
    I := Zac + Length( 'SESSIONBEGIN' );

    S := '';
    while Data[I] <> '|' do
      begin
        S := S + Data[I];
        Inc( I );
      end;
    SessionInfo.Rozvrhy := StrToInt( S );
    Inc( I );

    S := '';
    while Data[I] <> '|' do
      begin
        S := S + Data[I];
        Inc( I );
      end;
    SessionInfo.Listky := StrToInt( S );
    Inc( I );

    S := '';
    while Data[I] <> '|' do
      begin
        S := S + Data[I];
        Inc( I );
      end;
    SessionInfo.Zastavky := StrToInt( S );
    Inc( I );

    S := '';
    while Data[I] <> '|' do
      begin
        S := S + Data[I];
        Inc( I );
      end;
    SessionInfo.NewUpdate := S;
  except
    Status := csTransferError;
    exit;
  end;

  if (Assigned( OnSessionBegin )) then OnSessionBegin( SessionInfo );

  Status := csAcceptSession;
end;

procedure TMHDClient.SendAcceptSession;
var Data : string;
begin
  Data := 'SESSIONOK';
  Client.Socket.SendText( Data );

  LongFile := False;
  LongData := '';

  Status := csGettingFile;
end;

procedure TMHDClient.GetFile;
var Data : WideString;
    Zac, Kon : integer;
    I : integer;
    FileType : string;
begin
  Data := Client.Socket.ReceiveText;

  if (Data = 'FINISH') then
    begin
      Status := csFinish;
      exit;
    end;

  Zac := Pos( 'FILEBEGIN' , Data );
  Kon := Pos( 'FILEEND' , Data );

  if (Zac = 0) and
     (not LongFile) then
    begin
      Status := csTransferError;
      exit;
    end;

  if (Kon = 0) then
    begin
      LongFile := True;
      LongData := LongData + Data;
      exit;
    end;

  if (LongFile) then
    begin
      Data := LongData + Data;
      LongFile := False;
    end;

  I := Length( 'FILEBEGIN' )+1;
  FileType := '';
  while Data[I] <> '|' do
    begin
      FileType := FileType + Data[I];
      Inc( I );
    end;

  RecievedFile.FileType := ftNone;
  if (FileType = 'rozvrh') then RecievedFile.FileType := ftRozvrh;
  if (FileType = 'listok') then RecievedFile.FileType := ftListok;
  if (FileType = 'zastavky') then RecievedFile.FileType := ftZastavky;

  if (RecievedFile.FileType = ftNone) then
    begin
      Status := csTransferError;
      exit;
    end;

  Delete( Data , Pos( 'FILEEND' , Data ) , Length( 'FILEEND' ) );
  RecievedFile.Data := Copy( Data , I+1 , Length( Data ) );

  Status := csFileOK;
end;

procedure TMHDClient.SaveRozvrh( Data : WideString );
var FileName : string;
    I : integer;
    F : textfile;
begin
  I := Pos( '|' , Data );
  FileName := Copy( Data , 1 , I-1 );

  Delete( Data , 1 , I );
  Delete( Data , Pos( '|' , Data ) , 1 );

  AssignFile( F , ROZVRHY_DIR+'\'+FileName );
  {$I-}
  Rewrite( F );
  {$I+}
  if (IOResult <> 0) or
     (Data = 'ERROR') then
    begin
       if (Assigned( OnItemChange )) then OnItemChange( 0 , ROZVRHY_DIR+'\'+FileName , 'ERROR' );
      exit;
    end;

  Write( F , String( Data ) );

  CloseFile( F );

  if (Assigned( OnItemChange )) then OnItemChange( 0 , ROZVRHY_DIR+'\'+FileName , 'OK' );
end;

procedure TMHDClient.SaveListok( Data : WideString );
var Reg : TRegistry;
    Min, Norm, Zlav : string;
    I : integer;
begin
  Min := '';
  Norm := '';
  Zlav := '';

  I := 1;
  while (Data[I] <> '|') do
    begin
      Min := Min + Data[I];
      Inc( I );
    end;

  Inc( I );
  while (Data[I] <> '|') do
    begin
      Norm := Norm + Data[I];
      Inc( I );
    end;

  Inc( I );
  while (Data[I] <> '|') do
    begin
      Zlav := Zlav + Data[I];
      Inc( I );
    end;

  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    Reg.OpenKey( '\Software\MHDClient\Tickets\Default' , False );
    Reg.WriteString( Min , Norm+';'+Zlav );
  finally
    Reg.Free;
  end;

  if (Assigned( OnItemChange )) then OnItemChange( 1 , 'Dåžka : '+Min+' Normálny : '+Norm+' Z¾avnený : '+Zlav , 'OK' );
end;

procedure TMHDClient.SaveZastavky( Data : WideString );
var F : textfile;
begin
  Delete( Data , Pos( '|' , Data ) , 1 );

  AssignFile( F , ZASTAVKY_FILE );
  {$I-}
  Rewrite( F );
  {$I+}
  if (IOResult <> 0) or
     (Data = 'ERROR') then
    begin
       if (Assigned( OnItemChange )) then OnItemChange( 2 , ZASTAVKY_FILE , 'ERROR' );
      exit;
    end;

  Write( F , String( Data ) );

  CloseFile( F );

  if (Assigned( OnItemChange )) then OnItemChange( 2 , ZASTAVKY_FILE , 'OK' );
end;

procedure TMHDClient.SaveFile;
begin
  case RecievedFile.FileType of
    ftRozvrh : SaveRozvrh( RecievedFile.Data );
    ftListok : SaveListok( RecievedFile.Data );
    ftZastavky : SaveZastavky( RecievedFile.Data );
  end;

  Client.Socket.Write( Client.Socket.SocketHandle );
end;

procedure TMHDClient.SendFileOK;
var Data : string;
begin
  Data := 'FILEOK';
  Client.Socket.SendText( Data );

  Status := csGettingFile;
end;

procedure TMHDClient.SaveLastUpdate;
begin
  CLIENTINFO.LastUpdate := SessionInfo.NewUpdate;
end;

end.
