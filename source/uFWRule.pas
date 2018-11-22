unit uFWRule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Mask, StdCtrls, ComCtrls,commctrl, Buttons, ImgList,ShellAPI,
  DBCtrlsEh;

type
  TForm_FWRule = class(TForm)
    FWRule: TPageControl;
    IpRulePage: TTabSheet;
    Panel_Top: TPanel;
    PathRulePage: TTabSheet;
    OpenDialog1: TOpenDialog;
    BmBtnEditOK: TBitBtn;
    BmBtnEditCancel: TBitBtn;
    RuleEditorImageList: TImageList;
    Panel1: TPanel;
    Label_To2: TLabel;
    Label_ePort: TLabel;
    Label_sPort: TLabel;
    Label1: TLabel;
    MaskEdit_sPort: TDBEditEh;
    MaskEdit_ePort: TDBEditEh;
    Panel2: TPanel;
    Panel3: TPanel;
    IP1_1: TDBNumberEditEh;
    lbdot4: TLabel;
    IP1_2: TDBNumberEditEh;
    lbdot5: TLabel;
    IP1_3: TDBNumberEditEh;
    lbdot6: TLabel;
    IP1_4: TDBNumberEditEh;
    IP2_4: TDBNumberEditEh;
    lbdot3: TLabel;
    IP2_3: TDBNumberEditEh;
    lbdot2: TLabel;
    IP2_2: TDBNumberEditEh;
    lbdot1: TLabel;
    IP2_1: TDBNumberEditEh;
    lbIP_to1: TLabel;
    Label10: TLabel;
    Label3: TLabel;
    Radio_IP_Single: TDBCheckBoxEh;
    Radio_IP_Range: TDBCheckBoxEh;
    Radio_IP_All: TDBCheckBoxEh;
    Radio_Port_Single: TDBCheckBoxEh;
    Radio_Port_Range: TDBCheckBoxEh;
    Radio_Port_All: TDBCheckBoxEh;
    Radio_TCP: TDBCheckBoxEh;
    Radio_UDP: TDBCheckBoxEh;
    Radio_Access_Allow: TDBCheckBoxEh;
    Radio_Access_Deny: TDBCheckBoxEh;
    PathEdit: TDBEditEh;
    Label2: TLabel;
    BmBtnPath: TBitBtn;
    Label4: TLabel;
    Radio_Apl_Allow: TDBCheckBoxEh;
    Radio_Apl_Deny: TDBCheckBoxEh;
    procedure InputStatusCheck(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Radio_IP_SingleClick(Sender: TObject);
    procedure Radio_IP_RangeClick(Sender: TObject);
    procedure Radio_IP_AllClick(Sender: TObject);
    procedure Radio_Port_SingleClick(Sender: TObject);
    procedure Radio_Port_RangeClick(Sender: TObject);
    procedure Radio_Port_AllClick(Sender: TObject);
    procedure BmBtnEditOKClick(Sender: TObject);
    procedure BmBtnEditCancelClick(Sender: TObject);
    procedure BmBtnPathClick(Sender: TObject);
    procedure IP1_1Change(Sender: TObject);
    procedure IP2_1Change(Sender: TObject);
    procedure IP1_1Click(Sender: TObject);
    procedure Radio_IP_SingleMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Radio_IP_RangeMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Radio_IP_AllMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Radio_Port_SingleMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Radio_Port_RangeMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Radio_Port_AllMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Radio_TCPMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Radio_UDPMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Radio_Access_AllowMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Radio_Access_DenyMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Radio_Apl_AllowMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Radio_Apl_DenyClick(Sender: TObject); private
    { Private declarations }


    FIPAddress: Longint;
    HIPAddressFrom: HWND;
    HIPAddressTo: HWND;
    PrevWndProc: TWndMethod;
    procedure  ChooseEditPathRule();
    procedure  NewWindowProc(var Message: TMessage);

    function   GetIPAddress(handle:HWND):string;
  public
    { Public declarations }
    procedure  SetIPFrom(sIp:string);
    function GetICON(path:string):TIcon;
  end;
//Appley changes to running fire service
  function ApplyFWStatus(StatusMode: byte):boolean;

var
  Form_FWRule: TForm_FWRule;
  const
  IP_ADDRESS_ID_FROM: Longword = $1100;
  IP_ADDRESS_ID_TO: Longword = $1101;

implementation

uses Main, 
     PSMFWRule;//Add on Web, Feb 11st, 2004

{$R *.dfm}

//----------------------------------------------------------------------------------------------------------------------


{Get Icon of application given by app path}
function TForm_FWRule.GetICON(path:string):TIcon;
{var
  wp: Array[1..MAX_PATH] of Char;
  i: Integer;
}
var
TheIcon:TIcon;
begin
  TheIcon:=TIcon.create;
  TheIcon.Handle := ExtractIcon(hInstance,Pchar(path),0);
  if TheIcon.Handle=0 then
  begin
    {ShowMessage('Call');
    for i:=1 to StrLen(Pchar(path)) do wp[i]:=path[i];
    TheIcon.Handle := ExtractIconW(hInstance,PWchar(@wp),0);
    }
    RuleEditorImageList.GetIcon(2,TheIcon);
  end;

  result :=TheIcon;
end;


//----------------------------------------------------------------------------------------------------------------------

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



//----------------------------------------------------------------------------------------------------------------------

// 입력창 활성화 상태 설정
{
Updated on 20th Feb to handle IP control.
lhuy@psmkorea.co.kr
}
procedure TForm_FWRule.InputStatusCheck(Sender: TObject);
begin
     // IP주소 입력창 활성화 상태 설정
     if Radio_IP_Single.Checked then
       begin
        IP2_1.Enabled:=false;
        IP2_2.Enabled:=false;
        IP2_3.Enabled:=false;
        IP2_4.Enabled:=false;

        lbdot1.Enabled:=false;
        lbdot2.Enabled:=false;
        lbdot3.Enabled:=false;
        lbIP_to1.Enabled:=false;

        IP1_1.Enabled:=true;
        IP1_2.Enabled:=true;
        IP1_3.Enabled:=true;
        IP1_4.Enabled:=true;
        lbdot4.Enabled:=true;
        lbdot5.Enabled:=true;
        lbdot6.Enabled:=true;

       end;
     if Radio_IP_Range.Checked then
       begin
        IP2_1.Enabled:=true;
        IP2_2.Enabled:=true;
        IP2_3.Enabled:=true;
        IP2_4.Enabled:=true;
        lbdot1.Enabled:=true;
        lbdot2.Enabled:=true;
        lbdot3.Enabled:=true;
        IP1_1.Enabled:=true;
        IP1_2.Enabled:=true;
        IP1_3.Enabled:=true;
        IP1_4.Enabled:=true;
        lbdot4.Enabled:=true;
        lbdot5.Enabled:=true;
        lbdot6.Enabled:=true;
        lbIP_to1.Enabled:=true;
      end;
     if Radio_IP_All.Checked then
      begin
        IP2_1.Enabled:=false;
        IP2_2.Enabled:=false;
        IP2_3.Enabled:=false;
        IP2_4.Enabled:=false;

        lbdot1.Enabled:=false;
        lbdot2.Enabled:=false;
        lbdot3.Enabled:=false;
        lbIP_to1.Enabled:=false;
        IP1_1.Enabled:=false;
        IP1_2.Enabled:=false;
        IP1_3.Enabled:=false;
        IP1_4.Enabled:=false;
        lbdot4.Enabled:=false;
        lbdot5.Enabled:=false;
        lbdot6.Enabled:=false;
     end;

     // 포트번호 입력창 활성화 상태 설정
     if Radio_Port_Single.Checked then begin
          MaskEdit_sPort.Enabled:= True;
          MaskEdit_ePort.Enabled:= False;
     end;
     if Radio_Port_Range.Checked then begin
          MaskEdit_sPort.Enabled:= True;
          MaskEdit_ePort.Enabled:= True;
     end;
     if Radio_Port_All.Checked then begin
          MaskEdit_sPort.Enabled:= False;
          MaskEdit_ePort.Enabled:= False;
     end;
end;


//----------------------------------------------------------------------------------------------------------------------

{
Init IP Address from IP control
Updated on 19th Feb, 2004
LuuTruongHuy<lhuy@psmkorea.co.kr>
}
procedure TForm_FWRule.FormCreate(Sender: TObject);
var
  lpInitCtrls: TInitCommonControlsEx;
  wfont: WPARAM;
begin
  lpInitCtrls.dwSize := SizeOf(TInitCommonControlsEx);
  lpInitCtrls.dwICC  := ICC_INTERNET_CLASSES;
  if InitCommonControlsEx(lpInitCtrls) then
  begin
    PrevWndProc := WindowProc;
    WindowProc  := NewWindowProc;

  end;

   PathEdit.MaxLength:=MAX_PATH;   //Set max length of path edit control.
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TForm_FWRule.NewWindowProc(var Message: TMessage);
var
  nField: longint;
begin
  case Message.Msg of
    WM_NOTIFY:
      begin
        if PNMHDR(Ptr(Message.lParam)).idFrom = IP_ADDRESS_ID_FROM then
        begin
          case PNMIPAddress(ptr(Message.lParam)).hdr.code of
            IPN_FIELDCHANGED:
              begin
                if SendMessage(HIPAddressFrom, IPM_ISBLANK, 0, 0) = 0 then
                  SendMessage(HIPAddressFrom, IPM_GETADDRESS, 0, lParam(LPDWORD(@FIPAddress)));
              end;
          end;
        end;

        if PNMHDR(Ptr(Message.lParam)).idFrom = IP_ADDRESS_ID_TO then
        begin
          case PNMIPAddress(ptr(Message.lParam)).hdr.code of
            IPN_FIELDCHANGED:
              begin
                if SendMessage(HIPAddressTo, IPM_ISBLANK, 0, 0) = 0 then
                  SendMessage(HIPAddressTo, IPM_GETADDRESS, 0, lParam(LPDWORD(@FIPAddress)));
              end;
          end;
        end;

      end;
    WM_COMMAND:
      begin
        if Message.WParamLo = IP_ADDRESS_ID_FROM then
          case Message.WParamHi of
            EN_SETFOCUS:
              begin
                nField := SendMessage(HIPAddressFrom, IPM_GETADDRESS, 0,
                  lParam(LPDWORD(@FIPAddress)));
                if nField = 4 then nField := 0;
                SendMessage(HIPAddressFrom, IPM_SETFOCUS, wParam(nField), 0);
              end;
            EN_KILLFOCUS:
              begin
                if SendMessage(HIPAddressFrom, IPM_ISBLANK, 0, 0) = 0 then
                  SendMessage(HIPAddressFrom, IPM_GETADDRESS, 0, lParam(LPDWORD(@FIPAddress)));
              end;
            EN_CHANGE:
              begin
              end;
          end;

          if Message.WParamLo = IP_ADDRESS_ID_TO then
          case Message.WParamHi of
            EN_SETFOCUS:
              begin
                nField := SendMessage(HIPAddressTo, IPM_GETADDRESS, 0,
                  lParam(LPDWORD(@FIPAddress)));
                if nField = 4 then nField := 0;
                SendMessage(HIPAddressTo, IPM_SETFOCUS, wParam(nField), 0);
              end;
            EN_KILLFOCUS:
              begin
                if SendMessage(HIPAddressFrom, IPM_ISBLANK, 0, 0) = 0 then
                  SendMessage(HIPAddressFrom, IPM_GETADDRESS, 0, lParam(LPDWORD(@FIPAddress)));
              end;
            EN_CHANGE:
              begin
              end;
          end;
      end;

  end;
  if Assigned(PrevWndProc) then PrevWndproc(Message);
end;


//----------------------------------------------------------------------------------------------------------------------

procedure TForm_FWRule.FormShow(Sender: TObject);
begin
     InputStatusCheck(self);
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TForm_FWRule.Radio_IP_SingleClick(Sender: TObject);
begin
     InputStatusCheck(self);
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TForm_FWRule.Radio_IP_RangeClick(Sender: TObject);
begin
     InputStatusCheck(self);
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TForm_FWRule.Radio_IP_AllClick(Sender: TObject);
begin
     InputStatusCheck(self);
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TForm_FWRule.Radio_Port_SingleClick(Sender: TObject);
begin
     InputStatusCheck(self);
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TForm_FWRule.Radio_Port_RangeClick(Sender: TObject);
begin
     InputStatusCheck(self);
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TForm_FWRule.Radio_Port_AllClick(Sender: TObject);
begin
     InputStatusCheck(self);
end;

//----------------------------------------------------------------------------------------------------------------------

{process when users choose editing path-rule page}
procedure TForm_FWRule.ChooseEditPathRule();
var
     fwPathRule:TPSMFWRule;
     ispermitted: integer;

     ListItem: TListItem;
     imIndex:Integer;

     tmpPath:String;
begin

     if Radio_Apl_Allow.Checked then     
          ispermitted:=1
     else
          ispermitted:=0;
     {Add to Registry}

     tmpPath:=LowerCase(PathEdit.Text);



     if(fwPathRule.PathRuleExisted(PChar(tmpPath),ispermitted)=False) then
     begin

     fwPathRule.AddPathRule(PChar(tmpPath),ispermitted);

     {Add to PathRule List}
     //if(Form_Option.Path_List.FindCaption(0,tmpPath,FALSE,TRUE,FALSE)= nil)then

          imIndex:=mainform.ImageListForAppPath.AddIcon(GetICON(PathEdit.Text));
          ListItem:=mainform.Path_List.Items.Add;
          //ListItem.ImageIndex:=5;
          ListItem.Caption:=tmpPath;// PathEdit.Text;

          if(ispermitted=1) then
               ListItem.SubItems.Add('ALLOW')
          else
               ListItem.SubItems.Add('DENY');

          //Add Application icon here.
          ListItem.ImageIndex:=imIndex;
     end
     else
          MessageBox(Self.Handle,'This Application Rule is existed','PSM FireWall',MB_OK or MB_ICONEXCLAMATION);

end;


//----------------------------------------------------------------------------------------------------------------------

{
Get IP Address from IP control
}
function TForm_FWRule.GetIPAddress(handle:HWND):string;
var
     wIP: longword;
     b1,b2,b3,b4: Byte;
begin
     SendMessage(handle,IPM_GETADDRESS,0,LPARAM(@wIP));
     b1:=FIRST_IPADDRESS(wIP);
     b2:=SECOND_IPADDRESS(wIP);
     b3:=THIRD_IPADDRESS(wIP);
     b4:=FOURTH_IPADDRESS(wIP);
     Result:=Format('%d.%d.%d.%d',[b1,b2,b3,b4]);
end;

//----------------------------------------------------------------------------------------------------------------------

procedure  TForm_FWRule.SetIPFrom(sIp:string);
var
     ipItems: TStringList;
     b1,b2,b3,b4: Byte;
     ipNum:Integer;
begin
    ipItems:=TStringList.Create;
    ExtractStrings(['.'],[' '],PChar(sIp),ipItems);
    b1:=strtoint(ipItems[0]);
    b2:=strtoint(ipItems[1]);
    b3:=strtoint(ipItems[2]);
    b4:=strtoint(ipItems[3]);
    ipItems.Free;
    ipNum:= MAKEIPADDRESS(b1,b2,b3,b4);
    SendMessage(HIPAddressFrom,IPM_SETADDRESS,0,lParam(DWORD(ipNum)));
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TForm_FWRule.BmBtnEditOKClick(Sender: TObject);
var
     i: Integer;
     strIP, strPort, strProtocol, strType: String;
     strMessage: String;
     strFileName: String;
     bSuccess: Boolean;
     ListItem: TListItem;
     TempFile: TextFile;

     //Huy
     psmFWRule:TPSMFWRule;
     FromIP,ToIP: Pchar;
     FromPort,ToPort: Integer;
     IsPermitted: Integer;
begin
     //Check which page is currently active
     //Huy
     strMessage:= '';
     {Editing Path Rule page is active}
     if FWRule.ActivePageIndex=1 then
     begin
          if not FileExists(PathEdit.Text) then
          begin
              MessageBox(Self.Handle,'Chosen file doesn''t exist', 'Please choose another.',MB_OK or  MB_ICONERROR );
              exit;
          end;

          ChooseEditPathRule;
          if(MainForm.sbFWOn.Enabled)then
              ApplyFWStatus(1);//Apply a new rule
          Form_FWRule.Close;
          exit;
     end;

     {Editing IP Rule page is active}
     if Radio_IP_Single.Checked then begin
          FromIP:= PChar(ip1_1.text+'.'+ip1_2.text+'.'+ip1_3.text+'.'+ip1_4.text);
          ToIP:=  PChar(ip1_1.text+'.'+ip1_2.text+'.'+ip1_3.text+'.'+ip1_4.text);
     end;
     if Radio_IP_Range.Checked then begin
          FromIP:= PChar(ip1_1.text+'.'+ip1_2.text+'.'+ip1_3.text+'.'+ip1_4.text);
          ToIP:=  Pchar(ip2_1.text+'.'+ip2_2.text+'.'+ip2_3.text+'.'+ip2_4.text);
     end;
     if Radio_IP_All.Checked then begin
          FromIP:= '0.0.0.1';
          ToIP:=  '255.255.255.255';
     end;
   //  FromIP:= Pchar(psmFWRule.IPStd(FromIP));
   //  ToIP:= PChar(psmFWRule.IPStd(ToIP));

     //Check IP range validity
     if StrComp(FromIP,ToIP)>0 then
     begin
          MessageBox(Form_FWRule.Handle,'IP range is invalid','Rule Edit Error',MB_OK or MB_ICONERROR);
          exit;
     end;

     strIP:= FromIP + ' - ' + ToIP;
     strMessage:= strMessage + 'IP Address : ' + FromIP + ' - ' + ToIP;
     strMessage:= strMessage + #13;

     // 포트번호 설정 체크
     {for editing port}
     try
          if Radio_Port_Single.Checked then begin
               FromPort:=StrToInt(Trim(MaskEdit_sPort.Text));
               ToPort:= StrToInt(Trim(MaskEdit_sPort.Text));
          end;
          if Radio_Port_Range.Checked then begin
               FromPort:=StrToInt(Trim(MaskEdit_sPort.Text));
               ToPort:= StrToInt(Trim(MaskEdit_ePort.Text));
          end;
     except
          MessageBox(Form_FWRule.Handle,'Invalid Port Number','Rule Edit Error',MB_OK or MB_ICONERROR);
          exit;
     end;

     if Radio_Port_All.Checked then begin
          FromPort:=0;
          ToPort:= 65535;
     end;
     //Check of port range is valid or not
     if(FromPort>ToPort) then
     begin
        MessageBox(Form_FWRule.Handle,'Port range is invalid','Rule Edit Error',MB_OK or MB_ICONERROR);
        exit;
     end;

     if(ToPort<0) then ToPort:=0;
     if(ToPort>65535) then ToPort:=65535;
     if(FromPort<0) then FromPort:=0;
     if(FromPort>65535) then FromPort:=65535;

     strPort:= inttostr(FromPort) + ' - ' + inttostr(ToPort);
     strMessage:= strMessage + 'Port number : ' + inttostr(FromPort) + ' - ' + inttostr(ToPort);
     strMessage:= strMessage + #13;

     // 포트타입 설정 체크
     {
     if Radio_TCP.Checked then begin
          strProtocol:= 'TCP';
          strMessage:= strMessage + '포트타입 : TCP';
     end;
     if Radio_UDP.Checked then begin
          strProtocol:= 'UDP';
          strMessage:= strMessage + '포트타입 : UDP';
     end;
     }
     strProtocol:= 'TCP/UDP';
     strMessage:= strMessage + 'Protocol : TCP/UDP';
     strMessage:= strMessage + #13;

     // 허용여부 설정 체크
     if Radio_Access_Allow.Checked then begin
          strType:= 'Allow';
          strMessage:= strMessage + 'Permission : Allow';
          IsPermitted:=1;
     end;
     if Radio_Access_Deny.Checked then begin
          strType:= 'Deny';
          strMessage:= strMessage + 'Permission : Deny';

          IsPermitted:=0;
     end;
     strMessage:= strMessage + #13;

     strMessage:= strMessage + #13 + 'add this rule?';
     if Application.MessageBox(PChar(strMessage), PChar(Form_FWRule.Caption), MB_YESNO) = IDYES then begin
          // 방화벽 룰 적용하기
          if MainForm.sbFWOn.Enabled then begin
               {In the case the service was started}
               //bSuccess:= Form_Option.iShieldRuleControl(1, strIP, strPort, strProtocol, strType);
          end else begin
               {In the case the service wasnot started}
               bSuccess:= True;
          end;
          {Add and modify by Huy in Feb 04}
          bSuccess:= True;
          if bSuccess then begin

               if(psmFWRule.IPRuleExisted(FromIp,ToIp,FromPort,ToPort,IsPermitted)=False)then
               begin
                    ListItem:= mainform.ListView_FWRule.Items.Add;

                    ListItem.ImageIndex:=5;

                    ListItem.Caption:= strIP;
                    ListItem.SubItems.Add(strPort);
                    ListItem.SubItems.Add(strProtocol);
                    //ListItem.SubItems.Add(strType);
                    if(ispermitted=1) then
                       ListItem.SubItems.Add('ALLOW')
                     else
                    ListItem.SubItems.Add('DENY');

                    //Add rule to Registry
                    psmFWRule.AddIPRule(FromIp,ToIp,FromPort,ToPort,IsPermitted);
                    if(MainForm.sbFWOn.Enabled) then
                           ApplyFWStatus(1);
               end
               else
                    MessageBox(Self.Handle,'This IP Rule is existed','PSM FireWall',MB_OK or MB_ICONEXCLAMATION);
          end;
          Form_FWRule.Close;
     end;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TForm_FWRule.BmBtnEditCancelClick(Sender: TObject);
begin
        Close;
end;


//----------------------------------------------------------------------------------------------------------------------

procedure TForm_FWRule.BmBtnPathClick(Sender: TObject);
begin
       OpenDialog1.Filter := 'Execute File (*.exe,*.com)|*.EXE;*.COM;*.DLL|All File (*.*)|*.* ';
      OpenDialog1.Execute;
      PathEdit.Text:=OpenDialog1.FileName;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TForm_FWRule.IP1_1Change(Sender: TObject);
begin
    if (sender as TDBNumberEditEh).Value>99 then
     begin
        FindNextControl( (sender as TDBNumberEditEh),true,true,false).SetFocus;
        (FindNextControl( (sender as TDBNumberEditEh),true,true,false) as TDBNumberEditEh).SelectAll
     end;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TForm_FWRule.IP2_1Change(Sender: TObject);
begin
    if (sender as TDBNumberEditEh).Value>99 then
     begin
        FindNextControl( (sender as TDBNumberEditEh),true,true,false).SetFocus;
        (FindNextControl( (sender as TDBNumberEditEh),true,true,false) as TDBNumberEditEh).SelectAll
     end;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TForm_FWRule.IP1_1Click(Sender: TObject);
begin
  (sender as TDBNumberEditEh).SelectAll;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TForm_FWRule.Radio_IP_SingleMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Radio_IP_Range.Checked:=false;
  Radio_IP_All.Checked:=false;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TForm_FWRule.Radio_IP_RangeMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Radio_IP_Single.Checked:=false;
  Radio_IP_All.Checked:=false;

end;

//----------------------------------------------------------------------------------------------------------------------

procedure TForm_FWRule.Radio_IP_AllMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Radio_IP_Range.Checked:=false;
  Radio_IP_Single.Checked:=false;

end;

//----------------------------------------------------------------------------------------------------------------------

procedure TForm_FWRule.Radio_Port_SingleMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Radio_Port_Range.Checked:=false;
  Radio_Port_All.Checked:=false;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TForm_FWRule.Radio_Port_RangeMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Radio_Port_Single.Checked:=false;
  Radio_Port_All.Checked:=false;

end;

//----------------------------------------------------------------------------------------------------------------------

procedure TForm_FWRule.Radio_Port_AllMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Radio_Port_Single.Checked:=false;
  Radio_Port_Range.Checked:=false;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TForm_FWRule.Radio_TCPMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Radio_UDP.Checked:=false;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TForm_FWRule.Radio_UDPMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Radio_tcp.Checked:=false;

end;

//----------------------------------------------------------------------------------------------------------------------

procedure TForm_FWRule.Radio_Access_AllowMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    Radio_Access_Deny.Checked:=false;

end;

//----------------------------------------------------------------------------------------------------------------------

procedure TForm_FWRule.Radio_Access_DenyMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Radio_Access_Allow.Checked:=false;

end;

//----------------------------------------------------------------------------------------------------------------------

procedure TForm_FWRule.Radio_Apl_AllowMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Radio_Apl_Deny.Checked:=false;

end;

//----------------------------------------------------------------------------------------------------------------------

procedure TForm_FWRule.Radio_Apl_DenyClick(Sender: TObject);
begin
  Radio_Apl_Allow.Checked:=false;

end;

end.

