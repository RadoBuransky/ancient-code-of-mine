unit FormHlavneOkno;

interface

{$DEFINE DEBUG}

uses
  Windows, Messages, Classes, SysUtils, Graphics, Controls, Forms, Dialogs,
  Menus, ExtCtrls, ComCtrls, StdCtrls, ClassNewImage, lgmPanel, ImgList,
  Grids, ClassData, ClassSListBox;                      

type
  TShownPanels = set of (sLeft,sCenter,sRight,sMap,sBottom);
  TActiveSpoje = (asNone,asA,asE,asT,asN);
  TShownRoz = set of (srRoz,srSpoje);

  THlavneOkno = class(TForm)
    MainMenu: TMainMenu;
    MainMenuVyhladat: TMenuItem;
    MainMenuMapa: TMenuItem;
    ZobrazitSpoje: TMenuItem;
    ZobrazitZastavky: TMenuItem;
    ZobrazitVyhladanie: TMenuItem;
    Panel: TPanel;
    NewImageRozvrhy: TNewImage;
    NewImageN: TNewImage;
    NewImageT: TNewImage;
    NewImageE: TNewImage;
    NewImageA: TNewImage;
    Panel1: TPanel;
    lgmPanelLeft: TlgmPanel;
    lgmPanelMapa: TlgmPanel;
    ScrollBox: TScrollBox;
    lgmPanelCent: TlgmPanel;
    lgmPanelBottom: TlgmPanel;
    NewImageSearch: TNewImage;
    ComboBoxSpoje: TComboBox;
    NewImageOtocit: TNewImage;
    NewImageGO: TNewImage;
    NewImageM: TNewImage;
    PanelR: TPanel;
    NewImage1: TNewImage;
    NewImage3: TNewImage;
    NewImage2: TNewImage;
    NewImageS: TNewImage;
    PanelSpNaZst: TPanel;
    lgmPanelSpoje: TlgmPanel;
    NewImageSpNaZst: TNewImage;
    lgmPanelRight: TlgmPanel;
    NewImageGO2: TNewImage;
    ListBoxSpoje: TSListBox;
    ListBoxZast: TSListBox;
    ListBoxSpNaZast: TSListBox;
    Koniec: TMenuItem;
    NotebookSearch: TNotebook;
    NewImageFind: TNewImage;
    NewImageHodiny: TNewImage;
    NewImageResults: TNewImage;
    ComboBoxDO: TComboBox;
    Label2: TLabel;
    ComboBoxOD: TComboBox;
    Label1: TLabel;
    NewImageCancel: TNewImage;
    LabelCena: TLabel;
    ImageList: TImageList;
    NewImageUkazSpoj: TNewImage;
    Timer: TTimer;
    MapaImage: TNewImage;
    ScrollBoxRoz: TScrollBox;
    ImageRoz: TImage;
    LabelDlzka: TLabel;
    LabelPrest: TLabel;
    Panel2: TPanel;
    NewImagePrev: TNewImage;
    LabelNasR: TLabel;
    LabelVysR: TLabel;
    LabelSpoj: TLabel;
    NewImageNext: TNewImage;
    NewImageDet: TNewImage;
    Panel3: TPanel;
    LabelRoz: TLabel;
    NewImageShowRes: TNewImage;
    ImageTyp: TImage;
    NewImageSynchro: TNewImage;
    Pomoc: TMenuItem;

    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ZobrazitZastavkyClick(Sender: TObject);
    procedure ZobrazitSpojeClick(Sender: TObject);
    procedure NewImageHodinyClick(Sender: TObject);
    procedure FormCanResize(Sender: TObject; var NewWidth,
      NewHeight: Integer; var Resize: Boolean);
    procedure ZobrazitVyhladanieClick(Sender: TObject);
    procedure NewImageAClick(Sender: TObject);
    procedure NewImageEClick(Sender: TObject);
    procedure NewImageTClick(Sender: TObject);
    procedure NewImageNClick(Sender: TObject);
    procedure NewImageRozvrhyClick(Sender: TObject);
    procedure NewImageSearchClick(Sender: TObject);
    procedure ComboBoxSpojeChange(Sender: TObject);
    procedure NewImageOtocitClick(Sender: TObject);
    procedure NewImageMClick(Sender: TObject);
    procedure NewImageSClick(Sender: TObject);
    procedure NewImage1Click(Sender: TObject);
    procedure NewImage2Click(Sender: TObject);
    procedure NewImage3Click(Sender: TObject);
    procedure ListBoxSpNaZastClick(Sender: TObject);
    procedure NewImageSpNaZstClick(Sender: TObject);
    procedure NewImageGO2Click(Sender: TObject);
    procedure NewImageGOClick(Sender: TObject);
    procedure ListBoxSpNaZastKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure KoniecClick(Sender: TObject);
    procedure NewImageFindClick(Sender: TObject);
    procedure NewImageResultsClick(Sender: TObject);
    procedure NewImageCancelClick(Sender: TObject);
    procedure ListViewResSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure NewImageUkazSpojClick(Sender: TObject);
    procedure ListBoxSpojeClick(Sender: TObject);
    procedure ListBoxSpojeExit(Sender: TObject);
    procedure MapaImageMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure TimerTimer(Sender: TObject);
    procedure MapaImageMouseLeave(Sender: TObject);
    procedure ListBoxZastClick(Sender: TObject);
    procedure NewImageNextClick(Sender: TObject);
    procedure NewImagePrevClick(Sender: TObject);
    procedure NewImageDetClick(Sender: TObject);
    procedure NewImageShowResClick(Sender: TObject);
    procedure MapaImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MapaImageDblClick(Sender: TObject);
    procedure NewImageSynchroClick(Sender: TObject);
    procedure PomocClick(Sender: TObject);
  private
    { Private declarations }
    FShownPanels : TShownPanels; // zobrazene panely
    FActiveSpoje : TActiveSpoje; // ake spoje su zobrazene na lavom paneli (a,e,t,n)
    FActiveSpoj : PSpoj; // cislo spoja, ktoreho zastavky su vylistovane na lavom paneli
    FShownRoz : TShownRoz; // zobrazene panely v paneli "Rozvrhy"
    FActiveZast : PZastavka; // zobrazena zastavka v "Rozvrhy"
    FActiveSpNaZast : PSpoj; // zobrazeny spoj v "Rozvrhy"
    FActiveRozDen : integer; // ktore dni su zobrazene
    FShowResults : boolean; // zobrazene vysledky vyhladavania
    FActiveRozpis : integer; // ktora cesta je zobrazena v ListViewRozpis
    MousePos : TPoint; // pozicia mysi na mape (pre zobrazenie hintu)
    FStart : TPoint; // suradnice startu
    FFinish : TPoint; // suradnice konca

    procedure Inicializacia;
    procedure OtvorSubor;

    procedure SetShownPanels( Value : TShownPanels );
    procedure SetActiveSpoje( Value : TActiveSpoje );
    procedure SetActiveSpoj( Value : PSpoj );
    procedure SetShownRoz( Value : TShownRoz );
    procedure SetActiveZast( Value : PZastavka );
    procedure SetActiveSpNaZast( Value : PSpoj );
    procedure SetActiveRozDen( Value : integer );
    procedure SetShowResults( Value : boolean );
    procedure SetActiveRozpis( Value : integer );
    procedure SetStart( Value : TPoint );
    procedure SetFinish( Value : TPoint );

    procedure UpdateListBoxSpNaZast;
    procedure NajdiSur;
  protected
    property ShownPanels : TShownPanels read FShownPanels write SetShownPanels;
    property ActiveSpoje : TActiveSpoje read FActiveSpoje write SetActiveSpoje;
    property ActiveSpoj : PSpoj read FActiveSpoj write SetActiveSpoj;
    property ShownRoz : TShownRoz read FShownRoz write SetShownRoz;
    property ActiveZast : PZastavka read FActiveZast write SetActiveZast;
    property ActiveSpNaZast : PSpoj read FActiveSpNaZast write SetActiveSpNaZast;
    property ActiveRozDen : integer read FActiveRozDen write SetActiveRozDen;
    property ShowResults : boolean read FShowResults write SetShowResults;
    property ActiveRozpis : integer read FActiveRozpis write SetActiveRozpis;
    property Start : TPoint read FStart write SetStart;
    property Finish : TPoint read FFinish write SetFinish;
  public
    { Public declarations }
  end;

