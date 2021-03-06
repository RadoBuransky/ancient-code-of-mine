unit UnitMainForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, Grids, ExtCtrls, ComCtrls, Buttons, Gif, ExtDlgs,
  ImgList;

type
  TZastavka = record
    Off, Pasmo : byte;
    Nazov : string;
  end;

  TSubor = record
    Cislo : byte;
    Typ : byte;
    PlatnyOd, PlatnyDo : string;
    Zastavky : array of TZastavka;
    Poc : integer;
    Roz : array[0..3] of array[0..23,0..19] of integer;
  end;

  TMainForm = class(TForm)
    MainMenu: TMainMenu;
    File1: TMenuItem;
    New1: TMenuItem;
    Open1: TMenuItem;
    Exit1: TMenuItem;
    OpenDialog: TOpenDialog;
    Label1: TLabel;
    EditCislo: TEdit;
    Label2: TLabel;
    ComboBoxTyp: TComboBox;
    Label3: TLabel;
    EditOd: TEdit;
    EditDo: TEdit;
    Label4: TLabel;
    StringGridZast: TStringGrid;
    Button1: TButton;
    Save1: TMenuItem;
    SaveDialog: TSaveDialog;
    PageControl: TPageControl;
    TabSheet1: TTabSheet;
    ScrollBox: TScrollBox;
    TabSheet2: TTabSheet;
    MemoVyuc: TMemo;
    MemoPrazd: TMemo;
    MemoSv: TMemo;
    ButtonRec: TButton;
    SpeedButton: TSpeedButton;
    Image: TGif;
    OpenDialogPic: TOpenDialog;
    LabelHint: TLabel;
    ImageList: TImageList;
    procedure Exit1Click(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure New1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Save1Click(Sender: TObject);
    procedure StringGridZastKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StringGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ButtonRecClick(Sender: TObject);
    procedure SpeedButtonClick(Sender: TObject);
    procedure EditCisloKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ComboBoxTypKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditOdKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditDoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    Subor : TSubor;

    Memos : array[1..3] of TMemo;
    procedure RecognizeRect( Rect : TRect; Memo : TMemo );

    procedure InitSubor;

    procedure OtvorSubor( FileName : string );
      function SpracujRiadok( S : string ) : TZastavka;

    procedure UlozSubor( FileName : string );
      
    procedure SuborToForm;
    procedure FormToSubor;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses ClassOCR;

{$R *.DFM}

//==============================================================================
//==============================================================================
//
//                              Constructor
//
//==============================================================================
//==============================================================================

procedure TMainForm.InitSubor;
var I, J : integer;
begin
  with Subor do
    begin
      Cislo := 0;
      Typ := 0;
      PlatnyOd := '00.00.0000';
      PlatnyDo := '01.07.2001';
      Poc := 3;
      SetLength( Zastavky , 0 );
      for I := 0 to Poc-1 do
        for J := 0 to 23 do
          Roz[I,J,0] := -1;
    end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  OCR := TOcr.Create( ImageList );

  Memos[1] := MemoVyuc;
  Memos[2] := MemoPrazd;
  Memos[3] := MemoSv;

  with StringGridZast do
    begin
      ColWidths[0] := 20;
      ColWidths[1] := 20;
      ColWidths[2] := 120;
    end;

  InitSubor;
  SuborToForm;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  OCR.Free;
end;

//==============================================================================
//==============================================================================
//
//                               Main menu
//
//==============================================================================
//==============================================================================

procedure TMainForm.New1Click(Sender: TObject);
var I : integer;
begin
  InitSubor;
  SuborToForm;

  for I := 0 to 2 do
    StringGridZast.Rows[I].Clear;

  StringGridZast.Cells[0,0] := 'Offset';
  StringGridZast.Cells[1,0] := 'P�smo';
  StringGridZast.Cells[2,0] := 'Zastavka';
end;

procedure TMainForm.Exit1Click(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.Open1Click(Sender: TObject);
begin
  if OpenDialog.Execute then
    begin
      OtvorSubor( OpenDialog.FileName );
      SuborToForm;
    end;
end;

//==============================================================================
//==============================================================================
//
//                                  Convert
//
//==============================================================================
//==============================================================================

procedure TMainForm.SuborToForm;
var I, J : integer;
    S1, S2, S3 : string;
begin
  MemoVyuc.Clear;
  MemoPrazd.Clear;
  MemoSv.Clear;

  EditCislo.Text := IntToStr( Subor.Cislo );
  ComboBoxTyp.ItemIndex := Subor.Typ;
  EditOd.Text := Subor.PlatnyOd;
  EditDo.Text := Subor.PlatnyDo;

  if Length( Subor.Zastavky )+1 = 1 then
    begin
      StringGridZast.RowCount := 2;
      StringGridZast.Cells[ 0 , 1 ] := '';
      StringGridZast.Cells[ 1 , 1 ] := '';
      StringGridZast.Cells[ 2 , 1 ] := '';
    end
      else
    StringGridZast.RowCount := Length( Subor.Zastavky )+1;

  for I := 0 to Length( Subor.Zastavky )-1 do
    begin
      StringGridZast.Cells[ 0 , 1+I ] := IntToStr( Subor.Zastavky[I].Off );
      StringGridZast.Cells[ 1 , 1+I ] := IntToStr( Subor.Zastavky[I].Pasmo );
      StringGridZast.Cells[ 2 , 1+I ] := Subor.Zastavky[I].Nazov;
    end;

  for I := 0 to 23 do
    begin
      S1 := '';
      S2 := '';
      S3 := '';

      J := 0;
      while Subor.Roz[0][I,J] <> -1  do
        begin
          S1 := S1+IntToStr( Subor.Roz[0][I,J] )+' ';
          Inc( J );
        end;

      J := 0;
      while Subor.Roz[1][I,J] <> -1  do
        begin
          S2 := S2+IntToStr( Subor.Roz[1][I,J] )+' ';
          Inc( J );
        end;

      J := 0;
      while Subor.Roz[2][I,J] <> -1  do
        begin
          S3 := S3+IntToStr( Subor.Roz[2][I,J] )+' ';
          Inc( J );
        end;

      MemoVyuc.Lines.Add( S1 );
      MemoPrazd.Lines.Add( S2 );
      MemoSv.Lines.Add( S3 );
    end;
end;

procedure TMainForm.FormToSubor;
var I, J, K : integer;
    S : string;

function GetWord( S : string; var I : integer ) : string;
begin
  Result := '';
  if I > Length( S ) then exit;
  while (S[I] = ' ') and
        (I <= Length( S )) do Inc( I );
  if I > Length( S ) then exit;
  while (S[I] <> ' ') and
        (I <= Length( S )) do
    begin
      Result := Result + S[I];
      Inc( I );
    end;
end;

begin
  InitSubor;

  with Subor do
    try
      Cislo := StrToInt( EditCislo.Text );
      Typ := ComboBoxTyp.ItemIndex;
      PlatnyOd := EditOd.Text;
      PlatnyDo := EditDo.Text;

      SetLength( Zastavky , StringGridZast.RowCount-1 );
      for I := 1 to StringGridZast.RowCount-1 do
        begin
          if StringGridZast.Cells[0,I] = '' then StringGridZast.Cells[0,I] := '0';
          if StringGridZast.Cells[1,I] = '' then StringGridZast.Cells[1,I] := '0';
          Zastavky[I-1].Off := StrToInt( StringGridZast.Cells[0,I] );
          Zastavky[I-1].Pasmo := StrToInt( StringGridZast.Cells[1,I] );
          Zastavky[I-1].Nazov := StringGridZast.Cells[2,I];
        end;

      I := 0;
      while I <= MemoVyuc.Lines.Count-1 do
        begin
          J := 0;
          K := 1;
          repeat
            S := GetWord( MemoVyuc.Lines[I] , K );
            if S <> '' then
              begin
                Subor.Roz[0][I,J] := StrToInt( S );
                Inc( J );
              end;
          until S = '';
          Subor.Roz[0][I,J] := -1;

          Inc( I );
        end;

      I := 0;
      while I <= MemoPrazd.Lines.Count-1 do
        begin
          J := 0;
          K := 1;
          repeat
            S := GetWord( MemoPrazd.Lines[I] , K );
            if S <> '' then
              begin
                Subor.Roz[1][I,J] := StrToInt( S );
                Inc( J );
              end;
          until S = '';
          Subor.Roz[1][I,J] := -1;

          Inc( I );
        end;

      I := 0;
      while I <= MemoSv.Lines.Count-1 do
        begin
          J := 0;
          K := 1;
          repeat
            S := GetWord( MemoSv.Lines[I] , K );
            if S <> '' then
              begin
                Subor.Roz[2][I,J] := StrToInt( S );
                Inc( J );
              end;
          until S = '';
          Subor.Roz[2][I,J] := -1;

          Inc( I );
        end;
    except
    end;
end;

//==============================================================================
//==============================================================================
//
//                                 Praca so suborom
//
//==============================================================================
//==============================================================================

function TMainForm.SpracujRiadok( S : string ) : TZastavka;
var I : integer;
    Pom : string;
begin
  I := 1;
  while S[I] = ' ' do
    Inc( I );

  Pom := '';
  while S[I] <> ' ' do
    begin
      Pom := Pom + S[I];
      Inc( I );
    end;
  Result.Off := StrToInt( Pom );

  while S[I] = ' ' do
    Inc( I );

  Pom := '';
  while S[I] <> ' ' do
    begin
      Pom := Pom + S[I];
      Inc( I );
    end;
  Result.Pasmo := StrToInt( Pom );

  while S[I] = ' ' do
    Inc( I );

  Pom := '';
  while I <= Length( S ) do
    begin
      Pom := Pom + S[I];
      Inc( I );
    end;
  Result.Nazov := Pom;
end;

procedure TMainForm.OtvorSubor( FileName : string );
var I, J, K : integer;
    c : char;
    Min : integer;
    S : string;
begin
  InitSubor;

  AssignFile( Input , FileName );
  Reset( Input );

  Readln( Subor.Cislo );

  Readln( c );
  case c of
    'A' : Subor.Typ := 0;
    'E' : Subor.Typ := 1;
    'T' : Subor.Typ := 2;
    'N' : Subor.Typ := 3;
  end;

  Readln( Subor.PlatnyOd );
  Readln( Subor.PlatnyDo );

  I := 0;
  repeat
    Readln( S );
    SetLength( Subor.Zastavky , Length( Subor.Zastavky ) + 1 );
    Subor.Zastavky[I] := SpracujRiadok( S );
    Inc( I );
  until Subor.Zastavky[I-1].Nazov = 'KONIEC';
  SetLength( Subor.Zastavky , Length( Subor.Zastavky )-1 );

  Readln( Subor.Poc );

  for I := 0 to Subor.Poc-1 do
    for J := 0 to 23 do
      begin
        K := 0;

        Read( Min );
        repeat
          Subor.Roz[I][J,K] := Min;
          if Min = -1 then break;

          Read( Min );
          Inc( K );
        until False;

        Readln;
      end;

  CloseFile( Input );
end;

procedure TMainForm.UlozSubor( FileName : string );
var I, J, K : integer;
begin
  FormToSubor;

  AssignFile( Output , FileName );
  Rewrite( Output );

  Writeln( Subor.Cislo );

  case Subor.Typ of
    0 : Writeln( 'A' );
    1 : Writeln( 'E' );
    2 : Writeln( 'T' );
    3 : Writeln( 'N' );
  end;

  Writeln( Subor.PlatnyOd );

  Writeln( Subor.PlatnyDo );

  for I := 0 to Length( Subor.Zastavky )-1 do
    Writeln( Subor.Zastavky[I].Off ,' ', Subor.Zastavky[I].Pasmo ,' ', Subor.Zastavky[I].Nazov );
  Writeln( '0 0 KONIEC' );

  Writeln( Subor.Poc );

  for I := 0 to Subor.Poc-1 do
    for J := 0 to 23 do
      begin
        K := 0;
        repeat
          Write( Subor.Roz[I][J,K] );
          if Subor.Roz[I][J,K] = -1 then break
                                    else Write( ' ' );
          Inc( K );
        until False;
        Writeln;
      end;

  CloseFile( Output );
end;

//==============================================================================
//==============================================================================
//
//                                   O C R
//
//==============================================================================
//==============================================================================

procedure TMainForm.RecognizeRect( Rect : TRect; Memo : TMemo );
var I, J : integer;
    Bmp : TBitmap;
    S : string;
begin
  Bmp := TBitmap.Create;
  try
    Bmp.Width := Abs(Rect.Right - Rect.Left) + 1;
    Bmp.Height := Abs(Rect.Bottom - Rect.Top) + 1;

    for I := 0 to Bmp.Width-1 do
      for J := 0 to Bmp.Height-1 do
        Bmp.Canvas.Pixels[I,J] := Image.Picture.Bitmap.Canvas.Pixels[Rect.Left+I,Rect.Top+J];

    Ocr.Recognize( Bmp , Memo.Lines );

    for I := 0 to Memo.Lines.Count-1 do
      begin
        S := Memo.Lines[I];
        if Pos( ' ' , S ) > 0 then Delete( S , 1 , Pos( ' ' , S ) )
                              else S := '';
        Memo.Lines[I] := S;
      end;

  finally
    Bmp.Free;
  end;
end;

//==============================================================================
//==============================================================================
//
//                                 Komponenty
//
//==============================================================================
//==============================================================================

procedure TMainForm.Button1Click(Sender: TObject);
var I : integer;
    c : TZastavka;
    Max : integer;
begin
  FormToSubor;

  I := 0;
  while (Length(Subor.Zastavky)-I-1) - I >= 1 do
    begin
      c := Subor.Zastavky[I];
      Subor.Zastavky[I] := Subor.Zastavky[Length(Subor.Zastavky)-I-1];
      Subor.Zastavky[Length(Subor.Zastavky)-I-1] := c;
      Inc( I );
    end;

  Max := Subor.Zastavky[0].Off;
  for I := 0 to Length(Subor.Zastavky)-1 do
    Subor.Zastavky[I].Off := Max - Subor.Zastavky[I].Off;

  SuborToForm;
end;

procedure TMainForm.Save1Click(Sender: TObject);
begin
  if SaveDialog.Execute then
    UlozSubor( SaveDialog.FileName );
end;

procedure TMainForm.StringGridZastKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var A, B : integer;
begin
  if Key = VK_RETURN then
    begin
      if StringGridZast.Cells[ StringGridZast.Col , StringGridZast.Row ] = '' then exit;
      if StringGridZast.Col = 2 then
        begin
          StringGridZast.RowCount := StringGridZast.RowCount + 1;
          StringGridZast.Col := 0;
          StringGridZast.Row := StringGridZast.RowCount-1;
          StringGridZast.Cells[1,StringGridZast.Row] := StringGridZast.Cells[1,StringGridZast.Row-1]; 
        end
          else
        begin
          if (StringGridZast.Col = 0) and
             (StringGridZast.Row > 1) then
            begin
              A := 0;
              B := 0;
              try
                A := StrToInt( StringGridZast.Cells[ StringGridZast.Col , StringGridZast.Row-1 ] );
                B := StrToInt( StringGridZast.Cells[ StringGridZast.Col , StringGridZast.Row ] );
              except
              end;
              if B < A then exit;
            end;
          StringGridZast.Col := StringGridZast.Col + 1;
        end;
    end;
  if Key = VK_DELETE then
    begin
      if StringGridZast.EditorMode then exit;
      if StringGridZast.RowCount = 2 then
        begin
          StringGridZast.Cells[0,1] := '0';
          StringGridZast.Cells[1,1] := '0';
          StringGridZast.Cells[2,1] := '';
        end
          else
        begin
          for A := StringGridZast.Row to StringGridZast.RowCount-2do
            StringGridZast.Rows[A] := StringGridZast.Rows[A+1];
          StringGridZast.RowCount := StringGridZast.RowCount-1;
        end;
    end;
  if Key = VK_INSERT then
    begin
      if StringGridZast.EditorMode then exit;
      StringGridZast.RowCount := StringGridZast.RowCount+1;
      for A := StringGridZast.RowCount-1 downto StringGridZast.Row do
        StringGridZast.Rows[A] := StringGridZast.Rows[A-1];
      StringGridZast.Rows[StringGridZast.Row].Clear;
    end;
end;

procedure TMainForm.StringGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var A, B : integer;
begin
  if Key = VK_RETURN then
    with TStringGrid( Sender ) do
      begin
        if Cells[ Col , Row ] = '' then
          begin
            Col := 1;
            if (Row < RowCount-1) then Row := Row + 1;
          end
            else
          begin
            A := 0;
            B := 0;
            try
              A := StrToInt( Cells[ Col-1 , Row ] );
              B := StrToInt( Cells[ Col , Row ] );
            except
            end;

            if (B < 0) or
               (B > 59) then exit;

            if Col > 1 then
              if (B <= A) then exit;

            Col := Col + 1;
          end;
      end;
end;

procedure TMainForm.ButtonRecClick(Sender: TObject);
const R : array[1..3] of TRect =
          ((Left:220;Top:70;Right:482;Bottom:470),
           (Left:479;Top:70;Right:705;Bottom:496),
           (Left:215;Top:495;Right:665;Bottom:905));
var I : integer;
begin
  try
    Screen.Cursor := crHourGlass;
    for I := 1 to 3 do
      RecognizeRect( R[I] , Memos[I] );
  finally
    Screen.Cursor := crDefault;
    ButtonRec.Enabled := False;
  end;
  FormToSubor;
end;

procedure TMainForm.SpeedButtonClick(Sender: TObject);
begin
  if OpenDialogPic.Execute then
    if (ExtractFileExt( OpenDialogPic.FileName ) = '.gif') then Image.GIFFile := OpenDialogPic.FileName
                                                           else Image.Picture.LoadFromFile( OpenDialogPic.FileName );
  ButtonRec.Enabled := True;
end;

procedure TMainForm.EditCisloKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN : ComboBoxTyp.SetFocus;
  end;
end;

procedure TMainForm.ComboBoxTypKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN : EditOd.SetFocus;
  end;
end;

procedure TMainForm.EditOdKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN : EditDo.SetFocus;
  end;
end;

procedure TMainForm.EditDoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN : StringGridZast.SetFocus;
  end;
end;

end.


