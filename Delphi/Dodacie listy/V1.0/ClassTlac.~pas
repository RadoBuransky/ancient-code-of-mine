unit ClassTlac;

interface

uses Typy, Graphics, Printers, Classes;

const Left = 200;
      Right = 100;
      Top = 50;
      Bottom = 50;

type TTlac = class
     private
       Dodaci : TDodaci;
       SpolocnyText : TStringList;

       //Stav tlaèe :
       PocetStran : integer;
       PocetPoloziek, PocetSeriovych : integer;
       PocetRiadkovSpolocnehoTextu : integer;
       KoniecTlace : boolean;

       //Pomocne procedury
       procedure VytlacStranku;
       procedure Spracuj( iStringList : TStringList; var oSpolocnyText : TStringList );

     public
       procedure Vytlac( iDodaci : PDodaci );

       constructor Create;
       destructor Destroy; override;
     end;

implementation

uses FormHlavneOkno;

//==============================================================================
//==============================================================================
//
//                                  Constrcutor
//
//==============================================================================
//==============================================================================

constructor TTlac.Create;
begin
  inherited;
  SpolocnyText := TStringList.Create;
end;

//==============================================================================
//==============================================================================
//
//                                  Destrcutor
//
//==============================================================================
//==============================================================================

destructor TTlac.Destroy;
begin
  SpolocnyText.Free;
  inherited
end;

//==============================================================================
//==============================================================================
//
//                                  Interface
//
//==============================================================================
//==============================================================================

procedure TTlac.Vytlac( iDodaci : PDodaci );
begin
  PocetStran := 0;
  PocetPoloziek := 0;
  PocetSeriovych := 0;
  PocetRiadkovSpolocnehoTextu := 0;
  KoniecTlace := False;

  Dodaci := iDodaci^;

  Spracuj( Faktury.SpolocnyText , SpolocnyText );

  repeat
    VytlacStranku;
  until KoniecTlace;
end;

//==============================================================================
//==============================================================================
//
//                                Pomocne procedury
//
//==============================================================================
//==============================================================================

procedure TTlac.VytlacStranku;
var S : string;
    I, J, Max : integer;

    VelkyRiadok, MalyRiadok : integer;
    Posledny : integer;
    TabPos : array[1..5] of integer;

label Koniec;

