unit UnitMainForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  OleCtrls, SHDocVw, StdCtrls;

type
  TMainForm = class(TForm)
    WebBrowser: TWebBrowser;
    ButtonStart: TButton;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure ButtonStartClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure WebBrowserDocumentComplete(Sender: TObject;
      const pDisp: IDispatch; var URL: OleVariant);
  private
    { Private declarations }
    LastDownloaded : integer;
    List : TStringList;
    procedure MakeList;
    procedure DownloadNext;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.DFM}

//==============================================================================
//==============================================================================
//
//                                  Constructor
//
//==============================================================================
//==============================================================================

procedure TMainForm.FormCreate(Sender: TObject);
begin
  List := TStringList.Create;
end;

//==============================================================================
//==============================================================================
//
//                                  Destructor
//
//==============================================================================
//==============================================================================

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  List.Free;
end;

//==============================================================================
//==============================================================================
//
//                                 Downloading
//
//==============================================================================
//==============================================================================

procedure TMainForm.MakeList;
var I : integer;
begin
  List.Clear;
  for I := 20 to 100 do
    begin
      List.Add( 'on'+IntToStr(I)+'a.gif' );
      List.Add( 'on'+IntToStr(I)+'b.gif' );
    end;
end;

procedure TMainForm.DownloadNext;
begin
  Inc( LastDownloaded );
  if LastDownloaded = List.Count then exit;
  Label1.Caption := 'http://www.dpb.sk/cespor/abus/'+List[ LastDownloaded ];
  WebBrowser.Navigate( 'http://www.dpb.sk/cespor/abus/'+List[ LastDownloaded ] );
end;

//==============================================================================
//==============================================================================
//
//                                    Events
//
//==============================================================================
//==============================================================================

procedure TMainForm.WebBrowserDocumentComplete(Sender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
begin
  DownloadNext;
end;

procedure TMainForm.ButtonStartClick(Sender: TObject);
begin
  MakeList;

  LastDownloaded := -1;
  DownloadNext;
end;

end.
