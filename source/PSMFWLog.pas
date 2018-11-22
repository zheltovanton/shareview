unit PSMFWLog;

interface
uses
       Windows, Registry,SysUtils,Classes,StrUtils,IdTrivialFTPBase,WinSock;
type TPSMFWLog=class
public
     mTime: string;
     mDirection:string;
     mPermit:String;
     mIP:string;
     mHostName:string;
     mPort:String;
     mPath:string;
     mToltalRec:String;
     mToltalSen:String;
     mTotalRecSen:String;
     mSockNo:String;

     procedure AssignLogItems(LogLine: Pchar);
end;
implementation

function NameFromIP(ip:string;var hostname:string): Boolean;
var
     WSAData: TWSAData;
     InetAddr: u_long;
     HostEntPtr: PHostEnt;
     HostEnt: THostEnt;
     retVal:Boolean;

     len: Integer;

begin
     WSAStartUp( $101, WSAData );
     HostEntPtr:=Nil;
     try
          InetAddr := inet_addr( PChar(ip));
          if InetAddr = SOCKET_ERROR then
               raise Exception.Create( 'Invalid address entered' );

          HostEntPtr := GetHostByAddr( @InetAddr, len, AF_INET );
          if HostEntPtr = NIL then
               raise Exception.Create( 'WinSock error: ' + IntToStr( WSAGetLastError() ) );

          // Insert hostname into list
          hostname := String( HostEntPtr^.h_name );
          retVal:=True;
     except
          on E: Exception do begin
              retVal:=False;
          end;
     end;
     Result:=retVal;
end;

Procedure  TPSMFWLog.AssignLogItems(LogLine:Pchar);
var
     logItems: TStringList;
begin
     logItems:=TStringList.Create;

     ExtractStrings([#9],[' '],LogLine,logItems);


     //'sdsdf'#9'sfsdfsdf'
     mTime:=logItems[0];
     mDirection:=logItems[1];
     {
     if Trim(logItems[2])='DENY' then
          mPermit:=0
     else
          mPermit:=1;
     }
     mPermit:=logItems[2];
     mIP:=logItems[3];

     //if(not NameFromIP(mIP,mHostName)) then
      //   mHostName:= mIP;
     if(logItems.Count>9) then//New update for hostname
             mHostName:=logItems[10];

     mPort:=logItems[4];
     mPath:=logItems[5];
     mToltalRec:=logItems[6];
     mToltalSen:=logItems[7];
     mTotalRecSen:=logItems[8];
     mSockNo:=logItems[9];

     logItems.Free;
end;



end.
