program shareview_firewall;

uses
  Forms,
  UFWMain in 'UFWmain.pas' {FoFWmain};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFoFWmain, FoFWmain);
  Application.Run;
end.
