unit ClassHrac;

interface

uses Graphics, Typy;

type THrac = class
     private
       Pole : PPole;
     protected
       function MoznoPolozit( iX, iY, iCislo : integer ) : boolean;
       function HodnotaTahu( iX, iY, iCislo : integer ) : integer;
     public
       Farba : TColor;
 
       function UrobTah : TSur; virtual; abstract;

       constructor Create( iFarba : TColor; iPole : PPole );
       destructor Destroy; override;
     end;

implementation

//==============================================================================
//==============================================================================
//
//                                 Constructor
//
//==============================================================================
//==============================================================================

constructor THrac.Create( iFarba : TColor; iPole : PPole );
begin
  inherited Create;
  Farba := iFarba;
  Pole := iPole;
end;

//==============================================================================
//==============================================================================
//
//                                   Destructor
//
//==============================================================================
//==============================================================================

destructor THrac.Destroy;
begin
  inherited;
end;

//==============================================================================
//==============================================================================
//
//                               Pomocne procedury
//
//==============================================================================
//==============================================================================

function THrac.MoznoPolozit( iX , iY, iCislo : integer ) : boolean;
var I : integer;
begin
  result := False;

  //Dolava
  for I := iX-1 downto 1 do
    if Pole[I,iY] = 0 then break
                      else
                        if Pole[I,iY] = iCislo then
                          begin
                            if I = iX-1 then break;
                            result := True;
                            exit;
                          end;

  //Doprava
  for I := iX+1 to 14 do
    if Pole[I,iY] = 0 then break
                      else
                        if Pole[I,iY] = iCislo then
                          begin
                            if I = iX+1 then break;
                            result := True;
                            exit;
                          end;

  //Hore
  for I := iY-1 downto 1 do
    if Pole[iX,I] = 0 then break
                      else
                        if Pole[iX,I] = iCislo then
                          begin
                            if I = iY-1 then break;
                            result := True;
                            exit;
                          end;

  //Dole
  for I := iY+1 to 14 do
    if Pole[iX,I] = 0 then break
                      else
                        if Pole[iX,I] = iCislo then
                          begin
                            if I = iY+1 then break;
                            result := True;
                            exit;
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
                                   if I = 1 then break;
                                   result := True;
                                   exit;
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
                                   if I = 1 then break;
                                   result := True;
                                   exit;
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
                                   if I = 1 then break;
                                   result := True;
                                   exit;
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
                                   if I = 1 then break;
                                   result := True;
                                   exit;
                                 end;
      Inc(I);
    end;
end;

function THrac.HodnotaTahu( iX, iY, iCislo : integer ) : integer;
var I : integer;
    Cislo2 : integer;
begin
  Cislo2 := -iCislo+3;
  result := 2;

  //Rohy :
  if ((iX = 1) and (iY = 1)) or
     ((iX = 1) and (iY = 14)) or
     ((iX = 14) and (iY = 1)) or
     ((iX = 14) and (iY = 14)) then
       Inc( Result , 1000 );

  //Okraje :
  if (iX = 1) or
     (iX = 14) or
     (iY = 1) or
     (iY = 14) then
       Inc( Result , 100 );

  //Dolava
  for I := iX-1 downto 1 do
    if Pole[I,iY] = 0 then break
                       else
                         if Pole[I,iY] = iCislo then
                           begin
                             if I = 1 then Inc( Result , 100 )
                                      else
                                        if (Pole[I-1,iY] = Cislo2) and
                                           (iX < 14) then
                                             Dec( Result , 50 );
                             Inc( Result , iX-I-1 );
                             break;
                           end;

  //Doprava
  for I := iX+1 to 14 do
    if Pole[I,iY] = 0 then break
                      else
                        if Pole[I,iY] = iCislo then
                          begin
                            if I = 14 then Inc( Result , 100 )
                                      else
                                        if (Pole[I+1,iY] = Cislo2) and
                                           (iX > 1) then
                                             Dec( Result , 50 );
                            Inc( Result , I-iX-1 );
                            break;
                          end;

  //Hore
  for I := iY-1 downto 1 do
    if Pole[iX,I] = 0 then break
                      else
                        if Pole[iX,I] = iCislo then
                          begin
                            if I = 1 then Inc( Result , 100 )
                                     else
                                       if (Pole[iX,I-1] = Cislo2) and
                                          (iY < 14) then
                                            Dec( Result , 50 );
                            Inc( Result , iY-I-1 );
                            break;
                          end;

  //Dole
  for I := iY+1 to 14 do
    if Pole[iX,I] = 0 then break
                      else
                        if Pole[iX,I] = iCislo then
                          begin
                            if I = 14 then Inc( Result , 100 )
                                      else
                                        if (Pole[iX,I+1] = Cislo2) and
                                           (iY > 1) then
                                             Dec( Result , 50 );
                            Inc( Result , I-iY-1 );
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
                                   if (iX-I = 1) or
                                      (iY-I = 1) then Inc( Result , 100 );
                                   Inc( Result , I-1 );
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
                                   if (iX+I = 14) or
                                      (iY-I = 1) then Inc( Result , 100 );
                                   Inc( Result , I-1 );
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
                                   if (iX+I = 14) or
                                      (iY+I = 14) then Inc( Result , 100 );
                                   Inc( Result , I-1 );
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
                                   if (iX-I = 1) or
                                      (iY+I = 14) then Inc( Result , 100 );
                                   Inc( Result , I-1 );
                                   break;
                                 end;
      Inc(I);
    end;
end;

end.
