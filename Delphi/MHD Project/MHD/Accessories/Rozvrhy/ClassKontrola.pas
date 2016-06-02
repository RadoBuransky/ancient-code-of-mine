unit ClassKontrola;

interface

uses StdCtrls, Windows, Classes;

type PZast = ^TZast;
     TZast = record
       Nazov : string;
       Sur : TPoint;
       Pasmo : byte;
     end;

     TKontrola = class
     private
       ListBox : TListBox;
       MemoChyby : TMemo;
       LabelZast, LabelLinky : TLabel;
       Zastavky : TList;

       PocetLiniek : word;

       procedure PrejdiDatoveSubory;
         function UpravNazov( Nazov : string ) : string;
         procedure PrejdiSubor( iCesta : string );
       procedure ZoradZastavky;
     public
       constructor Create( iListBox : TListBox; iMemoChyby : TMemo;
                           iLabelPocetZast, iLabelPocetLiniek : TLabel );
       destructor Destroy; override;
     end;

implementation

uses SysUtils, Konstanty;

type PMinuty = ^TMinuty;
     TStav = (Plus,Minus,Normal);
     TMinuty = record
       Stav : TStav;
       Cas : integer;
       Next : PMinuty;
     end;

//==============================================================================
//==============================================================================
//
//                                Constructor
//
//==============================================================================
//==============================================================================

constructor TKontrola.Create( iListBox : TListBox; iMemoChyby : TMemo;
                              iLabelPocetZast, iLabelPocetLiniek : TLabel );
begin
  inherited Create;
  ListBox := iListBox;
  MemoChyby := iMemoChyby;
  LabelZast := iLabelPocetZast;
  LabelLinky := iLabelPocetLiniek;

  Zastavky := TList.Create;

  PocetLiniek := 0;

  PrejdiDatoveSubory;
  ZoradZastavky;

  LabelZast.Caption := 'PoËet zast·vok : '+IntToStr( Zastavky.Count );
  LabelLinky.Caption := 'PoËet liniek : '+IntToStr( PocetLiniek );
end;

//==============================================================================
//==============================================================================
//
//                                 Destructor
//
//==============================================================================
//==============================================================================

destructor TKontrola.Destroy;
var I : integer;
begin
  for I := 0 to Zastavky.Count-1 do
    Dispose( PZast( Zastavky[I] ) );

  Zastavky.Free;

  inherited;
end;

//==============================================================================
//==============================================================================
//
//                              Praca so subormi
//
//==============================================================================
//==============================================================================

function TKontrola.UpravNazov( Nazov : string ) : string;
var I : integer;
begin
  I := 1;
  while (Nazov[I] = ' ') or
        (Nazov[I] = 'z') do
          Delete( Nazov , i , 1 );
  Result := Nazov;
end;

procedure TKontrola.PrejdiSubor( iCesta : string );
var S : string;
    CisloLinky : string;
    I, J, N : integer;
    A : PMinuty;

    Vzdialenost, Pasmo : integer;

    PNewZast : PZast;

function NacitajMinuty : PMinuty;
var c : char;
    S : string;
begin
  Result := nil;

  Read( c );
  while (c = ' ') and
        (not EoLn( Input )) do
    Read( c );
  if EoLn( Input ) then
    begin
      readln;
      exit;
    end;

  S := c;
  repeat
    Read( c );
    if c <> ' ' then S := S + c;
  until (c = ' ') or
        (EoLn( Input ));

  if EoLn( Input ) then readln;

  if S = '-1' then exit;

  New( Result );

  c := S[Length(S)];
  case c of
    '+' : begin
            Result^.Stav := Plus;
            Delete( S , Length(S) , 1 );
          end;
    '-' : begin
            Result^.Stav := Minus;
            Delete( S , Length(S) , 1 );
          end;
    else Result^.Stav := Normal;
  end;

  Result^.Cas := StrToInt( S );
  Result^.Next := nil;
end;

