unit Unit1;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls;

type
  TDlgProgress = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    RadioGroup1: TRadioGroup;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DlgProgress: TDlgProgress;

implementation

{$R *.DFM}

end.
