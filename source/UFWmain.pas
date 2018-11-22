unit UFWmain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, OleServer, TIPFWHOOKLib_TLB, ExtCtrls,
  RXShell, TrayIcon, Animate, GIFCtrl;

type
  TfoFWmain = class(TForm)
    TIPFirewall1: TTIPFirewall;
    Button1: TButton;
    Button2: TButton;
    Timer1: TTimer;
    TrayIcon1: TTrayIcon;
    RxGIFAnimator1: TRxGIFAnimator;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure TIPFirewall1Log(ASender: TObject;
      const bstrMessage: WideString);
    procedure TIPFirewall1Error(ASender: TObject;
      const bstrError: WideString);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  foFWmain           : TfoFWmain;
  apl_path           : string;
  t                  : textfile;

implementation

{$R *.dfm}

procedure TfoFWmain.Button1Click(Sender: TObject);
begin
 TIPFirewall1.StartFirewall(apl_path+'\fw_hook.policy');

end;

procedure TfoFWmain.Button2Click(Sender: TObject);
begin
  TIPFirewall1.StopFirewall;
end;

procedure TfoFWmain.TIPFirewall1Log(ASender: TObject;
  const bstrMessage: WideString);
begin
  assignfile(t,apl_path+'\log.fw');
  if FileExists(apl_path+'\log.fw') then append(t) else rewrite(t);
  writeln(t,string(bstrMessage));
  closefile(t);
end;

procedure TfoFWmain.TIPFirewall1Error(ASender: TObject;
  const bstrError: WideString);
begin
  assignfile(t,apl_path+'\log.fw');
  if FileExists(apl_path+'\log.fw') then append(t) else rewrite(t);
  writeln(t,'Error: '+string(bstrError));
  closefile(t);
end;

procedure TfoFWmain.FormCreate(Sender: TObject);
begin
  apl_path:=ExtractFileDir(application.ExeName);
  Height:=1;//RxGIFAnimator1.Height;
  Width:=1;//RxGIFAnimator1.Width;

end;

procedure TfoFWmain.Timer1Timer(Sender: TObject);
begin
 TIPFirewall1.StartFirewall(apl_path+'\fw_hook.policy');
 Timer1.Enabled:=false;
TrayIcon1.Minimize;
 Application.Minimize;
end;

procedure TfoFWmain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  TIPFirewall1.StopFirewall;
end;

end.
