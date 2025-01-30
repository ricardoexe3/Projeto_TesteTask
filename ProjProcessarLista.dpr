program ProjProcessarLista;

uses
  Vcl.Forms,
  UView.Principal in 'View\UView.Principal.pas' {UViewPrincipal},
  UController.ProcessarLista in 'Controller\UController.ProcessarLista.pas',
  UModel.ProcessarLista in 'Model\UModel.ProcessarLista.pas',
  UTypes in 'Utils\UTypes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TUViewPrincipal, UViewPrincipal);
  Application.Run;
end.
