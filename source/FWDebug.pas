unit FWDebug;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,Types;

type
  TDebugFW = class(TForm)
    Memo1: TMemo;
    procedure FormResize(Sender: TObject);
    procedure Memo1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DebugFW: TDebugFW;

implementation

{$R *.dfm}

procedure TDebugFW.FormResize(Sender: TObject);

  
begin
     //Memo1.Left:=0+5;
     //Memo1.top:=0+5;
     //Memo1.width:=self.Width-10 ;
     //Memo1.height:=self.Height-10 ;
//  r:=TRect.Creat;
  //r:=GetClientRect;
  //ShowMessage(Format('%d:%d',[r.Bottom,r.Right]));
  //Memo1.SetBounds(r.Left+15,r.Top-35,r.Right-15,r.Bottom+15);
end;

procedure TDebugFW.Memo1DblClick(Sender: TObject);
begin
     Memo1.Clear;
end;

end.
