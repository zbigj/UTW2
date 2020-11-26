unit utw_main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, AdvPanel,
  dataModule, Vcl.Grids, AdvObj, BaseGrid, AdvGrid, DBAdvGrid, AdvPageControl,
  Vcl.ComCtrls, HTMLabel, dbhtmlab, Vcl.DBCtrls, datelbl, AdvUtil,
  AdvCheckTreeView, AdvGlassButton, AdvEdit, AdvEdBtn,
  bibl;

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
    AdvPanel5: TAdvPanel;
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
    aktDataLbl: TDateLabel;
    Label9: TLabel;
    DBAdvGrid3: TDBAdvGrid;
    Label11: TLabel;
    DBText9: TDBText;
    nazwaSemestruLbl: TLabel;
    DBAdvGrid4: TDBAdvGrid;
    Label10: TLabel;
    Button1: TButton;
    Label12: TLabel;
    Label13: TLabel;
    AdvTabSheet1: TAdvTabSheet;
    AdvTabSheet2: TAdvTabSheet;
    AdvCheckTreeView1: TAdvCheckTreeView;
    AdvPageControl1: TAdvPageControl;
    AdvTabSheet3: TAdvTabSheet;
    AdvTabSheet5: TAdvTabSheet;
    operatorzyDBGrid: TDBAdvGrid;
    Label16: TLabel;
    Label17: TLabel;
    AdvGlassButton1: TAdvGlassButton;
    AdvGlassButton2: TAdvGlassButton;
    Bevel1: TBevel;
    Label14: TLabel;
    operatorEdit: TAdvEdit;
    Label15: TLabel;
    loginEdit: TAdvEdit;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    haslo1Edit: TAdvEdit;
    haslo2Edit: TAdvEdit;
    procedure FormCreate(Sender: TObject);
    procedure DBAdvGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure AdvTabSheet5Show(Sender: TObject);
    procedure AdvCheckTreeView1NodeCheckedChanged(Sender: TObject;
      Node: TTreeNode; NewState: Boolean);
    procedure AdvGlassButton1Click(Sender: TObject);
    procedure operatorzyDBGridSelectionChanged(Sender: TObject; ALeft, ATop,
      ARight, ABottom: Integer);
    procedure AdvGlassButton2Click(Sender: TObject);
  private
    procedure otworzDB;
    function mamyPrawo(id_prawo:integer):boolean;
    {
    RadioButton1: TRadioButton;Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;



implementation

{$R *.dfm}
procedure TMainForm.operatorzyDBGridSelectionChanged(Sender: TObject; ALeft,
  ATop, ARight, ABottom: Integer);
begin
    AdvTabSheet5Show(Sender);
end;

procedure TMainForm.otworzDB;
begin
   with DM do begin
      linkDB.Connected:=true;
      DM.operatorzyQuery.Active:=true;
      kursanciQuery.Active := true;
      HistoriaWplatQuery.Active:=true;
      DM.obecneZajeciaQuery.Active:=true;
      DM.SemestryQuery.Active:=true;
   end;
end;

procedure TMainForm.AdvCheckTreeView1NodeCheckedChanged(Sender: TObject;
  Node: TTreeNode; NewState: Boolean);
var nazwiskoIImie:string;
    id_operator:integer;
begin
   nazwiskoIImie:=operatorzyDBGrid.Columns[1].Field.AsString;
   id_operator:=DM.linkDB.ExecSQLScalar
     ('select id_operator from operator where nazwiskoIImie=:nazwiskoIImie', [nazwiskoIImie]);
   if (Node.SelectedIndex>0) and NewState then begin
      if (DM.linkDB.ExecSQLScalar('select id_operator from posiadanePrawo where id_operator=:id_operator and id_prawo=:id_prawo',[id_operator,Node.SelectedIndex])=0) then
          dm.linkDB.ExecSQL('INSERT INTO posiadanePrawo values(null,:id_prawo,:id_operator)',[Node.SelectedIndex,id_operator])
   end else
   if not NewState and (Node.SelectedIndex>0) then begin
      if (DM.linkDB.ExecSQLScalar('select id_operator from posiadanePrawo where id_operator=:id_operator and id_prawo=:id_prawo',[id_operator,Node.SelectedIndex])<>0) then
         dm.linkDB.ExecSQL('DELETE FROM posiadanePrawo where id_prawo=:id_prawo and id_operator=:id_operator',[Node.SelectedIndex,id_operator]);
   end;

end;

procedure TMainForm.AdvGlassButton1Click(Sender: TObject);
begin
   if (haslo1Edit.text<>haslo2Edit.text) then
      komEsc('Has³a nie s¹ takie same')
   else if haslo1Edit.text='' then
        komEsc('Musisz podaæ has³o')
   else if loginEdit.text='' then
      komEsc('Musisz podaæ login')
   else begin
     if (operatorEdit.text<>'') and mamyPrawo(2) and pyte('Dodaæ operatora '+operatorEdit.text) then begin
         dm.linkDB.ExecSQL('INSERT INTO operator values(null,:nazwiskoIImie,:login,:haslo)',[operatorEdit.text,loginEdit.text,haslo1Edit.text]);
         dm.operatorzyDS.DataSet.Refresh;
         AdvTabSheet5Show(Sender);
         operatorEdit.text:='';
         haslo1Edit.text:='';
         haslo2edit.text:='';
         loginEdit.text:='';
     end;
   end;
end;

procedure TMainForm.AdvGlassButton2Click(Sender: TObject);
var id_operator:integer;
    nazwiskoIImie:string;
begin
end;

function tMainForm.mamyPrawo(id_prawo:integer):boolean;
   begin
      result:=true;
   end;

procedure TMainForm.AdvTabSheet5Show(Sender: TObject);
var i,iPrawo,id_operator:integer;
    nazwiskoIIMie:string;
    aktRow:integer;
begin
   with dm do begin
      id_operator:=operatorzyDS.dataSet.Fields[1].asInteger;
      scratchQuery.open('SELECT p.id_prawo from posiadanePrawo p where p.id_operator=:id_operator',[id_operator]);
      scratchQuery.first;
      for i:=0 to AdvCheckTreeView1.items.Count-1 do
         AdvCheckTreeView1.items[i].StateIndex:=1; // unchecked
      while not scratchQuery.Eof do begin
         iPrawo:=scratchQuery.Fields[0].AsInteger;
         for i := 0 to AdvCheckTreeView1.items.Count-1 do
            if AdvCheckTreeView1.items[i].SelectedIndex=iPrawo then
               AdvCheckTreeView1.items[i].StateIndex:=2;
         scratchQuery.Next;
      end;
   end;
   AdvCheckTreeView1.FullExpand;
end;

procedure TMainForm.Button1Click(Sender: TObject);
var plik1,plik2:textFile;
    tekst,tekst1:string;
    i:longInt;
begin
     AssignFile(plik1,'e:\Delphi 10\project\UTW\sluchacz.txt');
     reset(plik1);
     readln(plik1,tekst);
     tekst:=StringReplace(tekst,'''0000-00-00''','null',[rfReplaceAll]);
     AssignFile(plik2,'e:\Delphi 10\project\UTW\sluchacz2.txt');
     rewrite(plik2);
     repeat
           i:=pos(')',tekst);
           if i>0 then begin
                          tekst1:='INSERT INTO SLUCHACZ VALUES'+copy(tekst,1,i)+';';
                          delete(tekst,1,i+1);
                          writeln(plik2,tekst1);
                       end;
     until i=0;
     closefile(plik2);
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

procedure TMainForm.FormActivate(Sender: TObject);
begin
   nazwaSemestruLbl.Caption:=DM.linkDB.ExecSQLScalar('select s.nazwa from semestr s where s.dataPocz<=:aktData and s.dataKon>=:aktData',[aktDataLbl.Caption]);
   otworzDB;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
     Left:=(Screen.Width-Width)  div 2;
     Top:=(Screen.Height-Height) div 2;
end;

end.
