unit FormText;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls;

type
  TDialogSpolocnyText = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Bevel1: TBevel;
    Memo: TMemo;
    RadioGroupVyber: TRadioGroup;
    procedure OKBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure RadioGroupVyberClick(Sender: TObject);
    procedure MemoExit(Sender: TObject);
  private
    { Private declarations }
    Memo1, Memo2, Memo3 : TMemo;

    procedure NacitajText( iCesta : string; iMemo : TMemo );
    procedure ZapisText( iCesta : string; iMemo : TMemo );
  public
    { Public declarations }
  end;

var
  DialogSpolocnyText: TDialogSpolocnyText;

implementation

uses FormHlavneOkno;

{$R *.DFM}

//==============================================================================
//==============================================================================
//
//                                  Constrcutor
//
//==============================================================================
//==============================================================================
procedure TDialogSpolocnyText.FormCreate(Sender: TObject);
begin
  Memo1 := TMemo.CreateParented( Memo.Handle );
  Memo2 := TMemo.CreateParented( Memo.Handle );
  Memo3 := TMemo.CreateParented( Memo.Handle );

  NacitajText( 'text1.txt' , Memo1 );
  NacitajText( 'text2.txt' , Memo2 );
  NacitajText( 'text3.txt' , Memo3 );

  HlavneOkno.SpolocnyText.Assign( Memo1.Lines );
end;

//==============================================================================
//==============================================================================
//
//                                  Destrcutor
//
//==============================================================================
//==============================================================================
procedure TDialogSpolocnyText.FormDestroy(Sender: TObject);
begin
  ZapisText( HlavneOkno.CestaDef+'\text1.txt' , Memo1 );
  ZapisText( HlavneOkno.CestaDef+'\text2.txt' , Memo2 );
  ZapisText( HlavneOkno.CestaDef+'\text3.txt' , Memo3 );

  Memo1.Free;
  Memo2.Free;
  Memo3.Free;
end;

//==============================================================================
//==============================================================================
//
//                               Praca so suborom
//
//==============================================================================
//==============================================================================

procedure TDialogSpolocnyText.NacitajText( iCesta : string; iMemo : TMemo );
var Riadok : string;
begin
  AssignFile( Input , iCesta );
  {$I-}
  Reset( Input );
  {$I+}

  iMemo.Lines.Clear;

  if IOResult <> 0 then exit;

  while not EoF( Input ) do
    begin
      Readln( Riadok );
      iMemo.Lines.Add( Riadok );
    end;

  CloseFile( Input );
end;

procedure TDialogSpolocnyText.ZapisText( iCesta : string; iMemo : TMemo );
var I : integer;
begin
  AssignFile( Output , iCesta );
  Rewrite( Output );

  for I := 0 to iMemo.Lines.Count-1 do
    Writeln( iMemo.Lines[I] );

  CloseFile( Output );
end;


//==============================================================================
//==============================================================================
//
//                             K o m p o n e n t y
//
//==============================================================================
//==============================================================================

procedure TDialogSpolocnyText.OKBtnClick(Sender: TObject);
begin
  case RadioGroupVyber.ItemIndex of
    0 : Memo1.Lines.Assign( Memo.Lines );
    1 : Memo2.Lines.Assign( Memo.Lines );
    2 : Memo3.Lines.Assign( Memo.Lines );
  end;

  HlavneOkno.Spolontext1.Caption := '&Spoloèný text('+IntToStr( RadioGroupVyber.ItemIndex+1 )+')';
  HlavneOkno.SpolocnyText.Assign( Memo.Lines );

  Close;
end;

procedure TDialogSpolocnyText.CancelBtnClick(Sender: TObject);
begin
  Close;
end;

procedure TDialogSpolocnyText.RadioGroupVyberClick(Sender: TObject);
begin
  if RadioGroupVyber.ItemIndex = -1 then Memo.Visible := False
                                    else
                                      begin
                                        Memo.Visible := True;
                                        case RadioGroupVyber.ItemIndex of
                                          0 : Memo.Lines.Assign( Memo1.Lines );
                                          1 : Memo.Lines.Assign( Memo2.Lines );
                                          2 : Memo.Lines.Assign( Memo3.Lines );
                                        end;
                                      end;
end;

procedure TDialogSpolocnyText.MemoExit(Sender: TObject);
begin
  case RadioGroupVyber.ItemIndex of
    0 : Memo1.Lines.Assign( Memo.Lines );
    1 : Memo2.Lines.Assign( Memo.Lines );
    2 : Memo3.Lines.Assign( Memo.Lines );
  end;
end;

end.

