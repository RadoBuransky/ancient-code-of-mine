unit ClassPonuka;

interface

uses Windows, Graphics, Classes, Grids, StdCtrls;

const Left_def: integer = 200;
      Right_def : integer = 100;
      Top_def : integer = 50;
      Bottom_def : integer = 200;

      Vyska_def : integer = 500;

type TPonuka = class
     private
       Kom : TStringList;
       Model : TStringList;
       BezDph : TStringList;
       SDph : TStringList;
       Nakupna : TStringList;

       Koef, Dph, CelkomS, CelkomBez : real;

       Adresa : array of string;

       Datum : string;

       Dodaci : boolean;

       //TlaË
       PocetStran : integer;
       PocetRiadkov : integer;
       KoniecTlace : boolean;
       Zoom : real;

       Canvas : TCanvas;

       procedure VytlacStranku;
     public
       constructor Create;
       destructor Destroy; override;

       function FormatNumber( S : string ) : string;
       procedure PonukaToForm( StringGrid : TStringGrid; EditKoef, EditDPH,
                               EditDatum, EditS, EditBez : TEdit; Memo : TMemo );
       procedure FormToPonuka( StringGrid : TStringGrid; EditKoef, EditDPH,
                               EditDatum, EditS, EditBez : TEdit; Memo : TMemo );

       procedure Uloz( Cesta : string );
       procedure Otvor( Cesta : string );

       procedure Tlac;

       procedure ExportToHTML( FileName : string );
     end;

var Ponuka : TPonuka;

implementation

uses ExtCtrls, Sysutils, Printers, FormMoznosti, FormTlacPon, Dialogs, Forms,
     GifImage, Ini;

//==============================================================================
//==============================================================================
//
//                               Constructor
//
//==============================================================================
//==============================================================================

constructor TPonuka.Create;
begin
  inherited;

  Kom := TStringList.Create;
  Model := TStringList.Create;
  SDph := TStringList.Create;
  BezDph := TStringList.Create;
  Nakupna := TStringList.Create;

  Koef := 0;
  Dph := 0;
  CelkomS := 0;
  CelkomBez := 0;

  Dodaci := False;
end;

//==============================================================================
//==============================================================================
//
//                                Destructor
//
//==============================================================================
//==============================================================================

destructor TPonuka.Destroy;
begin
  Kom.Free;
  Model.Free;
  SDph.Free;
  BezDph.Free;
  Nakupna.Free;

  inherited;
end;

//==============================================================================
//==============================================================================
//
//                                   TlaË
//
//==============================================================================
//==============================================================================

procedure TPonuka.VytlacStranku;

procedure StringToRiadky( S : string; Riadky : TStringList; Width : integer );
var I : integer;
    Slovo, Riadok : string;
begin
  Riadky.Clear;

  I := 1;
  Riadok := '';
  while I <= Length( S ) do
    begin
      //  NaËÌtanie slova
      while (S[I] = ' ') and
            (I <= Length( S ) ) do Inc( I );
      if I > Length( S ) then break;

      Slovo := '';

      while (S[I] <> ' ') and
            (I <= Length( S ) ) do
        begin
          Slovo := Slovo + S[I];
          Inc( I );
        end;
      if I > Length( S ) then break;

      if Canvas.TextWidth( Slovo ) > Width then exit;

      if Canvas.TextWidth( Riadok+Slovo ) <= Width then Riadok := Riadok+Slovo+' '
                                                   else
                                                     begin
                                                       Delete( Riadok , Length( Riadok ) , 1 );
                                                       Riadky.Add( Riadok );
                                                       Riadok := Slovo+' ';
                                                     end;
    end;
  Delete( Riadok , Length( Riadok ) , 1 );
  Riadky.Add( Riadok );
end;

var I, J, K, L : integer;
    Posl : longint;
    Stlpce : array[1..4] of integer;
    VysTab, VysRiad : integer;
    Dest, Src : TRect;
    S : string;
    Riadky : TStringList;

    Left, Right, Top, Bottom, Vyska : integer;

