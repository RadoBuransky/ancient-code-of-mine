unit FormHlavneOkno;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ClassKontrola;

type
  THlavneOkno = class(TForm)
    ButtonZacni: TButton;
    GroupBox: TGroupBox;
    Label1: TLabel;
    LabelPocetZastavok: TLabel;
    LabelPocetLiniek: TLabel;
    Label2: TLabel;
    MemoChyby: TMemo;
    ListBox: TListBox;
    procedure ButtonZacniClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  HlavneOkno: THlavneOkno;
  Kontrola : TKontrola;

implementation

{$R *.DFM}

//==============================================================================
//==============================================================================
//
//                                   Z A È N I
//
//==============================================================================
//==============================================================================

procedure THlavneOkno.ButtonZacniClick(Sender: TObject);
begin
  ButtonZacni.Enabled := False;

  MemoChyby.Clear;

  Kontrola := TKontrola.Create( ListBox , MemoChyby , LabelPocetZastavok , LabelPocetLiniek );
  Kontrola.Free;
  
  ButtonZacni.Enabled := True;
end;

end.
