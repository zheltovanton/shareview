{
     PSM firewall rule.
     Created on Feb, 09 2004
     by Luu Truong Huy <lhuy@psmkorea.co.kr>
}
unit PSMFWRule;

interface

uses  Windows, Registry,SysUtils,Classes,StrUtils;

type TPSMFWRule=class

private
     function MakePathRule(Path: PChar;IsPermit:Integer): string;
     function MakeIPRule(FromIP:PChar; ToIP: PChar;FromPort:Integer;ToPort:Integer;IsPermit:Integer):string;
     function PortStd(port:Integer): string  ;
protected

public
     function IPStd(IP : Pchar): string;
     {defind functions for IP rules}
     procedure AddIPRule(FromIP:PChar; ToIP: PChar;
                         FromPort:Integer;ToPort:Integer;IsPermit:Integer);
     procedure RemoveIPRule(FromIP:PChar; ToIP: PChar);
     //procedure ModifyIPrule(FromIP:PChar; ToIP: PChar;
     //                    FromPort:Integer;ToPort:Integer;IsPermit:Integer);
     procedure ModifyIPrule(FromIP:PChar; ToIP: PChar;
                         oldFromPort:Integer;oldToPort:integer;
                         FromPort:Integer;ToPort:Integer;IsPermit:Integer);

     Procedure GetIPRuleList( var ipRuleList: TStringList);
     procedure ExtractIPRule(rule:string; var fromIP: string;var toip:String;
                                                var fromPort: Integer;var toPort:Integer;
                                                var Permit:Integer);

     function IPRuleExisted(FromIP:PChar; ToIP: PChar;
                         FromPort:Integer;ToPort:Integer;IsPermit:Integer): Boolean;

     {defind functions for Path rules}
     procedure AddPathRule(Path: PChar; IsPermit: Integer);

     function PathRuleExisted(Path: PChar; IsPermit: Integer):Boolean;

     procedure RemovePathRule(Path: PChar);
     procedure ModifyPathrule(Path: PChar; NewPermitValue: Integer);

     Procedure GetPathRuleList( var pathRuleList: TStringList);
     procedure ExtractPathRule(rule: string; var path: string; var permitted: integer);
     {Security level Functions}
     procedure SetSecurityLevel(level: Integer);
     function GetSecurityLevel(): Integer;
end;

var
  ROOT_IP_RULE: PChar   ='SOFTWARE\PSMFirewall\Rules';
  ROOT_PATH_RULE: PChar ='SOFTWARE\PSMFirewall\Rules1';
  PSM_FW_ROOT:Pchar='SOFTWARE\PSMFirewall';

implementation

{make IP be standard format like xxx.xxx.xxx.xxx}
function TPSMFWRule.IPStd(IP : Pchar): string;
var
     IpItems: TStringList;
     strTmp,strTmp1: PChar;
     I: Integer;
     sTmp1:string;
begin
     IpItems:=TStringList.Create;
     ExtractStrings(['.'],[' '],IP,IpItems);
     for i:=0 to IpItems.Count-1 do
     begin
          sTmp1:= Trim(IpItems[i]);
          strTmp1:=PChar(AnsiReplaceStr(Format('%3s',[sTmp1]),' ','0'));
          IpItems[i]:=strTmp1;
     end;
     IpItems.Delimiter:='.';
     Result:= IpItems.DelimitedText;
     IpItems.Free;

end;
function TPSMFWRule.PortStd(port:Integer): string  ;
var
     FormatedPorts:string[5];
begin
     FormatedPorts:=Format('%5d',[Port]);
     FormatedPorts:=Pchar(AnsiReplaceStr((FormatedPorts),' ','0'));
     result:= FormatedPorts;
end;

function TPSMFWRule.MakePathRule(Path: PChar;IsPermit:Integer): string;
var
     strTmp: String;
begin
    if IsPermit<>0 then IsPermit:=1;
    strTmp:=AnsiReplaceStr(Format('%1d',[IsPermit]),' ','0');
    strTmp:=Format('%s|%s',[Path,strTmp]);
    Result:= PChar(strTmp);