begin
  Printer.BeginDoc;

  //Inicializacia :
  Printer.Canvas.Pen.Color := clBlack;
  Printer.Canvas.Pen.Width := 1;
  Printer.Canvas.Brush.Color := clWhite;
  VelkyRiadok := Printer.Canvas.TextHeight( 'Í' ) + 40;
  MalyRiadok := Printer.Canvas.TextHeight( 'Í' ) + 10;
  Posledny := Top;
  TabPos[1] := Left;
  TabPos[2] := Left+Round(5*(Printer.PageWidth-(Left+Right))/8);
  TabPos[3] := Left+Round(6*(Printer.PageWidth-(Left+Right))/8);
  TabPos[4] := Left+Round(3*(Printer.PageWidth-(Left+Right))/8);
  TabPos[5] := Left+Round(7*(Printer.PageWidth-(Left+Right))/8);

  //Oramovanie :
  Printer.Canvas.Pen.Width := 3;
  Printer.Canvas.Rectangle( Left , Top , Printer.PageWidth-Right , Printer.PageHeight-Bottom );

  //Hlavicku :
  if PocetStran = 0 then
    begin
      //Nadpis :
      Printer.Canvas.Pen.Width := 3;
      Printer.Canvas.MoveTo( Left , Top+VelkyRiadok );
      Printer.Canvas.LineTo( Printer.PageWidth-Right , Top+VelkyRiadok );

      S := 'D O D A C Í   L I S T   è.   '+Dodaci.Cislo+'   k   f a k t ú r e   è.   '+TFaktura( Dodaci.Faktura^ ).Cislo;
      Printer.Canvas.Font.Style := [fsBold];
      Printer.Canvas.TextOut( Left + ((Printer.PageWidth-(Left+Right)) div 2) - (Printer.Canvas.TextWidth(s) div 2),
                              Top + 20 , S );
      Posledny := Top+VelkyRiadok;

      //Dodavatel a odberatel :
      if TFaktura( Dodaci.Faktura^ ).Dodavatel.Adresa.Count >
         TFaktura( Dodaci.Faktura^ ).Odberatel.Adresa.Count then
           Max := TFaktura( Dodaci.Faktura^ ).Dodavatel.Adresa.Count
             else
           Max := TFaktura( Dodaci.Faktura^ ).Odberatel.Adresa.Count;
      if Max < 5 then Max := 5;

      Printer.Canvas.Pen.Width := 1;
      Printer.Canvas.MoveTo( (Left + (Printer.PageWidth-Right)) div 2 , Posledny );
      Printer.Canvas.LineTo( (Left + (Printer.PageWidth-Right)) div 2 , Posledny+(MalyRiadok * Max)+(VelkyRiadok * 2) );
      Printer.Canvas.MoveTo( Left , Posledny+(MalyRiadok * Max)+(VelkyRiadok * 2) );
      Printer.Canvas.LineTo( Printer.PageWidth-Right , Posledny+(MalyRiadok * Max)+(VelkyRiadok * 2) );

      //Adresa dodavatela :
      Printer.Canvas.TextOut( Left + 20 , Posledny + 20 , 'D O D Á V A T E ¼ :' );
      Printer.Canvas.TextOut( Left + 20 , Posledny+(MalyRiadok * Max)+ VelkyRiadok ,
                              'I È O : '+ TFaktura( Dodaci.Faktura^ ).Dodavatel.ICO );
      Printer.Canvas.Font.Style := [];
      for I := 0 to TFaktura( Dodaci.Faktura^ ).Dodavatel.Adresa.Count-1 do
        Printer.Canvas.TextOut( Left + 40 , Posledny + 20 + ((I+1) * MalyRiadok ), TFaktura( Dodaci.Faktura^ ).Dodavatel.Adresa[I] );

      //Adresa odberatela :
      Printer.Canvas.Font.Style := [fsBold];
      Printer.Canvas.TextOut( ((Left + (Printer.PageWidth-Right)) div 2) + 20 , Posledny + 20 , 'O D B E R A T E ¼ :' );
      Printer.Canvas.TextOut( ((Left + (Printer.PageWidth-Right)) div 2) + 20 , Posledny+(MalyRiadok * Max)+ VelkyRiadok ,
                              'I È O : '+ TFaktura( Dodaci.Faktura^ ).Odberatel.ICO );
      Printer.Canvas.Font.Style := [];
      for I := 0 to TFaktura( Dodaci.Faktura^ ).Odberatel.Adresa.Count-1 do
        Printer.Canvas.TextOut( (Left + ((Printer.PageWidth-Right)) div 2) + 40 , Posledny + 20 + ((I+1) * MalyRiadok ), TFaktura( Dodaci.Faktura^ ).Odberatel.Adresa[I] );

      Posledny := Posledny+(MalyRiadok * Max)+(VelkyRiadok * 2);

      //Vystavil, schvalil, prijal
      Printer.Canvas.TextOut( Left + 20  , Posledny + 5 , 'Vystavil '+ Dodaci.Vystavil.Osoba +' dòa '+Dodaci.Vystavil.Datum);
      Printer.Canvas.TextOut( Left + 20  , Posledny + 5 + MalyRiadok , 'Schválil '+ Dodaci.Schvalil.Osoba +' dòa '+Dodaci.Schvalil.Datum);
      Printer.Canvas.TextOut( Left + 20  , Posledny + 5 + MalyRiadok*2 , 'Prijal '+ Dodaci.Prijal.Osoba +' dòa '+Dodaci.Prijal.Datum);
      Printer.Canvas.MoveTo( Left , Posledny + MalyRiadok*3 );
      Printer.Canvas.LineTo( Printer.PageWidth - Right , Posledny + MalyRiadok*3 );
      Posledny := Posledny +  MalyRiadok*3;
    end;

  //Hlavicka tabulky :
  Printer.Canvas.Pen.Width := 1;
  Printer.Canvas.Font.Style := [fsBold];
  Printer.Canvas.TextOut( TabPos[1]+20 , Posledny+20 , 'Text' );
  Printer.Canvas.TextOut( TabPos[2]+20 , Posledny+20 , 'Jednotka' );
  Printer.Canvas.TextOut( TabPos[3]+20 , Posledny+20 , 'Množstvo' );
  Printer.Canvas.TextOut( TabPos[4]+20 , Posledny+20 , 'Sériové èísla' );
  Printer.Canvas.TextOut( TabPos[5]+20 , Posledny+20 , 'Záruèná doba' );
  Printer.Canvas.Font.Style := [];
  Printer.Canvas.MoveTo( Left , Posledny  +  VelkyRiadok );
  Printer.Canvas.LineTo( Printer.PageWidth - Right , Posledny  +  VelkyRiadok );
  Posledny := Posledny + VelkyRiadok;

  //Polozky :
  for I := PocetPoloziek to TFaktura( Dodaci.Faktura^ ).Polozky.Count-1 do
    begin
      if PocetSeriovych = 0 then
        begin
          Printer.Canvas.Font.Style := [fsBold];
          Printer.Canvas.TextOut( TabPos[1] + 20 , Posledny + 20 ,
                                  TPolozka( TFaktura( Dodaci.Faktura^ ).Polozky[I]^ ).Text );
          Printer.Canvas.TextOut( TabPos[2] + 20 , Posledny + 20 ,
                                  TPolozka( TFaktura( Dodaci.Faktura^ ).Polozky[I]^ ).J );
          Printer.Canvas.TextOut( TabPos[3] + 20 , Posledny + 20 ,
                                  TPolozka( TFaktura( Dodaci.Faktura^ ).Polozky[I]^ ).Mnozstvo );
          Printer.Canvas.TextOut( TabPos[5] + 20 , Posledny + 20 ,
                                  TPolozka( TFaktura( Dodaci.Faktura^ ).Polozky[I]^ ).Zaruka+' mes.' );
          Inc( Posledny , VelkyRiadok );
        end;
      Printer.Canvas.Font.Style := [fsItalic];
      //A ich seriove cisla :
      for J := PocetSeriovych to TPolozka( TFaktura( Dodaci.Faktura^ ).Polozky[I]^ ).Vyrobne.Count-1 do
        begin
          Printer.Canvas.TextOut( TabPos[4] + 20 , Posledny + 5 ,
                                  TPolozka( TFaktura( Dodaci.Faktura^ ).Polozky[I]^ ).Vyrobne[J] );
          Inc( Posledny , MalyRiadok );

          if (Posledny+MalyRiadok) >= Printer.PageHeight-Bottom then
            begin
              PocetPoloziek := I;
              if J < TPolozka( TFaktura( Dodaci.Faktura^ ).Polozky[I]^ ).Vyrobne.Count-1 then
                PocetSeriovych := J+1;
              goto Koniec;
            end;
        end;
      PocetSeriovych := 0;
    end;

  //Spoloèný text :
  if (Printer.PageHeight-Bottom)-((SpolocnyText.Count+13)*MalyRiadok) < Posledny then goto Koniec;
  Posledny := (Printer.PageHeight-Bottom)-((SpolocnyText.Count+13)*MalyRiadok);

  KoniecTlace := True;

  Printer.Canvas.Font.Style := [fsItalic,fsBold];
  for I := PocetRiadkovSpolocnehoTextu to SpolocnyText.Count-1 do
    begin
      with Printer.Canvas do
        begin
          TextOut( Left+((Printer.PageWidth-Left-Right-TextWidth( SpolocnyText[I] )) div 2) , Posledny ,
                   SpolocnyText[I] );
          Inc( Posledny , MalyRiadok );
        end;
    end;

  //Odovzdal a prevzal :
  Inc( Posledny , 9*MalyRiadok );
  Printer.Canvas.Font.Style := [fsItalic];
  with Printer.Canvas do
    begin
      TextOut( Left + (( ((Printer.PageWidth-Left-Right) div 2) - TextWidth( 'O d o v z d a l' )) div 2) ,
               Posledny ,
               'O d o v z d a l' );
      TextOut( Left + ((Printer.PageWidth-Left-Right) div 2) + (( ((Printer.PageWidth-Left-Right) div 2) - TextWidth( 'P r e v z a l' )) div 2) ,
               Posledny ,
               'P r e v z a l' );
    end;


  //Koniec stranky :

  Koniec :
  Inc( PocetStran );
  Printer.EndDoc;
