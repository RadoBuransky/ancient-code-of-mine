unit ClassVykres;

interface

uses Typy, ClassSustava, ExtCtrls, Graphics, Windows, SysUtils, Classes;

type
  TStyle = record
             Farba : TColor;
             Hrubka : integer;
           end;

  TVykres = class
  private
    Image : TImage; {Kam sa ma vsetko vykreslit - pointer na ImageVykres}
    Sustava : TSustava; {Odkial sa maju ziskat data na vykreslenie}

    Norm, Slct : TStyle; {Akym stylom sa ma kreslit}

    LavyHorny : TBod; {Suradnice laveho horneho rohu vykresu}
    PravyDolny : TBod; {Suradnice praveho dolneho rohu}

    FZoom : real; {Ake je aktualne zvacsenie}
    FPozicia : TBod; {Suradnice stredu image}
    FZobrazitNazvy : boolean; {Maju sa vykreslit aj nazvy objektov?}
    FZobrazitOsi : boolean; {Maju sa vykreslit osi suradnej sustavy?}

    procedure ZmenZoom( iZoom : real );
    procedure ZmenPoziciu( iPozicia : TBod );
    procedure ZmenZobrazitNazvy( iZobrazitNazvy : boolean );
    procedure ZmenZobrazitOsi( iZobrazitOsi : boolean );

    {Pomocne procedury pre vykreslenie :}
    procedure NakresliOsi;

    procedure NakresliBody;
    procedure NakresliNUholniky;

  public
    procedure Prekresli; {Vsetko nakresli - NAJDOLEZITEJSIA PROCEDURA}

    {Prevod suradnic zo Sustavy na Image (a naopak):}
    function SusToIm( A : TBod ) : TPoint;
    function ImToSus( A : TPoint ) : TBod;

    constructor Create( iImage : TImage; iSustava : TSustava );
    destructor Destroy; override;

    property Zoom : real read FZoom write ZmenZoom;
    property Pozicia : TBod read FPozicia write ZmenPoziciu;
    property ZobrazitNazvy : boolean read FZobrazitNazvy write ZmenZobrazitNazvy;
    property ZobrazitOsi : boolean read FZobrazitOsi write ZmenZobrazitOsi;
  end;

implementation

uses Debugging;

//==============================================================================
//==============================================================================
//
//                                  Constructor
//
//==============================================================================
//==============================================================================

constructor TVykres.Create( iImage : TImage; iSustava : TSustava);
var Poz : TBod;
begin
  inherited Create;

  Napis( 'TVykres.Create' );
  Image := iImage;

  Sustava := iSustava;

  with Norm do
    begin
      Farba := clBlack;
      Hrubka := 1;
    end;

  with Slct do
    begin
      Farba := clBlue;
      Hrubka := 3;
    end;

  with Image.Canvas do
    begin
      Pen.Color := Norm.Farba;
      Pen.Width := Norm.Hrubka;
    end;

  FZoom := 1;
  with Poz do
    begin
      X := 0;
      Y := 0;
    end;
  Pozicia := Poz;

  FZobrazitNazvy := True;
  FZobrazitOsi := True;
end;

//==============================================================================
//==============================================================================
//
//                                    Destructor
//
//==============================================================================
//==============================================================================

destructor TVykres.Destroy;
begin
  inherited
end;


function TVykres.SusToIm( A : TBod ) : TPoint;
begin
  result.X := Round((A.X - LavyHorny.X) * Zoom);
  result.Y := Round((LavyHorny.Y - A.Y) * Zoom);
end;

function TVykres.ImToSus( A : TPoint ) : TBod;
begin
  result.X := LavyHorny.X+(A.X / FZoom);
  result.Y := LavyHorny.Y+(A.Y / FZoom);
end;

procedure TVykres.ZmenZoom( iZoom : real );
begin
  FZoom := iZoom;

  LavyHorny.X := FPozicia.X-((Image.Width / 2) / FZoom);
  LavyHorny.Y := FPozicia.Y+((Image.Height / 2) / FZoom);

  PravyDolny.X := FPozicia.X+((Image.Width / 2) / FZoom);
  PravyDolny.Y := FPozicia.Y-((Image.Height / 2) / FZoom);

  Prekresli;
end;

procedure TVykres.ZmenPoziciu( iPozicia : TBod );
begin
  FPozicia := iPozicia;

  LavyHorny.X := FPozicia.X-((Image.Width / 2) / FZoom);
  LavyHorny.Y := FPozicia.Y+((Image.Height / 2) / FZoom);

  PravyDolny.X := FPozicia.X+((Image.Width / 2) / FZoom);
  PravyDolny.Y := FPozicia.Y-((Image.Height / 2) / FZoom);

  Prekresli;
end;

procedure TVykres.ZmenZobrazitNazvy( iZobrazitNazvy : boolean );
begin
  FZobrazitNazvy := iZobrazitNazvy;
  Prekresli;
end;

procedure TVykres.ZmenZobrazitOsi( iZobrazitOsi : boolean );
begin
  FZobrazitOsi := iZobrazitOsi;
  if iZobrazitOsi then NakresliOsi
                  else Prekresli;
end;

(*
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
||                                Kreslenie                                   ||
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
*)

procedure TVykres.NakresliOsi;
const MIN_SIRKA = 100;

var A : TBod;
    B : TPoint;
    K : real;

    Zaciatok, Pozicia : real;
