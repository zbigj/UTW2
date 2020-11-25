program UTW;

uses
  Vcl.Forms,
  utw_main in 'utw_main.pas' {MainForm},
  dataModule in 'dataModule.pas' {DataModule2: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TDataModule2, DM);
  Application.Run;
end.