var
  HlavneOkno: THlavneOkno;

implementation

uses DialogProgress, FrmNastavenieCasu, ClassMapa, ClassHladanie,
     Konstanty, FrmDetail, FrmSynchro, ShellApi;

{$R *.DFM}

//==============================================================================
//==============================================================================
//
//                                  Constructor
//
//==============================================================================
//==============================================================================

procedure THlavneOkno.Inicializacia;
var I : integer;
begin
  for I := 0 to Data.Zastavky.Count-1 do
    begin
      ListBoxZast.Items.AddObject( TZastavka( Data.Zastavky[I]^ ).Nazov , Data.Zastavky[I] );
      ComboBoxOD.Items.AddObject( TZastavka( Data.Zastavky[I]^ ).Nazov , Data.Zastavky[I] );
      ComboBoxDO.Items.AddObject( TZastavka( Data.Zastavky[I]^ ).Nazov , Data.Zastavky[I] );
    end;

  if Data.Zastavky.Count > 0 then
    begin
      ComboBoxOD.ItemIndex := 148;
      ComboBoxDO.ItemIndex := 59;
    end;

  ShownPanels := [sMap];
  ActiveSpoje := asA;
  FActiveRozDen := -1;
  ActiveZast := nil;
  ActiveSpNaZast := nil;
  ActiveRozpis := -1;
  FStart.X := -1;
  FStart.Y := -1;
  FFinish.X := -1;
  FFinish.Y := -1;
end;

procedure THlavneOkno.OtvorSubor;
var I, J : integer;
    Cislo, Subor : string;
    Typ : char;
    F : TextFile;
begin
  if (ParamCount = 0) then exit;

  J := -1;
  for I := 2 to Length( String( CmdLine ) ) do
    if String( CmdLine )[I] = '"' then
      begin
        J := I+2;
      end;

  if (J = -1) then exit;

  Subor := Copy( String( CmdLine ) , J , Length( String( CmdLine ) ) );

  AssignFile( F , Subor );
  {$I-}
  Reset( F );
  {$I+}
  if IOResult <> 0 then exit;

  Readln( F , Cislo );
  Readln( F , Typ );

  CloseFile( F );

  for I := 0 to Data.SpojeInfo.Count-1 do
    if TSpojInfo( Data.SpojeInfo[I]^ ).Spoj^.Cislo = StrToInt( Cislo ) then
      begin
        case Typ of
          'A' : NewImageAClick( nil );
          'E' : NewImageEClick( nil );
          'T' : NewImageTClick( nil );
          'N' : NewImageNClick( nil );
        end;
        ActiveSpoj := TSpojInfo( Data.SpojeInfo[I]^ ).Spoj;
        break;
      end;

  for I := 0 to ComboBoxSpoje.Items.Count-1 do
    if (ComboBoxSpoje.Items[I] = Cislo) then
      begin
        ComboBoxSpoje.ItemIndex := I;
        break;
      end;
