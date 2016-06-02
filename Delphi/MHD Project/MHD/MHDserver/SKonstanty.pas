// Serverovske konstanty ! ! !

unit SKonstanty;

interface

type TTicket = record
       Min : integer;
       Norm, Zlav : integer;
     end;
     TTickets = array of TTicket;

     TClientInfo = record
       Name, Company, Serial : string;
       LastUpdate : string;
     end;

var UPDATES_FILE : string;
    LAST_ACTIVE : integer;
    PORT : integer;

    MAP_FILE : string;

implementation

uses Windows, Registry;

procedure ReadRegs;
var Reg : TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;

    Reg.OpenKey( '\Software\MHDServer\Files\' , False );
    MAP_FILE := Reg.ReadString( 'Mapa' );

    Reg.OpenKey( '\Software\MHDServer\Updates\' , False );
    UPDATES_FILE := Reg.ReadString( 'Updates' );
    LAST_ACTIVE := Reg.ReadInteger( 'LastActive' );

    Reg.OpenKey( '\Software\MHDServer\Synchronization\Settings\' , False );
    PORT := Reg.ReadInteger( 'Port' );
  finally
    Reg.Free;
  end;
end;

procedure WriteRegs;
var Reg : TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;

    Reg.OpenKey( '\Software\MHDServer\Updates\' , False );
    Reg.WriteInteger( 'LastActive' , LAST_ACTIVE );
  finally
    Reg.Free;
  end;
end;

initialization
  ReadRegs;
finalization
  WriteRegs;
end.
