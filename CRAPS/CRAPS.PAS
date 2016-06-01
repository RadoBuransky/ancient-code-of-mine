Program Over_Under;
{Curtis Johnston the Original 'C'}
{This program is the game of Over Under Some things in this game a documented
out like all of the save things to files such as the highscore and such.  If
you know how they work then take them out by all means.  You will need to create
and new file called highsc.hgh and goods.hgh for the game winner and highscore
If you don't then I would suggest you leave it alone.  AND by the way, if you
can follow my programming then you deserve a metal.  I have lots of labels and
lots of var's. Some vars are used several times over like x,y, and k }
uses crt;

var

f                               : text;
count,soft                      : integer;
bet,tw,cl                       : integer;
money,win,loss, comment         : integer;
guess,name,ya,filename          : string;
x,y,k                           : longint;
number,numbe,Hwin,hsc,hbet      : integer;
number2,tv,di,dir,num1          : integer;
number3                         : integer;
answer                          : char;
label  yep,99,1,2,3,71,98,4,5,6,reg,00,11,12,13,14,15,17,10,20;
label 30,40,50,60,70,80,90,100,110,120, mov1,mov2,mov3,mov4,mov5;

Procedure Table;
{This procedure draws the craps table and randomizes the dice which are
thrown so each time the dice bounce back off of the board in a different direction
for a change of pace.}
const
W =  (chr(219));
V =  (chr(219));
L =  (chr(219));
D =  (chr(254));

var
tw,cl,h         : integer;
x,y,k           : longint;
tv,di,dir,num1  : integer;

Label mov1,mov2,mov3,mov4,mov5,stop;

Begin
textbackground (white);
textcolor (white);
window (10,15,80,23);
textbackground (white);
textcolor (brown);
{top of table}
for tw := 1 to 56 do begin
    write (w);
end;

{left side of table}
gotoxy (1,1);
for tw := 1 to 7 do begin
       writeln (w);
end;

{bottom of table}
gotoxy (1,8);
for tw := 1 to 56 do begin
    write (w);
end;

{right side of table}
x :=0;
repeat
      inc(x);
      gotoxy (56,x);
      write (w);
until x = 7;

textcolor (green);
tv := 1;

repeat
      inc (tv);
      gotoxy (2,tv);
             for x := 1 to 54 do begin;
                 write (v);
             end;
until tv = 7;

textcolor (red);
X := 1;
repeat
      inc (x);
      inc (h);
      gotoxy (45,x);
      writeln (L);
Until x = 7;
{Makes the dice blink to give the illusion that the dice are turning as they
roll}
di := 1;
randomize;
x := 1;
repeat
      textbackground (green);
      inc(h);
             if h > 2 then h := 1;
             if h = 1 then textcolor(lightgray);
             if h = 2 then textcolor(darkgray);
             inc (di);
             window (12,18,53,18);
             clrscr;
             gotoxy (di,1);
             write (d);
             window (12,19,53,19);
             gotoxy (di,1);
             write (d);
             textcolor (green);
             delay (50);
             clrscr;
             window (52,18,53,18);
             clrscr;
until di = 41;
window (54,18,55,18);
textcolor (lightgray);
textbackground (red);
write (d);
window (54,19,55,19);
write (d);
di := 1;
h := 1;
repeat
      clrscr;
      textbackground (green);
      inc (di);
      window (54,18,64,18);
      clrscr;
      textcolor (red);
      write (l);
      inc(h);
             if h > 2 then h := 1;
             if h = 1 then textcolor(lightgray);
             if h = 2 then textcolor(darkgray);
             gotoxy (di,1);
             write (d);
             window (54,19,64,19);
             textcolor (red);
             write (l);
                   if h > 2 then  h:= 1;
                   if h = 1 then textcolor(lightgray);
                   if h = 2 then textcolor(darkgray);
                   gotoxy (di,1);
                   write (d);
                   textcolor (green);
                   delay (100);
until di = 10;


x := 9;y := 3; k:= 3 ;
window (55,16,64,21);

randomize;
clrscr;
     textcolor (darkgray);
     gotoxy(x,y);write(d);
     gotoxy(x,y+1);write(d);
     textcolor (green);
     delay(100);
     {picks the different move}
     num1 := (random(5) + 1);
          if num1 = 1 then goto mov1;
          if num1 = 2 then goto mov2;
          if num1 = 3 then goto mov3;
          if num1 = 4 then goto mov4;
          if num1 = 5 then goto mov5;
{moves dice back}
mov1:
repeat;
inc (h);
     clrscr;
     x := x - 1;
     if h > 2 then h := 1;
     if h = 1 then textcolor(lightgray);
     if h = 2 then textcolor(darkgray);
        gotoxy(x,y);write(d);
        gotoxy(x,y+1);write(d);
        textcolor (green);
        delay(200);
Until x = 5;

goto stop;
{move dice up and back}
mov2:
clrscr;
repeat;
     clrscr;
     x := x - 1;
     y := y - 1;
     textcolor (white);
     inc(cl);
     if h > 2 then h := 1;
     if h = 1 then textcolor(lightgray);
     if h = 2 then textcolor(darkgray);

     gotoxy(x,y);write(d);
     gotoxy(x,y+1);write(d);
     textcolor (green);
     delay(200);
Until x = 7;

goto stop;
{moves dice down}
Mov3:
repeat;
     clrscr;
     x := x - 1;
     y := y + 1;
     textcolor (white);
     inc(cl);
     if h > 2 then h := 1;
     if h = 1 then textcolor(lightgray);
     if h = 2 then textcolor(darkgray);

     gotoxy(x,y);write(d);
     gotoxy(x,y+1);write(d);
     textcolor (green);
     delay(200);
Until x = 7;

goto stop;
{move dice up and back}
Mov4 :
repeat;
     clrscr;
     x := x - 1;
     y := y - 1;
     k := k + 1;
     textcolor (white);
     inc(cl);
     if h > 2 then h := 1;
     if h = 1 then textcolor(lightgray);
     if h = 2 then textcolor(darkgray);

     gotoxy(x,y);write(d);
     gotoxy(x,k+1);write(d);
     textcolor (green);
     delay(200);
Until x = 7;

goto stop;
{moves dice up and down}
Mov5 :
repeat;
     clrscr;
     x := x - 1;
     y := y + 1;
     textcolor (white);
     inc(cl);
     if h > 2 then h := 1;
     if h = 1 then textcolor(lightgray);
     if h = 2 then textcolor(darkgray);

     gotoxy(x,k);write(d);
     gotoxy(x,y+1);write(d);
     textcolor (green);
     delay(200);
Until x = 7;

goto stop;
Stop:
window (1,1,80,25);
textbackground (white);
textcolor (black);
End;

Begin
clrscr;
money :=100;
Win  :=  0;
loss := 0;

textbackground (white);
textbackground (white);
textcolor (blue);
writeln;
gotoxy (23,2);
Writeln ('Welcome to the CURTIS'' UNDER 7 OVER 7');
gotoxy (24,3);
Writeln ('Created and run by Curtis Johnston');
writeln;
Writeln ('If you pick under or over seven you will get double your bet, if you win');
Writeln ('If you pick seven and win you will get four times of your bet');
Writeln ('Please dont bet more than you have.');
textcolor (red + blink);
Writeln ('Good Luck');
WRITELN;
WRITELN;
textbackground (white);
textcolor (black);
{Writeln ('Do you want to see the last winner of the game');}
read (ya);
{read (answer);}
answer := upcase (answer);
{The cheat for 1000 dollars in the game}
If ya = 'super' then money := 1000;
If ya = (chr(13)) then goto 70;
{If ya = 'Y' then GOTO Yep;
If ya = 'y' then
yep:
Begin
     {This creates a file which prints the high score to a file which gets saved
     and can be recalled}

     {assign(f,'C:\highsc.hgh');
     reset (f);
     Textcolor (lightgray);
     readln(f,name,Money);
     close(f);
     textcolor (black);
     Write (name);
     READLN;
     money := 100;
END;            }

randomize;
70:
{This is the Registeration Screen which comes up every once in a while which
slowly wears the user down into sendin me a dollar.}
Soft := (Random(10) + 1);
If soft = 10 then goto reg;
   clrscr;
If money < 1 then goto 90;
window (1,24,80,25);
textbackground (white);
textbackground (black);
clrscr;
gotoxy (1,3);
textcolor (white);
write ('Money : $',money);
gotoxy (20,1);
write ('Wins : ',win);
gotoxy (35,1);
write ('Losses : ',loss);
{This is for highest win of the game}
{assign(f,'C:\goods.hgh');
reset (f);
Textcolor (white);
readln(f,hwin);
close(f);        }
gotoxy (53,1);
write ('Highest Win : ',hwin);
window (1,1,80,23);
textcolor (black); textbackground (white);
clrscr;
textcolor (black);
textbackground (white);
gotoxy (25,2);
Writeln ('Please give all bets to ICEPICK');
gotoxy (12,3);
Writeln ('How much will you give to the bookie.  You have $ ',money);
readln (bet);
{Prevents cheating and determines a winner}
If bet > money then goto 100;
If money > 10000 then goto 110;
If bet < 0 then goto 120;
clrscr;
writeln;
gotoxy (23,2);
Writeln ('Pick <U>nder, <O>ver or Enter for Seven');


guess := readkey;
If guess = 'U' then goto 10;
If guess = 'O' then goto 20;
If guess = 'u' then goto 10;
If guess = 'o' then goto 20;
If guess = '' then goto 98;
98: goto 30;
10:
   gotoxy (25,5);
   Writeln ('You throw the dice on the table');
   gotoxy (25,6);
   Write ('The number is ');
   Table;
randomize;
number := (random(5));
NUMBE := (random(5));
number := (number + 1);
NUMBE := (numbe + 1);
Number2 :=(number+numbe);
textcolor (black);
gotoxy (40,13);
writeln (number2);
readln;
IF number2 <7 then goto 40;
If number2 >7 then goto 50;
iF NUMBER2 =7 then goto 50;
20: gotoxy (25,5);
    Writeln ('You throw the dice on the table');
gotoxy (25,6);
Write ('The number is ');
table;
randomize;
number := (random(5));
Numbe:= (RANDOM(5));
number := (number + 1);
NUMBE := (numbe + 1);
Number2:=(number+numbe);
textcolor (black);
gotoxy (40,13);
WRITELN (NUMBER2);
readln;
IF number2 <7 then goto 50;
If number2 >7 then goto 40;
If number2 =7 then goto 50;
30: gotoxy (25,5);
Writeln ('You throw the dice on the table');
gotoxy (25,6);
Write ('The number is');
table;
randomize;
number := (random(5));
numbe := (random(5));
number := (number + 1);
NUMBE := (numbe + 1);
number2:= (number+numbe);
textcolor (black);
gotoxy (38,14);
writeln (number2);
delay(50);
IF number2 <7 then goto 50;
If number2 >7 then goto 50;
If number2 = 7 then goto 60;
delay(1000);
40:TEXTCOLOR(RED);
gotoxy (1,13);
writeln ('YOU WON.  GOOD Going.');
Sound(100);
Delay(100);
NoSound;
Sound(200);
Delay(300);
NoSound;
Sound(300);
Delay(300);
NoSound;
money := money + (2 * bet);
win := win + 1;
If bet * 2 > hwin then
Hwin := bet * 2;
{assign (f,'C:\goods.hgh');
     Rewrite (f);
     writeln (f, Hwin);
     close (f);}
window (1,24,80,25);
textbackground (black);
clrscr;
gotoxy (1,3);
textcolor (white);
writeln ('Money : $ ',money - 2 * bet,' + ',2 * bet);
delay (700);
writeln ('Money : $',money);
gotoxy (20,1);
write ('Wins : ',win);
gotoxy (35,1);
write ('Losses : ',loss);
gotoxy (53,1);
write ('Highest Win : ',hwin);
window (1,1,80,23);
textcolor (red); textbackground (white);
gotoxy (1,14);

randomize;
{Write a comment in after a win}
comment := (Random(7));
If comment = 0 then goto 99;
If comment = 1 then goto 1;
If comment = 2 then goto 2;
If comment = 3 then goto 3;
If comment = 4 then goto 4;
If comment = 5 then goto 5;
If comment = 6 then goto 6;

50:TEXTCOLOR(YELLOW);
gotoxy (1,13);
writeln ('Tough Break, Kid');
sound(100);
delay (100);
NoSound;
Sound(200);
Delay(300);
NoSound;
Sound(100);
Delay(300);
NoSound;
money := money - (bet);
loss := loss + 1;
window (1,24,80,25);
textbackground (black);
clrscr;
gotoxy (1,3);
textcolor (white);
writeln ('Money : $ ',money + bet,' - ',  bet);
delay (700);
writeln ('Money : $',money);
gotoxy (20,1);
write ('Wins : ',win);
gotoxy (35,1);
write ('Losses : ',loss);
gotoxy (53,1);
write ('Highest Win : ',hwin);
window (1,1,80,23);
textcolor (yellow); textbackground (white);
gotoxy (1,14);
randomize;
comment := (Random(5));
{Writes a comment after a loss}
If comment = 0 then goto 11;
If comment = 1 then goto 12;
If comment = 2 then goto 13;
If comment = 3 then goto 14;
If comment = 4 then goto 15;
If comment = 5 then goto 17;


60:textbackground (red);
CLRSCR;
TEXTcolor (blue+blink );
Count :=0;
repeat
count := count+1;
write ('7');
until count = 3119;
readln;
Sound(600);
Delay(100);
Sound(1000);
Delay(200);
Sound(900);
Delay(100);
Sound(600);
Delay(100);
Sound(1000);
Delay(200);
Sound(900);
Delay(100);
Sound(600);
Delay(100);
Sound(1000);
Delay(200);
Sound(900);
Delay(100);
Sound(600);
Delay(100);
Sound(1000);
Delay(200);
Sound(900);
Delay(100);
Sound(600);
Delay(100);
Sound(1000);
Delay(200);
Sound(900);
Delay(100);
Sound(600);
Delay(100);
Sound(1000);
Delay(200);
Sound(900);
Delay(100);
nosound;
money := money + (bet*4);
If bet * 4 > hwin then
Hwin := bet * 4;
{assign (f,'C:\goods.hgh');
     Rewrite (f);
     read (f, Hwin);
     close (f); }
win := win + 1;
window (1,24,80,25);
textbackground (black);
clrscr;
gotoxy (1,3);
textcolor (white);
writeln ('Money : $ ',money - 2 * bet,' + ',4 * bet);
delay (700);
writeln ('Money : $',money);
gotoxy (20,1);
write ('Wins : ',win);
gotoxy (35,1);
write ('Losses : ',loss);
gotoxy (53,1);
write ('Highest Win : ',hwin);
window (1,1,80,23);
textcolor (red); textbackground (white);
gotoxy (1,16);

GOTO 00;
00:textbackground (white);
Clrscr;
If money < 1 then goto 90;
TEXTCOLOR (BLACK);
gotoxy (33,1);
Writeln ('Want to play again');
gotoxy (33,2);
Writeln ('<Y>es or <N>o');
gotoxy (33,3);
Writeln ('Or Enter to Continue');
answer := readkey;
iF MONEY  < 1 THEN GOTO 90;
If Money > 10000 then goto 110;
If answer = 'N' then goto 80;
If answer = 'Y' then goto 70;
If answer = 'n' then goto 80;
If answer = 'y' then goto 70;
If answer = '' then goto 71;
71: goto 70;
80: writeln ('You receive your money at the door');
READLN;
writeln ('Good but you could have done better.');
WRITELN ('You walk out with');
delay(100);
gotoxy (40,15);
Writeln (money);
READLN;
HALT;
90:
{This is what happens after the user loses all of their money}
TEXTCOLOR (GREEN);
WRITELN ('Icepick sees that you lost all of your money');
writeln ('Icepick picks you up and throws you out');
writeln ('You are just lucky he doesnt break both of your Knees.');
Sound(500);
Delay(300);
NoSound;
Sound(400);
Delay(300);
NoSound;
Sound(300);
Delay(300);
NoSound;
Sound(200);
Delay(300);
NoSound;
Sound(100);
Delay(300);
NoSound;
Sound(50);
Delay(700);
NoSound;
GOTOxy (40,15);
textcolor (black +blink);
writeln ('Your Mama');
readln;
GOTOxy (40,15);
textcolor (red +blink);
writeln ('Game Over');
delay(1000);

halt;

100:
{If the User tries to bet more than they have it takes off 25 dollars}
clrscr;
textcolor (YELLOW+ blink);
Sound(600);
Delay(100);
NoSound;
Sound(1000);
Delay(200);
NoSound;
Sound(900);
Delay(100);
NoSound;
Sound(600);
Delay(100);
NoSound;
gotoxy (7,3);
Writeln ('What kind of crap you trying to pull you dont have that kind of money');
gotoxy (20,4);
writeln ('Just for that I will take away 25 dollars');
money := money - 25;
GOTOxy (25,15);
textcolor (black);
writeln ('Dont make me break my foot off in you ass');
readln;
goto 70;

120:
{If the User tries to bet negative then the program takes of 100 dollars}
CLrscr;
Sound(1000);
Delay(100);
NoSound;
Sound(900);
Delay(200);
NoSound;
Sound(1000);
Delay(100);
NoSound;
Sound(900);
Delay(100);
NoSound;
Sound(1000);
Delay(100);
NoSound;
Sound(900);
Delay(200);
NoSound;
Sound(1000);
Delay(100);
NoSound;
Sound(10);
Delay(500);
NoSound;
textcolor (red + blink);
gotoxy (7,3);
Writeln ('You are the biggest cheater of them all.  You will regret this.');
gotoxy (20,4);
writeln ('You are lucky I dont break both of your legs.');
money := money -100;
GOTOxy (30,15);
textcolor (black);
writeln ('Kiss my fat black butt');
readln;
goto 70;

110:
{The winning screen}
CLRSCR;
writeln ('Curtis is the KING');
clrscr;
Textcolor (magenta);
Writeln ('Icepick see that you have a lot of money');
Writeln ('Icepick sees his business failing');
Writeln ('Icepick gives you $1000 to leave');
Writeln ('You walk out with');
Readln;
Sound(1000);
Delay(1000);
NoSound;
Sound (100);
Delay (1000);
NoSound;
Writeln (money + 1000);
readln;
writeln;
textcolor (lightred);
{If money > hsc then
Writeln ('Congratulation, you beat the game');
Writeln ('Please Enter your Name');
textcolor (black);
Readln (name);
read (money);
hsc := money;
assign (f,'C:\highsc.hgh');
     Rewrite (f);
     writeln (f, Name,'  ',Money);
     close (f);
GOTOxy (40,15);}
textcolor (red +blink);
writeln ('Game Over');
readln;
halt;
{The comments, you may change them if you wish}
99:writeln ('You arent as big of a loser as you thought you were');
readln;
goto 00;
1:writeln ('With this extra cash, you can get real a woman');
readln;
goto 00;
2:writeln ('No more Kraft dinner for this cowboy');
readln;
goto 00;
3:writeln ('You wont have to live under that bench anymore');
readln;
goto 00;
4:writeln ('You will no longer have to use that phone booth as a bathroom');
readln;
goto 00;
5:writeln ('You have enough money to move up to the just below poverty line');
readln;
goto 00;
6:writeln ('You can buy back those naked pictures of yourself');
readln;
goto 00;
11:writeln ('Now you are going to have to sell your liver');
readln;
goto 00;
12:writeln ('You will now have to sell your cardboard box');
readln;
goto 00;
13:writeln ('I guess you will have to make extra money at the blood donor clinic');
readln;
goto 00;
15:writeln ('Now you can''t plan for World Domaination');
readln;
goto 00;
14:writeln ('Subliminal message:  Curtis is King.');
readln;
goto 00;
17:writeln ('That was Grandmothers operation money');
Writeln ('She really didnt need a liver that bad anyways');
readln;
goto 00;
reg :
{That annoying screen}
clrscr;
Textcolor (white);
Writeln ('Please Send $1 to Curtis Johnston for him to make');
writeln ('other fine programs, such as his newest creations');
writeln ('Cock Fighting, and Horse Racing.');
textcolor (red + blink);  writeln ('And you can also get rid of the annoying message!!');
textcolor (white);
writeln ('Please Send $1 to Curtis Johnston at:');
writeln;
writeln ('Curtis Johnston');
writeln ('Box 2335');
writeln ('Rocky Mountain House, Alberta');
writeln ('Canada');
writeln ('T0M 1T0');
writeln ('Telephone 1-(403)-845-6964');
Textcolor (lightred);
writeln ('No Stalkers, Please');
gotoxy (1,15);
textcolor (white);
writeln ('It only a dollar and I worked long and hard on this');
writeln ('program.  If you don''t pay I guess you are mooching. ');
writeln ('Also ask for Cock Fighting which has graphics but don''t');
writeln ('expect too much, I not a great programmer and this is ');
writeln ('Turbo Pascal');
delay (5000);
textcolor (red + blink);
writeln ('Now Play Some more Under 7 Over 7');
readln;
goto 70;

end.
