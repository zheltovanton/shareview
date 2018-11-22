unit uReg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, shellapi, jpeg,
  Buttons, Mask, inifiles, DBCtrlsEh;

type
  TfoReg = class(TForm)
    Panel11: TPanel;
    Image3: TImage;
    lbFormCaption: TLabel;
    sbClose: TSpeedButton;
    CPanel1: TPanel;
    Label1: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    SpeedButton1: TSpeedButton;
    DBEditEh1: TDBEditEh;
    DBEditEh2: TDBEditEh;
    DBEditEh3: TDBEditEh;
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
    procedure DBEditEh3Change(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure sbCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  foReg: TfoReg;
  Ini: TIniFile;

implementation

uses Main;



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
   delete(s,1,length(s)-60);
   x:=length(s) div 2;
   delete(s,1,length(s)-30);

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
   s2:=s2[1]+s2[2]+s2[3]+s2[4]+s2[5]+s2[6]+'-'+
       s2[7]+s2[8]+s2[9]+s2[10]+s2[11]+s2[12]+'-'+
       s2[13]+s2[14]+s2[15]+s2[16]+s2[17]+s2[18]+'-'+
       s2[19]+s2[20]+s2[21]+s2[22]+s2[23]+s2[24]+'-'+
       s2[25]+s2[27]+s2[28]+s2[29]+s2[30]+s2[31];
   s2:=uppercase(s2);
   for x:=1 to trunc(sizeof(pipecpass)/4) do
     begin
       if trim(PipecPass[x])=trim(s2) then s2:='';
     end;
   result:=s2;
end;


procedure TfoReg.Label3MouseEnter(Sender: TObject);
begin
  (sender as tlabel).Font.Style:=[fsunderline];
end;

procedure TfoReg.Label3MouseLeave(Sender: TObject);
begin
  (sender as tlabel).Font.Style:=[];

end;

procedure TfoReg.Label3Click(Sender: TObject);
begin
  ShellExecute (0,'open', pchar('http://www.miridix.com/'), pchar(''),nil, SW_show);
end;

procedure TfoReg.Label4Click(Sender: TObject);
begin
  ShellExecute (0,'open', pchar('http://www.miridix.com/distr/shareview_setup.exe'), pchar(''),nil, SW_show);
end;

procedure TfoReg.Label5Click(Sender: TObject);
begin
  ShellExecute (0,'open', pchar('mailto:developer@miridix.com?subject=ShareView&body=Hello'), pchar(''),nil, SW_show);

end;

procedure TfoReg.Label6Click(Sender: TObject);
begin
  ShellExecute(0, nil,'mailto:support@miridix.com?subject=BugReport(Shareview)',nil,nil,1);

end;

procedure TfoReg.Label16Click(Sender: TObject);
begin
  ShellExecute (0,'open', pchar('http://www.miridix.com/page.php?id=3'), pchar(''),nil, SW_show);

end;

procedure TfoReg.Label14Click(Sender: TObject);
begin
  ShellExecute (0,'open', pchar('mailto:sales@miridix.com?subject=ShareView_buy'), pchar(''),nil, SW_show);
end;

procedure TfoReg.SpeedButton3Click(Sender: TObject);
begin
  close;
end;

procedure TfoReg.Image3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  image3.OnMouseMove:=Image3MouseMove;
  self.AlphaBlendValue:=trunc(255/100*strtofloatdef(mainform.draga,0));
  _x:=x;
  _y:=y;
end;

procedure TfoReg.Image3MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
    left:=x-_x+left;
    top:=y-_y+top;
end;

procedure TfoReg.Image3MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  image3.OnMouseMove:=nil;
  self.AlphaBlendValue:=255;

end;

procedure TfoReg.lbFormCaptionMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  lbFormCaption.OnMouseMove:=lbFormCaptionMouseMove;
  self.AlphaBlendValue:=trunc(255/100*strtofloatdef(mainform.draga,0));
  _x:=x;
  _y:=y;
end;

procedure TfoReg.lbFormCaptionMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
    left:=x-_x+left;
    top:=y-_y+top;
end;

procedure TfoReg.lbFormCaptionMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   lbFormCaption.OnMouseMove:=nil;
  self.AlphaBlendValue:=255;
end;

procedure TfoReg.Label19Click(Sender: TObject);
begin
 // help
end;

procedure TfoReg.FormCreate(Sender: TObject);
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
  DBEditEh3.OnChange:=nil;
  Ini := TIniFile.Create(getcurrentdir + '\shareview.ini');
  self.DBEditEh1.Text:=ini.readstring('reg', 'name', '');
  self.DBEditEh2.Text:=ini.readstring('reg', 'email', '');
  self.DBEditEh3.Text:=ini.readstring('reg', 'regkey', '');
  DBEditEh3.OnChange:=DBEditEh3Change;
  ini.free;
end;

procedure TfoReg.DBEditEh3Change(Sender: TObject);
var s,s1,s2,name,email:string;
    x:integer;
begin
    if length(trim(self.DBEditEh3.Text))=33 then sleep(2000);
    s:=self.DBEditEh1.Text;
    for x:=1 to length(s) do if s[x]<>' ' then s1:=s1+s[x];
    name:=s1;
    s:=self.DBEditEh2.Text;
    s1:='';
    for x:=1 to length(s) do if s[x]<>' ' then s1:=s1+s[x];
    email:=s1;
    s1:=trim(DoSomething(trim('ShareView'+name+email)));
    s2:=uppercase(TRIM(self.DBEditEh3.Text));
    if s1=s2 then
      begin
        s1:='';
        Showmessage('T'+s1+'h'+'a'+'n'+'k'+' '+'y'+'o'+'u'+' '+'f'+'o'+'r'+' '+
                    'b'+'u'+'y'+'i'+'n'+'g'+' '+'o'+'u'+'r'+' '+'s'+'o'+'f'+
                    't'+'w'+'a'+'r'+'e'+'.'+' '+'R'+'e'+'s'+'t'+'a'+'r'+'t'+
                    ' '+'p'+'r'+'o'+'g'+'r'+'a'+'m'+' '+'t'+'o'+' '+'a'+'p'+
                    'p'+'l'+'y'+' '+'c'+'h'+'a'+'n'+'g'+'e'+'s.');
        Ini := TIniFile.Create(getcurrentdir + '\shareview.ini');
        ini.writestring('reg', 'name', self.DBEditEh1.Text);
        ini.writestring('reg', 'email', self.DBEditEh2.Text);
        ini.writestring('reg', 'regkey', self.DBEditEh3.Text);
        ini.free;
      end;

end;

procedure TfoReg.SpeedButton1Click(Sender: TObject);
begin
close;
end;

procedure TfoReg.sbCloseClick(Sender: TObject);
begin
  close;
end;

end.
