unit ClassBoard;

interface

uses ClassBaseBoard, ClassLetters, Classes, Controls, ExtCtrls, Graphics;

type TScoreType = ( stSingle, stDblL, stTrpL, stDblW, stTrpW );

const CBckgndColor = $00000000;
      CDblLColor   = $00FFB0B0;
      CTrpLColor   = $00FF1010;
      CDblWColor   = $00B0B0FF;
      CTrpWColor   = $001010FF;
      CNumRows     = 15;
      CNumCols     = 15;
      CBoard       : array[1..CNumRows,1..CNumCols] of TScoreType =
                   (( stTrpW , stSingle, stSingle, stDblL , stSingle, stSingle, stSingle, stTrpW , stSingle, stSingle, stSingle, stDblL , stSingle, stSingle, stTrpW ),
                    ( stSingle, stDblW , stSingle, stSingle, stSingle, stTrpL , stSingle, stSingle, stSingle, stTrpL , stSingle, stSingle, stSingle, stDblW , stSingle),
                    ( stSingle, stSingle, stDblW , stSingle, stSingle, stSingle, stDblL , stSingle, stDblL , stSingle, stSingle, stSingle, stDblW , stSingle, stSingle),
                    ( stDblL , stSingle, stSingle, stDblW , stSingle, stSingle, stSingle, stDblL , stSingle, stSingle, stSingle, stDblW , stSingle, stSingle, stDblL ),
                    ( stSingle, stSingle, stSingle, stSingle, stDblW , stSingle, stSingle, stSingle, stSingle, stSingle, stDblW , stSingle, stSingle, stSingle, stSingle),
                    ( stSingle, stTrpL , stSingle, stSingle, stSingle, stTrpL , stSingle, stSingle, stSingle, stTrpL , stSingle, stSingle, stSingle, stTrpL , stSingle),
                    ( stSingle, stSingle, stDblL , stSingle, stSingle, stSingle, stDblL , stSingle, stDblL , stSingle, stSingle, stSingle, stDblL , stSingle, stSingle),
                    ( stTrpW , stSingle, stSingle, stDblL , stSingle, stSingle, stSingle, stDblW , stSingle, stSingle, stSingle, stDblL , stSingle, stSingle, stTrpW ),
                    ( stSingle, stSingle, stDblL , stSingle, stSingle, stSingle, stDblL , stSingle, stDblL , stSingle, stSingle, stSingle, stDblL , stSingle, stSingle),
                    ( stSingle, stTrpL , stSingle, stSingle, stSingle, stTrpL , stSingle, stSingle, stSingle, stTrpL , stSingle, stSingle, stSingle, stTrpL , stSingle),
                    ( stSingle, stSingle, stSingle, stSingle, stDblW , stSingle, stSingle, stSingle, stSingle, stSingle, stDblW , stSingle, stSingle, stSingle, stSingle),
                    ( stDblL , stSingle, stSingle, stDblW , stSingle, stSingle, stSingle, stDblL , stSingle, stSingle, stSingle, stDblW , stSingle, stSingle, stDblL ),
                    ( stSingle, stSingle, stDblW , stSingle, stSingle, stSingle, stDblL , stSingle, stDblL , stSingle, stSingle, stSingle, stDblW , stSingle, stSingle),
                    ( stSingle, stDblW , stSingle, stSingle, stSingle, stTrpL , stSingle, stSingle, stSingle, stTrpL , stSingle, stSingle, stSingle, stDblW , stSingle),
                    ( stTrpW , stSingle, stSingle, stDblL , stSingle, stSingle, stSingle, stTrpW , stSingle, stSingle, stSingle, stDblL , stSingle, stSingle, stTrpW ));

