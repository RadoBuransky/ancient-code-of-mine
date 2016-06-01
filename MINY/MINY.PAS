uses crt,graph,ini,mouse;

const n : byte = 5;
      pocet_min : byte = 10;
      sirka : byte = 30; {sirka policka miny}
      koniec : boolean = false;
      vybuch : boolean = false;
      uhadnute : byte = 0;

var pole_min : array[0..100,0..100] of byte;
    {1 : je tam mina
     0 : tam mina nie je}
    pole : array[1..100,1..100] of byte;
    {0 : nestlacene
     1 : stlacene
     2 : oznacene}

procedure zorad_miny;
var a,x,y : byte;
begin
  for a := 0 to n+1 do
    for x := 0 to n+1 do
      pole_min[a,x] := 0;

  for a := 1 to n do
    for x := 1 to n do
      pole[a,x] := 0;

  randomize;
  for a := 1 to pocet_min do
    begin
      x := 1+random(n);
      y := 1+random(n);
      if pole_min[x,y] = 0 then pole_min[x,y] := 1
                           else a := a - 1;
    end;
end;

function kolko(x,y : byte) : string;
var poc : byte;
    s : string;
begin
  poc := 0;
  if pole_min[x-1,y-1] = 1 then inc(poc);
  if pole_min[x-1,y] = 1 then inc(poc);
  if pole_min[x-1,y+1] = 1 then inc(poc);

  if pole_min[x+1,y-1] = 1 then inc(poc);
  if pole_min[x+1,y] = 1 then inc(poc);
  if pole_min[x+1,y+1] = 1 then inc(poc);

  if pole_min[x,y-1] = 1 then inc(poc);
  if pole_min[x,y+1] = 1 then inc(poc);

  Str(poc,s);

  kolko := s;
end;

procedure ukaz_minu(x,y : integer; a : byte; je : boolean);

begin
  setcolor(4);
  rectangle(x,y,x+sirka,y+sirka);

  setcolor(4);
  rectangle(x+5,y+5,x+sirka-5,y+sirka-5);

  line(x,y,x+5,y+5);
  line(x+sirka,y,x+sirka-5,y+5);
  line(x+sirka,y+sirka,x+sirka-5,y+sirka-5);
  line(x,y+sirka,x+5,y+sirka-5);

  case a of
    0 : begin
          setfillstyle(1,3);
          floodfill(x+5,y+2,4);
          floodfill(x+2,y+5,4);

          setfillstyle(1,1);
          floodfill(x+sirka-3,y+5,4);
          floodfill(x+5,y+sirka-3,4);
        end;
    1 : begin
          setfillstyle(1,1);
          floodfill(x+5,y+2,4);
          floodfill(x+2,y+5,4);

          setfillstyle(1,3);
          floodfill(x+sirka-3,y+5,4);
          floodfill(x+5,y+sirka-3,4);
        end;
  end;

  if je then setfillstyle(1,lightred)
        else setfillstyle(1,2);

  floodfill(x+sirka div 2,y+sirka div 2,4);

  if a = 2 then
    begin
      setcolor(0);
      line(x+17,y+17,x+sirka-17,y+sirka-17);
      line(x+sirka-17,y+17,x+17,y+sirka-17);
    end;

end;

procedure ukaz_vsetky_miny;
var a,b : byte;
begin
  for a := 0 to n-1 do
    for b := 0 to n-1 do
      ukaz_minu((getmaxx div 2)-((n div 2) *sirka)+(sirka*a),
                (getmaxy div 2)-((n div 2) *sirka)+(sirka*b),pole[a+1,b+1],false);
end;

procedure paleta;
begin
  rgb(0,0,0,0);
  rgb(1,20,20,20);
  rgb(2,40,40,40);
  rgb(3,50,50,50);
  rgb(4,60,60,60);
end;

procedure citaj_mys;
var x,y,tlac : word;

