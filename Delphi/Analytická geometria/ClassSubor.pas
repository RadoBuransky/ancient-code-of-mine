(*
//==============================================================================
//==============================================================================
||
||   Subor *.GEO
||   ===========
||
||   Subor je zlozeny z jednotlivych blokov dat. Kazdy blok obsahuje data jedne-
||   ho z poloziek (body, nuholniky, priamky, ... ).
||
||   Format suboru :
||
||   1.   Zaciatok bloku(1 byte) - podla toho ake informacie blok nesie ($01, ... )
||   2.   .... - data
||   3.   Koniec bloku(1 byte) - taky isty byte ako zaciatok bloku.
||
||
||
||        Blok bodov :
||        ============
||
||        Nazov bodu(n bytov)
||        Koniec nazvu $00 (1 byte)
||        X-ova suradnica(8 bytov) - typ real
||        Y-ova suradnica(8 bytov) - typ real
||
||
||
||        Blok N-Uholmikov :
||        ==================
||
||        Nazov N-Uholnika(n bytov)
||        Koniec nazvu $00(1 byte)
||        Zoznam cisiel bodov(k* sizeof( integer) )
||        Koniec zoznamu($FFFF)
||
||
||
\\==============================================================================
\\==============================================================================
*)

unit ClassSubor;

interface

uses Classes, ClassSustava, SysUtils, Dialogs, Typy;

const BodyBlok : byte = $01;
      NUhBlok : byte = $02;

type TSubor = class(TFileStream)
              private
                Sustava : TSustava;
                Cesta : string;
                Mode : word;

              protected
                procedure ZapisBody;
                procedure ZapisNUholniky;

                procedure NacitajBody;
                procedure NacitajNUholniky;
              public
                procedure Zapis;
                procedure Nacitaj( iMode : integer );

                constructor Create( iSustava : TSustava; iCesta : string; iMode : word );
              end;

implementation

uses Debugging;

(*
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
||                                Z á p i s                                   ||
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
*)

procedure TSubor.ZapisBody;
var I,J : integer;
    Bod : TBod;
begin
  Write( BodyBlok , SizeOf( BodyBlok ) );
  for I := 0 to Sustava.Body.Pole.Count-1 do
    begin
      Bod := TBod( Sustava.Body.Pole[I]^ );
      for J := 1 to Length( Bod.Nazov )+1 do
        Write( Bod.Nazov[J] , SizeOf( Bod.Nazov[J] ) );
      Write( Bod.X , SizeOf( Bod.X ) );
      Write( Bod.Y , SizeOf( Bod.Y ) );
    end;
  Write( BodyBlok , SizeOf( BodyBlok ) );
end;

procedure TSubor.ZapisNUholniky;
var I, J, K : integer;
    NUh : TNuholnik;
begin
  Write( NUhBlok , SizeOf( NUhBlok ) );
  for I := 0 to Sustava.NUholniky.Pole.Count-1 do
    begin
      NUh := TNUholnik( Sustava.NUholniky.Pole[I]^ );
      for J := 1 to Length( NUh.Nazov )+1 do
        Write( NUh.Nazov[J] , SizeOf( NUh.Nazov[J] ) );

      for J := 0 to NUh.Body.Count-1 do
        for  K := 0 to Sustava.Body.Pole.Count-1 do
          if ( NUh.Body[J] ) = ( Sustava.Body.Pole[K] ) then
            begin
              Write( K , SizeOf( K ) );
              break;
            end;

      K := $FFFF;
      Write( K , SizeOf( K ) );
    end;
  Write( NUhBlok , SizeOf( NUhBlok ) );
end;

procedure TSubor.Zapis;
begin
  if Mode <> fmCreate then exit;
  ZapisBody;
  ZapisNUholniky;
end;

(*
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
||                               È í t a n i e                                ||
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
*)

procedure TSubor.NacitajBody;
var Bod : TBod;
    Znak : byte;
begin
  repeat
    Bod.Nazov := '';
    repeat
      Read( Znak , SizeOf( Znak) );
      if (Znak = BodyBlok) and
         (Bod.Nazov = '') then
           exit;
      if Znak <> $00 then
        Bod.Nazov := Bod.Nazov + Char( Znak );
    until Znak = $00;
    Read( Bod.X , SizeOf( Bod.X ) );
    Read( Bod.Y , SizeOf( Bod.Y ) );

    Sustava.Body.Pridaj( Bod );
  until position >= size;
end;

procedure TSubor.NacitajNUholniky;
var NUh : TNUholnik;
    Znak : byte;
    Cislo : integer;
begin
  repeat
    NUh.Body := TList.Create;
    NUh.Nazov := '';

    repeat
      Read( Znak , SizeOf( Znak) );
      if (Znak = NUhBlok) and
         (NUh.Nazov = '') then
           exit;
      if Znak <> $00 then
        NUh.Nazov := NUh.Nazov + Char( Znak );
    until Znak = $00;

    repeat
      Read( Cislo , SizeOf( Cislo ) );
      if Cislo <> $FFFF then
        NUh.Body.Add( Sustava.Body.Pole[ Cislo ] );
    until Cislo = $FFFF;

    Sustava.NUholniky.Pridaj( NUh );
  until position >= size;
end;

procedure TSubor.Nacitaj( iMode : integer );
var Blok : byte;
begin
  if Mode <> fmOpenRead then exit;
  while Position < Size do
    begin
      Read( Blok , SizeOf( Blok ) );

      if (Blok = BodyBlok) and
         ((iMode and frBody) = frBody) then NacitajBody;

      if (Blok = NUhBlok) and
         ((iMode and frNUholniky) = frNUholniky) then NacitajNUholniky;
    end;
end;

(*
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
||                         Constrcutor & Destructor                           ||
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
*)

constructor TSubor.Create( iSustava : TSustava; iCesta : string; iMode : word );
begin
 try
    inherited Create( iCesta , iMode );
  except
    on EFOpenError do
      begin
        MessageDlg( 'Súbor '''+iCesta+''' sa nedá otvori na èítanie' , mtError , [mbOk] , 0 );
        exit;
      end;
    on EFCreateError do
      begin
        MessageDlg( 'Súbor '''+iCesta+''' sa nedá otvori na zápis' , mtError , [mbOk] , 0 );
        exit;
      end;
  end;

  Napis( 'TSubor.Create' );
  Cesta := iCesta;
  Mode := iMode;
  Sustava := iSustava;
end;

end.
