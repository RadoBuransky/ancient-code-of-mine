unit ClassHladanie;

interface

uses Windows, ClassData, Konstanty;

type PVysledok = ^TVysledok;

     TSettings = record
       Time : integer;
       Den : integer;

       Listky : TTickets;

       Zlavneny : boolean;
       Peso : integer;
       Rezerva : integer;
       AutoShow : boolean;
     end;

     TSearchData = record
       Odkial, Kam : PZastavka;
       Settings : TSettings;
     end;

     TPrestup = record
       Zaciatok : PSpoj;
       Koniec : integer; // ak (Spoj = nil), kam sa peso dostanem

       Zastavky : integer;
       Nastup, Vystup : integer;
     end;

     TVysledok = record
       Cena : integer;
       Dlzka : integer;
       Zaciatok, Koniec : PZastavka;
       Prestupy : array of TPrestup;

       FreePoint : boolean;
       A, B : TPoint;
     end;

     TZastavky = array of PZastavka;

     THladanie = class
     private
       procedure FreeVysledok;

       function ZistiNajskorsi( Spoj : PSpoj; Cas : integer; SearchData : TSearchData; Stav : TStav ) : integer;
       function UrciCenu( Vysledok : PVysledok; SearchData : TSearchData ) : integer;
       function NajdiNajblizsie( Point : TPoint ) : TZastavky;

       procedure NajdiCas( SearchData : TSearchData );
     public
       Vysledok : PVysledok;

       function Najdi( SearchData : TSearchData ) : PVysledok;
       function NajdiSur( Start, Finish : TPoint; SearchData : TSearchData ) : PVysledok;

       constructor Create;
       destructor Destroy; override;
     end;

var Hladanie : THladanie;

implementation

uses Forms, Controls;

//==============================================================================
//==============================================================================
//
//                                    Constructor
//
//==============================================================================
//==============================================================================

constructor THladanie.Create;
begin
  inherited;
end;

//==============================================================================
//==============================================================================
//
//                                    Destructor
//
//==============================================================================
//==============================================================================

destructor THladanie.Destroy;
begin
  FreeVysledok;
  inherited;
end;

//==============================================================================
//==============================================================================
//
//                                   Pomocne
//
//==============================================================================
//==============================================================================

procedure THladanie.FreeVysledok;
var I : integer;
begin
  if Vysledok = nil then exit;
  for I := 0 to Length( Vysledok^.Prestupy )-1 do
    SetLength( Vysledok^.Prestupy , 0 );
  Dispose( Vysledok );
  Vysledok := nil;
end;

//==============================================================================
//==============================================================================
//
//                                 H L A D A N I E
//
//==============================================================================
//==============================================================================

//==============================================================================
//  SPOLOCNE
//==============================================================================

function THladanie.ZistiNajskorsi( Spoj : PSpoj; Cas : integer; SearchData : TSearchData; Stav : TStav ) : integer;
var I : integer;
    Min : PMinuty;
begin
  Result := -1;

  I := Cas div 60;
  if (I < 0) or
     (I > 23) then exit;

  Min := Spoj^.Rozvrhy^.Rozvrh[ SearchData.Settings.Den ][I];

  repeat
    if (Min <> nil) and
       (Min^.Cas+(I*60) >= Cas) and
       ((Stav = Normal) or
        ((Stav = Plus) and
         (Min^.Stav = Plus)) or
        ((Stav = Minus) and
         (Min^.Stav <> Minus))) then break;

    if (Min = nil) then
      while (Min = nil) do
        begin
          Inc( I );
          if I = 24 then exit;
          Min := Spoj^.Rozvrhy^.Rozvrh[ SearchData.Settings.Den ][I];
        end
        else
      Min := Min^.Next;
  until false;

  Result := Min^.Cas+(I*60);
end;

function THladanie.UrciCenu( Vysledok : PVysledok; SearchData : TSearchData ) : integer;
type TListok = record
       Cena : integer;
       Dlzka : integer;
     end;
var Listky : array of TListok;
    Best : integer;

procedure Skusaj( Cas, Cena, Index : integer );
var I, J, K : integer;
    Zac, Kon : integer;
    ZacSpoj, Spoj : PSpoj;
    Min : integer;