end;

procedure THlavneOkno.FormCreate(Sender: TObject);
begin
  with TDlgProgress.Create(nil) do
    try
      Hladanie := THladanie.Create;

      Label1.Font.Style := [fsBold];
      Update;
      Data := TData.Create;
      Label1.Font.Style := [];
      Label1.Enabled := False;

      Label2.Font.Style := [fsBold];
      Update;

      Mapa := TMapa.Create( MapaImage , ScrollBox , ImageList );

      Label2.Font.Style := [];
      Label2.Enabled := False;

      Close;
    finally
      Free;
    end;

  Inicializacia;
  OtvorSubor;
end;

//==============================================================================
//==============================================================================
//
//                                  Destructor
//
//==============================================================================
//==============================================================================

procedure THlavneOkno.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Mapa.Free;
  Data.Free;
  Hladanie.Free;
end;

//==============================================================================
//==============================================================================
//
//                                M A I N   M E N U
//
//==============================================================================
//==============================================================================

procedure THlavneOkno.ZobrazitSpojeClick(Sender: TObject);
begin
  ZobrazitSpoje.Checked := not ZobrazitSpoje.Checked;
  if (sLeft in ShownPanels) then ShownPanels := ShownPanels - [sLeft]
                            else ShownPanels := ShownPanels + [sLeft];
end;

procedure THlavneOkno.ZobrazitZastavkyClick(Sender: TObject);
begin
  ZobrazitZastavky.Checked := not ZobrazitZastavky.Checked;
  if (sRight in ShownPanels) then ShownPanels := ShownPanels - [sRight]
                             else ShownPanels := ShownPanels + [sRight];
end;

procedure THlavneOkno.ZobrazitVyhladanieClick(Sender: TObject);
begin
  ZobrazitVyhladanie.Checked := not ZobrazitVyhladanie.Checked;
  if (sBottom in ShownPanels) then ShownPanels := ShownPanels - [sBottom]
                              else ShownPanels := ShownPanels + [sBottom];
end;

procedure THlavneOkno.NewImageHodinyClick(Sender: TObject);
begin
  FormNastavenieCasu.ShowModal;
end;

procedure THlavneOkno.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
end;

//==============================================================================
//==============================================================================
//
//                                Properties
//
//==============================================================================
//==============================================================================

procedure THlavneOkno.SetShownPanels( Value : TShownPanels );
var I, J, K : integer;
begin
  FShownPanels := Value;

  if ShowResults then lgmPanelBottom.Height := 97
                 else lgmPanelBottom.Height := 65;
  lgmPanelBottom.Top := lgmPanelBottom.Parent.Height - lgmPanelBottom.Height - 5;

  if (sMap in FShownPanels) then
    begin
      I := 0;
      J := lgmPanelMapa.Parent.Width;
      K := lgmPanelMapa.Parent.Height - 5;

      if (sLeft in FShownPanels) then
        begin
          I := I + (lgmPanelLeft.Width + 5);
          J := J - (lgmPanelLeft.Width + 5);
        end;

      if (sRight in FShownPanels) then
        J := J - (lgmPanelRight.Width + 5);

      if (sBottom in FShownPanels) then
        K := Abs(lgmPanelMapa.Top - lgmPanelBottom.Top) - 5;

      lgmPanelMapa.Left := I;
      lgmPanelMapa.Width := J;
      lgmPanelMapa.Height := K;

      if (sCenter in FShownPanels) then lgmPanelMapa.Visible := False
                                   else lgmPanelMapa.Visible := True;
      lgmPanelMapa.Invalidate;
    end
      else
    lgmPanelMapa.Visible := False;

  if (sLeft in FShownPanels) then
    begin
      I := lgmPanelLeft.Parent.Height - 5;

      if (sBottom in FShownPanels) then
        I := Abs(lgmPanelLeft.Top - lgmPanelBottom.Top) - 5;

      lgmPanelLeft.Height := I;

      lgmPanelLeft.Visible := True;
    end
      else
    lgmPanelLeft.Visible := False;

  if (sRight in FShownPanels) then
    begin
      I := lgmPanelRight.Parent.Height - 5;

      if (sBottom in FShownPanels) then
        I := Abs(lgmPanelRight.Top - lgmPanelBottom.Top) - 5;

      lgmPanelRight.Height := I;

      lgmPanelRight.Visible := True;
    end
      else
    lgmPanelRight.Visible := False;

  if (sCenter in FShownPanels) then
    begin
      I := lgmPanelCent.Parent.Height - 5;
      J := lgmPanelCent.Parent.Width;

      if (sLeft in FShownPanels) then
        J := J - (lgmPanelLeft.Width + 5);

      if (sRight in FShownPanels) then
        J := J - (lgmPanelRight.Width + 5);

      if (sBottom in FShownPanels) then
        I := Abs(lgmPanelCent.Top - lgmPanelBottom.Top) - 5;

      lgmPanelCent.Left := lgmPanelMapa.Left;
      lgmPanelCent.Width := J;
      lgmPanelCent.Height := I;

      lgmPanelCent.Visible := True;

      if ShownRoz = [] then ShownRoz := [srRoz]
                       else ShownRoz := ShownRoz;
    end
      else
    lgmPanelCent.Visible := False;

  if (sBottom in FShownPanels) then
    begin
      lgmPanelBottom.Visible := True;
      with NotebookSearch do
        begin
          Left := 1;
          Top := 17;
          Height := Parent.Height - 20;
          Width := Parent.Width - 4;
        end;
    end
      else
    lgmPanelBottom.Visible := False;