end;

function TPSMFWRule.MakeIPRule(FromIP:PChar; ToIP: PChar;
                         FromPort:Integer;ToPort:Integer;IsPermit:Integer):string;
var
     FormatedPorts:string[11];
     strTmp: string[255];
     Buffer: array[0..250] of char;
begin
     if IsPermit<>0 then IsPermit:=1;

     FromIP:=Pchar(IPStd(FromIP));
     ToIP:=Pchar(IPStd(ToIP));

     FormatedPorts:=Format('%5d|%5d',[FromPort,ToPort]);
     FormatedPorts:=Pchar(AnsiReplaceStr((FormatedPorts),' ','0'));
     StrFmt(Pchar(@strTmp),'%s|%s|%s|%1d|%1d',[FromIP,ToIP,FormatedPorts,0,IsPermit]);
     Result:= PChar(@strTmp);
end;

procedure TPSMFWRule.AddIPRule(FromIP:PChar; ToIP: PChar;
                         FromPort:Integer;ToPort:Integer;IsPermit:Integer);
var
     Reg: TRegistry;
     IsOK: Boolean;
begin
     Reg := TRegistry.Create;

     FromIP:=PChar(IPStd(FromIP));
     ToIP:=PChar(IPStd(ToIP));

     try
          Reg.RootKey:=HKEY_LOCAL_MACHINE;
          IsOk:=Reg.OpenKey(ROOT_IP_RULE,True);
          if IsOK then
               begin
                    Reg.WriteString(MakeIPRule(FromIP,ToIP,FromPort,ToPort,IsPermit),'');
                    Reg.CloseKey;
               end;

     finally
          Reg.Free;
     end;
end;

function TPSMFWRule.IPRuleExisted(FromIP:PChar; ToIP: PChar;
                         FromPort:Integer;ToPort:Integer;IsPermit:Integer): Boolean;
var
     Reg: TRegistry;
     IsOK: Boolean;
     IsFound:Boolean;
begin
     Reg := TRegistry.Create;
     IsFound:=False;

     FromIP:=PChar(IPStd(FromIP));
     ToIP:=PChar(IPStd(ToIP));

     try
          Reg.RootKey:=HKEY_LOCAL_MACHINE;
          IsOk:=Reg.OpenKey(ROOT_IP_RULE,True);
          if IsOK then
               begin
                    IsFound:=Reg.ValueExists(MakeIPRule(FromIP,ToIP,FromPort,ToPort,IsPermit));
                    Reg.CloseKey;
               end;

     finally
          Reg.Free;
     end;

     Result:=isFound;
end;

procedure TPSMFWRule.RemoveIPRule(FromIP:PChar; ToIP: PChar);
var
     Reg: TRegistry;
     KeyNameList: TStringList;
     Index: Integer;
     RuleIdendify,StrTmp:String;
     isOK: Boolean;
begin
     Reg := TRegistry.Create;
     KeyNameList:=TStringList.Create;

     FromIP:=PChar(IPStd(FromIP));
     ToIP:=PChar(IPStd(ToIP));

     RuleIdendify:=Format('%s|%s',[FromIP,ToIP]);
     try
        Reg.RootKey:=HKEY_LOCAL_MACHINE;
        IsOk:=Reg.OpenKey(ROOT_IP_RULE,False);
        if isOK then
        begin
          Reg.GetValueNames(KeyNameList);
          for Index:=0 to  KeyNameList.Count-1 do
          begin
               StrTmp:= PChar(KeyNameList[Index]);
               if Pos(RuleIdendify,StrTmp)>=1 then
               begin
                    Reg.DeleteValue(StrTmp);
                    Reg.CloseKey;
                    Break;
               end;
          end;
       end;
     finally
          Reg.Free;
          KeyNameList.Free;
     end;
end;
procedure TPSMFWRule.ModifyIPrule(FromIP:PChar; ToIP: PChar;
                         oldFromPort:Integer;oldToPort:integer;
                         FromPort:Integer;ToPort:Integer;IsPermit:Integer);
