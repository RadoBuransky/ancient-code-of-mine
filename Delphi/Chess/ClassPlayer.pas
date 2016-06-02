unit ClassPlayer;

interface

uses Types;

type TPlayer = class
     public
       function MakeMove( Figures : TFigures ) : TMove; virtual; abstract;
     end;

implementation

end.
