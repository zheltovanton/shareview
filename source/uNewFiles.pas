unit uNewFiles;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls;

type
  TfoNewFiles = class(TForm)
    lvFiles_compare: TListView;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lvFiles_compareClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  foNewFiles: TfoNewFiles;

implementation

uses uViewFiles, Main;

{$R *.dfm}

procedure TfoNewFiles.FormCreate(Sender: TObject);
begin
  timer1.Enabled:=true;
end;

procedure TfoNewFiles.Timer1Timer(Sender: TObject);
begin
  close;
end;

procedure TfoNewFiles.FormShow(Sender: TObject);
begin
  self.lvFiles_compare.Columns[0].Width:=0;
  self.lvFiles_compare.Columns[1].Width:=50;
  self.lvFiles_compare.Columns[2].Width:=250;
  self.lvFiles_compare.Columns[3].Width:=100;
  self.lvFiles_compare.Width:=300;
  self.Height:=self.lvFiles_compare.Items.Count*17+17;
  if self.Height<40 then self.Height:=40;
  self.left:=screen.Width-self.Width;
  self.Top:=screen.Height-self.Height-25;
  foNewFiles.BringToFront;
end;

procedure TfoNewFiles.lvFiles_compareClick(Sender: TObject);
begin
   mainform.WindowState:=wsNormal;
end;

end.