var
     Reg: TRegistry;
     KeyNameList: TStringList;
     Index: Integer;
     RuleIdendify,StrTmp:String;
     isOK: Boolean;

     //strTmp :string;
begin
     Reg := TRegistry.Create;
     KeyNameList:=TStringList.Create;

     FromIP:=PChar(IPStd(FromIP));
     ToIP:=Pchar(IPStd(ToIP));

     strTmp:=PortStd(oldFromPort)+'|'+PortStd(oldToPort);

     RuleIdendify:=Format('%s|%s|%s',[FromIP,ToIP,strTmp]);
     try
        Reg.RootKey:=HKEY_LOCAL_MACHINE;
        IsOk:=Reg.OpenKey(ROOT_IP_RULE,False);
        if isOK then
        begin
             Reg.GetValueNames(KeyNameList);
             for Index:=0 to  KeyNameList.Count-1 do
             begin
                 StrTmp:= KeyNameList[Index];
                 if Pos(RuleIdendify,StrTmp)>=1 then
                 begin
                    Reg.DeleteValue(StrTmp);
                    Reg.WriteString(MakeIPRule(FromIP,ToIP,FromPort,ToPort,IsPermit),'');
                    Reg.CloseKey;
                    Break;
                end;
             end;
        end;
     finally
          Reg.Free;
          KeyNameList.Free;
     end;
end;


procedure TPSMFWRule.AddPathRule(Path: PChar; IsPermit: Integer);
var
     Reg: TRegistry;
     IsOK: Boolean;

begin
     Reg := TRegistry.Create;
     try
          Reg.RootKey:=HKEY_LOCAL_MACHINE;
          IsOk:=Reg.OpenKey(ROOT_PATH_RULE,True);
          if IsOK then
               begin
                    Reg.WriteString(MakePathRule(Path,IsPermit),'');
                    Reg.CloseKey;
               end;

     finally
          Reg.Free;
     end;

end;

function TPSMFWRule.PathRuleExisted(Path: PChar; IsPermit: Integer):Boolean;
var
     Reg: TRegistry;
     IsOK: Boolean;
     IsFound:Boolean;
begin
     Reg := TRegistry.Create;
     IsFound:=False;
     try
          Reg.RootKey:=HKEY_LOCAL_MACHINE;
          IsOk:=Reg.OpenKey(ROOT_PATH_RULE,True);
          if IsOK then
               begin
                    IsFound:=Reg.ValueExists(MakePathRule(Path,IsPermit));
                    Reg.CloseKey;
               end;

     finally
          Reg.Free;
     end;

     Result:=IsFound;
end;

procedure TPSMFWRule.RemovePathRule(Path: PChar);
var
     Reg: TRegistry;
     IsOK: Boolean;
     KeyNameList: TStringList;
     Index: Integer;
     StrTmp: PChar;
begin
     Reg := TRegistry.Create;
     KeyNameList:=TStringList.Create;
     try
          Reg.RootKey:= HKEY_LOCAL_MACHINE;
          IsOk:=Reg.OpenKey(ROOT_PATH_RULE,False);
          if IsOK then
               begin
                    Reg.GetValueNames(KeyNameList);
                    for Index:=0 to  KeyNameList.Count-1 do
                    begin
                         StrTmp:= PChar(KeyNameList[Index]);
                         if (Pos(Path,StrTmp)>= 1) then
                         begin
                              Reg.DeleteValue(StrTmp);
                              Reg.CloseKey;
                              Break;
                         end;
                    end;
               end;
     finally
          Reg.Free;
          KeyNameList.Free;
     end;
end;

procedure TPSMFWRule.ModifyPathrule(Path: PChar; NewPermitValue: Integer);
var
     Reg: TRegistry;
     KeyNameList: TStringList;
     Index: Integer;
     StrTmp: PChar;
     IsOK: Boolean;
