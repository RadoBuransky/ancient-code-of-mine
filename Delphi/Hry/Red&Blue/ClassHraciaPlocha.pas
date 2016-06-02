unit ClassHraciaPlocha;

interface

uses Forms, ExtCtrls, Graphics, ClassClovek, ClassPocitac, Typy;

type THraciaPlocha = class
     private
       Pole : TPole;
       Image, Stav : TImage;

       PocetKamenov1, PocetKamenov2 : integer;

       Clovek : TClovek;
       Pocitac : TPocitac;

     protected
       procedure InicializaciaPlochy;

       procedure Poloz( iX , iY, Cislo : integer; iFarba : TColor );
       procedure PolozKamen( iX , iY, iCislo : integer; iFarba : TColor );

       procedure UpdateStav;
     public
       X, Y : integer;
       NaTahu : integer; {1 - Clovek, 2 - Comp}

       constructor Create( iX , iY : integer; iImage, iStav : TImage );
       destructor Destroy; override;

       procedure NovaHra;

       function Volno( iX , iY : integer ) : boolean;
     end;

implementation

uses FormHlavneOkno;

//==============================================================================
//==============================================================================
//
//                                 Inicializacia
//
//==============================================================================
//==============================================================================

procedure THraciaPlocha.InicializaciaPlochy;
var I : integer;
begin
  NaTahu := 0;

  FillChar( Pole , SizeOf( Pole ) , $00 );

  //Inicializacia Image
  with Image.Canvas do
    begin
      Pen.Color := clGray;
      Brush.Color := clBlack;

      FillRect( Image.ClientRect );
      for I := 1 to X-1 do
        begin
          MoveTo( Round( I*(Image.Width / X) ) , 0 );
          LineTo( Round( I*(Image.Width / X) ) , Image.Height );
        end;

      for I := 1 to Y-1 do
        begin
          MoveTo( 0 ,Round( I*(Image.Height / Y) ) );
          LineTo( Image.Width , Round( I*(Image.Height / Y) ) );
        end;
    end;

  PolozKamen( 7 , 7 , 1 , clBlue );
  PolozKamen( 8 , 8 , 1 , clBlue );
  PolozKamen( 7 , 8 , 2 , clRed );
  PolozKamen( 8 , 7 , 2 , clRed );
end;

//==============================================================================
//==============================================================================
//
//                                 Constructor
//
//==============================================================================
//==============================================================================

constructor THraciaPlocha.Create( iX , iY : integer; iImage, iStav : TImage );
begin
  inherited Create;
  X := iX;
  Y := iY;
  Image := iImage;
  Stav := iStav;
  Clovek := TClovek.Create( clBlue , @Pole );
  Pocitac := TPocitac.Create( clRed , @Pole );
end;

//==============================================================================
//==============================================================================
//
//                                 Destructor
//
//==============================================================================
//==============================================================================

destructor THraciaPlocha.Destroy;
begin
  Clovek.Free;
  Pocitac.Free;
  inherited;
end;

//==============================================================================
//==============================================================================
//
//                                   Hra
//
//==============================================================================
//==============================================================================

procedure THraciaPlocha.NovaHra;
var Sur : TSur;
    Nepolozil : integer;
begin
  PocetKamenov1 := 0;
  PocetKamenov2 := 0;

  InicializaciaPlochy;

  HlavneOkno.KoniecHry := 0;
  HlavneOkno.Vitaz := -1;

  Nepolozil := 0;
  repeat

    NaTahu := 1;
    Sur := Clovek.UrobTah;
    if (Sur.X > 0) and
       (Sur.Y > 0) then
         begin
           PolozKamen( Sur.X , Sur.Y , 1 , Clovek.Farba );
           Nepolozil := 0;
         end
           else
         Inc( Nepolozil );
    if HlavneOkno.KoniecHry = 1 then break;
    if (PocetKamenov1+PocetKamenov2 = X*Y) or
       (PocetKamenov1 = 0) or
       (PocetKamenov2 = 0) then
      begin
        HlavneOkno.KoniecHry := 2;
        break;
      end;

    NaTahu := 2;
    Sur := Pocitac.UrobTah;
    if (Sur.X > 0) and
       (Sur.Y > 0) then
         begin
           PolozKamen( Sur.X , Sur.Y , 2 , Pocitac.Farba );
           Nepolozil := 0;
         end
           else
         Inc( Nepolozil );
    if (PocetKamenov1+PocetKamenov2 = Y*X) or
       (PocetKamenov1 = 0) or
       (PocetKamenov2 = 0) then HlavneOkno.KoniecHry := 2;

  until (HlavneOkno.KoniecHry > 0) or (Nepolozil > 1);

  case HlavneOkno.KoniecHry of
    1 : HlavneOkno.Close;
    2 : if PocetKamenov2 > PocetKamenov1 then HlavneOkno.VyhralSom( 2 )
                                                      else
                                                        if PocetKamenov2 < PocetKamenov1 then HlavneOkno.VyhralSom( 1 )
                                                                                                      else HlavneOkno.VyhralSom( 0 );
  end;
