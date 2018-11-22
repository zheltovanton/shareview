program un_closesv;

uses
  windows,sysutils, Tlhelp32,PSMFWRule, PSMFWLog, madCodeHook;

{$R *.res}

function KillTask(ExeFileName: string): integer;
const
  PROCESS_TERMINATE=$0001;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  result := 0;

  FSnapshotHandle := CreateToolhelp32Snapshot
                     (TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := Sizeof(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle,
                                 FProcessEntry32);

  while integer(ContinueLoop) <> 0 do
  begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) =
         UpperCase(ExeFileName))
     or (UpperCase(FProcessEntry32.szExeFile) =
         UpperCase(ExeFileName))) then
      Result := Integer(TerminateProcess(OpenProcess(
                        PROCESS_TERMINATE, BOOL(0),
                        FProcessEntry32.th32ProcessID), 0));
    ContinueLoop := Process32Next(FSnapshotHandle,
                                  FProcessEntry32);
  end;

  CloseHandle(FSnapshotHandle);
end;


function ApplyFWStatus(StatusMode: byte):boolean;//=1: New rules, =2: Stop FW, =0: FW is running and no new rules.
type
  ShareData=record
    dwTotalBytes: DWORD;
    intProcessCount: Integer;
    boNewRule: Array[0..512] of byte;
  end;
var
  //llInit: Boolean;
  HMapping: THandle;
  PMapData: ^ShareData;
begin
  result:=false;
  try
  HMapping := CreateFileMapping(THandle($FFFFFFFF), nil, PAGE_READWRITE, 0, SizeOf(ShareData), pchar('PSMFWShareM'));
  // Check if already exists
  //llInit := (GetLastError() <> ERROR_ALREADY_EXISTS);
  if (hMapping = 0) then begin
    SysUtils.Beep;
    MessageBox(0,'Cannot apply new rules. '#13#10'Please restart Firewall to apply new rules!','Firewall',MB_OK);
    exit;
  end;
  PMapData := MapViewOfFile(HMapping, FILE_MAP_ALL_ACCESS, 0, 0, 0);
  if PMapData = nil then begin
    CloseHandle(HMapping);
    SysUtils.Beep;
    MessageBox(0,'New rules cannot be applied. '#13#10'Please restart Firewall to apply new rules!','Firewall',MB_OK);
    exit;
  end;

  //if (not llInit) then begin
    FillChar(PMapData^.boNewRule,SizeOf(PMapData^.boNewRule),StatusMode);
    UnMapViewOfFile(PMapData);
    CloseHandle(HMapping);
  //end;
  result:=true;

  except
    SysUtils.Beep;
    MessageBox(0,'Error at ApplyNewRules()','Firewall',MB_OK);
  end;
end;

procedure PSMFW_UnInitActionExecute; // 방화벽 기능 중지
var
     bCheck:Boolean;
begin

     bCheck:=UnInjectLibrary (ALL_SESSIONS Or SYSTEM_PROCESSES, 'PSMFireW.dll');
     ApplyFWStatus(2);//Set FW Stop-status

end;

var
    HMapMutex:THandle;

begin
 DestroyIpcQueue('PSMFirewall');

     HMapMutex := CreateMutex(nil, false, pchar('PSMFirewallApplication'));
     if HMapMutex <> 0 then begin
          if WaitForSingleObject(HMapMutex,100) = WAIT_OBJECT_0 then begin end ;
     end;
     ReleaseMutex(HMapMutex);
     CloseHandle(HMapMutex);
     PSMFW_UnInitActionExecute;
 KillTask('shareview.exe');

end.

