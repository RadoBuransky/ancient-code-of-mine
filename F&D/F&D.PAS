program Find_And_Destroy;
Uses crt,graph,ini;

procedure presents;
begin;
 cleardevice;
 setcolor(68);
 Outtextxy(249,229,'P R E S E N T S');
 setcolor(65);
 Outtextxy(250,230,'P R E S E N T S');
 readkey;
 cleardevice;
end;

procedure fd;
begin;
 Setcolor(1);
 moveto(395,335);
 lineto(160,330);
 lineto(335,100);
 lineto(395,335);
 setfillstyle(1,55);
 floodfill(300,300,1);

 {f}
 Setcolor(140);
 moveto(170,300);
 lineto(170,120);
 lineto(280,80);
 lineto(305,130);
 lineto(240,155);
 lineto(240,200);
 lineto(270,190);
 lineto(280,220);
 lineto(240,240);
 lineto(240,300);
 lineto(170,300);
 {d}
 moveto(290,300);
 lineto(290,136);
 moveto(290,120);
 ellipse(290,210,270,85,120,90);
 moveto(320,240);
 lineto(320,180);
 ellipse(320,210,270,90,50,30);
 setfillstyle(1,2);
 floodfill(180,280,140);
 floodfill(300,280,140);
 setcolor(44);
 Outtextxy(170,320,'F I N D');
 Outtextxy(255,320,'&');
 Outtextxy(290,320,'D E S T R O Y');
 setcolor(white);
 outtextxy(255,420,'Made by');
 Outtextxy(190,440,'R a d o  B u r a n s k y');
 Outtextxy(257,460,' 1997 ');
end;

procedure blesk;
var x : integer;
    p : pointer;
    s : word;
begin;
 x := 170;
 repeat;
  putpixel(x,309,42);
  putpixel(x,310,40);
  putpixel(x,311,112);
  putpixel(x+1,309,44);
  putpixel(x+2,310,44);
  putpixel(x+1,311,44);
  putpixel(x+1,310,92);
  delay(5);
  x := x + 1;
 until x = 393;
end;

procedure pozadie;
var i : integer;
begin;
  for i := 207 to 255 do rgb(i,((63 div 48)*(i-207)),0,63-((63 div 48)*(i-207)));
  for i := 0 to 47 do
    begin
      setcolor(207+i);
      setfillstyle(1,207+i);
      bar(0,470-(i*10),640,480-(i*10));
    end;
end;

procedure buttons;
begin;

end;

procedure zaciatok;
begin
  logo;
  readkey;
  stmievanie;
  init256;
  presents;
  fd;
  blesk;
  readkey;
  cleardevice;
end;

begin;
  clrscr;
  init256;
  zaciatok;
  pozadie;
  readkey;
  buttons;
end.