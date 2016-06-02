unit Typy;

interface

uses Classes;

type PFaktura = ^TFaktura;
     PPolozka = ^TPolozka;
     PDodaci = ^TDodaci;

     TOsobaDatum = record
       Osoba : string;
       Datum : string;
     end;

     TSpolocnost = record
       Adresa : TStringList;
       ICO : string;
     end;

     TPolozka = record
       Text : string;
       J : string;
       Mnozstvo : string;
       Zaruka : string[2];
       Vyrobne : TStringList;
     end;

     TFaktura = record
       Dodavatel, Odberatel : TSpolocnost;
       Polozky : TList;
       Cislo : string;
     end;

     TDodaci = record
       Faktura : PFaktura;
       Cislo : string;

       Vystavil, Schvalil, Prijal : TOsobaDatum;

       Otvoreny : boolean;
     end;

     TAktivny = record
       Subor : string;
       Ulozeny : boolean;
   end;

implementation

end.