begin
  Left := Round( Left_def*Zoom );
  Top := Round( Top_def*Zoom );
  Right := Round( Right_def*Zoom );
  Bottom := Round( Bottom_def*Zoom );
  Vyska := Round( Vyska_def*Zoom );

  KoniecTlace := True;

  Posl := Top;

  Canvas.Font.Name := FormTlacPonuka.ComboBoxFont.Items[ FormTlacPonuka.ComboBoxFont.ItemIndex ];
  Canvas.Font.Size := 8;

  //  V˝öky
  VysRiad := Canvas.TextHeight( 'Õ' ) + Round(10*Zoom);
  VysTab := VysRiad + Round(30*Zoom);

  //  äÌrka stÂpcov
  for I := 1 to 4 do
    Stlpce[I] := 0;

  if FormTlacPonuka.Stlpce[1] then
    begin
      Stlpce[1] := Canvas.TextWidth( 'Komponenty' )+Round( 40*Zoom );
      for I := 0 to Kom.Count-1 do
        begin
          J := Canvas.TextWidth( Kom[I] )+Round( 40*Zoom );
          if J > Stlpce[1] then
            Stlpce[1] := J;
        end;
    end;

  if FormTlacPonuka.Stlpce[3] then
    begin
      Stlpce[3] := Canvas.TextWidth( 'Cena bez DPH' )+Round( 40*Zoom );
      for I := 0 to BezDph.Count-1 do
        begin
          J := Canvas.TextWidth( BezDph[I] )+Round( 40*Zoom );
          if J > Stlpce[3] then
            Stlpce[3] := J;
        end;
      J := Canvas.TextWidth( FormatNumber( FloatToStr( CelkomBez ) ) )+Round( 40*Zoom );
      if J > Stlpce[3] then
        Stlpce[3] := J;
    end;

  if FormTlacPonuka.Stlpce[4] then
    begin
      Stlpce[4] := Canvas.TextWidth( 'Cena s DPH' )+Round( 40*Zoom );
      for I := 0 to SDph.Count-1 do
        begin
          J := Canvas.TextWidth( SDph[I] )+Round( 40*Zoom );
          if J > Stlpce[4] then
            Stlpce[4] := J;
        end;
      J := Canvas.TextWidth( FormatNumber( FloatToStr( CelkomBez ) ) )+Round( 40*Zoom );
      if J > Stlpce[4] then
        Stlpce[4] := J;
    end;

  if FormTlacPonuka.Stlpce[2] then
    Stlpce[2] := Round( Printer.PageWidth*Zoom )-Left-Right-Stlpce[1]-Stlpce[3]-Stlpce[4];

  if PocetStran = 0 then
    begin
      //  HlaviËka
      if FormMozn.Header <> nil then
        begin
          Dest.Left := Left;
          Dest.Right := Round( Printer.PageWidth*Zoom )-Right;
          Dest.Top := Top;
          Dest.Bottom := Top+Vyska;

          case FormMozn.RadioGroup1.ItemIndex of
            0 : begin
                  Src := FormMozn.Header.Bitmap.Canvas.ClipRect;

                  if Src.Bottom > Vyska  then
                    Src.Bottom := Vyska;

                  if Src.Right > Dest.Right-Dest.Left then
                    Src.Right := Dest.Right-Dest.Left;

                  Dest.Bottom := Dest.Top + Src.Bottom;
                  Dest.Right := Dest.Left + Src.Right;

                  Canvas.CopyRect( Dest , FormMozn.Header.Bitmap.Canvas , Src );
                end;
            1 : Canvas.StretchDraw( Dest , FormMozn.Header.Bitmap );
          end;
        end;
      Inc( Posl , Vyska );
      with Canvas do
        begin
          Pen.Color := clBlack;
          Pen.Width := 3;

          MoveTo( Left , Posl+Round( 20*Zoom ) );
          LineTo( Round( Printer.PageWidth*Zoom )-Right , Posl+Round( 20*Zoom ) );
        end;
      Inc( Posl , Round( 60*Zoom ) );

      //  Adresa
      Canvas.Font.Color := clBlack;
      Canvas.Font.Size := 15;

      J := 0;
      for I := 0 to Length( Adresa )-1 do
        begin
          K := Canvas.TextWidth( Adresa[I] );
          if K > J then J := K;
        end;

      K := Canvas.TextHeight( 'Õ' ) + Round( 10*Zoom );
      for I := 0 to Length( Adresa )-1 do
        begin
          Canvas.TextOut( Round( Printer.PageWidth*Zoom )-Right-J-Round( 20*Zoom ) , Posl , Adresa[I] );
          Inc( Posl , K );
        end;

      Canvas.Pen.Width := 1;
      Canvas.Brush.Style := bsClear;
  {    Canvas.Rectangle( Round( Printer.PageWidth*Zoom )-Right-J-40 , Posl-Length(Adresa)*K ,
                        Round( Printer.PageWidth*Zoom )-Right , Posl+10 );}

      //  Nadpis
      with Canvas do
        begin
          Font.Size := 25;

          TextOut( Left , (((Posl-Length(Adresa)*K)+(Posl+Round( 10*Zoom ))) div 2)-
                  (TextHeight('Cenov· ponuka') div 2) , 'Cenov· ponuka' );
        end;

      Inc( Posl , Round( 50*Zoom ) );
    end;

  //  HlaviËka tabulky
  if PocetRiadkov <= Kom.Count-1 then
    begin
      Canvas.Font.Size := 8;
      Canvas.Brush.Style := bsSolid;
      Canvas.Brush.Color := clLtGray;
      J := Left;
      for I := 1 to 4 do
        if FormTlacPonuka.Stlpce[I] then
          begin
            Canvas.Rectangle( J , Posl , J+Stlpce[I] , Posl+VysTab );
            case I of
              1 : S := 'Komponenty';
              2 : S := 'Model';
              3 : S := 'Cena bez DPH';
              4 : S := 'Cena s DPH';
            end;
            Canvas.TextOut( J+Round( 20*Zoom ) , ((2*Posl+VysTab) div 2)-Canvas.TextHeight( S )div 2 , S );
            Inc( J , Stlpce[I] );
          end;
      Canvas.Brush.Style := bsClear;
      Inc( Posl , VysTab );
    end;

  Riadky := TStringList.Create;
  for I := PocetRiadkov to Kom.Count-1 do
    begin
      K := 1;
      if FormTlacPonuka.Stlpce[2] then
        begin
          //  Model
          StringToRiadky( Model[I] , Riadky , Stlpce[2]-Round( 40*Zoom ) );
          K := Riadky.Count;
          if K = 0 then K := 1;
          if Riadky.Count*VysTab > Round( Printer.PageHeight*Zoom )-Bottom then
            begin
              PocetRiadkov := I;
              Inc( PocetStran );
              KoniecTlace := False;
              break;
            end;
        end;

      J := Left;
      if FormTlacPonuka.Stlpce[1] then
        begin
          //  Komponenty
          Canvas.TextOut( Left+Round( 20*Zoom ) , (((Posl)+(Posl+VysTab)) div 2)-(Canvas.TextHeight( Kom[I] )div 2) , Kom[I] );
          Canvas.Rectangle( J , Posl , J+Stlpce[1] , Posl+VysTab*K );
          Inc( J , Stlpce[1] );
        end;

      if FormTlacPonuka.Stlpce[2] then
        begin
          Canvas.Rectangle( J , Posl , J+Stlpce[2] , Posl+VysTab*K );
          Inc( J , Stlpce[2] );
        end;

       if FormTlacPonuka.Stlpce[3] then
        begin
          //  Cena bez DPH
          Canvas.Rectangle( J , Posl , J+Stlpce[3] , Posl+VysTab*K );
          Inc( J , Stlpce[3] );
        end;

      if FormTlacPonuka.Stlpce[4] then
        begin
          //  Cena s DPH
          Canvas.Rectangle( J , Posl , J+Stlpce[4] , Posl+VysTab*K );
        end;


      if FormTlacPonuka.Stlpce[2] then
        begin
          //  Model
          for L := 0 to Riadky.Count-1 do
            begin
              Canvas.TextOut( Left+Round( 20*Zoom )+Stlpce[1] , (((Posl)+(Posl+VysTab)) div 2)-Canvas.TextHeight( Riadky[L] )div 2 , Riadky[L] );
              Inc( Posl , VysTab );
            end;
          if Riadky.Count > 0 then Dec( Posl , VysTab );
        end;

      if FormTlacPonuka.Stlpce[3] then
        begin
          //  Cena bez DPH
          Canvas.TextOut( Left+Stlpce[1]+Stlpce[2]+Stlpce[3]-Round( 20*Zoom )-Canvas.TextWidth( BezDph[I] ) ,
                          (((Posl)+(Posl+VysTab)) div 2)-Canvas.TextHeight( BezDph[I] )div 2 ,
                          BezDph[I] );
        end;

      if FormTlacPonuka.Stlpce[4] then
        begin
          //  Cena s DPH
          Canvas.TextOut( Left+Stlpce[1]+Stlpce[2]+Stlpce[3]+Stlpce[4]-Round( 20*Zoom )-Canvas.TextWidth( SDph[I] ) ,
                          (((Posl)+(Posl+VysTab)) div 2)-Canvas.TextHeight( SDph[I] )div 2 ,
                          SDph[I] );
        end;

      Inc( Posl , VysTab );

      if Posl > Round( Printer.PageHeight*Zoom )-Bottom then
        begin
          PocetRiadkov := I+1;
          Inc( PocetStran );
          KoniecTlace := False;
          break;
        end;
    end;

  //  Celkom
  if KoniecTlace then
    begin
      StringToRiadky( FormMozn.Memo.Text , Riadky , Round( Printer.PageWidth*Zoom )-(2*Left)-2*Right );
      if Round( Printer.PageHeight*Zoom )-Bottom-Posl < 6*VysTab+(VysRiad*(Riadky.Count+1)) then
        begin
          PocetRiadkov := Kom.Count;
          KoniecTlace := False;
          Inc( PocetStran );
          exit;
        end;
      Inc( Posl , VysTab );
      with Canvas do
        begin
          Brush.Color := clLtGray;
          Brush.Style := bsSolid;
          Pen.Color := clBlack;
          Rectangle( Left , Posl , Round( Printer.PageWidth*Zoom )-Right , Posl+VysTab );
          Brush.Style := bsClear;

          TextOut( Left+Round( 20*Zoom ) ,
                   (((Posl)+(Posl+VysTab)) div 2)-Canvas.TextHeight( 'CELKOM' )div 2 ,
                   'C E L K O M' );

          if FormTlacPonuka.Stlpce[3] then
            begin
              TextOut( Left+Stlpce[1]+Stlpce[2]+Stlpce[3]-Round( 20*Zoom )-
                       Canvas.TextWidth( FormatNumber( FloatToStr( CelkomBez ) ) ),
                      (((Posl)+(Posl+VysTab)) div 2)-Canvas.TextHeight( FloatToStr( CelkomBez ) )div 2 ,
                      FormatNumber( FloatToStr( CelkomBez ) ) );
              MoveTo( Left+Stlpce[1]+Stlpce[2] , Posl );
              LineTo( Left+Stlpce[1]+Stlpce[2] , Posl+VysTab );
            end;

          if FormTlacPonuka.Stlpce[4] then
            begin
              TextOut( Left+Stlpce[1]+Stlpce[2]+Stlpce[3]+Stlpce[4]-Round( 20*Zoom )-
                       Canvas.TextWidth( FormatNumber( FloatToStr( CelkomS ) ) ) ,
                       (((Posl)+(Posl+VysTab)) div 2)-Canvas.TextHeight( FloatToStr( CelkomS ) )div 2 ,
                       FormatNumber( FloatToStr( CelkomS ) ) );
              MoveTo( Left+Stlpce[1]+Stlpce[2]+Stlpce[3] , Posl );
              LineTo( Left+Stlpce[1]+Stlpce[2]+Stlpce[3] , Posl+VysTab );
            end;

          Inc( Posl , 2*VysTab );

          for I := 0 to Riadky.Count-1 do
            begin
              TextOut( Left , Posl , Riadky[I] );
              Inc( Posl , VysRiad );
            end;

          Inc( Posl , 4*VysTab );

          TextOut( Left , Posl , 'V Bratislave dÚa '+Datum );
          TextOut( Round( Printer.PageWidth*Zoom )-Right-Round( 500*Zoom )-TextWidth( 'S pozdravom' ) , Posl , 'S pozdravom' );
        end;
    end;
  Riadky.Free;
