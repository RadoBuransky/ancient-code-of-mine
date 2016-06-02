unit FormMoznosti;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls;

type
  TFormMozn = class(TForm)
    PageControl: TPageControl;
    TabSheetText: TTabSheet;
    TabSheetHead: TTabSheet;
    ButtonOK: TButton;
    LabelPath: TLabel;
    ButtonFile: TButton;
    Memo: TMemo;
    OpenDialog: TOpenDialog;
    LabelBMP: TLabel;
    ButtonBMP: TButton;
    Label1: TLabel;
    EditS: TEdit;
    EditV: TEdit;
    Label2: TLabel;
    ScrollBox: TScrollBox;
    Image: TImage;
    RadioGroup1: TRadioGroup;
    procedure ButtonFileClick(Sender: TObject);
    procedure ButtonOKClick(Sender: TObject);
    procedure MemoExit(Sender: TObject);
    procedure ButtonBMPClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure NacitajHlavicku( FileName : string );
    procedure NacitajText( FileName : string );
  public
    { Public declarations }
    SpolocnyText : TStringList;
    Header : TPicture;
  end;

var
  FormMozn: TFormMozn;

implementation

uses ClassPonuka, Printers, Ini;

{$R *.DFM}

//==============================================================================
//==============================================================================
//
//                                 Constructor
//
//==============================================================================
//==============================================================================

procedure TFormMozn.FormCreate(Sender: TObject);
begin
  SpolocnyText := TStringList.Create;

  if hlavicka <> '' then NacitajHlavicku( hlavicka );
  if spol_text <> '' then NacitajText( spol_text );

  EditV.Text := IntToStr( Vyska_def );
  EditS.Text := IntToStr( (Printer.PageWidth-Left_def-Right_def) );
end;

//==============================================================================
//==============================================================================
//
//                                 Destructor
//
//==============================================================================
//==============================================================================

procedure TFormMozn.FormDestroy(Sender: TObject);
begin
  SpolocnyText.Free;
end;

//==============================================================================
//==============================================================================
//
//                                   Events
//
//==============================================================================
//==============================================================================

procedure TFormMozn.ButtonFileClick(Sender: TObject);
begin
  with OpenDialog do
    begin
      InitialDir := texty_dir;
      FileName := '';
      DefaultExt := '*.txt';
      Filter := 'PC PROMPT texty|*.txt';
      Title := 'Otvoriù text';
    end;

  if OpenDialog.Execute then
    begin
      spol_text := OpenDialog.FileName;
      texty_dir := ExtractFileDir( spol_text )+'\';

      NacitajText( spol_text );
    end;
end;

procedure TFormMozn.ButtonOKClick(Sender: TObject);
begin
  ModalResult := 1;
end;

procedure TFormMozn.MemoExit(Sender: TObject);
var I : integer;
begin
  AssignFile( Output , spol_text );

  Rewrite( Output );

  for I := 0 to Memo.Lines.Count-1 do
    Writeln( Memo.Lines[I] );

  CloseFile( Output );

  SpolocnyText.Assign( Memo.Lines );
end;

procedure TFormMozn.ButtonBMPClick(Sender: TObject);
begin
  with OpenDialog do
    begin
      InitialDir := hlavicky_dir;
      FileName := '';
      DefaultExt := '*.bmp';
      Filter := 'PC PROMPT hlaviËky|*.bmp';
      Title := 'Otvoriù hlaviËku';
    end;

  if OpenDialog.Execute then
    begin
      hlavicka := OpenDialog.FileName;
      hlavicky_dir := ExtractFileDir( hlavicka )+'\';

      NacitajHlavicku( hlavicka );
    end;
end;

//==============================================================================
//==============================================================================
//
//                              Pr·ca so s˙borom
//
//==============================================================================
//==============================================================================

procedure TFormMozn.NacitajHlavicku( FileName : string );
begin
  try
    LabelBMP.Caption := FileName;
    Image.Picture.LoadFromFile( FileName );
  except
    LabelBMP.Caption := '';
  end;
  Header := Image.Picture;
end;

procedure TFormMozn.NacitajText( FileName : string );
var S : string;
begin
  LabelPath.Caption := FileName;

  Memo.Clear;
  Memo.Enabled := True;

  AssignFile( Input , FileName );
  {$I-}
  Reset( Input );
  {$I+}
  if IOResult <> 0 then
    begin
      LabelPath.Caption := '';
      Memo.Enabled := False;
      exit;
    end;

  while not EoF( Input ) do
    begin
      Readln( S );
      Memo.Lines.Add( S );
    end;

  CloseFile( Input );

  SpolocnyText.Assign( Memo.Lines );
end;

end.
