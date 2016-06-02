unit ClassFaktury;

interface

uses Classes, ClassDBF, Typy, Math, Dialogs;

type TFaktury = class
     private
       DBF1, DBF2, DBF3 : TDBF;

       Subor1, Subor2, Subor3 : string;

       function BinarySearch( iCislo : string ) : integer;
     protected
       procedure Nacitaj;
     public
       Zoznam : TList;
       SpolocnyText : TStringList;

       constructor Create( iS1, iS2, iS3 : string );
       destructor Destroy; override;
     end;

implementation

//==============================================================================
//==============================================================================
//
//                                  Constrcutor
//
//==============================================================================
//==============================================================================

constructor TFaktury.Create( iS1, iS2, iS3 : string );

procedure QuickSortFaktury( iLeft, iRight : integer );
var I, J : integer;
    S : string;
    P : pointer;
begin
  I := iLeft;
  J := iRight;
  S := TFaktura( Zoznam[(I + J) div 2]^ ).Cislo;
  repeat
    while TFaktura( Zoznam[I]^ ).Cislo < S do Inc( I );
    while TFaktura( Zoznam[J]^ ).Cislo > S do Dec( J );
    if I <= J then
      begin
        P := Zoznam[I];
        Zoznam[I] := Zoznam[J];
        Zoznam[J] := P;

        Inc(I);
        Dec(J);
      end;
  until I > J;
  if J > iLeft then QuickSortFaktury( iLeft , J );
  if I < iRight then QuickSortFaktury( I , iRight );
end;

begin
  inherited Create;
  SpolocnyText := TStringList.Create;

  Subor1 := iS1;
  Subor2 := iS2;
  Subor3 := iS3;
  Zoznam := TList.Create;

  DBF1 := TDBF.Create( Subor1 );
  DBF2 := TDBF.Create( Subor2 );
  DBF3 := TDBF.Create( Subor3 );

  Nacitaj;
  QuickSortFaktury( 0 , Zoznam.Count-1 );
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
  Zoznam.Free;

  DBF1.Free;
  DBF2.Free;
  DBF3.Free;

  SpolocnyText.Free;
  inherited;
end;

//==============================================================================
//==============================================================================
//
//                                 Naèítanie dát
//
//==============================================================================
//==============================================================================

function TFaktury.BinarySearch( iCislo : string ) : integer;
var Found : boolean;
    First, Last : integer;
    Middle : integer;
    S : string;
begin
  Middle := 0;
  Found := False;
  First := 1;
  Last := DBF1.Header.Records;

  while (First <= Last) and
        (not Found ) do
    begin
      Middle := (Last + First) div 2;
      S := DBF1.Cells( Middle , 2 );
      if (iCislo = S) then Found := True
        else
          if (iCislo < S) then Last := Middle - 1
                          else First := Middle + 1;
    end;
  if Found then Result := Middle
           else Result := -1;
end;

procedure TFaktury.Nacitaj;
var I, J, K : integer;
    PNewFaktura : PFaktura;
    PNewPolozka : PPolozka;
    Cislo : string;
    CisloPolozky : integer;
    Pole : array[1..10000] of string;

begin
  for I := 1 to DBF3.Header.Records do
    Pole[I] := DBF3.Cells( I , 5 );

  I := 1;
  while I < Integer( DBF2.Header.Records ) do
    begin
      Cislo := DBF2.Cells( I , 1 );
      CisloPolozky := BinarySearch( Cislo );

      //Alokacie pamate pre novu fakturu a jej inicializacia :
      New( PNewFaktura );
      Zoznam.Add( PNewFaktura );
      PNewFaktura^.Cislo := DBF1.Cells( CisloPolozky , 2 );

      PNewFaktura^.Polozky := TList.Create;
      PNewFaktura^.Dodavatel.Adresa := TStringList.Create;
      PNewFaktura^.Odberatel.Adresa := TStringList.Create;

      with PNewFaktura^.Dodavatel.Adresa do
        begin
          Add( 'PC PROMPT, s. r. o.' );
          Add( 'Bajkalská 27' );
          Add( '821 01 Bratislava' );
        end;
      PNewFaktura^.Dodavatel.ICO := '35688149';

      PNewFaktura^.Odberatel.ICO := DBF1.Cells( CisloPolozky , 13 );
      for J := 1 to DBF3.Header.Records do
        if PNewFaktura^.Odberatel.ICO = Pole[J] then
          begin
            K := 1;
            repeat
              PNewFaktura^.Odberatel.Adresa.Add( DBF3.Cells( J , K ) );
              Inc( K );
            until DBF3.Cells( J , K ) = '';
            Break;
          end;

      //Pridanie poloziek k novej fakture :
      repeat

        New( PNewPolozka );

        PNewFaktura^.Polozky.Add( PNewPolozka );
        
        PNewPolozka^.Text := DBF2.Cells( I , 3 );
        PNewPolozka^.J := DBF2.Cells( I , 4 );
        PNewPolozka^.Mnozstvo := DBF2.Cells( I , 6 );
        PNewPolozka^.Vyrobne := TStringList.Create;
        PNewPolozka^.Zaruka := '0';

        Inc( I );

      until (I > Integer( DBF2.Header.Records )) or
            (DBF2.Cells( I , 1 ) <> Cislo);
    end;
end;

//==============================================================================
//==============================================================================
//
//                                  Interface
//
//==============================================================================
//==============================================================================

end.
