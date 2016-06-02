unit FrmNastavenieCasu;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ClassHladanie, ComCtrls;

type
  TFormNastavenieCasu = class(TForm)
    ButtonOK: TButton;
    ButtonCancel: TButton;
    PageControl: TPageControl;
    TabSheet1: TTabSheet;
    RadioGroupDen: TRadioGroup;
    Image: TImage;
    EditHod: TEdit;
    Label1: TLabel;
    EditMin: TEdit;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    Edit2: TEdit;
    Label3: TLabel;
    ListViewListky: TListView;
    ButtonPridat: TButton;
    ButtonObnov: TButton;
    ButtonDelete: TButton;
    CheckBox4: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ButtonOKClick(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure EditHodExit(Sender: TObject);
    procedure EditMinExit(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure ListViewListkySelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure ButtonDeleteClick(Sender: TObject);
    procedure ButtonPridatClick(Sender: TObject);
    procedure ButtonObnovClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    SBackup : TSettings;
    Povodny : TBitmap;

    procedure SettingsToForm;
    procedure FormToSettings;
  public
    { Public declarations }
    Settings : TSettings;
  end;

var
  FormNastavenieCasu: TFormNastavenieCasu;

implementation

uses FrmAddTicket, Konstanty;

{$R *.DFM}

//==============================================================================
//==============================================================================
//
//                                Constructor
//
//==============================================================================
//==============================================================================

procedure TFormNastavenieCasu.FormCreate(Sender: TObject);
begin
  Povodny := TBitmap.Create;
  Povodny.LoadFromFile( HODINY_FILE );

  with Settings do
    begin
      Time := DEF_SETTINGS.Time;
      Den := DEF_SETTINGS.Den;
      Listky := TICKETS;
      Zlavneny := DEF_SETTINGS.Zlavneny;
      Rezerva := DEF_SETTINGS.Rezerva;
      AutoShow := DEF_SETTINGS.AutoShow;
    end;

  SettingsToForm;
end;

//==============================================================================
//==============================================================================
//
//                                Destructor
//
//==============================================================================
//==============================================================================

procedure TFormNastavenieCasu.FormDestroy(Sender: TObject);
begin
  Povodny.Free;
end;

//==============================================================================
//==============================================================================
//
//                                 Pomocne funkcie
//
//==============================================================================
//==============================================================================

procedure TFormNastavenieCasu.SettingsToForm;
var I : integer;
    NewLI : TListItem;

procedure UpdateClock;
const r = 70;
var I : integer;
    Uhol : real;
    Alfa, Beta : real;
    Stred : TPoint;
    S : string;
begin
  Image.Canvas.CopyRect( Image.ClientRect , Povodny.Canvas , Image.ClientRect );
  with Image.Canvas do
    begin
      Pen.Color := clWhite;
      Pen.Width := 1;
      Brush.Color := Pen.Color;
    end;

  Stred.X := Image.Width div 2;
  Stred.Y := Image.Height div 2;

  Uhol := 0;
  for I := 1 to 12 do
    begin
      Uhol := Uhol + PI/6;
      Image.Canvas.MoveTo( Stred.X + Round(Cos(Uhol)*r) , Stred.Y + Round(Sin(Uhol)*r) );
      Image.Canvas.LineTo( Stred.X + Round(Cos(Uhol)*(r+5)) , Stred.Y + Round(Sin(Uhol)*(r+5)) );
    end;

  Alfa := PI/30*(Settings.Time mod 60) - PI/2;
  Beta := PI/6*(Settings.Time div 60) + PI/360*(Settings.Time mod 60) - PI/2;

  with Image.Canvas do
    begin
      Pen.Width := 3;
      MoveTo( Stred.X , Stred.Y );
      LineTo( Stred.X + Round(Cos(Alfa)*r) , Stred.Y + Round(Sin(Alfa)*r) );
      MoveTo( Stred.X , Stred.Y );
      LineTo( Stred.X + Round(Cos(Beta)*r/2) , Stred.Y + Round(Sin(Beta)*r/2) );
    end;

  I := (Settings.Time mod 60);
  if I < 10 then S := '0' + IntToStr( I )
            else S := IntToStr( I );
  EditMin.Text := S;
  EditHod.Text := IntToStr( Settings.Time div 60 );
end;

begin
  UpdateClock;
  RadioGroupDen.ItemIndex := Settings.Den;

  ListViewListky.Items.Clear;
  for I := 0 to Length( Settings.Listky )-1 do
    begin
      NewLI := ListViewListky.Items.Add;
      with NewLI do
        begin
          Caption := IntToStr( Settings.Listky[I].Min );
          SubItems.Add( IntToStr(  Settings.Listky[I].Norm ) );
          SubItems.Add( IntToStr(  Settings.Listky[I].Zlav ) );
        end;
    end;

{  if Settings.Peso > 0 then CheckBox1.Checked := True
                       else CheckBox1.Checked := False;
  Edit1.Text := IntToStr( Abs( Settings.Peso ) );
  Edit1.Enabled := CheckBox1.Checked;}

  if Settings.Rezerva > 0 then CheckBox2.Checked := True
                          else CheckBox2.Checked := False;
  Edit2.Text := IntToStr( Abs( Settings.Rezerva ) );
  Edit2.Enabled := CheckBox2.Checked;

  if Settings.AutoShow then CheckBox3.Checked := True
                       else CheckBox3.Checked := False;

  if Settings.Zlavneny then CheckBox4.Checked := True
                       else CheckBox4.Checked := False;
end;

procedure TFormNastavenieCasu.FormToSettings;
begin
  with Settings do
    begin
      Den := RadioGroupDen.ItemIndex;

{      Peso := StrToInt( Edit1.Text );
      if not CheckBox1.Checked then Peso := -Peso;}

      Rezerva := StrToInt( Edit2.Text );
      if not CheckBox2.Checked then Rezerva := -Rezerva;

      AutoShow := CheckBox3.Checked;
      Zlavneny := CheckBox4.Checked;
    end;

  with DEF_SETTINGS do
    begin
      Time := Settings.Time;
      Den := Settings.Den;
      Zlavneny := Settings.Zlavneny;
      Rezerva := Settings.Rezerva;
      AutoShow := Settings.AutoShow;
    end;
end;

//==============================================================================
//==============================================================================
//
//                                     Show
//
//==============================================================================
//==============================================================================

procedure TFormNastavenieCasu.FormShow(Sender: TObject);
begin
  SBackup := Settings;
end;

//==============================================================================
//==============================================================================
//
//                                   Komponenty
//
//==============================================================================
//==============================================================================

procedure TFormNastavenieCasu.EditHodExit(Sender: TObject);
var Hod : integer;
begin
  try
    Hod := StrToInt( EditHod.Text );
    if (Hod > 23) or
       (Hod < 0) then
         raise Exception.Create( 'Nesprávna hodnota èasu!' );
  except
    MessageDlg( 'Nesprávna hodnota èasu!' , mtError , [mbOK] , 0 );
    EditHod.SetFocus;
    EditHod.SelectAll;
    exit;
  end;

  Settings.Time := Hod*60 + (Settings.Time mod 60);
  SettingsToForm;
end;

procedure TFormNastavenieCasu.EditMinExit(Sender: TObject);
var Min : integer;
begin
  try
    Min := StrToInt( EditMin.Text );
    if (Min > 59) or
       (Min < 0) then
         raise Exception.Create( 'Nesprávna hodnota èasu!' );
  except
    MessageDlg( 'Nesprávna hodnota èasu!' , mtError , [mbOK] , 0 );
    EditMin.SetFocus;
    EditMin.SelectAll;
    exit;
  end;

  Settings.Time := (Settings.Time div 60)*60 + Min;
  SettingsToForm;
end;

procedure TFormNastavenieCasu.CheckBox1Click(Sender: TObject);
begin
{  Edit1.Enabled := CheckBox1.Checked;}
end;

procedure TFormNastavenieCasu.CheckBox2Click(Sender: TObject);
begin
  Edit2.Enabled := CheckBox2.Checked;
end;

procedure TFormNastavenieCasu.ButtonOKClick(Sender: TObject);
begin
  FormToSettings;
  ModalResult := 1;
end;

procedure TFormNastavenieCasu.ButtonCancelClick(Sender: TObject);
begin
  Settings := SBackup;
  SettingsToForm;
  ModalResult := -1;
end;

procedure TFormNastavenieCasu.ListViewListkySelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  ButtonDelete.Enabled := Selected;
end;

procedure TFormNastavenieCasu.ButtonDeleteClick(Sender: TObject);
var I : integer;
begin
  if MessageDlg( 'Naozaj chcete odstráni zvolený lístok?' , mtWarning , [mbYes,mbNo] , 0 ) = mrYes then
    begin
      for I := ListViewListky.Selected.Index to Length( Settings.Listky )-2 do
        Settings.Listky[I] := Settings.Listky[I+1];
      SetLength( Settings.Listky , Length( Settings.Listky )-1 );
      SettingsToForm;
    end;
end;

procedure TFormNastavenieCasu.ButtonPridatClick(Sender: TObject);
begin
  if FormAddTicket.ShowModal = 1 then
    begin
      SetLength( Settings.Listky , Length( Settings.Listky )+1 );
      Settings.Listky[ Length( Settings.Listky )-1 ] := FormAddTicket.NewTicket;
      SettingsToForm;
    end;
end;

procedure TFormNastavenieCasu.ButtonObnovClick(Sender: TObject);
begin
  Settings.Listky := GetTickets( '\Software\MHDClient\Tickets\Default' );
  SettingsToForm;
end;

procedure TFormNastavenieCasu.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  TICKETS := Settings.Listky;
end;

end.

