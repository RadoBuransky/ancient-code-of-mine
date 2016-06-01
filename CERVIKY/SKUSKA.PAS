uses crt,graph,ini;

const poc_ciar = 5;

var ciara : array[1..poc_ciar] of
  record
    x,y : real;
    x1,y1,x2,y2 : integer;
    sx1,sy1,sx2,sy2 : integer;
    sx,sy : real;
  end;
    smer : real;
    a : byte;

procedure nakresli(b : byte);
var uhol : real;
begin

  uhol := 180 - smer;

  if b = poc_ciar then
    begin
      setcolor(black);
      line(ciara[b].sx1,ciara[b].sy1,ciara[b].sx2,ciara[b].sy2);
    end;

  setcolor(white);

  ciara[b].x1 := Round(ciara[b].x + cos(pi/180*uhol)*5);
  ciara[b].y1 := Round(ciara[b].y + sin(pi/180*uhol)*5);
  ciara[b].x2 := Round(ciara[b].x - cos(pi/180*uhol)*5);
  ciara[b].y2 := Round(ciara[b].y - sin(pi/180*uhol)*5);

  line(ciara[b].x1,ciara[b].y1,ciara[b].x2,ciara[b].y2);

  ciara[b].sx1 := ciara[b].x1;
  ciara[b].sy1 := ciara[b].y1;
  ciara[b].sx2 := ciara[b].x2;
  ciara[b].sy2 := ciara[b].y2;
end;

procedure vypocitaj;
begin
  for a := 1 to poc_ciar do
    begin
      ciara[a].x := ciara[a].x + sin(pi/180*(180-smer)) * 0.1;
      ciara[a].y := ciara[a].y - cos(pi/180*(180-smer)) * 0.1;

      if (round(ciara[a].x) <> ciara[a].sx) or
         (round(ciara[a].y) <> ciara[a].sy) then
           nakresli(a);
    end;
end;

begin
  init16;
  setcolor(white);
  smer := 45;
  for a := 1 to poc_ciar do
    begin
      ciara[a].x := 320 + sin(pi/180*(180-smer)) * (6-a);
      ciara[a].y := 240 - cos(pi/180*(180-smer)) * (6-a);

      ciara[a].sx := round(ciara[a].x);
      ciara[a].sy := round(ciara[a].y);
    end;
   repeat;
    vypocitaj;
  until keypressed;
end.