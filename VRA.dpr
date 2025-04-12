program VRA;

uses
  Forms,
  UnitPrincipal in 'UnitPrincipal.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'VRA';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