end;

procedure TTlac.Spracuj( iStringList : TStringList; var oSpolocnyText : TStringList );
var I, J : integer;
    RiadokIN, RiadokOUT : string;
    Slovo : string;

function DajSlovo( iRiadok : string; var J : integer ) : string;
begin
  Result := '';

  while iRiadok[ J ] = ' ' do
    begin
      Inc( J );
      if J > Length( iRiadok ) then
        begin
          J := -1;
          exit;
        end;
    end;

  while iRiadok[ J ] <> ' ' do
    begin
      Result := Result + iRiadok[ J ];
      Inc( J );
      if J > Length( iRiadok ) then
        begin
          J := -1;
          exit;
        end;
    end;
end;

begin
  oSpolocnyText.Clear;

  RiadokOUT := '';

  I := 0;
  J := 1;
  RiadokIN := iStringList[I];

  Printer.Canvas.Font.Style := [fsItalic,fsBold];

  repeat
    Slovo := DajSlovo( RiadokIN , J );

    if J = -1 then
      begin
        J := 1;
        Inc( I );
        if I <= iStringList.Count-1 then RiadokIN := iStringList[I]
      end;

    if (Printer.Canvas.TextWidth( RiadokOUT+' '+Slovo ) < Printer.PageWidth-(Left+Right)) and
       (I <= iStringList.Count-1) then
      RiadokOUT := RiadokOUT +Slovo+' '
        else
      begin
        Delete( RiadokOUT , Length( RiadokOUT ) , 1 );
        oSpolocnyText.Add( RiadokOUT );
        RiadokOUT := Slovo;
      end;

  until I > iStringList.Count-1;
end;

end.
