unit ClassBSTree;

interface

type TBSTree = class;
     TBSTreeChildren = array of TBSTree;

     TBSTree = class
     public
       C           : char;
       IsWord      : boolean;
       Children    : TBSTreeChildren;

       constructor Create( Value : char; Word : boolean );
       destructor  Destroy; override;
     end;

implementation

//==============================================================================
// Constructor / destructor
//==============================================================================

constructor TBSTree.Create( Value : char; Word : boolean );
begin
  inherited Create;

  C      := Value;
  IsWord := Word;
  SetLength( Children , 0 );
end;

destructor TBSTree.Destroy;
var I : integer;
begin
  for I := Low( Children ) to High( Children ) do
    Children[I].Free;
  SetLength( Children , 0 );

  inherited;
end;

end.