procedure kontrola;
var kx,ky : integer;
begin
  if (x > (640 div 2)-((n div 2) *sirka)) and
     (y > (480 div 2)-((n div 2) *sirka)) and
     (x < (640 div 2)-((n div 2) *sirka)+(sirka*n)) and
     (y < (480 div 2)-((n div 2) *sirka)+(sirka*n)) then
       begin
         kx := (x - ((640 div 2)-((n div 2) *sirka))) div sirka + 1;
         ky := (y - ((480 div 2)-((n div 2) *sirka))) div sirka + 1;
         if (pole[kx,ky] = 0) and (tlac = 1) then
           begin
             pole[kx,ky] := 1;
             if pole_min[kx,ky] = 1 then vybuch := true;
             hidemouse;
             ukaz_minu((getmaxx div 2)-((n div 2) *sirka)+(sirka*(kx-1)),
                       (getmaxy div 2)-((n div 2) *sirka)+(sirka*(ky-1)),
                       pole[kx,ky],vybuch);
             if not vybuch then
               begin
                 setcolor(0);
                 outtextxy( (640 div 2)-((n div 2) *sirka)+(sirka*(kx-1))
                            + (sirka div 2) - 4,
                            (480 div 2)-((n div 2) *sirka)+(sirka*(ky-1))
                            + (sirka div 2) - 4,
                           kolko(kx,ky));
               end;
             if vybuch then koniec := true;
             vybuch := false;
             showmouse;
           end;

         if ((pole[kx,ky] = 0) or
             (pole[kx,ky] = 2)) and
             (tlac = 2) then
           begin
             if pole[kx,ky] = 0 then pole[kx,ky] := 2
                                else pole[kx,ky] := 0;
             if (pole[kx,ky] = 2) and (pole_min[kx,ky] = 1) then
               Inc(uhadnute);
             if (pole[kx,ky] = 0) and (pole_min[kx,ky] = 1) then
               dec(uhadnute);
             hidemouse;
             ukaz_minu((getmaxx div 2)-((n div 2) *sirka)+(sirka*(kx-1)),
                       (getmaxy div 2)-((n div 2) *sirka)+(sirka*(ky-1)),
                       pole[kx,ky],false);
             showmouse;
           end;
       end;
end;

begin
  getmouse(tlac,x,y);
  {1 : lave
   2 : prave}
  if tlac <> 0 then kontrola;
end;

procedure vyhral_si;
var a : byte;
    r,g,b : byte;
    n : integer;
    paleta : array[0..255] of
      record
        r,g,b : byte;
      end;

Procedure GetPal(Col : Byte; Var R,G,B : Byte);
  { This gets the Red, Green and Blue values of a certain color }
BEGIN
     port[$3c7]:=Col;

     r:=port[$3c9];
     g:=port[$3c9];
     b:=port[$3c9];
END;

Procedure Pal(Col,R,G,B : Byte);
  { This sets the Red, Green and Blue values of a certain color }
BEGIN
     port[$3c8]:=Col;

     port[$3c9]:=r;
     port[$3c9]:=g;
     port[$3c9]:=b;
END;


begin

  for n := 0 to 255 do
    begin
      GetPal(n,r,g,b);
      paleta[n].r := r;
      paleta[n].g := g;
      paleta[n].b := b;
    end;


  outtextxy(10,10,'Vyhral si!');

  a := 0;
  repeat
    rgb(0,a,a div 2, 40);
    a := a + 1;
    if a = 64 then a := 0;
    delay(50);
  until keypressed;

  koniec := true;
  for n := 0 to 255 do Pal(n,paleta[n].r,paleta[n].g,paleta[n].b);
end;

procedure zadaj;
begin
  clrscr;
  write('Napis kolko stlpcov a riadkov ma mat minove pole : ');
  Readln(n);

  write('Napis kolko min ma byt skrytych : ');
  Readln(pocet_min);

  sirka := 440 div n;

end;

begin
  zadaj;

  resetmouse;
  init16;

  setcolor(4);
  outtextxy(174,5,'H l a d a n i e   M I N   -   v 1 . 0');

  paleta;

  zorad_miny;
  ukaz_vsetky_miny;

  showmouse;
  repeat
    citaj_mys;
    if keypressed then
      if readkey = #27 then koniec := true;
    if pocet_min = uhadnute then vyhral_si;
  until koniec;
  hidemouse;
  cleardevice;
  closegraph;
  writeln('Have a nice day.');
end.