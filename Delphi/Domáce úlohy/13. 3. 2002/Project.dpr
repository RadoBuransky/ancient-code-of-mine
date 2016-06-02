program Project;

uses
  Classes,
  SysUtils,
  ClassStack in 'ClassStack.pas',
  ClassFile in 'ClassFile.pas';

var Dictionary : TFile;

procedure GenerateSlovEngl;
const Words : array[1..10] of
      record
        Slovak : string;
        English : string;
      end =
      (( Slovak:'Ano' ;      English:'Yes' ),
       ( Slovak:'Nie' ;      English:'No' ),
       ( Slovak:'Auto' ;     English:'Car' ),
       ( Slovak:'Dom' ;      English:'House' ),
       ( Slovak:'Strom' ;    English:'Tree' ),
       ( Slovak:'Jablko' ;   English:'Apple' ),
       ( Slovak:'Bicykel' ;  English:'Bike' ),
       ( Slovak:'Zosit' ;    English:'Notebook' ),
       ( Slovak:'Hracka' ;   English:'Toy') ,
       ( Slovak:'Okuliare' ; English:'Glasses' ));
var F : TFileStream;
    I, J : integer;
begin
  F := TFileStream.Create( 'slovengl.dat' , fmCreate );
  try
    for I := 1 to 10 do
      begin
        // Write slovak word
        J := Length( Words[I].Slovak );
        F.Write( J , SizeOf( J ) );
        F.Write( Words[I].Slovak[1] , J );

        // Write english word
        J := Length( Words[I].English );
        F.Write( J , SizeOf( J ) );
        F.Write( Words[I].English[1] , J );
      end;
  finally
    F.Free;
  end;
end;

begin
  // Generate Slovak - English file
  GenerateSlovEngl;

  Dictionary := TFile.Create;
  try
    Dictionary.CreateDictionary( 'slovengl.dat' , 'englslov.dat' );
  finally
    Dictionary.Free;
  end;
end.