end;

//==============================================================================
//==============================================================================
//
//                            Polozenie kamenena
//
//==============================================================================
//==============================================================================

procedure THraciaPlocha.Poloz( iX , iY, Cislo : integer; iFarba : TColor );
begin
  case Pole[iX,iY] of
    0 : case Cislo of
          1 : Inc( PocetKamenov1 );
          2 : Inc( PocetKamenov2 );
        end;
    1 : begin
          Dec( PocetKamenov1 );
          Inc( PocetKamenov2 );
        end;
    2 : begin
          Inc( PocetKamenov1 );
          Dec( PocetKamenov2 );
        end;
  end;
  Pole[iX,iY] := Cislo;
  with Image.Canvas do
    begin
      Pen.Color := iFarba;
      Brush.Color := iFarba;
      Ellipse( Round( (iX-1) * (Image.Width / X ))+1 ,
               Round( (iY-1) * (Image.Height / Y ))+1 ,
               Round( iX * (Image.Width / X ))-1 ,
               Round( iY * (Image.Height / Y ))-1 );
    end;
end;

procedure THraciaPlocha.PolozKamen( iX , iY, iCislo : integer; iFarba : TColor );
var I, J : integer;
begin
  Poloz( iX , iY , iCislo , iFarba );

  //Dolava
  for I := iX-1 downto 1 do
    if Pole[I,iY] = 0 then break
                      else
                        if Pole[I,iY] = iCislo then
                          begin
                            for J := I+1 to iX-1 do
                              Poloz( J , iY , iCislo , iFarba );
                            break;
                          end;

  //Doprava
  for I := iX+1 to 14 do
    if Pole[I,iY] = 0 then break
                      else
                        if Pole[I,iY] = iCislo then
                          begin
                            for J := I-1 downto iX+1 do
                              Poloz( J , iY , iCislo , iFarba );
                            break;
                          end;

  //Hore
  for I := iY-1 downto 1 do
    if Pole[iX,I] = 0 then break
                      else
                        if Pole[iX,I] = iCislo then
                          begin
                            for J := I+1 to iY-1 do
                              Poloz( iX , J , iCislo , iFarba );
                            break;
                          end;

  //Dole
  for I := iY+1 to 14 do
    if Pole[iX,I] = 0 then break
                      else
                        if Pole[iX,I] = iCislo then
                          begin
                            for J := I-1 downto iY+1 do
                              Poloz( iX , J , iCislo , iFarba );
                            break;
                          end;

  //Dolava-hore
  I := 1;
  while (iX-I > 0) and
        (iY-I > 0) do
    begin
      if Pole[iX-I,iY-I] = 0 then break
                             else
                               if Pole[iX-I,iY-I] = iCislo then
                                 begin
                                   for J := I-1 downto 1 do
                                     Poloz( iX-J , iY-J , iCislo , iFarba );
                                   break;
                                 end;
      Inc(I);
    end;

  //Doprava-hore
  I := 1;
  while (iX+I < 15) and
        (iY-I > 0) do
    begin
      if Pole[iX+I,iY-I] = 0 then break
                             else
                               if Pole[iX+I,iY-I] = iCislo then
                                 begin
                                   for J := I-1 downto 1 do
                                     Poloz( iX+J , iY-J , iCislo , iFarba );
                                   break;
                                 end;
      Inc(I);
    end;

  //Doprava-dole
  I := 1;
  while (iX+I < 15) and
        (iY+I < 15) do
    begin
      if Pole[iX+I,iY+I] = 0 then break
                             else
                               if Pole[iX+I,iY+I] = iCislo then
                                 begin
                                   for J := I-1 downto 1 do
                                     Poloz( iX+J , iY+J , iCislo , iFarba );
                                   break;
                                 end;
      Inc(I);
    end;

  //Dolava-dole
  I := 1;
  while (iX-I > 0) and
        (iY+I < 15) do
    begin
      if Pole[iX-I,iY+I] = 0 then break
                             else
                               if Pole[iX-I,iY+I] = iCislo then
                                 begin
                                   for J := I-1 downto 1 do
                                     Poloz( iX-J , iY+J , iCislo , iFarba );
                                   break;
                                 end;
      Inc(I);
    end;

  if iCislo = 2 then UpdateStav;
end;

//==============================================================================
//==============================================================================
//
//                                      Stav
//
//==============================================================================
//==============================================================================

procedure THraciaPlocha.UpdateStav;
var A, B : integer;
begin
  // 0...1 = Pocitac...Clovek
  A := PocetKamenov1;
  B := PocetKamenov2;
  HlavneOkno.UkazStav( A/(A+B) , A , B );
end;

//==============================================================================
//==============================================================================
//
//                                Pomocne procedury
//
//==============================================================================
//==============================================================================

function THraciaPlocha.Volno( iX , iY : integer ) : boolean;
begin
  if Pole[iX,iY] = 0 then result := True
                     else result := False;
end;

end.
