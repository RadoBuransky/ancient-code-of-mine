unit UnitMainForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Gauges, ExtCtrls, WinTypes, WinProcs;

type
  TMainForm = class(TForm)
    GaugeGDI: TGauge;
    GaugeUser: TGauge;
    Label1: TLabel;
    Label2: TLabel;
    Timer: TTimer;
    procedure TimerTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.DFM}

procedure TMainForm.TimerTimer(Sender: TObject);
var A : TMemorystatus;
begin
  GlobalMemoryStatus( A );

  GaugeUser.Progress := A.dwAvailPhys div (A.dwTotalPhys div 100);
  GaugeGdi.Progress := A.dwAvailVirtual div (A.dwTotalVirtual div 100);

  GaugeGdi.Invalidate;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  SetWindowPos( Application.Handle , Hwnd_TopMost , 0 , 0 , 0 , 0 , swp_NoSize or swp_NoMove );
  TimerTimer( self );
end;

end.