type TTile = record
       Letter : TLetter;
       X, Y   : integer;
     end;

     TBoardLtr = record
       Letter   : TLetter;
       ThisTurn : boolean;
     end;

     TLtrsBoard = array[1..CNumRows,1..CNumCols] of TBoardLtr;

     TOnClickEvent = procedure( X, Y : integer ) of object;

     TBoard = class( TBaseBoard )
     private
       FLetters     : TLtrsBoard;
       FOnClick     : TOnCLickEvent;

       procedure    PaintBoard;
       procedure    OnMouseDown( Sender: TObject; Button: TMouseButton;
                                 Shift: TShiftState; X, Y: Integer );
     public
       constructor Create( Image : TImage );
       destructor  Destroy; override;

       procedure   Clear;
       function    AddLetter( X, Y : integer; var Letter : TLetter ) : boolean;
       procedure   RemoveLetter( X, Y : integer );
       procedure   EndMove;
       function    GetScore : integer;

       property    OnClick : TOnClickEvent read FOnClick write FOnClick;
       property    Letters : TLtrsBoard read FLetters;
     end;

implementation

uses SysUtils, UnitFormJoker;

//==============================================================================
// Constructor / destructor
//==============================================================================

constructor TBoard.Create( Image : TImage );
begin
  inherited Create( Image );
  FImage.OnMouseDown := OnMouseDown;
  FOnClick           := nil;
end;

destructor TBoard.Destroy;
begin
  inherited;
end;

//==============================================================================
// P R I V A T E
//==============================================================================

procedure TBoard.PaintBoard;
var I, J  : integer;
    Color : TColor;
