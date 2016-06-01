uses crt,mouse;

const xg : integer = 40;
      yg : integer = 40;

      gula : array[0..3,0..3] of byte =
             ((0,1,1,0),
              (1,1,1,1),
              (1,1,1,1),
              (0,1,1,0));

      odr : array[0..4,0..19] of byte =
            ((0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0),
             (1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),
             (1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),
             (1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),
             (0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0));

var xgi,ygi : integer; {increase of THE GULA}
    xodr,yodr : word;
    sgx,sgy : integer;
    pole : array[1..28,1..32] of boolean;
    zacni : boolean;

procedure init_mcga; assembler;
asm
  mov ax,13h
  int 10h
end;

procedure init_premenne;
var a,b : byte;
begin
  xgi := 1;
  ygi := 1;
  xodr := 50;
  yodr := 169;
  setmouse(50,10);
  zacni := true;
  for a := 1 to 28 do
    for b := 1 to 32 do
      pole[a,b] := false;
  pole[1,1] := true;
  pole[2,2] := true;
  pole[3,1] := true;
end;

procedure pixel(x,y,color : integer);
begin
  mem[$a000:(y*320)+x] := color;
end;

Procedure Rgb(Col,R,G,B : Byte);
  { This sets the Red, Green and Blue values of a certain color }
BEGIN
     port[$3c8]:=Col;

     port[$3c9]:=r;
     port[$3c9]:=g;
     port[$3c9]:=b;
END;

procedure init_paletu;
var a : byte;
begin
  {farba gule = 100 + gula[a,b]}
  rgb(101,40,60,10);

  {farba odrazatka = 110 + odr[a,b]}
  rgb(111,50,20,10);

  {okolie}
  a := 18;
  rgb(50,0,0,a);
  rgb(51,5,5,5+a);
  rgb(52,10,10,10+a);
  rgb(53,15,15,15+a);
  rgb(54,20,20,20+a);
  rgb(55,25,25,25+a);
  rgb(56,30,30,30+a);
  rgb(57,35,35,35+a);
  rgb(58,40,40,40+a);
  rgb(59,45,45,45+a);

  {ram}
  rgb(60,20,30,10);
  rgb(61,30,40,20);
  rgb(62,40,50,30);
  rgb(63,50,60,40);
  rgb(64,60,63,50);
end;

procedure ukaz_policka;
var a,b,e : byte;

procedure nakresli(x,y : byte);
var c,d : byte;
begin
  case e of
    white : e := lightgreen;
    lightgreen : e := white;
  end;
  x := 30+((x-1)*10);
  y := 10+((y-1)*5);
  for c := 0 to 9 do
    for d := 0 to 4 do
      pixel(x+c,y+d,e);
end;

begin
  e := white;
  for a := 1 to 28 do
    for b := 1 to 32 do
      if pole[a,b] then nakresli(a,b);
end;

procedure init_obrazovku;
var a,b : integer;
    poc : byte;
    c : integer;
begin
  poc := 0;
  for a := 0 to 199 do
    begin
      if poc = 9 then c := -1;
      if poc = 0 then c := 1;
      for b := 0 to 319 do
        begin
          if ((b < 30) or (b > 309)) or
             ((a < 10) or (a > 179)) then pixel(b,a,50 + poc);
          inc(poc,c);
          if poc = 9 then c := -1;
          if poc = 0 then c := 1;
        end;
   end;

  for a := 25 to 29 do
    for b := 10-(29-a) to 179+(29-a) do
      begin
        pixel(a,b,89-a);
        pixel(339-a,b,89-a);
      end;

  for b := 5 to 9 do
    for a := 25+(b-5) to 314-(b-5) do
      begin
        pixel(a,b,69-b);
        pixel(a,189-b,69-b);
      end;
  ukaz_policka;
end;

procedure ukaz_gulu;
var a,b : byte;
begin
  for a := 0 to 3 do
    for b := 0 to 3 do
      if gula[a,b] <> 0 then pixel(xg+a,yg+b,100+gula[a,b])
                        else pixel(xg+a,yg+b,black);
end;

procedure zmaz_gulu;
var a,b : byte;
begin
  for a := 0 to 3 do
    for b := 0 to 3 do
      if gula[a,b] <> 0 then pixel(xg+a,yg+b,black)
end;

procedure zmaz_odr;
var a,b : byte;
begin
  for a := 0 to 19 do
    for b := 0 to 4 do
      if odr[b,a] <> 0 then pixel(xodr+a,yodr+b,black)
end;

procedure ukaz_odr;
var a,b : byte;
begin
  for a := 0 to 19 do
    for b := 0 to 4 do
      if odr[b,a] <> 0 then pixel(xodr+a,yodr+b,110+odr[b,a]);
end;

procedure ukaz_vsetko;
begin
  ukaz_gulu;
  ukaz_odr;
end;

procedure zmaz_vsetko;
begin
  zmaz_gulu;
end;

procedure prepocitaj_hodnoty;
var key,a,b : word;
    c : integer;
begin
  sgx := xg;
  sgy := yg;
  inc(xg,xgi);
  inc(yg,ygi);
  b := xodr;
  getmouse(key,xodr,a);
  c := 1;
  if (b <> xodr) then
    begin
      if zacni then
        begin
          c := xodr-b;
          if c < -3 then c := -3;
          if c > 3 then c := 3;
        end;
      a := xodr;
      xodr := b;
      zmaz_odr;
      xodr := a;
    end;
  if zacni and (key = 1) then
    begin
      zacni := false;
      xgi := c;
      ygi := -1;
    end;
  if zacni then
    begin
      xg := xodr + 8;
      yg := yodr - 5;
      xgi := 0;
      ygi := 0;
    end;
end;

procedure tukni;
begin
  Sound(3000);
  Delay(2);
  nosound;
end;

procedure kontrola;
var sxgi,sygi : integer;
    a,b : byte;
begin
  sxgi := xgi;
  sygi := ygi;

  a := ((xg-30) div 10) + 1;
  b := ((yg-10) div 5) + 1;

  if pole[a,b] then
    begin

    end;

  if (yg <= 10) or (yg >= 175) then ygi := -ygi;
  if (xg <= 30) or (xg >= 305) then xgi := -xgi;
  if (yg = 165) and ((xg >= xodr-2) and (xg <= xodr + 21)) then ygi := -ygi;
  if (sxgi <> xgi) or (sygi <> ygi) then
    begin
      tukni;
      inc(xg,xgi);
      inc(yg,ygi);
    end;
end;

begin
  clrscr;
  if not je_mys then
    begin
      Writeln('Nenasiel som mys!');
      halt;
    end;
  init_mcga;
  resetmouse;
  setmousex(30,290);
  setmousey(10,179);
  init_premenne;
  init_paletu;
  init_obrazovku;
  repeat
    ukaz_vsetko;
    delay(10);
    zmaz_vsetko;
    prepocitaj_hodnoty;
    kontrola;
  until keypressed;
end.