end;

function TPonuka.FormatNumber( S : string ) : string;
var I : integer;
begin
  Result := S;
  I := Pos( ',' , S );
  if I = 0 then
    begin
      Result := S+',00'
    end
           else
             begin
               if I+2 <= Length( S ) then
                 Delete( S , I+2 , Length( S )-(I+1) );
               Result := S+'0';
             end;
end;

//==============================================================================
//==============================================================================
//
//                               I N T E R F A C E
//
//==============================================================================
//==============================================================================

//==============================================================================
//  Convert
//==============================================================================

procedure TPonuka.PonukaToForm( StringGrid : TStringGrid; EditKoef, EditDPH,
                                EditDatum, EditS, EditBez : TEdit; Memo : TMemo );
var I : integer;
begin
  StringGrid.RowCount := Kom.Count+1;
  if StringGrid.RowCount = 1 then
    begin
      StringGrid.RowCount := StringGrid.RowCount+1;
      StringGrid.FixedRows := 1;
    end;

  for I := 0 to Kom.Count-1 do
    begin
      StringGrid.Cells[0,I+1] := Kom[I];
      StringGrid.Cells[1,I+1] := Model[I];
      StringGrid.Cells[2,I+1] := BezDph[I];
      StringGrid.Cells[3,I+1] := SDph[I];
      StringGrid.Cells[4,I+1] := Nakupna[I];
    end;

  EditKoef.Text := FloatToStr( Koef );
  EditDPH.Text := FloatToStr( DPH );
  EditS.Text := FloatToStr( CelkomS );
  EditBez.Text := FloatToStr( CelkomBez );
  EditDatum.Text := Datum;

  Memo.Clear;
  for I := 0 to Length( Adresa )-1 do
    Memo.Lines.Add( Adresa[I] );