begin
  with Image.Canvas do
    begin
      {Os Y:}
      if (LavyHorny.X < 0) and
         (PravyDolny.X > 0) then
           begin
             A.X := 0;
             A.Y := 0;
             MoveTo( SusToIm(A).X , 0 );
             LineTo( SusToIm(A).X , Image.Height );

             K := 10;
             if (K*Zoom < MIN_SIRKA) then
               begin
                 while (K*Zoom < MIN_SIRKA) do
                   K := K*2;
               end
                 else
               begin
                 while (K*Zoom > MIN_SIRKA) do
                   K := K/2;
               end;

             if K > 100000 then K := 100000;
             if K < 0.625 then K := 0.625;

             Zaciatok := (Int(LavyHorny.Y / K)+1)*K;
             Pozicia := Zaciatok;
             repeat
               A.X := 0;
               A.Y := Pozicia;

               B := SusToIm( A );

               MoveTo( B.X-1 , B.Y );
               LineTo( B.X+2 , B.Y );

               if Pozicia <> 0 then TextOut( B.X+2 , B.Y-2 , FloatToStr( Pozicia ) );

               Pozicia := Pozicia - K;
             until Pozicia < PravyDolny.Y;
           end;

      {Os X:}
      if (LavyHorny.Y > 0) and
         (PravyDolny.Y < 0) then
           begin
             A.X := 0;
             A.Y := 0;
             MoveTo( 0 , SusToIm(A).Y );
             LineTo( Image.Width , SusToIm(A).Y );

             K := 10;
             if (K*Zoom < MIN_SIRKA) then
               begin
                 while (K*Zoom <= MIN_SIRKA) do
                   K := K*2;
               end
                 else
               begin
                 while (K*Zoom > MIN_SIRKA) do
                   K := K/2;
               end;

             if K > 100000 then K := 100000;
             if K < 0.625 then K := 0.625;

             Zaciatok := (Int(LavyHorny.X / K)-1)*K;
             Pozicia := Zaciatok;
             repeat
               A.X := Pozicia;
               A.Y := 0;

               B := SusToIm( A );

               MoveTo( B.X , B.Y-2 );
               LineTo( B.X , B.Y+2 );

               TextOut( B.X-2 , B.Y+2 , FloatToStr( Pozicia ) );

               Pozicia := Pozicia + K;
             until Pozicia > PravyDolny.X;
           end;
    end;
end;

procedure TVykres.NakresliBody;
var I : integer;
    A : TPoint;
    B : TBod;
begin
  for I := 0 to Sustava.Body.Pole.Count-1 do
    if (TBod( Sustava.Body.Pole[I]^ ).X >= LavyHorny.X) and
       (TBod( Sustava.Body.Pole[I]^ ).X <= PravyDolny.X) and
       (TBod( Sustava.Body.Pole[I]^ ).Y <= LavyHorny.Y) and
       (TBod( Sustava.Body.Pole[I]^ ).Y >= PravyDolny.Y) then
      begin
        B.X := TBod( Sustava.Body.Pole[I]^ ).X;
        B.Y := TBod( Sustava.Body.Pole[I]^ ).Y;
        B.Nazov := TBod( Sustava.Body.Pole[I]^ ).Nazov;

        A := SusToIm( B );

        Image.Canvas.MoveTo( A.X-2 , A.Y-2 );
        Image.Canvas.LineTo( A.X+3 , A.Y+3 );

        Image.Canvas.MoveTo( A.X+2 , A.Y-2 );
        Image.Canvas.LineTo( A.X-3 , A.Y+3 );

        if ZobrazitNazvy then
          Image.Canvas.TextOut( A.X+3, A.Y , B.Nazov );
      end;
end;

procedure TVykres.NakresliNUholniky;
var I, J : integer;
    JeVidiet : boolean; {Ci je vidiet N-uholnik na obrazovke}
    A : TBod;
    B, B0 : TPoint;
begin
  for I := 0 to Sustava.NUholniky.Pole.Count-1 do
    begin
      JeVidiet := False;
      for J := 0 to TNuholnik( Sustava.NUholniky.Pole[I]^ ).Body.Count-1 do
        if (TBod( TNuholnik( Sustava.NUholniky.Pole[I]^ ).Body[J]^ ).X >= LavyHorny.X) and
           (TBod( TNuholnik( Sustava.NUholniky.Pole[I]^ ).Body[J]^ ).X <= PravyDolny.X) and
           (TBod( TNuholnik( Sustava.NUholniky.Pole[I]^ ).Body[J]^ ).Y <= LavyHorny.Y) and
           (TBod( TNuholnik( Sustava.NUholniky.Pole[I]^ ).Body[J]^ ).Y >= PravyDolny.Y) then
             begin
               JeVidiet := True;
               break;
             end;
      if not JeVidiet then continue;

      for J := 0 to TNuholnik( Sustava.NUholniky.Pole[I]^ ).Body.Count-1 do
        begin
          A := TBod( TNuholnik( Sustava.NUholniky.Pole[I]^ ).Body[I]^ );
          B := SusToIm( A );
          if J = 0 then
            begin
              Image.Canvas.MoveTo( B.X , B.Y );
              B0 := B;
            end
              else Image.Canvas.LineTo( B.X , B.Y );
        end;
      Image.Canvas.LineTo( B0.X , B0.Y );
      
    end;
end;

procedure TVykres.Prekresli;
begin
  Image.Canvas.FillRect( Image.ClientRect );

  with Image.Canvas do
    begin
      Pen.Color := Norm.Farba;
      Pen.Width := Norm.Hrubka;
    end;

  NakresliBody;
  NakresliNUholniky;

  if ZobrazitOsi then NakresliOsi;
end;

end.
