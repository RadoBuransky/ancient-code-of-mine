unit ClassBisekcia;

interface

uses ExtCtrls, ClassNulovy;

type TBisekcia = class( TNulovy )
     public
       constructor Create( iLavy, iPravy : real; iImage : TImage );
       destructor Destroy; override;

       procedure Krok; override;
     end;

implementation

uses Graphics, Dialogs;

//==============================================================================
//==============================================================================
//
//                                    Constructor
//
//==============================================================================
//==============================================================================

constructor TBisekcia.Create( iLavy, iPravy : real; iImage : TImage );
begin
  inherited Create( iLavy, iPravy, iImage );
end;

//==============================================================================
//==============================================================================
//
//                                    Destructor
//
//==============================================================================
//==============================================================================

destructor TBisekcia.Destroy;
begin
  inherited;
end;

//==============================================================================
//==============================================================================
//
//                                 I N T E R F A C E
//
//==============================================================================
//==============================================================================

procedure TBisekcia.Krok;
var L, P, S : real;
    hL, hP, hS : real;
begin
  NakresliFunkciu;
  NasielRiesenie := False;

  L := PocitajL;
  P := PocitajP;
  S := (L+P)/2;

  hL := Funkcia(L);
  hP := Funkcia(P);
  hS := Funkcia(S);

  if hL*hP > 0 then
    begin
      MessageDlg( 'V danom intervale nie je zaidny koren, alebo je ich parny pocet' , mtError ,
                  [mbOK] , 0 );
      Hotovo := True;
      exit;
    end;

  with Image.Canvas do
    begin
      Pen.Color := clAqua;
      Pen.Style := psDot;
      MoveTo( Round( Stred.X + L ) , Stred.Y );
      LineTo( Round( Stred.X + L ) , Round( Stred.Y - hL ) );
      MoveTo( Round( Stred.X + P ) , Round( Stred.y - hP ) );
      LineTo( Round( Stred.X + P ) , Stred.Y );

      Pen.Color := clRed;
      Pen.Style := psSolid;
      MoveTo( Round( Stred.X + S ) , Stred.Y );
      LineTo( Round( Stred.X + S ) , Round( Stred.Y - hS ) );
    end;

  if Abs( hS ) <= Presnost then
    begin
      Hotovo := True;
      NasielRiesenie := True;
      PocitajL := S;
      PocitajP := S;
    end;

  if hL*hS < 0 then PocitajP := S
               else PocitajL := S;
end;

end.
