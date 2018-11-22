unit usetup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, main, Buttons,
  jpeg,inifiles, Mask, DBCtrlsEh;

type
  TfoSetup = class(TForm)
    Panel11: TPanel;
    Image3: TImage;
    lbFormCaption: TLabel;
    sbClose: TSpeedButton;
    CPanel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    SpeedButton1: TSpeedButton;
    cbwriteLog: TDBCheckBoxEh;
    cbrunmini: TDBCheckBoxEh;
    cbrunatlogin: TDBCheckBoxEh;
    Label7: TLabel;
    edPopupa: TDBNumberEditEh;
    edDraga: TDBNumberEditEh;
    cbPopup: TDBCheckBoxEh;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    edrefreshtime: TDBNumberEditEh;
    edDeleteafter: TDBNumberEditEh;
    Label8: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    cbRunFW: TDBCheckBoxEh;
    Bevel5: TBevel;
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
    procedure edpopupaChange(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edrefreshtimeChange(Sender: TObject);
    procedure edDeleteafterChange(Sender: TObject);
    procedure sbCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  foSetup: TfoSetup;
  Ini: TIniFile;

implementation

{$R *.dfm}


function DoSomething (s:string):string;
var s2:string;
    i:integer;
    x:integer;
  b2:array [1..30] of byte;
  b:array [1..60] of byte;
    b3:byte;

const abc:array [1..64] of string =
           ('s','f','d','k','l','j','s','d','l','q','o','w','r','p','t','o',
           'k','g','r','e',';','w',',','m',' ','b','f','.','d','f','j','a',
           's','o','e','d','f','u','i','o','w','f','w','b','f','a','s','l',
           'k','d','g','f','a','s','o','f','j','g','o','i','u','g','f','f');
const a2:array [1..64] of string =
          ('0','1','2','3','4','5','6','7','8','9','0','q','w','e','r','t',
           'y','u','i','o','p','a','s','d','f','g','h','j','k','l','z','x',
           'c','v','b','n','m','Q','W','E','R','T','Y','U','I','O','P','A',
           'S','D','F','G','H','J','K','L','Z','X','C','V','B','N','M','k');
begin
   delete(s,61,length(s)-60);
   x:=length(s) div 2;
   delete(s,31,length(s)-30);

   if length(s)<30 then for i:=length(s) to 30 do s:=s+abc[i];
   for i:=1 to 30 do
       b2[i]:=(ord(s[i]));
   for i:=1 to 30 do
       b2[i]:=b2[i] xor ord(abc[i+x][1]);

   s2:='';
   for i:=1 to 30 do
     begin
       b[i*2-1]:=b2[i] shr 2;
       b[i*2]:=( b2[i] shl 4) shr 5;
       b3:=b[i*2-1]+b[i*2];
       if b3>64 then b3:=b3 shr 2;
       if b3>64 then b3:=b3 shr 2;
       if b3>64 then b3:=b3 shr 2;
       s2:=s2+a2[b3];
     end;

   result:=s2;
end;


procedure TfoSetup.dxButton1Click(Sender: TObject);
begin
  close;
end;

procedure TfoSetup.Image3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  image3.OnMouseMove:=Image3MouseMove;
  self.AlphaBlendValue:=trunc(255/100*strtofloatdef(mainform.draga,0));
  _x:=x;
  _y:=y;
end;

procedure TfoSetup.Image3MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
    left:=x-_x+left;
    top:=y-_y+top;
end;

procedure TfoSetup.Image3MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  image3.OnMouseMove:=nil;
  self.AlphaBlendValue:=255;
end;

procedure TfoSetup.lbFormCaptionMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  lbFormCaption.OnMouseMove:=lbFormCaptionMouseMove;
  self.AlphaBlendValue:=trunc(255/100*strtofloatdef(mainform.draga,0));
  _x:=x;
  _y:=y;
end;

procedure TfoSetup.lbFormCaptionMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
    left:=x-_x+left;
    top:=y-_y+top;
end;

procedure TfoSetup.lbFormCaptionMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   lbFormCaption.OnMouseMove:=nil;
  self.AlphaBlendValue:=255;
end;

procedure TfoSetup.SpeedButton3Click(Sender: TObject);
begin
  close;
end;

procedure TfoSetup.edpopupaChange(Sender: TObject);
begin
 if strtointdef((sender as tedit).Text,-1)<0 then (sender as tedit).Text:='100';
end;

procedure TfoSetup.SpeedButton1Click(Sender: TObject);
begin
    Ini := TIniFile.Create(getcurrentdir + '\shareview.ini');

    if self.cbwriteLog.Checked then ini.writestring('system', 'writelog', 'TRUE')
      else ini.writestring('system', 'writelog', 'FALSE');

    if self.cbrunmini.Checked then ini.writestring('system', 'runminimized', 'TRUE')
      else ini.writestring('system', 'runminimized', 'FALSE');

    if self.cbrunatlogin.Checked then ini.writestring('system', 'runatlogin', 'TRUE')
      else ini.writestring('system', 'runatlogin', 'FALSE');

    if self.cbpopup.Checked then ini.writestring('system', ' Showpopups', 'TRUE')
      else ini.writestring('system', 'Showpopups', 'FALSE');

{    if self.cbAlerts.Checked then ini.writestring('system', ' ShowAlerts', 'TRUE')
      else ini.writestring('system', 'Showalerts', 'FALSE');}

    if self.cbRunFW.Checked then ini.writestring('system', 'RunFW', 'TRUE')
      else ini.writestring('system', 'RunFW', 'FALSE');

    ini.writestring('system', 'refreshtime', edrefreshtime.Text);

    ini.writestring('system', 'popupalpha', edpopupa.value);

    ini.writestring('system', 'dragalpha', eddraga.value);

    ini.writestring('system', 'logdays', edDeleteafter.Text);
    ini.free;
    mainform.iniread;
    self.close;
end;

procedure TfoSetup.FormCreate(Sender: TObject);
begin
    Ini := TIniFile.Create(getcurrentdir + '\shareview.ini');

    if uppercase(ini.readstring('system', 'writelog', 'false')) <> 'TRUE' then
      self.cbwriteLog.Checked:=false else self.cbwriteLog.Checked:=true;

    if uppercase(ini.readstring('system', 'runminimized', 'false')) <> 'TRUE' then
      self.cbrunmini.Checked:=false else self.cbrunmini.Checked:=true;

    if uppercase(ini.readstring('system', 'runatlogin', 'false')) <> 'TRUE' then
      self.cbrunatlogin.Checked:=false else self.cbrunatlogin.Checked:=true;

    if uppercase(ini.readstring('system', 'Showpopups', 'false')) <> 'TRUE' then
      self.cbpopup.Checked:=false else self.cbpopup.Checked:=true;

   { if uppercase(ini.readstring('system', 'ShowAlerts', 'false')) <> 'TRUE' then
      self.cbAlerts.Checked:=false else self.cbAlerts.Checked:=true; }

    edrefreshtime.Text:=ini.readstring('system', 'refreshtime', '100');

    edpopupa.Text:=ini.readstring('system', 'popupalpha', '100');

    eddraga.Text:=ini.readstring('system', 'dragalpha', '100');

    edDeleteafter.Text:=ini.readstring('system', 'logdays', '60');


    Ini.free;
 end;

procedure TfoSetup.edrefreshtimeChange(Sender: TObject);
begin
 if strtointdef(edrefreshtime.Text,-1)<0 then edrefreshtime.Text:='1000';
end;

procedure TfoSetup.edDeleteafterChange(Sender: TObject);
begin
 if strtointdef(edDeleteafter.Text,-1)<0 then edDeleteafter.Text:='60';

end;

procedure TfoSetup.sbCloseClick(Sender: TObject);
begin
close;
end;

end.
