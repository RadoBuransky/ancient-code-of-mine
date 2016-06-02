unit Typy;

interface

uses Classes;

const frBody  = $01;
      frNUholniky = $02;

type PBod = ^TBod;
     PPriamka = ^TPriamka;
     PPolPriamka = ^TPolpriamka;
     PUsecka = ^PUsecka;
     PNUholnik = ^TNuholnik;

     TVektor = record
                 X, Y : Real;
               end;

     TBod = record
              X, Y : Real;
              Nazov : String;
            end;

     TPriamka = record
                  A : TBod;
                  Smer : TVektor;
                  Nazov : String;
                end;

     TPolpriamka = record
                     A : TBod;
                     Smer : TVektor;
                     Nazov : String;
                   end;

     TUsecka = record
                 A : TBod;
                 Smer : TVektor;
                 Dlzka : Real;
                 Nazov : String;
               end;

     TNuholnik = record
                   Body : TList;
                   Nazov : String;
                 end;

     TBodObject = class(TObject)
                  public
                    p_Bod : PBod;
                  end;

implementation

end.
 