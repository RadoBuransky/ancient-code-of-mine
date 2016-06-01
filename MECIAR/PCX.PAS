procedure ukaz_pcx;

procedure setmode(mode:word);assembler;
asm
mov ax,mode
int 10h
end;

procedure setpal(col,r,g,b:byte);
begin
port[$3c8]:=col;
port[$3c9]:=r;
port[$3c9]:=g;
port[$3c9]:=b;
end;

function valid(s:string):boolean;
var f:file;
begin
assign(f,s);
{$i-}
reset(f);
close(f);
{$i+}
if ioresult <> 0 then valid := false
else valid := true;
end;

procedure loadpcx(name:string;where:word);
var f:file of byte;              {The PCX file}
    size:longint;                {Stores the size of the file}
    pointer:longint;             {Points to the current position in the file}
    count:word;                  {A counter}
    col,r,g,b:byte;              {Bytes for the palette}
    data:byte;                   {Byte we will read data to}
    k:word;                      {A counter}

begin
assign(f,name);                  {Assigns the .PCX file}
reset(f);                        {Opens it for output}
size:=filesize(f);               {Get the size of the .PCX file}
seek(f,size-768);                {Seek to the beginning of the palatte data}


{Read in the Palette data}
for col:=0 to 255 do
begin
read(f,r);
r:=r div 4;
read(f,g);
g:=g div 4;
read(f,b);
b:=b div 4;
setpal(col,r,g,b);
end;
{End of palette data}


{Read in the Data}
seek(f,128);                            {Seek to beginning of data}
pointer:=0;
count:=0;

while filepos(f) <> size-768  do        {While not at palette data}
begin

read(f,data);                           {Read a byte}


if data<192 then                 {If it is smaller than 192, put the pixel}
begin
mem[where:pointer]:=data;
inc(pointer);
end else

begin                            {If it is bigger than 192, decode it}
count:=data-192;             {Calculate the number of times to put the pixel}
read(f,data);                    {Read the next byte}

for k:=1 to count do             {Put the byte as many times as calculated}
begin
mem[where:pointer]:=data;
inc(pointer);
end;

end;

end;
close(f);                        {Close the file}
end;



begin
setmode($13);                    {Set 320x200x256 mode}
loadpcx('meciar.pcx',$a000);       {Load the pcx if the name is valid}
readkey;
setmode($3);                     {Set textmode}
end;
