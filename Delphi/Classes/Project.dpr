program Project;

{$R *.RES}

type	TA = class
		protected
			procedure F; virtual; abstract;
		end;

		TB = class( TA )
		protected
			procedure F; override;
		end;

		TC = class( TB )
		protected
			procedure F; override;
		end;

begin
end.
