unit uHelp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, jpeg, ComCtrls, main, OleCtrls,
  SHDocVw;

{admin$ 
My Documents 
print$ 
ipc$ 
Shared Docs 
Any default shares named a$ through z$  }

type
  TfoHelp = class(TForm)
    Panel11: TPanel;
    Image3: TImage;
    lbFormCaption: TLabel;
    WebBrowser1: TWebBrowser;
    sbClose: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure dxButton1Click(Sender: TObject);
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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  foHelp: TfoHelp;

implementation

{$R *.dfm}


procedure TfoHelp.FormCreate(Sender: TObject);
begin
//
  self.WebBrowser1.Navigate(apl_path+'\help.rtf');
end;


procedure TfoHelp.dxButton1Click(Sender: TObject);
begin
  close;
end;

procedure TfoHelp.Image3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  image3.OnMouseMove:=Image3MouseMove;
  self.AlphaBlendValue:=trunc(255/100*strtofloatdef(mainform.draga,0));
  _x:=x;
  _y:=y;
end;

procedure TfoHelp.Image3MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
    left:=x-_x+left;
    top:=y-_y+top;
end;

procedure TfoHelp.Image3MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  image3.OnMouseMove:=nil;
  self.AlphaBlendValue:=255;
end;

procedure TfoHelp.lbFormCaptionMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  lbFormCaption.OnMouseMove:=lbFormCaptionMouseMove;
  self.AlphaBlendValue:=trunc(255/100*strtofloatdef(mainform.draga,0));
  _x:=x;
  _y:=y;
end;

procedure TfoHelp.lbFormCaptionMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
    left:=x-_x+left;
    top:=y-_y+top;
end;

procedure TfoHelp.lbFormCaptionMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   lbFormCaption.OnMouseMove:=nil;
  self.AlphaBlendValue:=255;
end;

procedure TfoHelp.SpeedButton3Click(Sender: TObject);
begin
  close;
end;

end.
