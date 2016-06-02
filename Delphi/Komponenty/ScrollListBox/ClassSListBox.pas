unit ClassSListBox;

interface

uses StdCtrls, Messages;

type TSListBox = class(TListBox)
     private
       procedure OnMouseWheel( var Message : TMessage ); message WM_MOUSEWHEEL;
     end;

procedure Register;

implementation

uses Classes;

procedure Register;
begin
  RegisterComponents( 'Standard' , [TSListBox] );
end;

procedure TSListBox.OnMouseWheel( var Message : TMessage );
var Delta : integer;
begin
  Delta := (Abs(Message.WParam) shr 16) div 120;

  if Message.WParam > 0 then Delta := -Delta;

  if (Delta > 0) then
    begin
      if (ItemIndex + Delta > Items.Count-1) then ItemIndex := Items.Count-1
                                             else ItemIndex := ItemIndex + Delta;
    end
      else
    begin
      if (ItemIndex + Delta < 0) then ItemIndex := 0
                                 else ItemIndex := ItemIndex + Delta;
    end;
end;

end.

