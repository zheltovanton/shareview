unit uLogSes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGridEh, Buttons, ExtCtrls, main,
  DBCtrlsEh, StdCtrls, Mask, jpeg, EhLibADO;

type
  TfoLogSes = class(TForm)
    CPanel1: TPanel;
    DBGridEh1: TDBGridEh;
    ADOQuery1: TADOQuery;
    DataSource1: TDataSource;
    DBEditEh1: TDBEditEh;
    Label1: TLabel;
    DBDateTimeEditEh1: TDBDateTimeEditEh;
    Label2: TLabel;
    DBDateTimeEditEh2: TDBDateTimeEditEh;
    Label3: TLabel;
    Label4: TLabel;
    DBEditEh2: TDBEditEh;
    Panel11: TPanel;
    Image3: TImage;
    lbFormCaption: TLabel;
    Panel1: TPanel;
    sbMax: TSpeedButton;
    sbClose: TSpeedButton;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure Image3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image3MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image3MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lbFormCaptionMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lbFormCaptionMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure lbFormCaptionMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SpeedButton3Click(Sender: TObject);
    procedure DBEditEh1Change(Sender: TObject);
    procedure SpeedButton166Click(Sender: TObject);
    procedure SpeedButton53Click(Sender: TObject);
    procedure sbCloseClick(Sender: TObject);
    procedure sbMaxClick(Sender: TObject);
    procedure DBGridEh1TitleBtnClick(Sender: TObject; ACol: Integer;
      Column: TColumnEh);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  foLogSes: TfoLogSes;

procedure DataSetAfterOpen(DataSet: TDataSet); forward;

implementation

//----------------------------------------------------------------------------------------------------------------------

var

  fs:formstates;


{$R *.dfm}

//----------------------------------------------------------------------------------------------------------------------

procedure TfoLogSes.FormCreate(Sender: TObject);
begin
  DBGridEh1.SortLocal:=true;
  self.DBDateTimeEditEh1.value:=now;
  self.DBDateTimeEditEh2.value:=now+1;
  self.DBDateTimeEditEh2.OnChange:=DBEditEh1Change;
  self.DBDateTimeEditEh1.OnChange:=DBEditEh1Change;
  self.DBEditEh1Change(self);
  fs:=fsnormal;

  self.sbClose.Left:=self.Width-self.sbClose.Width;
  self.sbMax.Left:=self.Width-self.sbClose.Width*2;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TfoLogSes.Image3MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   image3.OnMouseMove:=Image3MouseMove;
  self.AlphaBlendValue:=trunc(255/100*strtofloatdef(mainform.draga,0));
  _x:=x;
  _y:=y;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TfoLogSes.Image3MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
    left:=x-_x+left;
    top:=y-_y+top;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TfoLogSes.Image3MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   image3.OnMouseMove:=nil;
  self.AlphaBlendValue:=255;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TfoLogSes.lbFormCaptionMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   lbFormCaption.OnMouseMove:=lbFormCaptionMouseMove;
  self.AlphaBlendValue:=trunc(255/100*strtofloatdef(mainform.draga,0));
  _x:=x;
  _y:=y;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TfoLogSes.lbFormCaptionMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
    left:=x-_x+left;
    top:=y-_y+top;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TfoLogSes.lbFormCaptionMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  lbFormCaption.OnMouseMove:=nil;
  self.AlphaBlendValue:=255;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TfoLogSes.SpeedButton3Click(Sender: TObject);
begin
close;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TfoLogSes.DBEditEh1Change(Sender: TObject);
begin
  if self.ADOQuery1.Active then self.ADOQuery1.Active:=false;
  self.ADOQuery1.SQL.Clear;
  self.ADOQuery1.SQL.Add(' select * from sessions ');
  self.ADOQuery1.SQL.Add(' where dtime >= :d1  and dtime <= :d2 ');
  if self.DBEditEh1.Text<>'' then
  self.ADOQuery1.SQL.Add(' and ucase(Sesi502_cname) like '+#39+'%'+self.DBEditEh1.Text+'%'+#39+' ');
  if self.DBEditEh2.Text<>'' then
  self.ADOQuery1.SQL.Add(' and ucase(Sesi502_username) like '+#39+'%'+self.DBEditEh2.Text+'%'+#39+' ');

  self.ADOQuery1.Parameters.ParameterCollection.Refresh;
  self.ADOQuery1.Parameters.Refresh;
  self.ADOQuery1.Parameters[0].Value:=strtodate(self.DBDateTimeEditEh1.text);
  self.ADOQuery1.Parameters[1].Value:=strtodate(self.DBDateTimeEditEh2.text);
//  self.ADOQuery1.SQL.SaveToFile('1.sql');
  self.ADOQuery1.Open;
  DataSetAfterOpen(self.ADOQuery1);
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TfoLogSes.SpeedButton166Click(Sender: TObject);
begin
  self.ADOQuery1.First;

end;

//----------------------------------------------------------------------------------------------------------------------

procedure TfoLogSes.SpeedButton53Click(Sender: TObject);
begin
self.ADOQuery1.last;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TfoLogSes.sbCloseClick(Sender: TObject);
begin
close;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TfoLogSes.sbMaxClick(Sender: TObject);
begin

   if fs=fsMaximized then fs:=fsNormal else fs:=fsMaximized;

   if fs=fsMaximized then
     begin
       self.Left:=screen.WorkAreaRect.Left;
       self.Top:=screen.WorkAreaRect.Top;
       self.Width:=screen.WorkAreaRect.Right+screen.WorkAreaRect.Left;
       self.Height:=screen.WorkAreaRect.Bottom+screen.WorkAreaRect.Top;
     end;

   if fs=fsNormal then
     begin
       self.Width:=NormalSizeWidth;
       self.Height:=NormalSizeHeight;
       self.Left:=(screen.WorkAreaWidth-self.Width) div 2;
       self.Top:=(screen.WorkAreaHeight-self.Height) div 2;
     end;

   self.sbClose.Left:=self.Width-self.sbClose.Width;
   self.sbMax.Left:=self.Width-self.sbClose.Width*2;

end;

//----------------------------------------------------------------------------------------------------------------------

procedure DataSetAfterOpen(DataSet: TDataSet);
 var i: Integer;
begin
 for i:=1 to foLogSes.DBGridEh1.Columns.Count do
  if foLogSes.DBGridEh1.Columns[i-1].Title.SortMarker<>smNoneEh then
  TAdoDataset(foLogSes.DbgridEh1.Datasource.dataset).Sort := foLogSes.DBGridEh1.Columns[i-1].FieldName;
  DataSet.First;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TfoLogSes.DBGridEh1TitleBtnClick(Sender: TObject; ACol: Integer;
  Column: TColumnEh);
var i:integer;
begin
// (Sender as TDBGridEh).DataSource.DataSet.DoSort([Column.FieldName],[(Column.Title.SortMarker=smUpEh)]);
  TAdoDataset(foLogSes.DbgridEh1.Datasource.dataset).Sort := Column.FieldName;

  if Column.Title.SortIndex=0 then
  begin
   for i:=1 to (Sender as TDBGridEh).Columns.Count do dbgrideh1.Columns[i-1].Title.SortIndex:=0;
   Column.Title.SortMarker:=smUpEh;
  end
   else
    begin
     if Column.Title.SortMarker=smUpEh then Column.Title.SortMarker:=smDownEh
      else Column.Title.SortMarker:=smUpEh;
    end;
end;

end.
