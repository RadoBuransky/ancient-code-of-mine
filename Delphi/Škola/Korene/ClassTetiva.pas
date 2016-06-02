unit ClassTetiva;

interface

uses ExtCtrls, ClassNulovy;

type TTetiva = class( TNulovy )
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

constructor TTetiva.Create( iLavy, iPravy : real; iImage : TImage );
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

destructor TTetiva.Destroy;
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

procedure TTetiva.Krok;
var L, P, S : real;
    hL, hP, hS : real;
begin
  NakresliFunkciu;
  NasielRiesenie := False;

  L := PocitajL;
  P := PocitajP;

  hL := Funkcia( L );
  hP := Funkcia( P );

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
      MoveTo( Round( Stred.X + L ) , Round( Stred.Y - hL ) );
      LineTo( Round( Stred.X + P ) , Round( Stred.y - hP ) );
    end;

  S := L + (Abs(P-L) / Abs(hP-hL) * Abs(hL));
  hS := Funkcia( S );

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