end;

procedure THlavneOkno.SetActiveSpoje( Value : TActiveSpoje );
var I : integer;
    Typ : integer;
begin
  if Value = FActiveSpoje then exit
                          else FActiveSpoje := Value;

  Typ := -1;
  case FActiveSpoje of
    asA : begin
            lgmPanelLeft.Title.Caption := 'Autobusy';
            Typ := 0;
          end;
    asE : begin
            lgmPanelLeft.Title.Caption := 'Elektrièky';
            Typ := 1;
          end;
    asT : begin
            lgmPanelLeft.Title.Caption := 'Trolejbusy';
            Typ := 2;
          end;
    asN : begin
            lgmPanelLeft.Title.Caption := 'Noèné spoje';
            Typ := 3;
          end;
  end;

  ComboBoxSpoje.Clear;
  for I := 0 to Data.ZoznamSpojov.Count-1 do
    if TSpojInfo( Data.ZoznamSpojov[I]^ ).Spoj <> nil then
      if TSpojInfo( Data.ZoznamSpojov[I]^ ).Spoj^.Typ = Typ then
        ComboBoxSpoje.Items.AddObject( IntToStr( TSpojInfo( Data.ZoznamSpojov[I]^ ).Spoj^.Cislo ) , TObject( TSpojInfo( Data.ZoznamSpojov[I]^ ).Spoj ) );

  if ComboBoxSpoje.Items.Count > 0 then
    begin
      ComboBoxSpoje.ItemIndex := 0;
      ActiveSpoj := PSpoj( ComboBoxSpoje.Items.Objects[0] );
    end
      else
    begin
      ComboBoxSpoje.ItemIndex := -1;
      ActiveSpoj := nil;
    end;
end;

procedure THlavneOkno.SetActiveSpoj( Value : PSpoj );
var Spoj : PSpoj;
begin
  if (FActiveSpoj) = Value then exit;
  FActiveSpoj := Value;

  if (Mapa.ShowSpoj <> nil) then
    Mapa.ShowSpoj := FActiveSpoj;

  ListBoxSpoje.Clear;
  if FActiveSpoj = nil then exit;

  Spoj := FActiveSpoj;
  while Spoj <> nil do
    begin
      ListBoxSpoje.Items.AddObject( Spoj^.NaZastavke^.Nazov , TObject( Spoj^.NaZastavke ) );
      Spoj := Spoj.Next;
   end;
end;

procedure THlavneOkno.SetShownRoz( Value : TShownRoz );
var I : integer;
begin
  FShownRoz := Value;

  I := PanelR.Parent.Width - 15;

  if (srSpoje in FShownRoz) then
    Dec( I , lgmPanelSpoje.Width + 5 );

  PanelR.Width := I;

  if (srSpoje in FShownRoz) then
    begin
      PanelSpNaZst.Left := PanelR.Left + PanelR.Width + 5;
      PanelSpNaZst.Visible := True;
    end
      else
    PanelSpNaZst.Visible := False;
end;

procedure THlavneOkno.SetActiveZast( Value : PZastavka );
var I : integer;
begin
  if (FActiveZast = Value) and
     (Value <> nil) then exit
                    else FActiveZast := Value;

  if (FActiveZast = nil) then
    FActiveZast := PZastavka( Data.Zastavky[0] );

  LabelRoz.Caption := FActiveZast^.Nazov;
  if FActiveZast^.NaZnamenie then LabelRoz.Caption := LabelRoz.Caption + ' (na znamenie)';

  ListBoxSpNaZast.Clear;
  for I := 0 to FActiveZast^.Spoje.Count-1 do
    ListBoxSpNaZast.Items.AddObject( '' , FActiveZast^.Spoje[I] );
  UpdateListBoxSpNaZast;
end;

procedure THlavneOkno.SetActiveRozDen( Value : integer );
var I, J : integer;
    Roz : PRozvrh;
    Min : PMinuty;
    Pocet : integer;

    VysR, SirS, Posl : integer;
