unit ClassFaktury;

interface

uses Classes, DBTables;

type TFaktury = class
     private
       Query : TQuery;
     protected
       procedure NacitajFaktury;
       procedure OpravDiakritiku;
     public
       Zoznam : TList;

       constructor Create;
       destructor Destroy; override;
     end;

var Faktury : TFaktury;

implementation

uses Dialogs, Typy;

//==============================================================================
//==============================================================================
//
//                                  Constrcutor
//
//==============================================================================
//==============================================================================

constructor TFaktury.Create;
begin
  inherited Create;
  Zoznam := TList.Create;
  Query := TQuery.Create(nil);

  with Query do
    begin
      Active := False;

      DatabaseName := 'PcPrompt';

      SQL.Add( 'SELECT (fakodb.cisfak), (adresy.odber1), (adresy.odber2), (adresy.odber3), '+
               '(adresy.ico),  (fotext.text), (fotext.jed), (fotext.mno)' );
      SQL.Add( 'FROM fakodb, adresy, fotext ' );
      SQL.Add( 'WHERE (adresy.ico = fakodb.ico) AND (fakodb.cisfak = fotext.kcisfak)' );
      SQL.Add( 'ORDER BY cisfak' );

      try
        Active := True;
      except
        MessageDlg( 'Vyskytla sa chyba pri inicialz·cii komunik·cie s BDE' , mtError , [mbOk] , 0 );
        exit;
      end;
    end;

  NacitajFaktury;
  OpravDiakritiku;
end;

//==============================================================================
//==============================================================================
//
//                                  Destrcutor
//
//==============================================================================
//==============================================================================

destructor TFaktury.Destroy;
var I, J : integer;
begin
  for I := 0 to Zoznam.Count-1 do
    begin
      for J := 0 to TFaktura( Zoznam[I]^ ).Polozky.Count-1 do
        begin
          TPolozka( TFaktura( Zoznam[I]^ ).Polozky[J]^ ).Vyrobne.Free;
          Dispose( PPolozka( TFaktura( Zoznam[I]^ ).Polozky[J] ) );
        end;
      TFaktura( Zoznam[I]^ ).Polozky.Free;
      TFaktura( Zoznam[I]^ ).Dodavatel.Adresa.Free;
      TFaktura( Zoznam[I]^ ).Odberatel.Adresa.Free;
      Dispose( PFaktura( Zoznam[I] ) );
    end;

  Query.Free;
  Zoznam.Free;

  inherited;
end;

//==============================================================================
//==============================================================================
//
//                                 Praca s datami
//
//==============================================================================
//==============================================================================

procedure TFaktury.NacitajFaktury;
var PNewFaktura : PFaktura;
    PNewPolozka : PPolozka;
begin
  Query.First;
  while not Query.EoF do
    begin
      New( PNewFaktura );
      Zoznam.Add( PNewFaktura );

      with PNewFaktura^ do
        begin
          with Dodavatel do
            begin
              Adresa := TStringList.Create;
              Adresa.Add( 'PC PROMPT, s.r.o.' );
              Adresa.Add( 'Bajkalsk· 27' );
              Adresa.Add( 'BRATISLAVA, 821 01' );
              ICO := '35688149';
            end;
          with Odberatel do
            begin
              Adresa := TStringList.Create;
              Adresa.Add( Query.Fields[1].AsString );
              Adresa.Add( Query.Fields[2].AsString );
              Adresa.Add( Query.Fields[3].AsString );
              ICO := Query.Fields[4].AsString;              
            end;
          Cislo := Query.Fields[0].AsString;

          Polozky := TList.Create;
          while (Query.Fields[0].AsString = Cislo) and (not Query.Eof) do
            begin
              New( PNewPolozka );
              Polozky.Add( PNewPolozka );

              with PNewPolozka^ do
                begin
                  Vyrobne := TStringList.Create;

                  Text := Query.Fields[5].AsString;
                  J := Query.Fields[6].AsString;
                  Mnozstvo := Query.Fields[7].AsString;
                  Zaruka := '';
                end;

              Query.Next;
            end;
        end;
    end;
end;

procedure TFaktury.OpravDiakritiku;
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
    S : string;

procedure Oprav( var s : string );
var I : integer;
begin
  for I := 1 to Length(s) do
    if (Ord(s[I]) div $10 in [$08..$0A]) then
      s[I] := MJK[ Ord(s[I]) mod $10 , Ord(s[I]) div $10 ];
end;

begin
  for I := 0 to Zoznam.Count-1 do
    begin
      for J := 0 to TFaktura( Zoznam[I]^ ).Odberatel.Adresa.Count-1 do
        begin
          S := TFaktura( Zoznam[I]^ ).Odberatel.Adresa[J];
          Oprav( S );
          TFaktura( Zoznam[I]^ ).Odberatel.Adresa[J] := S;
        end;

      for J := 0 to TFaktura( Zoznam[I]^ ).Polozky.Count-1 do
        Oprav( TPolozka( TFaktura( Zoznam[I]^ ).Polozky[J]^ ).Text );
    end;
end;

end.