begin
     Reg := TRegistry.Create;
     KeyNameList:=TStringList.Create;
     try
        Reg.RootKey:= HKEY_LOCAL_MACHINE;
        IsOk:=Reg.OpenKey(ROOT_PATH_RULE,False);
        if(IsOK) then
        begin
          Reg.GetValueNames(KeyNameList);
          for Index:=0 to  KeyNameList.Count-1 do
          begin
               StrTmp:= PChar(KeyNameList[Index]);
               if (Pos(Path,StrTmp)>= 1)  then
               begin
                    Reg.DeleteValue(StrTmp);
                    Reg.WriteString(MakePathRule(Path,NewPermitValue),'');
                    Reg.CloseKey;
                    Break;
               end;
            end;
       end;
     finally
          Reg.Free;
          KeyNameList.Free;
     end;
end;

procedure TPSMFWRule.SetSecurityLevel(level:Integer);
var
     Reg: TRegistry;
     isOK:Boolean;
begin
     Reg := TRegistry.Create;
     if level<0 then level:=0;
     if level>2 then level:=2;
     try
          Reg.rootKey:= HKEY_LOCAL_MACHINE;
          IsOk:=Reg.OpenKey(PSM_FW_ROOT,TRUE);
          if(IsOk) then
          begin
                Reg.WriteInteger('Level',level);
                Reg.CloseKey;
          end;

     finally
               Reg.Free;
     end;

end;
function TPSMFWRule.GetSecurityLevel(): Integer;
var
     Reg: TRegistry;
     isOK:Boolean;
     retValue:Integer;
begin
     Reg := TRegistry.Create;
     try
          Reg.rootKey:= HKEY_LOCAL_MACHINE;
          IsOk:=Reg.OpenKey(PSM_FW_ROOT,TRUE);
          if(IsOk) then
          begin
               if(Reg.ValueExists('Level')) then
                retValue:=Reg.ReadInteger('Level')
               else
                  begin
                      Reg.WriteInteger('Level',1);
                      retValue:=1;
                  end;
                Reg.CloseKey;
          end;

     finally
               Reg.Free;
     end;
     Result:= retValue;
end;

{Implement functions that get the list of rules}

Procedure TPSMFWRule.GetIPRuleList( var ipRuleList: TStringList);
var
     Reg: TRegistry;
     isOK: Boolean;
begin
     reg:=TRegistry.Create;
     try
          Reg.RootKey:= HKEY_LOCAL_MACHINE;
          IsOk:=Reg.OpenKey(ROOT_IP_RULE,TRUE);
          if(IsOk) then
          begin
               Reg.GetValueNames(ipRuleList);
          end;
          Reg.CloseKey;
     finally
          Reg.Free;
     end;

end;

Procedure TPSMFWRule.GetPathRuleList( var pathRuleList: TStringList);
var
     Reg: TRegistry;
     isOK: Boolean;
begin
     reg:=TRegistry.Create;
     try
          Reg.RootKey:= HKEY_LOCAL_MACHINE;
          IsOk:=Reg.OpenKey(ROOT_PATH_RULE,TRUE);
          if(IsOk) then
          begin
               Reg.GetValueNames(pathRuleList);
          end;
          Reg.CloseKey;
     finally
          Reg.Free;
     end;

end;

procedure   TPSMFWRule.ExtractPathRule(rule: string; var path: string; var permitted: integer);
var
     intPos: integer;
begin
     intPos:=Pos('|',rule);
     path:=LeftStr(rule,intPos-1);
     permitted:=StrtoInt(RightStr(rule,Length(rule)- intPos));

end;

procedure TPSMFWRule.ExtractIPRule(rule:string; var fromIP: string; var toip:String;
                                                var fromPort: Integer;var toPort:Integer;
                                                var Permit:Integer);

var
     strList:TStringList;
begin
     strList:=TSTringList.Create;
     ExtractStrings(['|'],[' '],PChar(rule),strList);
     fromIP:=strList[0];
     toIp:=strList[1];
     fromPort:=strtoint(strList[2]);
     toPort:=strtoint(strList[3]);
     //Item in 4th position is reserved
     permit:=strtoint(strList[5]);
     strList.Free;
end;

end.
