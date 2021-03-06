unit ublackfiles;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGridEh, Buttons, ExtCtrls, main,
  DBCtrlsEh, StdCtrls, Mask, jpeg;

type
  Tfoblackfiles = class(TForm)
    CPanel1: TPanel;
    DBGridEh1: TDBGridEh;
    ADOQuery1: TADOQuery;
    DataSource1: TDataSource;
    Panel11: TPanel;
    Image3: TImage;
    lbFormCaption: TLabel;
    SpeedButton1k: TSpeedButton;
    Panel1: TPanel;
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
    procedure SpeedButton166Click(Sender: TObject);
    procedure SpeedButton53Click(Sender: TObject);
    procedure SpeedButton1kClick(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure sbCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  foblackfiles: Tfoblackfiles;

implementation

{$R *.dfm}

procedure Tfoblackfiles.FormCreate(Sender: TObject);
begin
  if self.ADOQuery1.Active then self.ADOQuery1.Active:=false;
  self.ADOQuery1.SQL.Clear;
  self.ADOQuery1.SQL.Add(' select * from files_white ');
  self.ADOQuery1.SQL.Add(' order by fi3_pathname,fi3_username ');
  self.ADOQuery1.Open;
end;

procedure Tfoblackfiles.Image3MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   image3.OnMouseMove:=Image3MouseMove;
  self.AlphaBlendValue:=trunc(255/100*strtofloatdef(mainform.draga,0));
  _x:=x;
  _y:=y;
end;

procedure Tfoblackfiles.Image3MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
    left:=x-_x+left;
    top:=y-_y+top;
end;

procedure Tfoblackfiles.Image3MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   image3.OnMouseMove:=nil;
  self.AlphaBlendValue:=255;
end;

procedure Tfoblackfiles.lbFormCaptionMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   lbFormCaption.OnMouseMove:=lbFormCaptionMouseMove;
  self.AlphaBlendValue:=trunc(255/100*strtofloatdef(mainform.draga,0));
  _x:=x;
  _y:=y;
end;

procedure Tfoblackfiles.lbFormCaptionMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
    left:=x-_x+left;
    top:=y-_y+top;
end;

procedure Tfoblackfiles.lbFormCaptionMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  lbFormCaption.OnMouseMove:=nil;
  self.AlphaBlendValue:=255;
end;

procedure Tfoblackfiles.SpeedButton3Click(Sender: TObject);
begin
close;
end;

procedure Tfoblackfiles.SpeedButton166Click(Sender: TObject);
begin
  self.ADOQuery1.First;

end;

procedure Tfoblackfiles.SpeedButton53Click(Sender: TObject);
begin
self.ADOQuery1.last;
end;

procedure Tfoblackfiles.SpeedButton1kClick(Sender: TObject);
begin
  if MessageDlg('Will be deleted 1 record. OK?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes  then
    begin
      self.ADOQuery1.Delete;
    end;

end;

procedure Tfoblackfiles.SpeedButton4Click(Sender: TObject);
begin
  self.WindowState:=wsminimized;
end;

procedure Tfoblackfiles.sbCloseClick(Sender: TObject);
begin
  close;
end;

end.
