program SOLIDProject;

uses
  Vcl.Forms,
  frmSOLID in 'frmSOLID.pas' {Form1},
  uItemInterfaces in 'uItemInterfaces.pas',
  uOrderItems in 'uOrderItems.pas',
  uOrder in 'uOrder.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
