program ShareView;

uses
  Forms,
  windows,
  sysutils,
  dialogs,
  Main in 'Main.pas' {MainForm},
  uNewFiles in 'uNewFiles.pas' {foNewFiles},
  uViewFiles in 'uViewFiles.pas' {foViewFiles},
  uMemo in 'uMemo.pas' {fo_Memo},
  uLogFiles in 'uLogFiles.pas' {foLogFiles},
  uLogSes in 'uLogSes.pas' {foLogSes},
  uUnreg in 'uUnreg.pas' {foUnreg},
  uTraffic in 'uTraffic.pas' {foTraffic},
  uDialog in 'uDialog.pas' {FoDialog},
  uWhiteFiles in 'uWhiteFiles.pas' {foWhiteFiles},
  uWhiteSes in 'uWhiteSes.pas' {foWhiteSes},
  uBlackFiles in 'uBlackFiles.pas' {foBlackFiles},
  uBlackSes in 'uBlackSes.pas' {foBlackSes},
  uBlackAlert in 'uBlackAlert.pas' {foBlackAlert},
  uBlackAlertFiles in 'uBlackAlertFiles.pas' {foBlackAlertFiles},
  uAbout in 'uAbout.pas' {foabout},
  uReg in 'uReg.pas' {foReg},
  uTrialEnd in 'uTrialEnd.pas' {foTrialEnd},
  uShared in 'uShared.pas' {foShared},
  usetup in 'usetup.pas' {foSetup},
  uWait in 'uWait.pas' {foWait},
  uFWRule in 'uFWRule.pas' {Form_FWRule},

  uHelp in 'uHelp.pas' {foHelp};


{$R *.res}

//----------------------------------------------------------------------------------------------------------------------

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


//----------------------------------------------------------------------------------------------------------------------


var
 hwndPrev: integer;

//----------------------------------------------------------------------------------------------------------------------


begin

 hwndPrev := FindWindow('TMainform','ShareView');
  Application.Initialize;
  //���� ��� ���� ����� ����� ����������, �� �������
  if hwndPrev > 0 then
  begin
       SetForegroundWindow(hwndPrev);
       Application.Terminate;
  end;
  Application.Title := 'ShareView';
  ChDir(ExtractFilePath(Application.ExeName));
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TForm_FWRule, Form_FWRule);  
  Application.Run;
end.

//----------------------------------------------------------------------------------------------------------------------


