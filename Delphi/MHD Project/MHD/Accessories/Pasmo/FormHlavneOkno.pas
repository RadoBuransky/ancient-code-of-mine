unit FormHlavneOkno;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ExtCtrls, ClassMapa;

type
  THlavneOkno = class(TForm)
    MainMenu: TMainMenu;
    MainMenuVyhladat: TMenuItem;
    MainMenuZobrazit: TMenuItem;
    ZobrazitAutomaty: TMenuItem;
    ZobrazitNazvy: TMenuItem;
    ZobrazitHranicePasiem: TMenuItem;
    ZobrazitPredajneDPB: TMenuItem;
    MainMenuRozvrhy: TMenuItem;
    MapaImage: TImage;
    Info: TImage;
    Bevel1: TBevel;
    Bevel2: TBevel;
    MiniMapaImage: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure ZapisPolygon;
  public
    { Public declarations }
  end;

var
  HlavneOkno: THlavneOkno;
  Mapa : TMapa;

implementation

{$R *.DFM}

//==============================================================================
//==============================================================================
//
//                                    Constructor
//
//==============================================================================
//==============================================================================

procedure THlavneOkno.FormCreate(Sender: TObject);
begin
  Mapa := TMapa.Create( MiniMapaImage , MapaImage );
end;

//==============================================================================
//==============================================================================
//
//                                     Destructor
//
//==============================================================================
//==============================================================================

procedure THlavneOkno.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ZapisPolygon;
  Mapa.Free;
end;

//==============================================================================
//==============================================================================
//
//                                  Zapis do suboru
//
//==============================================================================
//==============================================================================

procedure THlavneOkno.ZapisPolygon;
var F : TextFile;
    I : integer;
begin
  AssignFile( F , '../../Data/Pasma/Pasma.txt' );
  Rewrite( F );
  for I := 0 to Mapa.Body.Count-1 do
    Writeln( F , TPoint( Mapa.Body[I]^ ).X,' ',TPoint( Mapa.Body[I]^ ).Y );
  CloseFile( F );
end;

end.