begin
  if (Cas >= Vysledok^.Dlzka) then
    begin
      if (Best = -1) or
         (Cena < Best) then
        Best := Cena;
      exit;
    end;

  Zac := Vysledok^.Prestupy[0].Nastup+Cas;
  Kon := -1;

  // Najde spoj, v ktorom v case "Zac" som
  for I := 0 to Length( Vysledok^.Prestupy )-1 do
    if (Zac <= Vysledok^.Prestupy[I].Vystup) then
      begin
        if (Zac < Vysledok^.Prestupy[I].Nastup) then
          Zac := Vysledok^.Prestupy[I].Nastup;

        Min := Vysledok^.Prestupy[I].Nastup;
        ZacSpoj := Vysledok^.Prestupy[I].Zaciatok;
        K := 0;
        while (ZacSpoj <> nil) and
              (Min <= Zac) and
              (K <= Vysledok^.Prestupy[I].Zastavky) do
          begin
            Inc( K );
            Inc( Min , ZacSpoj^.NextMin );
            if (ZacSpoj^.Next = nil) then break;
            ZacSpoj := ZacSpoj^.Next;
          end;
        if (ZacSpoj^.Next <> nil) and
           (ZacSpoj^.Prev <> nil) then ZacSpoj := ZacSpoj^.Prev;

        Kon := Vysledok^.Prestupy[ Length( Vysledok^.Prestupy )-1 ].Vystup;
        for J := I to Length( Vysledok^.Prestupy )-1 do
          begin
            Spoj := Vysledok^.Prestupy[J].Zaciatok;
            Min := Vysledok^.Prestupy[J].Nastup;
            K := 0;
            while (Spoj <> nil) and
                  (K <= Vysledok^.Prestupy[J].Zastavky) do
              begin
                if (Spoj^.NaZastavke^.Pasmo <> ZacSpoj^.NaZastavke^.Pasmo) and
                   (Min > Zac) then
                  begin
                    Kon := Min;
                    break;
                  end;
                Inc( K );
                Inc( Min , Spoj^.NextMin );
                Spoj := Spoj^.Next;
              end;
          end;
        break;
      end;

  if (Kon = -1) then exit;

  for I := 0 to Length( TICKETS )-1 do
    begin
      if (Index > Length( Listky )-1) then
        SetLength( Listky , Length( Listky )+10 );

      if (SearchData.Settings.Zlavneny) then Listky[Index].Cena := TICKETS[I].Zlav
                                        else Listky[Index].Cena := TICKETS[I].Norm;
      Listky[Index].Dlzka := TICKETS[I].Min;

      if (Zac+Listky[Index].Dlzka > Kon) then
        Skusaj( Kon-Vysledok^.Prestupy[0].Nastup , Cena+Listky[Index].Cena , Index+1 )
          else
        Skusaj( Cas+Listky[Index].Dlzka , Cena+Listky[Index].Cena , Index+1 )
    end;
end;

begin
  SetLength( Listky , 10 );
  Best := -1;

  Skusaj( 0 , 0 , 0 );

  if (Best = -1) then Best := 0;
  Result := Best;
end;

function THladanie.NajdiNajblizsie( Point : TPoint ) : TZastavky;
var I : integer;
    Naj, d, PesoPix : integer;
    Peso : boolean;
begin
  SetLength( Result , 0 );

  Naj := -1;
  Peso := False;
  if (Data.Peso > 0) then PesoPix := Round((Data.Peso/100)*HEKTOMETER)
                     else PesoPix := 0;
  for I := 0 to Data.Zastavky.Count-1 do
    begin
      d := Round( Sqrt( Sqr(TZastavka( Data.Zastavky[I]^ ).Sur.X - Point.X) +
                        Sqr(TZastavka( Data.Zastavky[I]^ ).Sur.Y - Point.Y) ) );

      if (Naj = -1) then
        begin
          SetLength( Result , 1 );
          Result[0] := Data.Zastavky[I];
          if (d <= PesoPix) then Peso := True;
          Naj := d;
          continue;
        end;

      if (not Peso) then
        begin
          if (d <= PesoPix) and
             (not Peso) then
            begin
              SetLength( Result , 1 );
              Peso := True;
            end;

          if (d < Naj) then
            begin
              Result[0] := Data.Zastavky[I];
              Naj := d;
            end;
        end
          else
        begin
          SetLength( Result , Length( Result )+1 );
          Result[Length( Result )-1] := Data.Zastavky[I];
        end;
    end;
