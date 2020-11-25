unit utw_main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, AdvPanel,
  dataModule, Vcl.Grids, AdvObj, BaseGrid, AdvGrid, DBAdvGrid, AdvPageControl,
  Vcl.ComCtrls, HTMLabel, dbhtmlab, Vcl.DBCtrls, datelbl;

type
  TMainForm = class(TForm)
    AdvPanel1: TAdvPanel;
    AdvPageControl3: TAdvPageControl;
    AdvTabSheet7: TAdvTabSheet;
    AdvTabSheet8: TAdvTabSheet;
    AdvTabSheet9: TAdvTabSheet;
    AdvPanel2: TAdvPanel;
    AdvPanel3: TAdvPanel;
    DBAdvGrid1: TDBAdvGrid;
    AdvPanel4: TAdvPanel;
    AdvPanel5: TAdvPanel;
    Bevel1: TBevel;
    DBText1: TDBText;
    DBText2: TDBText;
    DBText3: TDBText;
    DBText4: TDBText;
    DBText5: TDBText;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    DBText6: TDBText;
    DBText7: TDBText;
    DBText8: TDBText;
    Label7: TLabel;
    Label8: TLabel;
    DBAdvGrid2: TDBAdvGrid;
    DateLabel1: TDateLabel;
    Label9: TLabel;
    Label10: TLabel;
    DBAdvGrid3: TDBAdvGrid;
    Label11: TLabel;
    DBText9: TDBText;
    procedure FormCreate(Sender: TObject);
    procedure DBAdvGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
  private
    procedure otworzDB;
    {
    RadioButton1: TRadioButton;Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;



implementation

{$R *.dfm}
procedure TMainForm.otworzDB;
begin
   with DM do begin
      linkDB.open
        ('driverId=FB;dataBase=E:\Delphi 10\project\UTW\UTW2.FDB;user_name=SYSDBA;password=masterkey');
      linkDB.Connected:=true;
      kursanciQuery.Active := true;
   end;
end;

procedure TMainForm.DBAdvGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  vDbGrid: TDBAdvGrid absolute Sender;
begin
  // only do the next line if this event generated for
  // the first columnn (column with index 0)
  if (ACol=0) and (aRow<>0) then
    vDbGrid.Canvas.TextOut(Rect.Left + 2
                           , Rect.Top + 2
                           , IntToStr(ARow));
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
     Left:=(Screen.Width-Width)  div 2;
     Top:=(Screen.Height-Height) div 2;
end;

end.
