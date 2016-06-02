unit ClassGame;

interface

uses ClassPlayer, ClassHuman, ClassComputer, ClassLetters, ClassBoard,
     ClassLetterBoard, ClassScoreBoard, ClassWords, ExtCtrls, Controls, Forms,
     StdCtrls;

type TGameType = ( gtDontKnow, gtHvsH, gtHvsC, gtCvsH, gtCvsC );

     TGame = class
     private
       FPlayer1      : TPlayer;
       FPlayer2      : TPlayer;
       FLetters      : TLetters;
       FBoard        : TBoard;
       FLetterBrd    : TLetterBoard;
       FScoreBrd     : TScoreBoard;
       FWords        : TWords;

       FImBoard      : TImage;
       FImLtrBoard   : TImage;
       FImScBoard    : TImage;
       FLabel        : TLabel;

       FActivePlayer : TPlayer;
       FFirstMove    : boolean;
       FPasses       : integer;

       function      CheckWord( Word : string ) : boolean;
       function      RulesOK : boolean;
       procedure     EndGame( StackEmpty : boolean );
     public
       constructor Create( Board, LetterBoard, ScoreBoard : TImage; Label1 : TLabel );
       destructor  Destroy; override;

       procedure   New( GameType : TGameType );
       procedure   Load( FileName : string );
       procedure   Save( FileName : string );
       procedure   OnPlay;
       procedure   OnTile;
       procedure   OnChange;
     end;

implementation

uses SysUtils, Dialogs, UnitFormWinner, UnitFormNewGame;

//==============================================================================
// Constructor / destructor
//==============================================================================

constructor TGame.Create( Board, LetterBoard, ScoreBoard : TImage; Label1 : TLabel );
begin
  inherited Create;

  FPlayer1      := nil;
  FPlayer2      := nil;
  FLetters      := TLetters.Create;
  FBoard        := TBoard.Create( Board );
  FLetterBrd    := TLetterBoard.Create( LetterBoard );
  FScoreBrd     := TScoreBoard.Create( ScoreBoard );
  FWords        := TWords.Create( 'English.pck' );

  FImBoard      := Board;
  FImLtrBoard   := LetterBoard;
  FImScBoard    := ScoreBoard;
  FLabel        := Label1;

  FActivePlayer := nil;
  FFirstMove    := false;
  FPasses       := 0;
end;

destructor TGame.Destroy;
begin
  FLetters.Free;
  FBoard.Free;
  FLetterBrd.Free;
  FScoreBrd.Free;
  FWords.Free;

  inherited;
end;

//==============================================================================
// P R I V A T E
//==============================================================================

function TGame.CheckWord( Word : string ) : boolean;
begin
  Result := FWords.ExistsWord( Word );

  if (not Result) then
    MessageDlg( 'Word "'+Word+'" doesn''t exists!' , mtCustom , [mbOk] , 0 );
end;

function TGame.RulesOK : boolean;
const CSur : array[0..3] of
              record
                dX, dY : integer;
              end =
            ((dX:-1;dY:0),
             (dX:0;dY:1),
             (dX:1;dY:0),
             (dX:0;dY:-1));
var I, J : integer;
    Word  : string;
    New   : boolean;