end;

//==============================================================================
//  CAS
//==============================================================================

procedure THladanie.NajdiCas( SearchData : TSearchData );
type TStack = record
       Items : array of Integer;
       Last : integer;
     end;

     TPrich = record
       Spoj : PSpoj; // spoj, ktorym som na zastavku prisiel (nil = peso)
       iZast : integer; // index zastavky z ktorej som prisiel
       iSpoj : integer; // index spoja na zastavke z ktorej som prisiel
       Cas : integer; // kedy som prisiel
       Prestupy : integer; // pocet prestupov

       Vysledok : TVysledok;
     end;

     TOdch = record
       Spoj : PSpoj; // spoj, ktorym idem na dalsiu zastavku
       Odchod : integer; // cas odchodu zo zastavky
       Prestupy : integer; // pocet prestupov
     end;

     TZast = record
       Odchody : array of TOdch;
       Prichody, NewPrichody : array of TPrich;
     end;

var Stack, NewStack : TStack; // cisla zastavok, ktore budu v dalsom cykle spracovane
    Zast : array of TZast;


    I, J, K, L, M, N, O : integer;

    Spoje : array of PSpoj; // spoje, ktorymi mozem ist zo zastavky dalej
    Prich, Odch, Prest : integer;

    Best : integer;

procedure ZapisVysledok;
var I, J, K, L : integer;
begin
  J := 0;
  L := Length( Zast[SearchData.Kam^.Cislo].Prichody[0].Vysledok.Prestupy )-1;
  for I := 0 to Length( Zast[SearchData.Kam^.Cislo].Prichody )-1 do
    begin
      K := Length( Zast[SearchData.Kam^.Cislo].Prichody[I].Vysledok.Prestupy )-1;
      if (Zast[SearchData.Kam^.Cislo].Prichody[I].Vysledok.Prestupy[K].Vystup < Zast[SearchData.Kam^.Cislo].Prichody[J].Vysledok.Prestupy[L].Vystup) or
         ((Zast[SearchData.Kam^.Cislo].Prichody[I].Vysledok.Prestupy[K].Vystup = Zast[SearchData.Kam^.Cislo].Prichody[J].Vysledok.Prestupy[L].Vystup) and
          (Zast[SearchData.Kam^.Cislo].Prichody[I].Prestupy < Zast[SearchData.Kam^.Cislo].Prichody[J].Prestupy)) then
        begin
          J := I;
          L := Length( Zast[SearchData.Kam^.Cislo].Prichody[I].Vysledok.Prestupy )-1;
        end;
    end;

  if (Vysledok = nil) then
    New( Vysledok )
      else
    begin
      if (Zast[SearchData.Kam^.Cislo].Prichody[J].Vysledok.Prestupy[L].Vystup > Vysledok^.Prestupy[ Length( Vysledok^.Prestupy )-1 ].Vystup) or
         ((Zast[SearchData.Kam^.Cislo].Prichody[J].Vysledok.Prestupy[L].Vystup = Vysledok^.Prestupy[ Length( Vysledok^.Prestupy )-1 ].Vystup) and
          (L > Length( Vysledok^.Prestupy )-1)) then
        exit;
    end;

  with Vysledok^ do
    begin
      Zaciatok := SearchData.Odkial;
      Koniec := SearchData.Kam;
      Prestupy := Zast[SearchData.Kam^.Cislo].Prichody[J].Vysledok.Prestupy;
      Best := Prestupy[ Length( Prestupy )-1 ].Vystup;

      Cena := 0;
      Dlzka := Prestupy[ Length( Prestupy )-1 ].Vystup - Prestupy[ 0 ].Nastup;
    end;
end;