begin
  FImage.Canvas.Brush.Color := CBckgndColor;
  FImage.Canvas.FillRect( FImage.ClientRect );

  for I := 1 to CNumRows do
    for J := 1 to CNumCols do
      begin
        if ((FLetters[I,J].Letter.C = #0) or
            (FLetters[I,J].ThisTurn)) then
          begin
            case CBoard[I,J] of
              stSingle : Color := CEmptyColor;
              stDblL   : Color := CDblLColor;
              stTrpL   : Color := CTrpLColor;
              stDblW   : Color := CDblWColor;
              stTrpW   : Color := CTrpWColor;
              else       Color := CBckgndColor;
            end;

            PaintEmpty( (J-1)*(CStoneSize+1) , (I-1)*(CStoneSize+1) , Color );
          end;
      end;
end;

procedure TBoard.OnMouseDown( Sender: TObject; Button: TMouseButton;
                              Shift: TShiftState; X, Y: Integer );
var I, J : integer;
begin
  if ((X = 0) or
      (X = FImage.Width-1) or
      (Y = 0) or
      (Y = FImage.Height-1)) then
    exit;

  I := (X div (CStoneSize + 1)) + 1;
  J := (Y div (CStoneSize + 1)) + 1;

  if (Assigned( FOnClick )) then
    FOnClick( I , J );
end;

//==============================================================================
// P U B L I C
//==============================================================================

procedure TBoard.Clear;
var I, J  : integer;
begin
  for I := 1 to CNumRows do
    for J := 1 to CNumCols do
      FLetters[I,J].Letter.C := #0;

  PaintBoard;
end;

function TBoard.AddLetter( X, Y : integer; var Letter : TLetter ) : boolean;
begin
  if (FLetters[Y,X].Letter.C = #0) then
    begin
      if (Letter.C = '?') then
        begin
          FormJoker.ShowModal;
          if ((FormJoker.Edit.Text <> '') and
              (UpCase( FormJoker.Edit.Text[1] ) in ['A'..'Z'])) then
            Letter.C := LowerCase( FormJoker.Edit.Text[1] )[1]
          else
            begin
              Result := false;
              exit;
            end;
        end;

      FLetters[Y,X].Letter   := Letter;
      FLetters[Y,X].ThisTurn := true;

      PaintLetter( FLetters[Y,X].Letter , X , Y , CLtrColor , CLtrBckColor );

      Result := true;
    end
  else
    Result := false;
end;

procedure TBoard.RemoveLetter( X, Y : integer );
var Color : TColor;
begin
  FLetters[Y,X].Letter.C := #0;
  FLetters[Y,X].ThisTurn := false;

  case CBoard[Y,X] of
    stSingle : Color := CEmptyColor;
    stDblL   : Color := CDblLColor;
    stTrpL   : Color := CTrpLColor;
    stDblW   : Color := CDblWColor;
    stTrpW   : Color := CTrpWColor;
    else       Color := CBckgndColor;
  end;

  PaintEmpty( (X-1)*(CStoneSize+1) , (Y-1)*(CStoneSize+1) , Color );
end;

procedure TBoard.EndMove;
var I, J : integer;
begin
  for I := 1 to CNumRows do
    for J := 1 to CNumCols do
      if (FLetters[I,J].ThisTurn) then
        begin
          FLetters[I,J].ThisTurn := false;
          PaintLetter( FLetters[I,J].Letter , J , I , CLtrColor , CLtrBckColor );
        end;
end;

function TBoard.GetScore : integer;
var I,J       : integer;
    Word      : string;
    IsNew     : boolean;
    WordScore : integer;
    LtrScore  : integer;
    Count     : integer;
begin
  Result := 0;

  for I := 1 to CNumRows do
    begin
      Word      := '';
      IsNew     := false;
      WordScore := 1;
      LtrScore  := 0;
      J         := 1;
      repeat
        if (FLetters[I,J].Letter.C <> #0) then
          begin
            Word := Word + FLetters[I,J].Letter.C;

            Inc( LtrScore , FLetters[I,J].Letter.Value );

            if (FLetters[I,J].ThisTurn) then
              case (CBoard[I,J]) of
                stDblL   : Inc( LtrScore , FLetters[I,J].Letter.Value );
                stTrpL   : Inc( LtrScore , FLetters[I,J].Letter.Value*2 );
                stDblW   : WordScore := WordScore*2;
                stTrpW   : WordScore := WordScore*3;
              end;

            if (FLetters[I,J].ThisTurn) then
              IsNew := true;
          end
        else
          begin
            if ((Word <> '') and
                (Length( Word ) > 1) and
                (IsNew)) then
              Result := Result + (LtrScore*WordScore);

            Word      := '';
            IsNew     := false;
            WordScore := 1;
            LtrScore  := 0;
          end;

        Inc( J );

        if ((J > CNumCols) and
            (Word <> '') and
            (Length( Word ) > 1) and
            (IsNew)) then
          Result := Result + (LtrScore*WordScore);

      until (J > CNumCols);
    end;

  for J := 1 to CNumCols do
    begin
      Word      := '';
      IsNew     := false;
      WordScore := 1;
      LtrScore  := 0;
      I         := 1;
      repeat
        if (FLetters[I,J].Letter.C <> #0) then
          begin
            Word := Word + FLetters[I,J].Letter.C;

            Inc( LtrScore , FLetters[I,J].Letter.Value );

            if (FLetters[I,J].ThisTurn) then
              case (CBoard[I,J]) of
                stDblL   : Inc( LtrScore , FLetters[I,J].Letter.Value );
                stTrpL   : Inc( LtrScore , FLetters[I,J].Letter.Value*2 );
                stDblW   : WordScore := WordScore*2;
                stTrpW   : WordScore := WordScore*3;
              end;

            if (FLetters[I,J].ThisTurn) then
              IsNew := true;
          end
        else
          begin
            if ((Word <> '') and
                (Length( Word ) > 1) and
                (IsNew)) then
              Result := Result + (LtrScore*WordScore);

            Word      := '';
            IsNew     := false;
            WordScore := 1;
            LtrScore  := 0;
          end;

        Inc( I );

        if ((I > CNumRows) and
            (Word <> '') and
            (Length( Word ) > 1) and
            (IsNew)) then
          Result := Result + (LtrScore*WordScore);

      until (I > CNumRows);
    end;

  Count := 0;
  for I := Low( FLetters ) to High( FLetters ) do
    for J := Low( FLetters[I] ) to High( FLetters[I] ) do
      if (FLetters[I,J].ThisTurn) then
        Inc( Count );

  if (Count = 7) then
    Inc( Result , 50 );
end;

end.