begin
  if FActiveSpNaZast = nil then exit;
  FActiveRozDen := Value;

  if (FActiveRozDen = -1) then exit;

  Roz := FActiveSpNaZast^.Rozvrhy^.Rozvrh[ FActiveRozDen ];

  Pocet := 1;
  for I := 0 to 23 do
    begin
      Min := Roz[I];
      J := 0;
      while Min <> nil do
        begin
          Inc( J );
          Min := Min^.Next;
        end;
      if J > (Pocet-1) then
        Pocet := J+1;
    end;

  with ImageRoz.Canvas do
    begin
      Font.Color := clBlack;
      Font.Style := [];

      VysR := (TextHeight( '0' ) + 2);
      SirS := (TextWidth( '00' ) + 10);

      ImageRoz.Height := 2 + VysR * 24;
      ImageRoz.Width := 3 + SirS * Pocet;

      Pen.Color := clBlack;
      Pen.Width := 1;
      Brush.Color := clWhite;

      FillRect( ImageRoz.ClientRect );

      for I := 0 to 9 do
        TextOut( 2 , 2+(I*VysR) , '0'+IntToStr( I ) );
      for I := 10 to 23 do
        TextOut( 2 , 2+(I*VysR) , IntToStr( I ) );

      MoveTo( 3 + SirS - 5 , 2 );
      LineTo( 3 + SirS - 5 , ImageRoz.Height - 2 );

      for I := 0 to 23 do
        begin
          Posl := 5 + SirS;
          Min := Roz[I];
          while Min <> nil do
            begin
              if Min^.Cas < 10 then
                TextOut( Posl , 2+(I*VysR) , '0'+IntToStr( Min^.Cas ) )
                  else
                TextOut( Posl , 2+(I*VysR) , IntToStr( Min^.Cas ) );

              Inc( Posl , SirS );
              Min := Min^.Next;
            end;
        end;
    end;

  case FActiveRozDen of
    0 : begin
          NewImage1.Pressed := True;
          NewImage2.Pressed := False;
          NewImage3.Pressed := False;
        end;
    1 : begin
          NewImage1.Pressed := False;
          NewImage2.Pressed := True;
          NewImage3.Pressed := False;
        end;
    2 : begin
          NewImage1.Pressed := False;
          NewImage2.Pressed := False;
          NewImage3.Pressed := True;
        end;
  end;
end;

procedure THlavneOkno.SetActiveSpNaZast( Value : PSpoj );
var I : integer;
begin
  if (ActiveSpNaZast = Value) and
     (Value <> nil)
       then exit;

  FActiveSpNaZast := Value;

  if (FActiveSpNaZast = nil) and
     (ListBoxSpNaZast.Items.Count > 0) then
       FActiveSpNaZast := PSpoj( ListBoxSpNaZast.Items.Objects[0] );

  for I := 0 to ListBoxSpNaZast.Items.Count-1 do
    if PSpoj( ListBoxSpNaZast.Items.Objects[I] ) = FActiveSpNaZast then
      begin
        ListBoxSpNaZast.ItemIndex := I;
        break;
      end;

  if (ActiveRozDen = -1) then ActiverozDen := 0
                         else ActiveRozDen := ActiveRozDen;
end;

procedure THlavneOkno.UpdateListBoxSpNaZast;
var I : integer;
    S : string;
    P : pointer;
begin
  for I := 0 to ListBoxSpNaZast.Items.Count-1 do
    begin
      P := ListBoxSpNaZast.Items.Objects[I];

      S := IntToStr( TSpoj( P^ ).Cislo );
      S := S + ' (' + TSpoj( P^ ).Info^.Zaciatok^.Nazov;
      S := S + ' --> ';
      S := S + TSpoj( P^ ).Info^.Koniec^.Nazov + ')';
      ListBoxSpNaZast.Items[I] := S;
    end;
end;

procedure THlavneOkno.SetShowResults( Value : boolean );
begin
  if Value = FShowResults then exit
                          else FShowResults := Value;

  ShownPanels := ShownPanels;

  if FShowResults then NotebookSearch.PageIndex := 1
                  else NotebookSearch.PageIndex := 0;
end;

procedure THlavneOkno.SetActiveRozpis( Value : integer );
var h, m : integer;
    hs, ms : string;
    I : integer;
    Koniec : PSpoj;
begin
  FActiveRozpis := Value;

  if FActiveRozpis = -1 then exit;

  if (FActiveRozpis = 0) then NewImagePrev.Visible := False
                         else NewImagePrev.Visible := True;

  if (FActiveRozpis = Length( Hladanie.Vysledok^.Prestupy )-1) then
    NewImageNext.Visible := False
      else
    NewImageNext.Visible := True;

  h := Hladanie.Vysledok^.Prestupy[ FActiveRozpis ].Nastup div 60;
  m := Hladanie.Vysledok^.Prestupy[ FActiveRozpis ].Nastup mod 60;

  hs := IntToStr( h );

  if (m < 10) then ms := '0'+IntToStr( m )
              else ms := IntToStr( m );

  LabelNasR.Caption := 'Nástup :    '+hs+':'+ms+'    '+Hladanie.Vysledok^.Prestupy[ FActiveRozpis ].Zaciatok^.NaZastavke^.Nazov;
  if Hladanie.Vysledok^.Prestupy[ FActiveRozpis ].Zaciatok^.NaZastavke^.NaZnamenie then
    LabelNasR.Caption := LabelNasR.Caption + ' (na znamenie)';

  Koniec := Hladanie.Vysledok^.Prestupy[ FActiveRozpis ].Zaciatok;
  I := 0;
  while (I < Hladanie.Vysledok^.Prestupy[ FActiveRozpis ].Zastavky) do
    begin
      Koniec := Koniec^.Next;
      Inc( I );
    end;

  h := Hladanie.Vysledok^.Prestupy[ FActiveRozpis ].Vystup div 60;
  m := Hladanie.Vysledok^.Prestupy[ FActiveRozpis ].Vystup mod 60;

  hs := IntToStr( h );

  if (m < 10) then ms := '0'+IntToStr( m )
              else ms := IntToStr( m );

  LabelVysR.Caption := 'Výstup :    '+hs+':'+ms+'    '+Koniec^.NaZastavke^.Nazov;
  if Koniec^.NaZastavke^.NaZnamenie then
    LabelVysR.Caption := LabelVysR.Caption + ' (na znamenie)';

  LabelSpoj.Caption := IntToStr( Hladanie.Vysledok^.Prestupy[ FActiveRozpis ].Zaciatok^.Cislo );

  with ImageTyp.Canvas do
    begin
      Brush.Color := clBtnFace;
      FillRect( ImageTyp.ClientRect );
    end;

 ImageList.GetBitmap( Hladanie.Vysledok^.Prestupy[ FActiveRozpis ].Zaciatok^.Typ , ImageTyp.Picture.Bitmap );

  if (Mapa.ShowRes = Hladanie.Vysledok) then
    Mapa.LookAt := Hladanie.Vysledok^.Prestupy[ FActiveRozpis ].Zaciatok^.NaZastavke^.Sur;