end;

procedure TPonuka.FormToPonuka( StringGrid : TStringGrid; EditKoef, EditDPH,
                                EditDatum, EditS, EditBez : TEdit; Memo : TMemo );
var I : integer;
begin
  Kom.Clear;
  Model.Clear;
  SDph.Clear;
  BezDph.Clear;
  Nakupna.Clear;

  for I := 1 to StringGrid.RowCount-1 do
    begin
      Kom.Add( StringGrid.Cells[0,I] );
      Model.Add( StringGrid.Cells[1,I] );
      BezDph.Add( StringGrid.Cells[2,I] );
      SDph.Add( StringGrid.Cells[3,I] );
      Nakupna.Add( StringGrid.Cells[4,I] );
    end;

  Koef := StrToFloat( EditKoef.Text );
  DPH := StrToFloat( EditDPH.Text );
  Datum := EditDatum.Text;
  CelkomS := StrToFloat( EditS.Text );
  CelkomBez := StrToFloat( EditBez.Text );

  SetLength( Adresa , Memo.Lines.Count );
  for I := 0 to Memo.Lines.Count-1 do
    Adresa[I] := Memo.Lines[I];
end;

//==============================================================================
//  Pr·ca so s˙bormi
//==============================================================================

procedure TPonuka.Uloz( Cesta : string );
var I : integer;
begin
  Assign( Output , Cesta );
  {$I-}
  Rewrite( Output );
  {$I+}
  if IOResult <> 0 then
    begin
      MessageDlg( 'S˙bor '+Cesta+' sa ned· vytvoriù!' , mtError , [mbOK] , 0 );
      exit;
    end;

  if Dodaci then Writeln( 'ANO' )
            else Writeln( 'NIE' );

  Writeln( Datum );

  Writeln( Kom.Count );
  for I := 0 to Kom.Count-1 do
    begin
      Writeln( Kom[I] );
      Writeln( Model[I] );
      Writeln( BezDph[I] );
      Writeln( SDph[I] );
      Writeln( Nakupna[I] );
    end;

  Writeln( Koef );
  Writeln( DPH );

  for I := 0 to Length( Adresa )-1 do
    Writeln( Adresa[I] );

  CloseFile( Output );
