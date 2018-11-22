unit uTrialEnd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, shellapi, jpeg,
  Buttons, ComCtrls;

type
  TfoTrialEnd = class(TForm)
    BmBtnEditCancel: TBitBtn;
    BmBtnEditOK: TBitBtn;
    ProgressBar1: TProgressBar;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label15: TLabel;
    Label6: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    Label7: TLabel;
    procedure Label3MouseEnter(Sender: TObject);
    procedure Label3MouseLeave(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure Label6Click(Sender: TObject);
    procedure Label16Click(Sender: TObject);
    procedure Label14Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure Label19Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sbCloseClick(Sender: TObject);
    procedure BmBtnEditOKClick(Sender: TObject);
    procedure BmBtnEditCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  foTrialEnd: TfoTrialEnd;

implementation

uses Main, uReg;

{$R *.dfm}

procedure TfoTrialEnd.Label3MouseEnter(Sender: TObject);
begin
  (sender as tlabel).Font.Style:=[fsunderline];
end;

procedure TfoTrialEnd.Label3MouseLeave(Sender: TObject);
begin
  (sender as tlabel).Font.Style:=[];

end;

procedure TfoTrialEnd.Label3Click(Sender: TObject);
begin
  ShellExecute (0,'open', pchar('http://www.miridix.com/'), pchar(''),nil, SW_show);
end;

procedure TfoTrialEnd.Label4Click(Sender: TObject);
begin
  if not assigned(foreg) then Application.CreateForm(Tforeg, foreg);
  foreg.show;
  //
end;

procedure TfoTrialEnd.Label5Click(Sender: TObject);
begin
  ShellExecute (0,'open', pchar('mailto:developer@miridix.com?subject=ShareView&body=Hello'), pchar(''),nil, SW_show);

end;

procedure TfoTrialEnd.Label6Click(Sender: TObject);
begin
  ShellExecute(0, nil,'mailto:support@miridix.com?subject=BugReport(Shareview)',nil,nil,1);

end;

procedure TfoTrialEnd.Label16Click(Sender: TObject);
begin
  ShellExecute (0,'open', pchar('http://www.miridix.com/page-3.htm'), pchar(''),nil, SW_show);

end;

procedure TfoTrialEnd.Label14Click(Sender: TObject);
begin
  ShellExecute (0,'open', pchar('mailto:sales@miridix.com?subject=ShareView_buy'), pchar(''),nil, SW_show);
end;

procedure TfoTrialEnd.SpeedButton3Click(Sender: TObject);
begin
  halt;
end;

procedure TfoTrialEnd.Label19Click(Sender: TObject);
begin
 // help
end;

procedure TfoTrialEnd.FormCreate(Sender: TObject);
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
  ProgressBar1.Position:=mainform.somedigit;
  Label7.Caption:=inttostr(mainform.somedigit);
  if mainform.somedigit>30 then BmBtnEditOK.Enabled:=false;
end;

procedure TfoTrialEnd.sbCloseClick(Sender: TObject);
begin
  close;
end;

procedure TfoTrialEnd.BmBtnEditOKClick(Sender: TObject);
begin
  self.OnClose:=nil;
  close;
end;

procedure TfoTrialEnd.BmBtnEditCancelClick(Sender: TObject);
begin
  mainform.N2Click(self);
end;

procedure TfoTrialEnd.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:=canone;
end;

end.
