program ConsomeAPI;

uses
  Forms,
  UPrincipalView in 'View\UPrincipalView.pas' {frmPrincipal},
  Rest.Builder in 'Service\Rest.Builder.pas',
  Rest.Interfaces in 'Service\Rest.Interfaces.pas',
  Rest.Model in 'Service\Rest.Model.pas',
  Rest.Utils in 'Service\Rest.Utils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
