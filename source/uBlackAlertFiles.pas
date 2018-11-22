unit uBlackAlertFiles;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, Buttons, StdCtrls;

type
  TfoBlackAlertFiles = class(TForm)
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
  foBlackAlertFiles: TfoBlackAlertFiles;

implementation

uses uViewFiles, Main, Types;

{$R *.dfm}

procedure TfoBlackAlertFiles.FormCreate(Sender: TObject);
begin
 // timer1.Enabled:=true;
end;

procedure TfoBlackAlertFiles.Timer1Timer(Sender: TObject);
begin
  MainForm.tmSesBlackCheck.Enabled:=true;
  close;
end;

procedure TfoBlackAlertFiles.FormShow(Sender: TObject);
begin
//  self.Height:=90;
//  self.Width:=120;
  self.left:=screen.WorkAreaRect.Right+screen.WorkAreaRect.Left-self.Width;
  self.Top:=screen.WorkAreaRect.Top+screen.WorkAreaRect.Bottom-self.Height;
  foBlackAlertFiles.BringToFront;
end;

procedure TfoBlackAlertFiles.lvFiles_compareClick(Sender: TObject);
begin
   mainform.WindowState:=wsNormal;
end;

procedure TfoBlackAlertFiles.SpeedButton1Click(Sender: TObject);
begin
  Application.Restore;
  close
end;

end.