begin
  if (FFirstMove) then
    begin
      Result := false;
      for I := 0 to Length( FActivePlayer.LastMove )-1 do
        if ((FActivePlayer.LastMove[I].X = 8) and
            (FActivePlayer.LastMove[I].Y = 8)) then
          begin
            Result := true;
            break;
          end;

      if (not Result) then
        begin
          MessageDlg( 'First word must be placed in the center!' , mtCustom ,
                      [mbOk] , 0 );
          exit;
        end;
    end
  else
    begin
      Result := false;
      for I := 0 to Length( FActivePlayer.LastMove )-1 do
        begin
          for J := 0 to 3 do
            if ((FActivePlayer.LastMove[I].X + CSur[J].dX >= 1) and
                (FActivePlayer.LastMove[I].X + CSur[J].dX <= CNumRows) and
                (FActivePlayer.LastMove[I].Y + CSur[J].dY >= 1) and
                (FActivePlayer.LastMove[I].Y + CSur[J].dY <= CNumCols)) then
              if ((FBoard.Letters[FActivePlayer.LastMove[I].Y + CSur[J].dY,FActivePlayer.LastMove[I].X + CSur[J].dX].Letter.C <> #0) and
                  (not FBoard.Letters[FActivePlayer.LastMove[I].Y + CSur[J].dY,FActivePlayer.LastMove[I].X + CSur[J].dX].ThisTurn)) then
                begin
                  Result := true;
                  break;
                end;
        end;

      if (not Result) then
        begin
          MessageDlg( 'Word must be placed near existing one!' , mtCustom ,
                      [mbOk] , 0 );
          exit;
        end;
    end;

  for J := 1 to CNumCols do
    begin
      I := 1;
      repeat
        if (FBoard.Letters[I,J].Letter.C <> #0) then
          begin
            Word := '';
            New  := false;
            repeat
              if (FBoard.Letters[I,J].Letter.C = #0) then
                break;

              if (FBoard.Letters[I,J].ThisTurn) then
                New := true;

              Word := Word + FBoard.Letters[I,J].Letter.C;

              Inc( I );
            until (I > CNumRows);

            if ((New) and
                (Length( Word ) > 1)) then
              if (not CheckWord( Word )) then
                begin
                  Result := false;
                  exit;
                end;
          end
        else
          Inc( I );
      until I > CNumRows;
    end;

  for I := 1 to CNumRows do
    begin
      J := 1;
      repeat
        if (FBoard.Letters[I,J].Letter.C <> #0) then
          begin
            Word := '';
            New  := false;
            repeat
              if (FBoard.Letters[I,J].Letter.C = #0) then
                break;

              if (FBoard.Letters[I,J].ThisTurn) then
                New := true;

              Word := Word + FBoard.Letters[I,J].Letter.C;

              Inc( J );
            until (J > CNumCols);

            if ((New) and
                (Length( Word ) > 1)) then
              if (not CheckWord( Word )) then
                begin
                  Result := false;
                  exit;
                end;
          end
        else
          Inc( J );
      until J > CNumCols;
    end;
end;

procedure TGame.EndGame( StackEmpty : boolean );
var Rest1, Rest2 : integer;
    Score1, Score2 : integer;
begin
  Rest1 := FPlayer1.GetRest;
  Rest2 := FPlayer2.GetRest;

  Score1 := FPlayer1.Score;
  Score2 := FPlayer2.Score;

  Dec( Score1 , Rest1 );
  if (Score1 < 0) then
    Score1 := 0;

  Dec( Score2 , Rest2 );
  if (Score2 < 0) then
    Score2 := 0;

  if (StackEmpty) then
    begin
      if (FActivePlayer = FPlayer1) then
        Inc( Score1 , Rest2 )
      else
        Inc( Score2 , Rest1 );
    end;

  if (FPlayer1 is THuman) then
    FormWinner.Label1.Caption := 'Player 1 : '
  else
    FormWinner.Label1.Caption := 'Comp : ';

  if (FPlayer2 is THuman) then
    FormWinner.Label2.Caption := 'Player 2 : '
  else
    FormWinner.Label2.Caption := 'Comp : ';

  FormWinner.Label1.Caption := FormWinner.Label1.Caption + IntToStr( Score1 );
  FormWinner.Label2.Caption := FormWinner.Label2.Caption + IntToStr( Score2 );

  FormWinner.ShowModal;

  New( gtDontKnow );
end;

//==============================================================================
// P U B L I C
//==============================================================================

procedure TGame.New( GameType : TGameType );
var Result : integer;
begin
  if (FPlayer1 <> nil) then
    FPlayer1.Free;

  if (FPlayer2 <> nil) then
    FPlayer2.Free;

  if (GameType = gtDontKnow) then
    begin
      repeat
        Result := FormNewGame.ShowModal;
        if (Result < 10) then
          MessageDlg( 'Please, choose your opponent and click OK!' , mtCustom , [mbOk] , 0 )
      until Result > 10;

      case (Result) of
        11 : GameType := gtHvsH;
        12 : GameType := gtHvsC;
        21 : GameType := gtCvsH;
        22 : GameType := gtCvsC;
      end;
    end;

  case (GameType) of
    gtHvsH : begin
               FPlayer1 := THuman.Create( FLetters , FBoard , FLetterBrd );
               FPlayer2 := THuman.Create( FLetters , FBoard , FLetterBrd );

               FScoreBrd.Player1 := pPl1;
               FScoreBrd.Player2 := pPl2;
             end;

    gtCvsH : begin
               FPlayer1 := TComputer.Create( FLetters , FBoard , OnPlay , OnTile , FWords );
               FPlayer2 := THuman.Create( FLetters , FBoard , FLetterBrd );

               FScoreBrd.Player1 := pComp1;
               FScoreBrd.Player2 := pPl2;
             end;

    gtHvsC : begin
               FPlayer2 := TComputer.Create( FLetters , FBoard , OnPlay , OnTile , FWords );
               FPlayer1 := THuman.Create( FLetters , FBoard , FLetterBrd );

               FScoreBrd.Player2 := pComp1;
               FScoreBrd.Player1 := pPl1;
             end;

    gtCvsC : begin
               FPlayer1 := TComputer.Create( FLetters , FBoard , OnPlay , OnTile , FWords );
               FPlayer2 := TComputer.Create( FLetters , FBoard , OnPlay , OnTile , FWords );

               FScoreBrd.Player1 := pComp1;
               FScoreBrd.Player2 := pComp1;
             end;
  end;

  FBoard.Clear;
  FLetters.Reset;
  FScoreBrd.Reset;

  FPlayer1.TakeLetters;
  FPlayer2.TakeLetters;

  FActivePlayer := nil;
  FFirstMove    := true;
  FPasses       := 0;

  OnPlay;
end;

procedure TGame.Load( FileName : string );
begin
end;

procedure TGame.Save( FileName : string );
begin
end;

procedure TGame.OnPlay;
label Zaciatok;
begin
  Zaciatok :
  if (FActivePlayer = nil) then
    FActivePlayer := FPlayer1
  else
    begin
      if (Length( FActivePlayer.LastMove ) = 0) then
        begin
          if (FActivePlayer is TComputer) then
            FActivePlayer.EndMove;

          Inc( FPasses );
          if (FPasses = 4) then
            begin
              EndGame( False );
              exit;
            end;
        end
      else
        begin
          if ((FActivePlayer is THuman) and
              (not RulesOK)) then
            exit;

          FPasses := 0;
          FActivePlayer.Score := FActivePlayer.Score + FBoard.GetScore;
          if (FActivePlayer.EndMove) then
            begin
              EndGame( True );
              exit;
            end;

          if (FFirstMove) then
            FFirstMove := false;
        end;

      if (FActivePlayer = FPlayer1) then
        begin
          FScoreBrd.Score1 := FActivePlayer.Score;
          FActivePlayer    := FPlayer2
        end
      else
        begin
          FScoreBrd.Score2 := FActivePlayer.Score;
          FActivePlayer    := FPlayer1;
        end;
    end;

  FLetterBrd.SetStack( FActivePlayer.LtrStack );

  if (FActivePlayer = FPlayer1) then
    FLabel.Caption := 'Player 1'
  else
    FLabel.Caption := 'Player 2';

  Application.ProcessMessages;
  FActivePlayer.MakeMove( FFirstMove );

  if (FActivePlayer is TComputer) then
    goto Zaciatok;
end;

procedure TGame.OnTile;
begin
  if (Length( FActivePlayer.LastMove ) = 0) then
    begin
      FActivePlayer.ChangeLetters;
      Dec( FPasses );
      OnPlay;
    end
  else
    MessageDlg( 'If you want to change whole rack, you cannot use any letter!' , mtCustom , [mbOk] , 0 )
end;

procedure TGame.OnChange;
begin
  if (Length( FActivePlayer.LastMove ) = 0) then
    begin
      FActivePlayer.ChangeSomeLetters;
      Dec( FPasses );
      OnPlay;
    end
  else
    MessageDlg( 'If you want to change some tiles, you cannot use any letter!' , mtCustom , [mbOk] , 0 )
end;

end.
