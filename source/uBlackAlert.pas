unit uBlackAlert;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, Buttons, StdCtrls;

type
  TfoBlackAlert = class(TForm)
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lvFiles_compareClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  foBlackAlert: TfoBlackAlert;

implementation

uses uViewFiles, Main, Types;

{$R *.dfm}

procedure TfoBlackAlert.FormCreate(Sender: TObject);
begin
 // timer1.Enabled:=true;
end;

procedure TfoBlackAlert.Timer1Timer(Sender: TObject);
begin
  MainForm.tmSesBlackCheck.Enabled:=true;
  close;
end;

procedure TfoBlackAlert.FormShow(Sender: TObject);
begin
//  self.Height:=90;
//  self.Width:=120;
  self.left:=screen.WorkAreaRect.Right+screen.WorkAreaRect.Left-self.Width;
  self.Top:=screen.WorkAreaRect.Top+screen.WorkAreaRect.Bottom-self.Height;
  foBlackAlert.BringToFront;
end;

procedure TfoBlackAlert.lvFiles_compareClick(Sender: TObject);
begin
   mainform.WindowState:=wsNormal;
end;

procedure TfoBlackAlert.SpeedButton1Click(Sender: TObject);
begin
  Application.Restore;
  close
end;

end.