end;

procedure TPonuka.Otvor( Cesta : string );
var I, N : integer;
    S : string;
begin
  AssignFile( Input , Cesta );
  {$I-}
  Reset( Input );
  {$I+}
  if IOResult <> 0 then
    begin
      MessageDlg( 'S˙bor '+Cesta+' sa ned· otvoriù!' , mtError , [mbOK] , 0 );
      exit;
    end;

  Kom.Clear;
  Model.Clear;
  BezDph.Clear;
  SDph.Clear;
  Nakupna.Clear;

  Readln( S );
  if S = 'ANO' then Dodaci := True
               else Dodaci := False;

  Readln( Datum );

  Readln( N );
  for I := 1 to N do
    begin
      Readln( S );
      Kom.Add( S );

      Readln( S );
      Model.Add( S );

      Readln( S );
      BezDph.Add( S );

      Readln( S );
      SDph.Add( S );

      Readln( S );
      Nakupna.Add( S );
    end;

  Readln( Koef );
  Readln( DPH );

  SetLength( Adresa , 0 );
  while not EoF( Input ) do
    begin
      SetLength( Adresa , Length( Adresa )+1 );
      Readln( Adresa[Length( Adresa )-1] );
    end;

  CloseFile( Input );
end;

//==============================================================================
//  TlaË
//==============================================================================

