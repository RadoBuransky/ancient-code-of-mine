program piskvorky;

{Kazdy predsa pozna piskvorky}

Uses Crt;

const piskvorka : word = 0;

Var pole : array[1..80,1..25] of word;
    cur :  record
             x,y : integer;
           end;
    hrac : shortint;

procedure koniec;
begin
  textcolor(lightgray);
  textbackground(black);
  clrscr;
  Writeln('Have a nice day.');
  halt;
end;

procedure vyhral;
var a : integer;
begin
  if hrac = 1 then Textcolor(lightred)
              else Textcolor(lightgreen);

  if hrac = 1 then Textbackground(lightred)
              else Textbackground(lightgreen);

  for a := 1 to 80 do
    begin
      gotoxy(a,24);
      Write(#219);
    end;

  for a := 1 to 23 do
   begin
     Gotoxy(1,a);
     Write(#219);
     Gotoxy(80,a);
     Write(#219);
     Gotoxy(2,a);
     Write(#219);
     Gotoxy(79,a);
     Write(#219);
   end;

   if hrac = 1 then
     begin
       textcolor(white);

       Gotoxy(31,24);
       Write('Vyhral   C E R V E N Y');
     end
     else
     begin
       textcolor(black);

       Gotoxy(32,24);
       Write('Vyhral   Z E L E N Y');
     end;

  readkey;
  koniec;
end;

procedure kontrola1;
var a,b,c,d : integer;
begin


  {kontrola z laveho horneho rohu do praveho dolneho rohu}


  a := 1;
  repeat
     if pole[cur.x-5+a,cur.y-5+a] = 1 then Inc(piskvorka)
                                      else piskvorka := 0;
   if piskvorka = 5 then
     begin
       c := a - 4;
       textcolor(white);
       repeat
         gotoxy(cur.x-5+c,cur.y-5+c);
         Write('X');
         c := c + 1;
       until c = a+1;
       textcolor(lightgray);
       vyhral;
     end;
   a := a + 1;
  until a = 10;


  {kontrola z lava do prava}


  piskvorka := 0;
  a := 1;
  repeat
     if pole[cur.x-5+a,cur.y] = 1 then Inc(piskvorka)
                                  else piskvorka := 0;
   if piskvorka = 5 then
     begin
       c := a - 4;
       textcolor(white);
       repeat
         gotoxy(cur.x-5+c,cur.y);
         Write('X');
         c := c + 1;
       until c = a+1;
       textcolor(lightgray);
       vyhral;
     end;
   a := a + 1;
  until a = 10;

  {kontrola z hora dole}

  piskvorka := 0;
  a := 1;
  repeat
     if pole[cur.x,cur.y-5+a] = 1 then Inc(piskvorka)
                                  else piskvorka := 0;
   if piskvorka = 5 then
     begin
       c := a-4;
       textcolor(white);
       repeat
         gotoxy(cur.x,cur.y-5+c);
         Write('X');
         c := c + 1;
       until c = a+1;
       textcolor(lightgray);
       vyhral;
     end;
   a := a + 1;
  until a = 10;

  {kontrola z praveho horneho rohu do laveho dolneho rohu}

  piskvorka := 0;
  a := 1;
  repeat
     if pole[cur.x+5-a,cur.y-5+a] = 1 then Inc(piskvorka)
                                      else piskvorka := 0;
   if piskvorka = 5 then
     begin
       c := a-4;
       textcolor(white);
       repeat
         gotoxy(cur.x+5-c,cur.y-5+c);
         Write('X');
         c := c + 1;
       until c = a+1;
       textcolor(lightgray);
       vyhral;
     end;
   a := a + 1;
  until a = 10;

end;

procedure kontrola2;
var a,b,c,d : integer;
begin

  piskvorka := 0;
  a := 1;
  repeat
     if pole[cur.x,cur.y-5+a] = 2 then Inc(piskvorka)
                                  else piskvorka := 0;
   if piskvorka = 5 then
     begin
       c := a-4;
       textcolor(white);
       repeat
         gotoxy(cur.x,cur.y-5+c);
         Write('O');
         c := c + 1;
       until c = a+1;
       textcolor(lightgray);
       vyhral;
     end;
   a := a + 1;
  until a = 10;



  {kontrola z laveho horneho rohu do praveho dolneho rohu}


  a := 1;
  repeat
     if pole[cur.x-5+a,cur.y-5+a] = 2 then Inc(piskvorka)
                                      else piskvorka := 0;
   if piskvorka = 5 then
     begin
       c := a - 4;
       textcolor(white);
       repeat
         gotoxy(cur.x-5+c,cur.y-5+c);
         Write('O');
         c := c + 1;
       until c = a+1;
       textcolor(lightgray);
       vyhral;
     end;
   a := a + 1;
  until a = 10;


  {kontrola z lava do prava}


  piskvorka := 0;
  a := 1;
  repeat
     if pole[cur.x-5+a,cur.y] = 2 then Inc(piskvorka)
                                  else piskvorka := 0;
   if piskvorka = 5 then
     begin
       c := a - 4;
       textcolor(white);
       repeat
         gotoxy(cur.x-5+c,cur.y);
         Write('O');
         c := c + 1;
       until c = a+1;
       textcolor(lightgray);
       vyhral;
     end;
   a := a + 1;
  until a = 10;

  {kontrola z praveho horneho rohu do laveho dolneho rohu}

  piskvorka := 0;
  a := 1;
  repeat
     if pole[cur.x+5-a,cur.y-5+a] = 2 then Inc(piskvorka)
                                      else piskvorka := 0;
   if piskvorka = 5 then
     begin
       c := a-4;
       textcolor(white);
       repeat
         gotoxy(cur.x+5-c,cur.y-5+c);
         Write('O');
         c := c + 1;
       until c = a+1;
       textcolor(lightgray);
       vyhral;
     end;
   a := a + 1;
  until a = 10;

end;

procedure ukaz_hracie_pole;
var a,b : integer;
begin
  textcolor(lightgray);
  for a := 1 to 80 do
    for b := 1 to 25 do pole[a,b] := 0;
  for a := 1 to 23 do
    for b := 1 to 23 do
      begin
        gotoxy(30+a,b);
        Write(#197)
      end;

  for a := 1 to 23 do
    begin
      gotoxy(30+a,1);
      Write(#196);
    end;
  for a := 1 to 23 do
    begin
      gotoxy(30+a,23);
      Write(#196);
    end;
  for a := 1 to 23 do
    begin
      gotoxy(30,a);
      Write(#179);
      gotoxy(53,a);
      Write(#179);
    end;
  gotoxy(30,1);
  Write(#218);
  Gotoxy(53,1);
  Write(#191);
  Gotoxy(53,23);
  Write(#217);
  Gotoxy(30,23);
  Write(#192);
  gotoxy(10,24);
  Write('P i s k v o r k y  by  MGC  from  Rado  B u r a n s k y  1997')
end;

procedure hraj;

var c : Char;
    a : integer;
begin
  cur.x := 42;
  cur.y := 11;
  hrac := 1;
  repeat;
    if hrac =  1 then Textcolor(lightred)
               else Textcolor(lightgreen);

    for a := 1 to 23 do
     begin
       Gotoxy(1,a);
       Write(#219);
       Gotoxy(80,a);
       Write(#219);
       Gotoxy(2,a);
       Write(#219);
       Gotoxy(79,a);
       Write(#219);
     end;

   textcolor(lightgray);

    gotoxy(cur.x,cur.y);

    c := readkey;

     case c of
       #75 : Dec(cur.x);
       #77 : Inc(cur.x);
       #72 : dec(cur.y);
       #80 : Inc(cur.y);
     end;

    case cur.x of
      53 : cur.x := 52;
      30 : cur.x := 31;
    end;

    case cur.y of
      1 : cur.y := 2;
      23: cur.y := 22;
    end;

    if (c = #13) and (pole[cur.x,cur.y] = 0) then
    begin
      gotoxy(cur.x,cur.y);
      if hrac = 1 then
        begin
          Textcolor(lightred);
          Write('X');
          Textcolor(lightgray);
          pole[cur.x,cur.y] := 1;
        end;
      if hrac = -1 then
        begin
          Textcolor(lightgreen);
          Write('O');
          Textcolor(lightgray);
          pole[cur.x,cur.y] := 2;
        end;

      kontrola1;
      kontrola2;

      hrac := hrac * -1;
    end;

  until c = #27;
  koniec;
end;

begin
  clrscr;
  textmode(-1);
  ukaz_hracie_pole;
  hraj;
end.