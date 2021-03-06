unit ClassAdresy;

interface

uses DBTables, StdCtrls;

type TAdresy = class
     private
       Query : TQuery;

       procedure NacitajAdresy;
       procedure OpravDiakritiku;
     public
       Adresy : array of array of string;
       Active : integer;

       constructor Create;
       destructor Destroy; override;

       procedure NapisAdresu( Memo : TMemo; Cislo : integer; SetActive : boolean );
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
      SQL.Add( 'ORDER BY odber1' );

      try
        Active := True;
      except
        MessageDlg( 'Vyskytla sa chyba pri inicialz�cii komunik�cie s BDE' , mtError , [mbOk] , 0 );
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
//                             Pomocn� proced�ry
//
//==============================================================================
//==============================================================================

procedure TAdresy.NacitajAdresy;
var I, J, Poc : integer;
begin
  SetLength( Adresy , Query.RecordCount );

  I := 0;
  Poc := 0;
  Query.First;
  while not Query.EoF do
    begin
      SetLength( Adresy[I] , 4 );

      for J := 0 to 3 do
        if Query.Fields[J].AsString = '' then
          begin
            SetLength( Adresy[I] , J );
            if J = 0 then
              begin
                Dec( I );
                Inc( Poc );
              end;
            break;
          end
            else
          Adresy[I][J] := Query.Fields[J].AsString;

      Query.Next;
      Inc( I );
    end;
  SetLength( Adresy , Query.RecordCount-Poc );
end;

procedure TAdresy.OpravDiakritiku;
const MJK : array[$00..$0F,$08..$0A] of char =
        (('�','�','�'),
         ('�','�','�'),
         ('�','�','�'),
         ('�','�','�'),
         ('�','�','�'),
         ('�','�','�'),
         ('�','�','�'),
         ('�','�','�'),
         ('�','�','�'),
         ('�','�','�'),
         ('�','�','�'),
         ('�','�','�'),
         ('�','�',' '),
         ('�','�','�'),
         ('�','�',' '),
         ('�','�',' '));
var I, J : integer;

procedure Oprav( var s : string );
var I : integer;
begin
  for I := 1 to Length(s) do
    if (Ord(s[I]) div $10 in [$08..$0A]) then
      s[I] := MJK[ Ord(s[I]) mod $10 , Ord(s[I]) div $10 ];
end;

begin
  for I := 0 to Length( Adresy )-1 do
    for J := 0 to Length( Adresy[I] )-1 do
      Oprav( Adresy[I][J] );
end;

//==============================================================================
//==============================================================================
//
//                              I N T E R F A C E
//
//==============================================================================
//==============================================================================

procedure TAdresy.NapisAdresu( Memo : TMemo; Cislo : integer; SetActive : boolean );
var I : integer;
begin
  if Cislo < 0 then Cislo := Length( Adresy )-1;
  if Cislo > Length( Adresy )-1 then Cislo := 0;

  if SetActive then Active := Cislo;

  Memo.Clear;
  for I := 0 to Length( Adresy[Cislo] )-1 do
    Memo.Lines.Add( Adresy[Cislo][I] );  
end;

end.