procedure TPonuka.Tlac;
begin
  if FormTlacPonuka.ShowModal = 1 then
    begin
      Zoom := 1;
      PocetStran := 0;
      PocetRiadkov := 0;
      KoniecTlace := False;

      Canvas := Printer.Canvas;

      repeat
        Printer.BeginDoc;
        VytlacStranku;
        Printer.EndDoc;
      until KoniecTlace;

    end;
end;

procedure TPonuka.ExportToHTML( FileName : string );
var F : textfile;
    I : integer;
    S : string;
    Bmp : TBitmap;
begin
  Bmp := TBitmap.Create;
  try
    Bmp.LoadFromFile( exe_dir+'\logo.bmp' );
    Bmp.SaveToFile( ExtractFilePath( FileName )+'logo.bmp' );
  finally
    Bmp.Free;
  end;

  AssignFile( F , FileName );
  {$I-}
  Rewrite( F );
  {$I+}
  if IOResult <> 0 then exit;

  Writeln( F , '<html>' );

  Writeln( F , '<head>' );
  Writeln( F , '<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">' );
  Writeln( F , '<title>PC PROMPT - Cenov· ponuka</title>' );
  Writeln( F , '</head>' );

  // Tab1
  // H L A V I » K A
  Writeln( F , '<body>' );
  Writeln( F , '<div align="left">' );
  Writeln( F , '' );
  Writeln( F , '<table border="0" width="710" height="135">' );
  Writeln( F , '<tr>' );
  Writeln( F , '<td width="162" height="70" rowspan="3">' );
  Writeln( F , '<p align="center"><img border="0" src="logo.bmp" width="150" height="150"></td>' );
  Writeln( F , '<td width="532" height="44"><p align="center"><font face="ZurichCalligraphic" size="7"><span style="letter-spacing: 6">PC' );
  Writeln( F , 'PROMPT, s.r.o.</span></font></p>' );
  Writeln( F , '</td>' );
  Writeln( F , '</tr>' );
  Writeln( F , '<tr>' );
  Writeln( F , '<td width="532" height="24"><p align="center"><font face="ZurichCalligraphic" size="5"><span style="letter-spacing: 6">Bajkalsk·' );
  Writeln( F , '27, 827 21 Bratislava</span></font></p>' );
  Writeln( F , '</td>' );
  Writeln( F , '</tr>' );
  Writeln( F , '<tr>' );
  Writeln( F , '<td width="532" height="1"><p align="center"><font face="ZurichCalligraphic" size="5"><span style="letter-spacing: 6">tel./fax:07-5342' );
  Writeln( F , '1040, 5248 228</span></font></p>' );
  Writeln( F , '</td>' );
  Writeln( F , '</tr>' );
  Writeln( F , '</table>' );
  Writeln( F , '</div>' );

  // Tab2
  Writeln( F , '<div align="left">' );
  Writeln( F , '<table border="0" width="710" height="51">' );
  Writeln( F , '<tr>' );
  Writeln( F , '<td width="445" height="15">&nbsp</td>' );
  Writeln( F , '<td width="248" height="15">&nbsp</td>' );
  Writeln( F , '</tr>' );

  // A D R E S A
  if Length( Adresa ) = 0 then
    begin
      S := '';
      I := 1;
    end
      else
    begin
      S := Adresa[0];
      I := Length( Adresa );
    end;
  Writeln( F , '<tr>' );
  Writeln( F , '<td width="445" height="85" rowspan="',I,'"><font size="6">Cenov· ponuka</font></td>' );
  Writeln( F , '<td width="248" height="17" valign="top" align="left">'+S+'</td>' );
  Writeln( F , '</tr>' );

  for I := 1 to Length( Adresa )-1 do
    begin
      Writeln( F , '<tr>' );
      Writeln( F , '<td width="248" height="18" valign="top" align="left">'+Adresa[I]+'</td>' );
      Writeln( F , '</tr>' );
    end;
  Writeln( F , '<tr>' );
  Writeln( F , '<td width="445" height="1">&nbsp</td>' );
  Writeln( F , '<td width="248" height="1" valign="top" align="left">&nbsp</td>' );
  Writeln( F , '</tr>' );

  Writeln( F , '</table>' );
  Writeln( F , '</div>' );

  // Tab3
  Writeln( F , '<div align="left">' );
  Writeln( F , '<table border="1" width="710" height="1" cellspacing="1" cellpadding="2">' );

  Writeln( F , '<tr>' );
  Writeln( F , '<td width="101" height="10" bgcolor="#C0C0C0">Komponenty</td>' );
  Writeln( F , '<td width="341" height="10" bgcolor="#C0C0C0">Model</td>' );
  Writeln( F , '<td width="131" height="10" bgcolor="#C0C0C0" align="center">Cena bez DPH</td>' );
  Writeln( F , '<td width="117" height="10" bgcolor="#C0C0C0" align="center">Cena s DPH</td>' );
  Writeln( F , '</tr>' );

  for I := 0 to Kom.Count-1 do
    begin
      Writeln( F , '<tr>' );
      Writeln( F , '<td width="103" height="7">'+Kom[I]+'</td>' );
      Writeln( F , '<td width="339" height="7">'+Model[I]+'</td>' );
      Writeln( F , '<td width="131" height="7"><p align="right">'+BezDPH[I]+'</td>' );
      Writeln( F , '<td width="117" height="7"><p align="right">'+SDPH[I]+'</td>' );
      Writeln( F , '</tr>' );
    end;

  Writeln( F , '<tr>' );
  Writeln( F , '<td width="442" height="10" colspan="2" bgcolor="#C0C0C0">C E L K O M</td>' );
  Writeln( F , '<td width="131" height="10" bgcolor="#C0C0C0" align="right">'+FormatNumber( FloatToStr( CelkomBez ) )+'</td>' );
  Writeln( F , '<td width="117" height="10" bgcolor="#C0C0C0" align="right">'+FormatNumber( FloatToStr( CelkomS ) )+'</td>' );
  Writeln( F , '</tr>' );

  Writeln( F , '</table>' );
  Writeln( F , '</div>' );

  // S P O L O » N ›   T E X T
  Writeln( F , '<div align="left">' );
  Writeln( F , '<table border="0" width="710" height="1">' );
  Writeln( F , '<tr>' );
  Writeln( F , '<td width="700" height="1">&nbsp</td>' );
  Writeln( F , '</tr>' );
  Writeln( F , '<tr>' );
  Writeln( F , '<td width="700" height="44">' );

  Writeln( F , FormMozn.Memo.Text );

  Writeln( F , '</td>' );
  Writeln( F , '</tr>' );
  Writeln( F , '<tr>' );
  Writeln( F , '<td width="700" height="1">&nbsp</td>' );
  Writeln( F , '</tr>' );
  Writeln( F , '</table>' );
  Writeln( F , '</div>' );

  Writeln( F , '<div align="left">' );
  Writeln( F , '<table border="0" width="710" height="127">' );
  Writeln( F , '<tr>' );
  Writeln( F , '<td width="447" height="127" valign="bottom">' );
  Writeln( F , '<p align="left">V Bratislave d&#328;a '+Datum+'</td>' );
  Writeln( F , '<td width="253" height="127" valign="bottom">S pozdravom</td>' );
  Writeln( F , '</tr>' );
  Writeln( F , '</table>' );
  Writeln( F , '</div>' );

  Writeln( F , '</body>' );

  Writeln( F , '</html>' );

  CloseFile( F );
end;

end.


