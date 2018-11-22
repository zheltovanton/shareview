unit uDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ExtCtrls, DBCtrlsEh, StdCtrls, Mask, jpeg, DB, ADODB, Grids, DBGridEh;

type
  TfoDialog = class(TForm)
    Panel11: TPanel;
    Image3: TImage;
    lbFormCaption: TLabel;
    Panel1: TPanel;
    sbClose: TSpeedButton;
    SpeedButton1: TSpeedButton;
    lbText: TLabel;
    edResName: TDBEditEh;
    Label1: TLabel;
    edDirectory: TDBEditEh;
    SpeedButton2: TSpeedButton;
    Label2: TLabel;
    edComment: TDBEditEh;
    Label3: TLabel;
    edPass: TDBEditEh;
    Label4: TLabel;
    edMaxUsers: TDBEditEh;
    Label5: TLabel;
    SpeedButton3: TSpeedButton;
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
    Procedure LoadLang;
    procedure SpeedButton3Click(Sender: TObject);
    procedure DBEditEh1Change(Sender: TObject);
    procedure SpeedButton166Click(Sender: TObject);
    procedure SpeedButton53Click(Sender: TObject);
    procedure sbCloseClick(Sender: TObject);
    procedure sbMaxClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  foDialog: TfoDialog;

procedure DataSetAfterOpen(DataSet: TDataSet); forward;

implementation

uses Main;

//----------------------------------------------------------------------------------------------------------------------

var

  fs:formstates;


{$R *.dfm}


Procedure TfoDialog.LoadLang;
begin
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TfoDialog.FormCreate(Sender: TObject);
var i:integer;
    s:string;
begin
  foDialog.edDirectory.Text:='';
  foDialog.edResName.Text:='';
  
  edDirectory.Text:=MainForm.SelectDirectory;
  s:=edDirectory.Text;
  for i:=1 to length(s) do if s[length(s)-i]='\' then break;
  delete(s,1,length(s)-i);
  edResName.Text:=s;
  foDialog.BringToFront;
  if edDirectory.Text='' then close;
  self.sbClose.Left:=self.Width-self.sbClose.Width;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TfoDialog.Image3MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   image3.OnMouseMove:=Image3MouseMove;
//  self.AlphaBlendValue:=trunc(255/100*strtofloatdef(mainform.draga,0));
  _x:=x;
  _y:=y;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TfoDialog.Image3MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
    left:=x-_x+left;
    top:=y-_y+top;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TfoDialog.Image3MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   image3.OnMouseMove:=nil;
  self.AlphaBlendValue:=255;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TfoDialog.lbFormCaptionMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   lbFormCaption.OnMouseMove:=lbFormCaptionMouseMove;
//  self.AlphaBlendValue:=trunc(255/100*strtofloatdef(mainform.draga,0));
  _x:=x;
  _y:=y;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TfoDialog.lbFormCaptionMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
    left:=x-_x+left;
    top:=y-_y+top;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TfoDialog.lbFormCaptionMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  lbFormCaption.OnMouseMove:=nil;
  self.AlphaBlendValue:=255;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TfoDialog.SpeedButton3Click(Sender: TObject);
begin
  close;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TfoDialog.DBEditEh1Change(Sender: TObject);
begin
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TfoDialog.SpeedButton166Click(Sender: TObject);
begin

end;

//----------------------------------------------------------------------------------------------------------------------

procedure TfoDialog.SpeedButton53Click(Sender: TObject);
begin
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TfoDialog.sbCloseClick(Sender: TObject);
begin
   mainform.dialog_result:=false;
close;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TfoDialog.sbMaxClick(Sender: TObject);
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

end;

//----------------------------------------------------------------------------------------------------------------------

procedure DataSetAfterOpen(DataSet: TDataSet);
begin
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TfoDialog.SpeedButton1Click(Sender: TObject);
begin
   mainform.dialog_result:=true;
   GetMem(MainForm.srDir, SizeOF(WideChar)*256);
   GetMem(MainForm.srComment, SizeOF(WideChar)*256);
   GetMem(MainForm.srName, SizeOF(WideChar)*256);
   GetMem(MainForm.srPass, SizeOF(WideChar)*256);
   GetMem(MainForm.srMaxusers, SizeOF(WideChar)*256);
   StringToWideChar(edDirectory.Text, MainForm.srDir, SizeOF(WideChar)*256);
   StringToWideChar(edResName.Text, MainForm.srName, SizeOF(WideChar)*256);
   StringToWideChar(edComment.Text, MainForm.srComment, SizeOF(WideChar)*256);
   StringToWideChar(edPass.Text, MainForm.srPass, SizeOF(WideChar)*256);
   StringToWideChar(edMaxUsers.Text, MainForm.srMaxusers, SizeOF(WideChar)*256);
   close;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TfoDialog.SpeedButton2Click(Sender: TObject);
var i:integer;
    s:string;
begin
  edDirectory.Text:=MainForm.SelectDirectory;
  s:=edDirectory.Text;
  for i:=1 to length(s) do if s[length(s)-i]='\' then break;
  delete(s,1,length(s)-i);
  edResName.Text:=s;
  foDialog.BringToFront;

end;

//----------------------------------------------------------------------------------------------------------------------

end.
