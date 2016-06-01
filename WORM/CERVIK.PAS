program cervik;

uses crt,mcga256,graph;

const max_dlz = 15000; {maximalna dlzka}

var cerv : array[1..max_dlz] of record
                               x,y : word;
                             end;
    zmaz : record
             x,y : word;
           end;
    dlzka,a : word;
    predlz : byte;
    key : char;
    smer : shortint;
    opit : real;

Procedure GetRGB(Col : Byte; Var R,G,B : Byte);
BEGIN
     port[$3c7]:=Col;

     r:=port[$3c9];
     g:=port[$3c9];
     b:=port[$3c9];
END;


procedure nakresli;
var b,d : word;
    c : byte;
begin
  Putpixel(zmaz.x,zmaz.y,black);
  d := 1;
  c := 1;
  for b := 1 to dlzka-1 do
    begin
      if d < 12 then c := c + 1;
      if d >= 12 then c := c - 1;
      Putpixel(cerv[b].x,cerv[b].y,c);
      inc(d);
      if d = 23 then d := 1;
    end;
end;

procedure mrtvy;
begin
  halt;
end;

procedure hyb;
var b : byte;
begin
  b := 0;
  if predlz > 0 then
    begin
      b := 1;
      Dec(predlz);
    end;
  zmaz.x := cerv[dlzka].x;
  zmaz.y := cerv[dlzka].y;
  dlzka := dlzka + b;
  for a := dlzka downto 2 do
    begin
      cerv[a].x := cerv[a-1].x;
      cerv[a].y := cerv[a-1].y;
    end;
  case smer of
     1 : Dec(cerv[1].y);
     2 : begin
           Inc(cerv[1].x);
           opit := opit + 70;
           if opit > 360 then opit := opit - 360;
           cerv[1].y := cerv[1].y + Round(Sin(pi/180*opit));
         end;
     3 : Inc(cerv[1].y);
     4 : Dec(cerv[1].x);
  end;
  if (cerv[1].x < 5) or
     (cerv[1].x > 315) or
     (cerv[1].y < 11) or
     (cerv[1].y > 195) then mrtvy;
end;

procedure doska;
var a,b : integer;
begin
  for a := 1 to 10 do
    for b := 1 to 319 do
      mem[$a000:(a*320)+b] := 26-Random(13);
  for a := 10 to 199 do
    for b := 1 to 5 do
      mem[$a000:(a*320)+b] := 26-Random(13);
  for a := 10 to 199 do
    for b := 315 to 319 do
      mem[$a000:(a*320)+b] := 26-Random(13);
  for a := 195 to 199 do
    for b := 1 to 319 do
      mem[$a000:(a*320)+b] := 26-Random(13);

  for a := 2 to 198 do
      mem[$a000:(a*320)+1] := mem[$a000:(a*320)+1]+13;

  for a := 11 to 194 do
      mem[$a000:(a*320)+315] := mem[$a000:(a*320)+315]+13;

  for a := 1 to 317 do
      mem[$a000:(1*320)+a] := mem[$a000:(1*320)+a]+13;

  for a := 6 to 314 do
      mem[$a000:(195*320)+a] := mem[$a000:(195*320)+a]+13;

  for a := 6 to 314 do
      mem[$a000:(10*320)+a] := mem[$a000:(10*320)+a]+26;

  for a := 2 to 318 do
      mem[$a000:(199*320)+a] := mem[$a000:(199*320)+a]+26;

  for a := 10 to 195 do
      mem[$a000:(a*320)+5] := mem[$a000:(a*320)+5]+26;

  for a := 1 to 199 do
      mem[$a000:(a*320)+319] := mem[$a000:(a*320)+319]+26;
end;

procedure init_paletu;
begin
  RGB(0,0,0,0);

  RGB(1,5,5,45);
  RGB(2,10,10,46);
  RGB(3,15,15,47);
  RGB(4,20,20,48);
  RGB(5,25,25,49);
  RGB(6,30,30,50);
  RGB(7,35,35,51);
  RGB(8,40,40,52);
  RGB(9,45,45,53);
  RGB(10,50,50,54);
  RGB(11,55,55,55);
  RGB(12,60,60,56);
  RGB(13,63,63,57);

  RGB(14,0,40,35);
  RGB(15,5,41,35);
  RGB(16,10,42,35);
  RGB(17,15,43,35);
  RGB(18,20,44,35);
  RGB(19,25,45,35);
  RGB(20,30,46,35);
  RGB(21,35,47,40);
  RGB(22,40,48,40);
  RGB(23,45,49,40);
  RGB(24,50,50,40);
  RGB(25,55,51,40);
  RGB(26,60,52,40);

  RGB(27,15,55,50);
  RGB(28,20,56,50);
  RGB(29,25,57,50);
  RGB(30,30,58,50);
  RGB(31,35,59,50);
  RGB(32,40,60,50);
  RGB(33,45,61,50);
  RGB(34,50,62,55);
  RGB(35,55,63,55);
  RGB(36,60,63,55);
  RGB(37,63,63,55);
  RGB(38,63,63,55);
  RGB(39,63,63,55);

  RGB(40,0,25,20);
  RGB(41,0,26,20);
  RGB(42,0,27,20);
  RGB(43,0,28,20);
  RGB(44,5,29,20);
  RGB(45,10,30,20);
  RGB(46,15,31,20);
  RGB(47,20,32,25);
  RGB(48,25,33,25);
  RGB(49,30,34,25);
  RGB(50,35,35,25);
  RGB(51,40,36,25);
  RGB(52,45,37,25);
end;

procedure pause;
begin

end;

begin
  clrscr;
  randomize;
  for a := 1 to max_dlz do
    begin
      cerv[a].x := 0;
      cerv[a].y := 0;
    end;
  dlzka := 0;
  predlz := 200;
  smer := 1;
  init;
  doska;
  cerv[1].x := 160;
  cerv[1].y := 100;
  opit := 0;
  repeat
    hyb;
    Delay(20);
    nakresli;
    key := #0;
    if keypressed then
      key := readkey;
    case key of
      #72 : if smer <> 3 then smer := 1;
      #77 : if smer <> 4 then smer := 2;
      #80 : if smer <> 1 then smer := 3;
      #75 : if smer <> 2 then smer := 4;
      #13 : predlz := 200;
      'P' : pause;
    end;
  until key = #27;
  closegraph;
end.