end;

procedure THlavneOkno.SetStart( Value : TPoint );
begin
  FStart := Value;

  Screen.Cursor := crHourGlass;
  try
    Mapa.Start := FStart;
  finally
    Screen.Cursor := crDefault;
  end;

  if (Finish.X = -1) and
     (Finish.Y = -1) then exit;

  NajdiSur;
end;

procedure THlavneOkno.SetFinish( Value : TPoint );
begin
  FFinish := Value;

  Screen.Cursor := crHourGlass;
  try
    Mapa.Finish := FFinish;
  finally
    Screen.Cursor := crDefault;
  end;

  if (Start.X = -1) and
     (Start.Y = -1) then exit;

  NajdiSur;
end;

procedure THlavneOkno.NajdiSur;
var SearchData : TSearchData;
    Vysledok : PVysledok;
    h, m : integer;
    sh, sm : string;
    Point : TPoint;
begin
  with SearchData do
    begin
      Odkial := nil;
      Kam := nil;
      Settings := FormNastavenieCasu.Settings;
    end;

  Screen.Cursor := crHourGlass;
  try
    Vysledok := Hladanie.NajdiSur( Start , Finish , SearchData );

    if Vysledok = nil then NewImageResults.Visible := False
                      else
      begin
        ComboBoxOD.ItemIndex := Vysledok^.Zaciatok^.Cislo;
        ComboBoxDO.ItemIndex := Vysledok^.Koniec^.Cislo;

        FormDetail.Vysledok := Vysledok;

        NewImageResults.Visible := True;
        LabelCena.Caption := 'Cena : '+IntToStr( Vysledok^.Cena )+',- Sk';

        h := Vysledok^.Dlzka div 60;
        m := Vysledok^.Dlzka mod 60;

        sh := '';
        if (h > 0) then
          sh := IntToStr( h )+ ' hod ';

        if (m < 10) and
           (h > 0) then sm := '0';
        sm := sm + IntToStr( m ) + ' min';

        LabelDlzka.Caption := 'Dåžka : '+sh+sm;
        LabelPrest.Caption := 'Prestupy : '+IntToStr( Length( Vysledok^.Prestupy )-1 );

        ActiveRozpis := 0;

        NewImageShowRes.Pressed := True;
        NewImageShowResClick( nil );

        Point.X := -1;
        Point.Y := -1;

        FStart := Point;
        FFinish := Point;
      end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

//==============================================================================
//==============================================================================
//
//                                F A S T   M E N U
//
//==============================================================================
//==============================================================================

procedure THlavneOkno.NewImageAClick(Sender: TObject);
begin
  if (ActiveSpoje = asA) and
     (sLeft in ShownPanels) then
    begin
      NewImageA.Pressed := False;
      ZobrazitSpoje.Checked := False;
      ShownPanels := ShownPanels - [sLeft];
      exit;
    end
      else
    NewImageA.Pressed := True;

  ActiveSpoje := asA;
  NewImageE.Pressed := False;
  NewImageT.Pressed := False;
  NewImageN.Pressed := False;

  ZobrazitSpoje.Checked := True;
  ShownPanels := ShownPanels + [sLeft];
end;

procedure THlavneOkno.NewImageEClick(Sender: TObject);
begin
  if (ActiveSpoje = asE) and
     (sLeft in ShownPanels) then
    begin
      NewImageE.Pressed := False;
      ZobrazitSpoje.Checked := False;
      ShownPanels := ShownPanels - [sLeft];
      exit;
    end
      else
    NewImageE.Pressed := True;

  ActiveSpoje := asE;
  NewImageA.Pressed := False;
  NewImageT.Pressed := False;
  NewImageN.Pressed := False;

  ZobrazitSpoje.Checked := True;
  ShownPanels := ShownPanels + [sLeft];
end;

procedure THlavneOkno.NewImageTClick(Sender: TObject);
begin
  if (ActiveSpoje = asT) and
     (sLeft in ShownPanels) then
    begin
      NewImageT.Pressed := False;
      ZobrazitSpoje.Checked := False;
      ShownPanels := ShownPanels - [sLeft];
      exit;
    end
      else
    NewImageT.Pressed := True;

  ActiveSpoje := asT;
  NewImageE.Pressed := False;
  NewImageA.Pressed := False;
  NewImageN.Pressed := False;

  ZobrazitSpoje.Checked := True;
  ShownPanels := ShownPanels + [sLeft];
end;

