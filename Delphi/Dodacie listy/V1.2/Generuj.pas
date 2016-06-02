unit Generuj;

interface

function GenerujNazov( Znak : char; Dlzka : integer; Cesta : string; Ext : string ) : string;

implementation

uses Math, SysUtils;

function Nazov( Znak : char; Dlzka : integer; Cislo : integer ) : string;
var I : integer;
begin
  Result := Znak;
  for I := 1 to Dlzka-Round( Int( Log10( Cislo ) ) ) do
    Result := Result + '0';
  Result := Result + IntToStr( Cislo );
end;

function GenerujNazov( Znak : char; Dlzka : integer; Cesta : string; Ext : string ) : string;
var I : integer;
    NewName : string;
    SR : TSearchRec;
begin
  Result := '';

  I := 1;
  NewName := Nazov( Znak , Dlzka , I );
  while FindFirst( Cesta+NewName+'.'+Ext , faAnyFile , SR  ) = 0 do
    begin
      Inc( I );
      NewName := Nazov( Znak , Dlzka , I );
    end;
  FindClose( SR );

  Result := NewName;
end;

end.
