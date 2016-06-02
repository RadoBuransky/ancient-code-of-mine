unit ClassAdresy;

interface

uses DBTables, StdCtrls;

type TAdresy = class
     private
       Query : TQuery;
       FAdresy : array of array of string;

       function  GetAdresy( I, J : integer ) : string;
       function  GetCount : integer;
       function  GetAdresyCount( I : integer ) : integer;

       procedure NacitajAdresy;
       procedure OpravDiakritiku;
     public
       constructor Create;
       destructor Destroy; override;

       property Adresy[I, J : integer] : string read GetAdresy; default;
       property Count : integer read GetCount;
       property AdresyCount[I : integer] : integer read GetAdresyCount;
     end;

var Adresy : TAdresy;

implementation

uses Dialogs;

//==============================================================================
//==============================================================================
//
//                                 Constructor
//
//==============================================================================
//==============================================================================

constructor TAdresy.Create;
begin
  inherited;
  Query := TQuery.Create(nil);
  with Query do
    begin
      Active := False;

      DatabaseName := 'PcPrompt';

      SQL.Add( 'SELECT (adresy.odber1), (adresy.odber2), (adresy.odber3) , (adresy.odber4)' );
      SQL.Add( 'FROM adresy' );

      try
        Active := True;
      except
        MessageDlg( 'Vyskytla sa chyba pri inicialz·cii komunik·cie s BDE' , mtError , [mbOk] , 0 );
        exit;
      end;
    end;

  NacitajAdresy;
  OpravDiakritiku;
end;

//==============================================================================
//==============================================================================
//
//                                 Destructor
//
//==============================================================================
//==============================================================================

destructor TAdresy.Destroy;
begin
  Query.Free;
  inherited;
end;

//==============================================================================
//==============================================================================
//
//                             PomocnÈ proced˙ry
//
//==============================================================================
//==============================================================================

function TAdresy.GetAdresy( I, J : integer ) : string;
begin
  Result := FAdresy[I][J];
end;

function TAdresy.GetCount : integer;
begin
  Result := Length( FAdresy );
end;

function TAdresy.GetAdresyCount( I : integer ) : integer;
begin
  Result := Length( FAdresy[I] );
end;

procedure TAdresy.NacitajAdresy;
var I, J, Poc : integer;
begin
  SetLength( FAdresy , Query.RecordCount );

  I := 0;
  Poc := 0;
  Query.First;
  while not Query.EoF do
    begin
      SetLength( FAdresy[I] , 4 );

      for J := 0 to 3 do
        if Query.Fields[J].AsString = '' then
          begin
            SetLength( FAdresy[I] , J );
            if J = 0 then
              begin
                Dec( I );
                Inc( Poc );
              end;
            break;
          end
            else
          FAdresy[I][J] := Query.Fields[J].AsString;

      Query.Next;
      Inc( I );
    end;
  SetLength( FAdresy , Query.RecordCount-Poc );
end;

procedure TAdresy.OpravDiakritiku;
const MJK : array[$00..$0F,$08..$0A] of char =
        (('»','…','·'),
         ('¸','û','Ì'),
         ('È','é','Û'),
         ('Ô','Ù','˙'),
         ('‰','ˆ','Ú'),
         ('œ','”','“'),
         ('ç','˘','Ÿ'),
         ('Ë','⁄','‘'),
         ('Ï','˝','ö'),
         ('Ã','÷','¯'),
         ('≈','‹','‡'),
         ('Õ','ä','¿'),
         ('æ','º',' '),
         ('Â','›','ß'),
         ('ƒ','ÿ',' '),
         ('¡','ù',' '));
var I, J : integer;

procedure Oprav( var s : string );
var I : integer;
begin
  for I := 1 to Length(s) do
    if (Ord(s[I]) div $10 in [$08..$0A]) then
      s[I] := MJK[ Ord(s[I]) mod $10 , Ord(s[I]) div $10 ];
end;

begin
  for I := 0 to Length( FAdresy )-1 do
    for J := 0 to Length( FAdresy[I] )-1 do
      Oprav( FAdresy[I][J] );
end;

//==============================================================================
//==============================================================================
//
//                              I N T E R F A C E
//
//==============================================================================
//==============================================================================

end.