procedure THlavneOkno.NewImageNClick(Sender: TObject);
begin
  if (ActiveSpoje = asN) and
     (sLeft in ShownPanels) then
    begin
      NewImageN.Pressed := False;
      ZobrazitSpoje.Checked := False;
      ShownPanels := ShownPanels - [sLeft];
      exit;
    end
      else
    NewImageN.Pressed := True;

  ActiveSpoje := asN;
  NewImageE.Pressed := False;
  NewImageT.Pressed := False;
  NewImageA.Pressed := False;

  ZobrazitSpoje.Checked := True;
  ShownPanels := ShownPanels + [sLeft];
end;

procedure THlavneOkno.NewImageRozvrhyClick(Sender: TObject);
begin
  ZobrazitZastavky.Checked := not ZobrazitZastavky.Checked;
  NewImageRozvrhy.Pressed := ZobrazitZastavky.Checked;
  if not (sRight in ShownPanels) then ShownPanels := ShownPanels + [sRight]
                                 else ShownPanels := ShownPanels - [sRight];
end;

procedure THlavneOkno.NewImageSearchClick(Sender: TObject);
begin
  ZobrazitVyhladanie.Checked := not ZobrazitVyhladanie.Checked;
  NewImageSearch.Pressed := ZobrazitVyhladanie.Checked;
  if not (sBottom in ShownPanels) then ShownPanels := ShownPanels + [sBottom]
                                  else ShownPanels := ShownPanels - [sBottom];
end;

//==============================================================================
//==============================================================================
//
//                                    Events
//
//==============================================================================
//==============================================================================

procedure THlavneOkno.ComboBoxSpojeChange(Sender: TObject);
begin
  ActiveSpoj := PSpoj( ComboBoxSpoje.Items.Objects[ComboBoxSpoje.ItemIndex] );
end;

procedure THlavneOkno.NewImageOtocitClick(Sender: TObject);
begin
  if ActiveSpoj = ActiveSpoj^.Info^.Spoj then
    begin
      if ActiveSpoj^.Info^.OpacnySpoj <> nil then
        ActiveSpoj := ActiveSpoj^.Info^.OpacnySpoj;
    end
      else ActiveSpoj := ActiveSpoj^.Info^.Spoj;
end;

procedure THlavneOkno.NewImageMClick(Sender: TObject);
begin
  ShownPanels := ShownPanels - [sCenter];
end;

procedure THlavneOkno.NewImageSClick(Sender: TObject);
begin
  if not (srSpoje in ShownRoz) then ShownRoz := ShownRoz + [srSpoje]
                               else ShownRoz := ShownRoz - [srSpoje];
end;

procedure THlavneOkno.NewImage1Click(Sender: TObject);
begin
  ActiveRozDen := 0;
end;

procedure THlavneOkno.NewImage2Click(Sender: TObject);
begin
  ActiveRozDen := 1;
end;

procedure THlavneOkno.NewImage3Click(Sender: TObject);
begin
  ActiveRozDen := 2;
end;

procedure THlavneOkno.ListBoxSpNaZastClick(Sender: TObject);
begin
  ActiveSpNaZast := PSpoj( ListBoxSpNaZast.Items.Objects[ ListBoxSpNaZast.ItemIndex ] );
end;

procedure THlavneOkno.NewImageSpNaZstClick(Sender: TObject);
var Spoj : PSpoj;
begin
  if ListBoxSpNaZast.ItemIndex = -1 then exit;

  Spoj := Pointer( ListBoxSpNaZast.Items.Objects[ ListBoxSpNaZast.ItemIndex ] );
  if Spoj^.Opacny <> nil then
    Spoj := Spoj^.Opacny;
  ListBoxSpNaZast.Items.Objects[ ListBoxSpNaZast.ItemIndex ] := TObject( Spoj );

  UpdateListBoxSpNaZast;
  ActiveSpNaZast := Spoj;
  ActiveRozDen := 0;
end;

procedure THlavneOkno.NewImageGO2Click(Sender: TObject);
begin
  if ListBoxZast.ItemIndex = -1 then exit;
  if TZastavka( Data.Zastavky[ ListBoxZast.ItemIndex ]^ ).Spoje.Count = 0 then exit;

  ActiveZast := PZastavka( Data.Zastavky[ ListBoxZast.ItemIndex ] );
  ActiveSpNaZast := nil;
  ShownPanels := ShownPanels + [sCenter];
end;

procedure THlavneOkno.NewImageGOClick(Sender: TObject);
var I : integer;
    Spoj : PSpoj;
begin
  if (ListBoxSpoje.ItemIndex = -1) or
     (ComboBoxSpoje.ItemIndex = -1) or
     (ActiveSpoj = nil) then exit;

  ActiveZast := PZastavka( ListBoxSpoje.Items.Objects[ ListBoxSpoje.ItemIndex ] );

  Spoj := ActiveSpoj;
  while Spoj <> nil do
    begin
      if Spoj^.NaZastavke = ActiveZast then break;
      Spoj := Spoj^.Next;
    end;

  for I := 0 to ActiveZast^.Spoje.Count-1 do
    if TSpoj( ActiveZast^.Spoje[I]^ ).Cislo = Spoj^.Cislo then
      begin
        ListBoxSpNaZast.Items.Objects[I] := TObject( Spoj );
        break;
      end;

  ActiveSpNaZast := Spoj;

  UpdateListBoxSpNaZast;

  ShownPanels := ShownPanels + [sCenter];
end;

procedure THlavneOkno.ListBoxSpNaZastKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_RIGHT :
      begin
        NewImageSpNaZstClick(Sender);
        Key := 0;
      end;
    VK_LEFT :
      begin
        NewImageSpNaZstClick(Sender);
        Key := 0;
      end;
  end;
