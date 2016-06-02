unit UnitChars;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, ExtCtrls;

type
  TFormChars = class(TForm)
    ButtonOK: TButton;
    ListView: TListView;
    Image: TImage;
    ButtonAdd: TButton;
    ButtonRmv: TButton;
    procedure FormShow(Sender: TObject);
    procedure ListViewSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure ButtonOKClick(Sender: TObject);
    procedure ButtonRmvClick(Sender: TObject);
    procedure ButtonAddClick(Sender: TObject);
  private
    { Private declarations }
    procedure UpdateListView;
  public
    { Public declarations }
  end;

var
  FormChars: TFormChars;

implementation

uses ClassChars, UnitAddChar;

{$R *.DFM}

procedure TFormChars.UpdateListView;
var I : integer;
begin
  ListView.Items.Clear;
  for I := 0 to Chars.Data.Count-1 do
    begin
      with TListItem( ListView.Items.Add ) do
        begin
          Caption := TData( Chars.Data[I]^ ).Value;
          SubItems.Add( TData( Chars.Data[I]^ ).BMPFileName );
        end;
    end;
end;

procedure TFormChars.FormShow(Sender: TObject);
begin
  UpdateListView;
end;

procedure TFormChars.ListViewSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  if Selected then
    begin
      Image.Picture.Bitmap := TData( Chars.Data[Item.Index]^ ).BMP;
      ButtonRmv.Enabled := True;
    end
      else
    begin
      Image.Picture.Bitmap := nil;
      ButtonRmv.Enabled := False;
    end;
end;

procedure TFormChars.ButtonOKClick(Sender: TObject);
begin
  ModalResult := 1;
end;

procedure TFormChars.ButtonRmvClick(Sender: TObject);
begin
  Chars.Data.Delete( ListView.Selected.Index );
  UpdateListView;
end;

procedure TFormChars.ButtonAddClick(Sender: TObject);
var PNewData : PData;
begin
  if FormAddChar.ShowModal = 1 then
    begin
      New( PNewData );
      with PNewData^ do
        begin
          Value := FormAddChar.NewChar.Value;
          BMPFileName := FormAddChar.NewChar.BMPFileName;
          BMP := TBitmap.Create;
          BMP.Assign( FormAddChar.NewChar.BMP );
        end;
      Chars.AddData( PNewData );
    end;
  UpdateListView;
end;

end.