begin
  AssignFile( Input , ROZVRHY_DIR+'\'+iCesta );
  Reset( Input );

  // MemoChyby.Lines.Add( 'C:\Delphi\Mhd\'+ROZVRHY_DIR+iCesta );

  Readln( CisloLinky );
  try
    StrToInt( CisloLinky );
  except
    MemoChyby.Lines.Add( 'Nespr·vne ËÌslo linky : '+CisloLinky );
  end;

  Readln( S );
  if (S <> 'A') and
     (S <> 'E') and
     (S <> 'T') and
     (S <> 'N') then
       MemoChyby.Lines.Add( 'Nespr·vny typ spoja : '+CisloLinky );

  Readln( S );
  Readln( S );

  Readln( Vzdialenost , Pasmo , S );
  repeat
    New( PNewZast );
    Zastavky.Add( PNewZast );

    with PNewZast^ do
      begin
        Nazov := UpravNazov( S );
        Sur.X := 0;
        Sur.Y := 0;
        Pasmo := Pasmo;
      end;

    for I := 0 to ListBox.Items.Count-1 do
      if (ListBox.Items.Strings[I] = PNewZast^.Nazov) and
         (ListBox.Selected[I]) then
           MemoChyby.Lines.Add( 'N·jden˝ n·zov hæadanej zast·vky : '+PNewZast^.Nazov+' v s˙bore '+iCesta );

    Readln( Vzdialenost , Pasmo , S );
  until UpravNazov( S ) = 'KONIEC';

  Readln( N );

  for I := 1 to N do
    for J := 0 to 23 do
      begin
        repeat
          A := NacitajMinuty;
          if A = nil then break;

          if (A^.Cas > 59) or
             (EoLn( Input )) then
            begin
              MemoChyby.Lines.Add( 'Chyba v rozvrhu :' );
              MemoChyby.Lines.Add( 'Linka ËÌslo '+CisloLinky );
              MemoChyby.Lines.Add( '»asù : '+IntToStr( I ) );
              MemoChyby.Lines.Add( 'Hodina : '+IntToStr( J ) );
            end;

          Dispose( A );
        until (A^.Cas = -1) or
              (EoF( Input) );

        if (J < 23) and
           (EoF( Input ) ) then
             begin
               MemoChyby.Lines.Add( 'PredËasn˝ koniec s˙boru '+iCesta );
               break;
             end;
      end;

  if not EoF( Input ) then MemoChyby.Lines.Add( 'NeËakane dlh˝ s˙bor '+iCesta );

  // MemoChyby.Lines.Add( '' );

  CloseFile( Input );
end;

procedure TKontrola.PrejdiDatoveSubory;
var SearchRec : TSearchRec;
begin
  if FindFirst( ROZVRHY_DIR+'\*.mhd' , faAnyFile , SearchRec ) <> 0 then
    begin
      MemoChyby.Lines.Add( 'Nebol n·jden˝ ûiadny d·tov˝ s˙bor' );
      exit;
    end;

  Inc( PocetLiniek );
  PrejdiSubor( SearchRec.Name );

  while FindNext( SearchRec ) = 0 do
    begin
      Inc( PocetLiniek );
      PrejdiSubor( SearchRec.Name );
    end;

  FindClose( SearchRec );
end;

function Porovnaj( P1, P2 : pointer ) : integer;
var S1, S2 : string;
begin
  S1 := string( P1^ );
  S2 := string( P2^ );

  Result := 0;

  if S1 < S2 then Result := -1;
  if S1 > S2 then Result := 1;
end;

procedure TKontrola.ZoradZastavky;
var I : integer;
begin
  Zastavky.Sort( Porovnaj );

  for I := 1 to Zastavky.Count-1 do
    if (TZast( Zastavky[I-1]^ ).Nazov = TZast( Zastavky[I]^ ).Nazov) then
      begin
        Dispose( PZast( Zastavky[I-1] ) );
        Zastavky[I-1] := nil;
      end;

  Zastavky.Pack;

  ListBox.Clear;
  for I := 0 to Zastavky.Count-1 do
    ListBox.Items.Add( TZast( Zastavky[I]^ ).Nazov );
end;

end.