begin
  // najlepsi vysledok
  Best := 9999;

  // inicializacia stacku
  SetLength( Stack.Items , 1 );
  Stack.Last := 0;
  Stack.Items[0] := SearchData.Odkial^.Cislo;

  // inicializacia noveho stacku
  SetLength( NewStack.Items , Data.Zastavky.Count );
  NewStack.Last := 0;

  // inicializacia zast
  SetLength( Zast , Data.Zastavky.Count );

  // inicializacia prvej zastavky
  SetLength( Zast[ SearchData.Odkial^.Cislo ].Prichody , 1 );
  with Zast[ SearchData.Odkial^.Cislo ].Prichody[0] do
    begin
      Spoj := nil;
      iZast := -1;
      iSpoj := -1;
      Cas := SearchData.Settings.Time;
      Prestupy := -1;

      SetLength( Vysledok.Prestupy , 0 );
    end;

  repeat
    // vyprazdni novy stack
    NewStack.Last := -1;

    // pre kazdu polozku v stacku
    for I := 0 to Stack.Last do
      begin
        // ak som dorazil na koniec
        if (Stack.Items[I] = SearchData.Kam^.Cislo) then
          begin
            ZapisVysledok;
            continue;
          end;

        // zoznam spojov, ktorymi sa mozem dalej sirit
        K := -1;
        SetLength( Spoje , TZastavka( Data.Zastavky[ Stack.Items[I] ]^ ).Spoje.Count*2 );
        for J := 0 to TZastavka( Data.Zastavky[ Stack.Items[I] ]^ ).Spoje.Count-1 do
          begin
            Inc( K );
            Spoje[K] := TZastavka( Data.Zastavky[ Stack.Items[I] ]^ ).Spoje[J];
            if (Spoje[K]^.Opacny <> nil) then
              begin
                Inc( K );
                Spoje[K] := Spoje[K-1]^.Opacny;
              end;
          end;
        SetLength( Spoje , K+1 );

        if (Length( Zast[ Stack.Items[I] ].Odchody  ) = 0) then
          SetLength( Zast[ Stack.Items[I] ].Odchody , K+1 );

        // pre kazdy prichod na zastavku sprav odchody
        for J := 0 to Length( Zast[ Stack.Items[I] ].Prichody )-1 do
          begin
            for K := 0 to Length( Spoje )-1 do
              begin
                // ak sa tym spojom uz neda ist dalej
                if (Spoje[K]^.Next = nil) then continue;

                Prich := Zast[ Stack.Items[I] ].Prichody[J].Cas;
                Prest := Zast[ Stack.Items[I] ].Prichody[J].Prestupy;

                // ak prestupujem, tak zvys pocet prestupov, a prirataj rezervu na prestup
                if (Zast[ Stack.Items[I] ].Prichody[J].Spoj = nil) or
                   (Zast[ Stack.Items[I] ].Prichody[J].Spoj^.Next <> Spoje[K]) then
                  begin
                    Inc( Prest );
                    if (SearchData.Settings.Rezerva > 0) then
                      Inc( Prich , SearchData.Settings.Rezerva );
                  end;

                // kedy mi odchadza najblizsi spoj
                Odch := ZistiNajskorsi( Spoje[K] , Prich , SearchData , Spoje[K]^.Next^.Stav );

                // ak uz mi dnes nikdy nejde (alebo ak tymto spojom lepsi vysledok nezistim)
                if (Odch = -1) or
                   (Odch > Best) then continue;

                // ak som uz tymto spojom isiel (ale skorsim)
                if (Zast[ Stack.Items[I] ].Odchody[K].Odchod > 0) and
                   (Odch > Zast[ Stack.Items[I] ].Odchody[K].Odchod) then continue;

                // ak som isiel presne tymto, ale s menej prestupmi
                if (Zast[ Stack.Items[I] ].Odchody[K].Odchod > 0) and
                   (Odch = Zast[ Stack.Items[I] ].Odchody[K].Odchod) and
                   (Prest >= Zast[ Stack.Items[I] ].Odchody[K].Prestupy) then continue;

                // nasiel som lepsi spoj
                with Zast[ Stack.Items[I] ].Odchody[K] do
                  begin
                    Spoj := Spoje[K];
                    Odchod := Odch;
                    Prestupy := Prest;
                  end;

                // ak zastavka, na ktoru sa mam dostat, este nie je v stacku, tak ju tam pridaj
                if (Length( Zast[ Spoje[K]^.Next^.NaZastavke^.Cislo ].NewPrichody ) = 0) then
                  begin
                    Inc( NewStack.Last );
                    NewStack.Items[ NewStack.Last ] := Spoje[K]^.Next^.NaZastavke^.Cislo;
                  end;

                // nastavim novy prichod
                L := Length( Zast[ Spoje[K]^.Next^.NaZastavke^.Cislo ].NewPrichody );
{                N := 0;
                for M := 0 to L-1 do
                  if (Zast[ Spoje[K]^.Next^.NaZastavke^.Cislo ].NewPrichody[M].Spoj = Spoje[K]) then
                    begin
                      L := M;
                      N := 1;
                      break;
                    end;

                if (N = 0) then}
                  SetLength( Zast[ Spoje[K]^.Next^.NaZastavke^.Cislo ].NewPrichody , L+1 );
                with Zast[ Spoje[K]^.Next^.NaZastavke^.Cislo ].NewPrichody[L] do
                  begin
                    Spoj := Spoje[K];
                    iZast := Stack.Items[I];
                    iSpoj := K;
                    Cas := Odch + Spoje[K]^.NextMin;
                    Prestupy := Prest;
                    Vysledok.Prestupy := Copy( Zast[ Stack.Items[I] ].Prichody[J].Vysledok.Prestupy , 0 , Length( Zast[ Stack.Items[I] ].Prichody[J].Vysledok.Prestupy ) );
                    if (Zast[ Stack.Items[I] ].Prichody[J].Spoj = nil) or
                       (Zast[ Stack.Items[I] ].Prichody[J].Spoj^.Next <> Spoje[K]) then
                      begin
                        SetLength( Vysledok.Prestupy , Length( Vysledok.Prestupy )+1 );
                        with Vysledok.Prestupy[ Length( Vysledok.Prestupy )-1 ] do
                          begin
                            Zaciatok := Spoje[K];
                            Koniec := Spoje[K]^.Next^.NaZastavke^.Cislo;
                            Zastavky := 1;
                            Nastup := Odch;
                            Vystup := Cas;
                          end;
                      end
                        else
                      begin
                        with Vysledok.Prestupy[ Length( Vysledok.Prestupy )-1 ] do
                          begin
                            Koniec := Spoje[K]^.Next^.NaZastavke^.Cislo;
                            Inc( Zastavky );
                            Vystup := Cas;
                          end;
                      end;
                  end;
              end;

            // Ak som sa na tuto zastavku dostal peso, alebo ak je chodenie peso
            // zakazane
{            if (Zast[ Stack.Items[I] ].Prichody[J].Spoj = nil) or
               (SearchData.Settings.Peso <= 0) then continue;

            // Pre kazdu blizku zastavku vytvor prichod
            for K := 0 to Length( TZastavka( Data.Zastavky[ Stack.Items[I] ]^ ).BlizkeZast )-1 do
              begin
                // Cislo zastavky na ktoru sa idem sirit
                L := TZastavka( Data.Zastavky[ Stack.Items[I] ]^ ).BlizkeZast[K].Zast^.Cislo;
                M := Length( Zast[ L ].NewPrichody )-1;
                O := 0;
                for N := 0 to M do
                  if (Zast[ L ].NewPrichody[N].Spoj = nil) then
                    begin
                      O := 1;
                      M := N;
                      break;
                    end;

                if (O = 0) then
                  SetLength( Zast[ L ].NewPrichody

                if (Length( Zast[ L ].NewPrichody ) = 0) then
                  begin
                    Inc( NewStack.Last );
                    NewStack.Items[ NewStack.Last ] := L;
                  end;

                SetLength( Zast[ L ].NewPrichody , Length( Zast[ L ].NewPrichody )+1 );
                with Zast[ L ].NewPrichody[ Length( Zast[ L ].NewPrichody )-1 ] do
                  begin
                    Spoj := nil;
                    iZast := Stack.Items[I];
                    iSpoj := -1;
                    Cas := Zast[ Stack.Items[I] ].Prichody[J].Cas + TZastavka( Data.Zastavky[ Stack.Items[I] ]^ ).BlizkeZast[K].Min;
                    Prestupy := Zast[ Stack.Items[I] ].Prichody[J].Prestupy + 1;

                    Vysledok.Prestupy := Copy( Zast[ Stack.Items[I] ].Prichody[J].Vysledok.Prestupy , 0 , Length( Zast[ Stack.Items[I] ].Prichody[J].Vysledok.Prestupy ) );
                    SetLength( Vysledok.Prestupy , Length( Vysledok.Prestupy )+1 );
                    with Vysledok.Prestupy[ Length( Vysledok.Prestupy )-1 ] do
                      begin
                        Zaciatok := nil;
                        Koniec := L;
                        Zastavky := 1;
                        Nastup := Zast[ Stack.Items[I] ].Prichody[J].Cas;
                        Vystup := Cas;
                      end;
                  end;
              end;}
          end;
      end;

    // zmaz stare prichody
    for I := 0 to Stack.Last do
      SetLength( Zast[ Stack.Items[I] ].Prichody , 0 );

    // prirad nove prichody
    for I := 0 to NewStack.Last do
      begin
        Zast[ NewStack.Items[I] ].Prichody := Copy( Zast[ NewStack.Items[I] ].NewPrichody , 0 , Length( Zast[ NewStack.Items[I] ].NewPrichody ) );
        SetLength( Zast[ NewStack.Items[I] ].NewPrichody , 0 );
      end;

    Stack.Last := NewStack.Last;
    Stack.Items := Copy( NewStack.Items , 0 , NewStack.Last+1 );
  until (Stack.Last = -1);
end;

//==============================================================================
//==============================================================================
//
//                                I N T E R F A C E
//
//==============================================================================
//==============================================================================

function THladanie.Najdi( SearchData : TSearchData ) : PVysledok;
begin
  FreeVysledok;

  Screen.Cursor := crHourGlass;
  try
    if (SearchData.Settings.Peso > 0) then Data.Peso := SearchData.Settings.Peso
                                      else Data.Peso := 0;
    NajdiCas( SearchData );
  finally
    Screen.Cursor := crDefault;
  end;

  Result := Vysledok;

  if Result <> nil then
    begin
      Result^.FreePoint := False;
      Result^.Cena := UrciCenu( Result , SearchData );
    end;
end;

function THladanie.NajdiSur( Start, Finish : TPoint; SearchData : TSearchData ) : PVysledok;
var NajVysledok : PVysledok;
    Odkial, Kam : TZastavky;
    I, J : integer;
begin
  FreeVysledok;

  NajVysledok := nil;

  Screen.Cursor := crHourGlass;
  try
    if (SearchData.Settings.Peso > 0) then Data.Peso := SearchData.Settings.Peso
                                      else Data.Peso := 0;

    Odkial := NajdiNajblizsie( Start );
    Kam := NajdiNajblizsie( Finish );

    for I := 0 to Length( Odkial )-1 do
      begin
        SearchData.Odkial := Odkial[I];

        for J := 0 to Length( Kam )-1 do
          begin
            SearchData.Kam := Kam[J];

            if (SearchData.Odkial = SearchData.Kam) then continue;

            NajdiCas( SearchData );

            if (Vysledok = nil) then continue;

            if (NajVysledok = nil) or
               (NajVysledok^.Prestupy[ Length( NajVysledok^.Prestupy )-1 ].Vystup > Vysledok^.Prestupy[ Length( Vysledok^.Prestupy )-1 ].Vystup) or
               ((NajVysledok^.Prestupy[ Length( NajVysledok^.Prestupy )-1 ].Vystup = Vysledok^.Prestupy[ Length( Vysledok^.Prestupy )-1 ].Vystup) and
                (Length( NajVysledok^.Prestupy ) = Length( Vysledok^.Prestupy ))) then
              begin
                if (NajVysledok = nil) then New( NajVysledok );
                NajVysledok^ := Vysledok^;
              end;

            FreeVysledok;
          end;
      end;
  finally
    Screen.Cursor := crDefault;
  end;

  Vysledok := NajVysledok;
  if (Vysledok <> nil) then
    with Vysledok^ do
      begin
        FreePoint := True;
        A := Start;
        B := Finish;
      end;
  Result := Vysledok;

  if Result <> nil then Result^.Cena := UrciCenu( Result , SearchData );
end;

end.