end;

procedure THlavneOkno.KoniecClick(Sender: TObject);
begin
  Close;
end;

procedure THlavneOkno.NewImageFindClick(Sender: TObject);
var SearchData : TSearchData;
    Vysledok : PVysledok;
    h, m : integer;
    sh, sm : string;
begin
  if ComboBoxOD.ItemIndex = ComboBoxDO.ItemIndex then exit;
  with SearchData do
    begin
      if ComboBoxOD.ItemIndex = -1 then exit
                                   else Odkial := PZastavka( ComboBoxOD.Items.Objects[ComboBoxOD.ItemIndex] );
      if ComboBoxDO.ItemIndex = -1 then exit
                                   else Kam := PZastavka( ComboBoxDO.Items.Objects[ComboBoxDO.ItemIndex] );
      Settings := FormNastavenieCasu.Settings;
    end;

  Vysledok := Hladanie.Najdi( SearchData );

  if Vysledok = nil then NewImageResults.Visible := False
                    else
    begin
      FormDetail.Vysledok := Vysledok;

      NewImageResults.Visible := True;
      LabelCena.Caption := 'Cena : '+IntToStr( Vysledok^.Cena )+',- Sk';

      h := Vysledok^.Dlzka div 60;
      m := Vysledok^.Dlzka mod 60;

      sh := '';
      if (h > 0) then
        sh := IntToStr( h )+ ' hod ';

      if (m < 10) and
         (h > 0) then sm := '0';
      sm := sm + IntToStr( m ) + ' min';

      LabelDlzka.Caption := 'Dåžka : '+sh+sm;
      LabelPrest.Caption := 'Prestupy : '+IntToStr( Length( Vysledok^.Prestupy )-1 );

      ActiveRozpis := 0;

      if SearchData.Settings.AutoShow then
        begin
          NewImageShowRes.Pressed := True;
          NewImageShowResClick( Sender );
        end;
    end;
end;

procedure THlavneOkno.NewImageResultsClick(Sender: TObject);
begin
  ShowResults := True;
end;

procedure THlavneOkno.NewImageCancelClick(Sender: TObject);
begin
  Mapa.ShowRes := nil;
  ShowResults := False;
end;

procedure THlavneOkno.ListViewResSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  if not Selected then ActiveRozpis := -1
                  else ActiveRozpis := Item.Index;
end;

procedure THlavneOkno.NewImageUkazSpojClick(Sender: TObject);
begin
  Mapa.ShowSpoj := ActiveSpoj;
  if (sCenter in ShownPanels) then
    ShownPanels := ShownPanels + [sMap] - [sCenter]
      else
    ShownPanels := ShownPanels + [sMap];
end;

procedure THlavneOkno.ListBoxSpojeClick(Sender: TObject);
begin
  if ListBoxSpoje.ItemIndex = -1 then exit;

  if (sCenter in ShownPanels) then
    NewImageGOClick(Sender);

  if (sMap in ShownPanels) then
    Mapa.ShowZast := PZastavka( ListBoxSpoje.Items.Objects[ ListBoxSpoje.ItemIndex ] );
end;

procedure THlavneOkno.ListBoxSpojeExit(Sender: TObject);
begin
  Mapa.ShowZast := nil;
end;

procedure THlavneOkno.MapaImageMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  Timer.Enabled := False;
  Timer.Enabled := True;
  MousePos.X := X;
  MousePos.Y := Y;
end;

procedure THlavneOkno.TimerTimer(Sender: TObject);
begin
  Mapa.LookAtNearest( MousePos );
  Timer.Enabled := False;
end;

procedure THlavneOkno.MapaImageMouseLeave(Sender: TObject);
begin
  Timer.Enabled := False;
end;

procedure THlavneOkno.ListBoxZastClick(Sender: TObject);
begin
  if ListBoxZast.ItemIndex = -1 then exit;

  if (sCenter in ShownPanels) then
    NewImageGO2Click(Sender);

  if (sMap in ShownPanels) then
    Mapa.ShowZast := PZastavka( ListBoxZast.Items.Objects[ ListBoxZast.ItemIndex ] );
end;

procedure THlavneOkno.NewImageNextClick(Sender: TObject);
begin
  ActiveRozpis := ActiveRozpis + 1;
end;

procedure THlavneOkno.NewImagePrevClick(Sender: TObject);
begin
  ActiveRozpis := ActiveRozpis - 1;
end;

procedure THlavneOkno.NewImageDetClick(Sender: TObject);
begin
  FormDetail.ShowModal;
end;

procedure THlavneOkno.NewImageShowResClick(Sender: TObject);
begin
  Mapa.ShowRes := Hladanie.Vysledok;
end;

procedure THlavneOkno.MapaImageMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var Point : TPoint;
begin
  Point.X := X;
  Point.Y := Y;
  case Button of
    mbLeft : Start := Point;
    mbRight : Finish := Point;
  end;
end;

procedure THlavneOkno.MapaImageDblClick(Sender: TObject);
var Point : TPoint;
begin
  Point.X := -1;
  Point.Y := -1;

  Start := Point;
  Finish := Point;
end;

procedure THlavneOkno.NewImageSynchroClick(Sender: TObject);
begin
  FormSynchro.ShowModal;
end;

procedure THlavneOkno.PomocClick(Sender: TObject);
begin
  ShellExecute( Handle , 'open' , 'MHD.chm' , '' , '' , SW_MAXIMIZE );
end;

end.

