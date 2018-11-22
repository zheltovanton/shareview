unit uUnreg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, shellapi, jpeg,
  Buttons;

type
  TfoUnreg = class(TForm)
    CPanel1: TPanel;
    Image1: TImage;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Panel11: TPanel;
    Image3: TImage;
    lbFormCaption: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Image2: TImage;
    sbClose: TSpeedButton;
    procedure Label3MouseEnter(Sender: TObject);
    procedure Label3MouseLeave(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure Label6Click(Sender: TObject);
    procedure Label16Click(Sender: TObject);
    procedure Label14Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
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
    procedure Label19Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sbCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  foUnreg: TfoUnreg;

implementation

uses Main, uReg;

{$R *.dfm}

procedure TfoUnreg.Label3MouseEnter(Sender: TObject);
begin
  (sender as tlabel).Font.Style:=[fsunderline];
end;

procedure TfoUnreg.Label3MouseLeave(Sender: TObject);
begin
  (sender as tlabel).Font.Style:=[];

end;

procedure TfoUnreg.Label3Click(Sender: TObject);
begin
  ShellExecute (0,'open', pchar('http://www.miridix.com/'), pchar(''),nil, SW_show);
end;

procedure TfoUnreg.Label4Click(Sender: TObject);
begin
  if not assigned(foreg) then Application.CreateForm(Tforeg, foreg);
  foreg.show;
  //
end;

procedure TfoUnreg.Label5Click(Sender: TObject);
begin
  ShellExecute (0,'open', pchar('mailto:developer@miridix.com?subject=ShareView&body=Hello'), pchar(''),nil, SW_show);

end;

procedure TfoUnreg.Label6Click(Sender: TObject);
begin
  ShellExecute(0, nil,'mailto:support@miridix.com?subject=BugReport(Shareview)',nil,nil,1);

end;

procedure TfoUnreg.Label16Click(Sender: TObject);
begin
  ShellExecute (0,'open', pchar('http://www.miridix.com/page-3.htm'), pchar(''),nil, SW_show);

end;

procedure TfoUnreg.Label14Click(Sender: TObject);
begin
  ShellExecute (0,'open', pchar('mailto:sales@miridix.com?subject=ShareView_buy'), pchar(''),nil, SW_show);
end;

procedure TfoUnreg.SpeedButton3Click(Sender: TObject);
begin
  close;
end;

procedure TfoUnreg.Image3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  image3.OnMouseMove:=Image3MouseMove;
  self.AlphaBlendValue:=trunc(255/100*strtofloatdef(mainform.draga,0));
  _x:=x;
  _y:=y;
end;

procedure TfoUnreg.Image3MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
    left:=x-_x+left;
    top:=y-_y+top;
end;

procedure TfoUnreg.Image3MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  image3.OnMouseMove:=nil;
  self.AlphaBlendValue:=255;

end;

procedure TfoUnreg.lbFormCaptionMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  lbFormCaption.OnMouseMove:=lbFormCaptionMouseMove;
  self.AlphaBlendValue:=trunc(255/100*strtofloatdef(mainform.draga,0));
  _x:=x;
  _y:=y;
end;

procedure TfoUnreg.lbFormCaptionMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
    left:=x-_x+left;
    top:=y-_y+top;
end;

procedure TfoUnreg.lbFormCaptionMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   lbFormCaption.OnMouseMove:=nil;
  self.AlphaBlendValue:=255;
end;

procedure TfoUnreg.Label19Click(Sender: TObject);
begin
 // help
end;

procedure TfoUnreg.FormCreate(Sender: TObject);
var i:integer;
begin
  self.AlphaBlend:=true;
  self.AlphaBlendValue:=0;
  for i:=0 to 12 do
    begin
      self.AlphaBlendValue:=i*20;
      sleep(10);
      application.ProcessMessages;
    end;

end;

procedure TfoUnreg.sbCloseClick(Sender: TObject);
begin
  close;
end;

end.
