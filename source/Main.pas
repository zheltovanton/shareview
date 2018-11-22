unit Main;

interface

uses
  Windows, IdHTTP, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, activex, WinSock, ImgList, XPMenu,
  Menus, TrayIcon, DB, ADODB, Buttons, jpeg, registry,StrUtils, uFWRule,
  ShellAPI, ShlObj, comobj ,Variants,  inifiles, uabout, AppEvnts, Grids,
  DBGridEh, RXShell, commctrl, ShellCtrls, XPMan, OleCtrls, Sockets,
  SHDocVw, Mask, DBCtrlsEh, uWait, {OleServer,}  PSMFWRule, PSMFWLog,
  ScktComp, IPHelper, IPHLPAPI, Animate, GIFCtrl, madCodeHook,
  {IdAntiFreezeBase, IdAntiFreeze,} IdBaseComponent, IdComponent, IdRawBase,
  IdRawClient, IdIcmpClient,IdAntiFreezeBase, IdAntiFreeze,IDStack;

type formstates = (fsMaximized, fsNormal);

const NormalSizeWidth=891;
      NormalSizeHeight=600;
      Version = '4.7';
      VersionFloat = 4.7;
      Progname = 'Miridix ShareView';

const PipecPass:array [1..12] of string =
           ('NIFZEA-5TW5S0-3326NW-66WL3U-2IJW3',
            'DURP9N-IFZEA5-TW5S0D-2MJ62L-665T0',
            'IAW0QT-002ZPI-UWI8WA-F3JT2S-52WG6',
            'J36RTM-BWTZPC-LA8FT9-PVF53P-2R5I3',
            'J36RTM-BWTTUF-ZAJFOH-MFHNHN-GTZT3',
            'I0FF0-AIJG4R-Y008WF-60T0WI-50QQI',
            'J36RTM-BWTZPC-LA8FT9-PVF53P-2R5I3',
            'WP5338-5NMSLI-8HINHZ-BSYBK2-I6QJW',
            '6RTMBW-TOUWFU-FFLMET-665QLF-UWZ59',
            'U0H8YF-A5A9HS-NFV0FI-FFJTII-WTFR2',
            'DURP9N-IFZWST-UJMIHZ-ZFDYKD-F65T0',
            '36RTMB-WTTF06-OEFITP-6FK28L-8WT30' );
const
  STR_START    =  'Begin scan';
  STR_STOP     =  'Stop scan';
  STR_STARTED  =  '   Scanning ..';
  STR_STOPPED  =  '   Scan complite ..';
  STR_END      =  '   Ending thread ..';
  STR_FIELD    =  '   Field not selected ..';

type
  TDemoThread = class(TThread)
  private
    TreeNetWrk: TTreeNode;
    TreeDomain: TTreeNode;
    TreeServer: TTreeNode;
    TreeShares: TTreeNode;
    Param_dwType: Byte;
    Param_dwDisplayType: Byte;
    Param_lpRemoteName: String;
    Param_lpIP: String;
  protected
    procedure Execute; override;
    procedure Scan(Res: TNetResource; Root: boolean);
    procedure AddElement;
    procedure Stop;
  end;

type
  TMainForm = class(TForm)
    tmrTraffic: TTimer;
    tmFiles: TTimer;
    GroupBox1: TGroupBox;
    Panel2: TPanel;
    lvfiles_compare: TListView;
    ADOConnect: TADOConnection;
    aqSQL: TADOQuery;
    tmSessions: TTimer;
    ppMainmenu: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    XPMenu1: TXPMenu;
    pmSessions: TPopupMenu;
    IP1: TMenuItem;
    IP2: TMenuItem;
    Timer3: TTimer;
    ppFiles: TPopupMenu;
    Killselected1: TMenuItem;
    Killall1: TMenuItem;
    N6: TMenuItem;
    Viewlog1: TMenuItem;
    aqLogCleaner: TADOQuery;
    aqSesBlack: TADOQuery;
    ppBanWhite: TPopupMenu;
    ppBanBlack: TPopupMenu;
    Files1: TMenuItem;
    Sessions1: TMenuItem;
    Files2: TMenuItem;
    Sessions2: TMenuItem;
    NameIP1: TMenuItem;
    ppLog: TPopupMenu;
    Files3: TMenuItem;
    Sessions3: TMenuItem;
    Logs1: TMenuItem;
    Files4: TMenuItem;
    Sessions4: TMenuItem;
    Pause1: TMenuItem;
    Start1: TMenuItem;
    Help1: TMenuItem;
    N10: TMenuItem;
    About1: TMenuItem;
    Register1: TMenuItem;
    aqFilesBlack: TADOQuery;
    tmSesBlackCheck: TTimer;
    aqlist: TADOQuery;
    DataSource1: TDataSource;
    tmFilesBlackCheck: TTimer;
    Killblack2: TMenuItem;
    Blockall1: TMenuItem;
    Openall1: TMenuItem;
    N11: TMenuItem;
    Shared1: TMenuItem;
    Addnew1: TMenuItem;
    Miridix1: TMenuItem;
    RxTrayIcon1: TRxTrayIcon;
    Panel5: TPanel;
    Splitter2: TSplitter;
    LargeImages: TImageList;
    ImageList1: TImageList;
    PageControl: TPageControl;
    PageOpenfiles: TTabSheet;
    Panel1: TPanel;
    Splitter1: TSplitter;
    Panel3: TPanel;
    Panel9: TPanel;
    lvFiles: TListView;
    Panel8: TPanel;
    Label1: TLabel;
    Panel4: TPanel;
    Panel7: TPanel;
    lvSessions: TListView;
    Panel10: TPanel;
    Label2: TLabel;
    lvSessions_compare: TListView;
    PageFW: TTabSheet;
    PageAdvancedFW: TTabSheet;
    PagePing: TTabSheet;
    PageLogs: TTabSheet;
    Panel16: TPanel;
    SpeedButton8: TSpeedButton;
    Label4: TLabel;
    SpeedButton11: TSpeedButton;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Label5: TLabel;
    lbRecordinFiles: TLabel;
    SpeedButton12: TSpeedButton;
    Label6: TLabel;
    lbRecordsinSessions: TLabel;
    SpeedButton13: TSpeedButton;
    XPManifest1: TXPManifest;
    PageWeb: TTabSheet;
    WebBrowser1: TWebBrowser;
    PageControlPage: TPageControl;
    PagePing_WinPingIP: TTabSheet;
    mmWinPing: TMemo;
    Panel15: TPanel;
    SpeedButton6: TSpeedButton;
    IP1_1: TDBNumberEditEh;
    IP1_2: TDBNumberEditEh;
    IP1_3: TDBNumberEditEh;
    IP1_4: TDBNumberEditEh;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    lbIP_to1: TLabel;
    IP2_1: TDBNumberEditEh;
    lbdot1: TLabel;
    IP2_2: TDBNumberEditEh;
    lbdot2: TLabel;
    IP2_3: TDBNumberEditEh;
    lbdot3: TLabel;
    IP2_4: TDBNumberEditEh;
    Bevel3: TBevel;
    Bevel4: TBevel;
    cbIP1range: TDBCheckBoxEh;
    mmTemp: TMemo;
    Label11: TLabel;
    edCount: TDBNumberEditEh;
    Label12: TLabel;
    edSize: TDBNumberEditEh;
    edTTL: TDBNumberEditEh;
    Label13: TLabel;
    Label14: TLabel;
    edWait: TDBNumberEditEh;
    SpeedButton14: TSpeedButton;
    PagePing_WinPingHost: TTabSheet;
    Panel18: TPanel;
    Bevel7: TBevel;
    Bevel8: TBevel;
    SpeedButton17: TSpeedButton;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    SpeedButton18: TSpeedButton;
    edCountHost: TDBNumberEditEh;
    edSizeHost: TDBNumberEditEh;
    edTTLHost: TDBNumberEditEh;
    edWaithost: TDBNumberEditEh;
    mmWinPingHost: TMemo;
    edPingHost: TDBEditEh;
    PageTracert: TTabSheet;
    PageIPConfig: TTabSheet;
    Panel19: TPanel;
    Bevel9: TBevel;
    SpeedButton19: TSpeedButton;
    Label18: TLabel;
    SpeedButton20: TSpeedButton;
    edTraceHost: TDBEditEh;
    Panel20: TPanel;
    SpeedButton21: TSpeedButton;
    SpeedButton22: TSpeedButton;
    mmTrace: TMemo;
    mmIPConf: TMemo;
    aqFirewall: TADOQuery;
    DataSource2: TDataSource;
    ADOQuery1: TADOQuery;
    Bevel6: TBevel;
    aqFw_log: TADOQuery;
    DataSource3: TDataSource;
    aqSQL2: TADOQuery;
    mmTemp_fwlog: TMemo;
    tmFWlog: TTimer;
    Label29: TLabel;
    Label35: TLabel;
    SpeedButton34: TSpeedButton;
    SpeedButton36: TSpeedButton;
    Bevel12: TBevel;
    lbFireCount: TLabel;
    PageHelp: TTabSheet;
    WebBrowserHelp: TWebBrowser;
    Firrewall: TMenuItem;
    Stop1: TMenuItem;
    Start2: TMenuItem;
    PageFirewalls: TPageControl;
    Page_FWSimple: TTabSheet;
    Page_AD_FW: TTabSheet;
    Page_FWLog: TTabSheet;
    CPanel1: TPanel;
    SpeedButton9: TSpeedButton;
    SpeedButton10: TSpeedButton;
    sbChart: TSpeedButton;
    sbShareview: TSpeedButton;
    SpeedButt8on1: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton1: TSpeedButton;
    SpeedButton4: TSpeedButton;
    sbFWOn: TSpeedButton;
    sbFWOff: TSpeedButton;
    SpeedButton33: TSpeedButton;
    lvTraffic: TListView;
    ListView_FWRule: TListView;
    Panel12: TPanel;
    SpeedButton23: TSpeedButton;
    sbSave: TSpeedButton;
    Panel11: TPanel;
    SpeedButton2: TSpeedButton;
    SpeedButton5: TSpeedButton;
    ListView_FWLog: TListView;
    RulePopupMenu: TPopupMenu;
    mnuRuleAddnew: TMenuItem;
    Delete: TMenuItem;
    MenuItem1: TMenuItem;
    mnuRuleChangePermision: TMenuItem;
    LogPopupMenu: TPopupMenu;
    mnuAddIPRule: TMenuItem;
    mnuAddPathRule: TMenuItem;
    MenuItem2: TMenuItem;
    Display1: TMenuItem;
    mnuDirection: TMenuItem;
    mnuPermission: TMenuItem;
    mnuHostName: TMenuItem;
    mnuApplicationPath: TMenuItem;
    mnuBytesReceived: TMenuItem;
    mnuBytesSent: TMenuItem;
    mnuSocketNumber: TMenuItem;
    MenuItem3: TMenuItem;
    mnuClearLog: TMenuItem;
    Path_List: TListView;
    ImageListForAppPath: TImageList;
    Page_FWOptions: TTabSheet;
    Label24: TLabel;
    Label23: TLabel;
    Label25: TLabel;
    Label_Level0: TLabel;
    Label_Level1: TLabel;
    Label_Level2: TLabel;
    Label_Level3: TLabel;
    TrackBar_Level: TTrackBar;
    Panel14: TPanel;
    SpeedButton37: TSpeedButton;
    SpeedButton38: TSpeedButton;
    Page_Netstat: TTabSheet;
    Panel21: TPanel;
    SpeedButton24: TSpeedButton;
    SpeedButton25: TSpeedButton;
    mmNetstat: TMemo;
    cbNetstat_a: TDBCheckBoxEh;
    cbNetstat_b: TDBCheckBoxEh;
    cbNetstat_n: TDBCheckBoxEh;
    cbNetstat_e: TDBCheckBoxEh;
    cbNetstat_r: TDBCheckBoxEh;
    cbNetstat_o: TDBCheckBoxEh;
    cbNetstat_v: TDBCheckBoxEh;
    cbNetstat_s: TDBCheckBoxEh;
    SpeedButton26: TSpeedButton;
    Page_Traffic: TTabSheet;
    tmTraffic: TTimer;
    PageControl1: TPageControl;
    Page_Traf_Traffic: TTabSheet;
    Page_Traf_TCP: TTabSheet;
    lvTCPConnections: TListView;
    lvTraffic2: TListView;
    Panel23: TPanel;
    Image2: TImage;
    Label26: TLabel;
    Panel24: TPanel;
    Label27: TLabel;
    lbConnection: TLabel;
    lbMac: TLabel;
    Label28: TLabel;
    Label36: TLabel;
    lbSpeed: TLabel;
    Label37: TLabel;
    lbIn: TLabel;
    Label38: TLabel;
    lbOut: TLabel;
    lbErrorsin: TLabel;
    Label39: TLabel;
    lbErrorsout: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    lbMtu: TLabel;
    lbPacketsin: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    lbPacketsOut: TLabel;
    Label44: TLabel;
    lbDiscardsIn: TLabel;
    Label45: TLabel;
    lbDiscardsOut: TLabel;
    Page_Traf_Stat: TTabSheet;
    Page_Traf_Stat__: TPageControl;
    Page_Traf_Stat_TCP: TTabSheet;
    Page_Traf_Stat_IP: TTabSheet;
    Page_Traf_Stat_ICMP: TTabSheet;
    Page_Traf_Stat_UDP: TTabSheet;
    TCPStatMemo: TMemo;
    StaticText7: TStaticText;
    IPStatsMemo: TMemo;
    StaticText5: TStaticText;
    Panel22: TPanel;
    StaticText12: TStaticText;
    ICMPInMemo: TMemo;
    Splitter3: TSplitter;
    Panel25: TPanel;
    ICMPOutMemo: TMemo;
    StaticText1: TStaticText;
    StaticText4: TStaticText;
    UDPStatsMemo: TMemo;
    Image10: TImage;
    Image11: TImage;
    Image13: TImage;
    AplRulePopupMenu: TPopupMenu;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    sbHelp: TSpeedButton;
    sbAbout: TSpeedButton;
    Image17: TImage;
    SpeedB6utton27: TSpeedButton;
    SpeedButton28: TSpeedButton;
    image1: TRxGIFAnimator;
    tvmain: TTreeView;
    Panel6: TPanel;
    Panel26: TPanel;
    Page_Trace: TTabSheet;
    Icmp: TIdIcmpClient;
    Panel17: TPanel;
    sbStop: TSpeedButton;
    sbTrace: TSpeedButton;
    cbResolveHosts: TCheckBox;
    edtIP: TEdit;
    edtHost: TEdit;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    Panel27: TPanel;
    reLog: TRichEdit;
    StaticText6: TStaticText;
    StatusBar: TStatusBar;
    IdIcmpClient1: TIdIcmpClient;
    Page_IPSCan: TTabSheet;
    Panel28: TPanel;
    Label3: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Bevel5: TBevel;
    Bevel10: TBevel;
    sbRunPing: TSpeedButton;
    Label21: TLabel;
    Label22: TLabel;
    Bevel11: TBevel;
    IP4_1: TDBNumberEditEh;
    IP4_2: TDBNumberEditEh;
    IP4_3: TDBNumberEditEh;
    IP4_4: TDBNumberEditEh;
    IP5_1: TDBNumberEditEh;
    IP5_2: TDBNumberEditEh;
    IP5_3: TDBNumberEditEh;
    IP5_4: TDBNumberEditEh;
    cbIP3range: TDBCheckBoxEh;
    cbCheckHost: TDBCheckBoxEh;
    cbLowSpeed: TDBCheckBoxEh;
    WebBrowser2: TWebBrowser;
    Memo1: TMemo;
    Timer1: TTimer;
    Timer2: TTimer;
    raceroute1: TMenuItem;
    IPScan1: TMenuItem;
    Page_SharedFolders: TTabSheet;
    Panel29: TPanel;
    SpeedButton15: TSpeedButton;
    SpeedButton16: TSpeedButton;
    SpeedButton29: TSpeedButton;
    SpeedB3utton30: TSpeedButton;
    SpeedButton31: TSpeedButton;
    SpeedButton32: TSpeedButton;
    lbxShares: TListView;
    ADOQuery2: TADOQuery;
    ppSharedFolders: TPopupMenu;
    Unshareresource1: TMenuItem;
    Openresource1: TMenuItem;
    Addresource1: TMenuItem;
    MenuItem8: TMenuItem;
    Closeall1: TMenuItem;
    MenuItem9: TMenuItem;
    MenuItem10: TMenuItem;
    Delete1: TMenuItem;
    Refresh1: TMenuItem;
    sbClose2: TSpeedButton;
    lbSpIn: TLabel;
    Label47: TLabel;
    Label46: TLabel;
    lbSpOut: TLabel;
    Page_PortScan: TTabSheet;
    Panel30: TPanel;
    ListView_Port: TListView;
    Panel31: TPanel;
    ProgressBar_PortScan: TProgressBar;
    BmBtnPortDefault: TSpeedButton;
    BmBtnPortBackDoor: TSpeedButton;
    BmBtnPortAll: TSpeedButton;
    ListView_PortTemp: TListView;
    Panel32: TPanel;
    SpeedButton42: TSpeedButton;
    ppPortScan: TPopupMenu;
    Showall1: TMenuItem;
    Showclosedport1: TMenuItem;
    Showopened1: TMenuItem;
    ListView_PortTempAll: TListView;
    PageNetResource: TTabSheet;
    Panel13: TPanel;
    SpeedButto0n7: TSpeedButton;
    tvNetwork: TTreeView;
    StatusBar1: TStatusBar;
    procedure ShowAlertFiles;
    procedure ShowAlert;
    function  IsNT(var Value: Boolean): Boolean;
    procedure btnGetSharesClick(Sender: TObject);
    procedure btnCloseSharesClick(Sender: TObject);
    function  SelectDirectory: String;
    procedure btnAddSharesClick(Sender: TObject);
    function  CardinalToTimeStr(Value:Cardinal):String;
    procedure btnGetSessionsClick(Sender: TObject);
    procedure btnCloseSessionClick(Sender: TObject);
    procedure btnGetFilesClick(Sender: TObject);
    procedure btnCloseFileClick(Sender: TObject);
    procedure tmrTrafficTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TrapMSG(var MSGX: TMessage);
    procedure N2Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PSMFW_UnInitActionExecute(Sender: TObject); // №жИ­є® ±вґЙ БЯБц
    procedure PSMFW_InitActionExecute(Sender: TObject); // №жИ­є® ±вґЙ БЯБц
    procedure TrayIcon1DblClickLeft(Sender: TObject);
    procedure IP1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure dxButton4Click(Sender: TObject);
    procedure dxButton5Click(Sender: TObject);
    procedure dxButton6Click(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
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
    procedure sbhelpClick(Sender: TObject);
    procedure sbCloseClick(Sender: TObject);
    procedure SpeedButton57Click(Sender: TObject);
    procedure CriticalError(Sender: TObject; E: Exception);
    procedure Killall1Click(Sender: TObject);
    procedure Killall2Click(Sender: TObject);
    procedure iniread;
    procedure IP2Click(Sender: TObject);
    procedure ApplicationEvents1Restore(Sender: TObject);
    procedure Viewlog2Click(Sender: TObject);
    procedure Viewlog1Click(Sender: TObject);
    procedure Addtowhitelist1Click(Sender: TObject);
    procedure Addtoblacklist1Click(Sender: TObject);
    procedure Addtowhitelist2Click(Sender: TObject);
    procedure Addtoblacklist2Click(Sender: TObject);
    procedure Files1Click(Sender: TObject);
    procedure Sessions1Click(Sender: TObject);
    procedure Files2Click(Sender: TObject);
    procedure Sessions2Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure KillSession(s:string);
    procedure NameIP1Click(Sender: TObject);
    procedure SpeedButton10Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure sbRegClick(Sender: TObject);
    procedure Files3Click(Sender: TObject);
    procedure Get_TCPTable( );
    procedure Sessions3Click(Sender: TObject);
    procedure Unregisteredversion;
    procedure sbMaxClick(Sender: TObject);
    procedure sbShareviewClick(Sender: TObject);
    procedure RefreshTrayHint;
    procedure tmSesBlackCheckTimer(Sender: TObject);
    procedure tmFilesBlackCheckTimer(Sender: TObject);
    procedure Killblack1Click(Sender: TObject);
    procedure Killblack2Click(Sender: TObject);
    procedure sbShowTrafficClick(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButt8on1Click(Sender: TObject);
    procedure Addnew1Click(Sender: TObject);
    procedure Miridix1Click(Sender: TObject);
    procedure RxTrayIcon1DblClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure AppRestore(Sender: TObject);
    procedure AppMinimize(Sender: TObject);
    procedure OpenPage(page:integer);
    procedure XPTreeClick(Sender: TObject);
    procedure SpeedButton12Click(Sender: TObject);
    procedure SpeedButton13Click(Sender: TObject);
    procedure RefreshRecordsLabels(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure IP1_1Change(Sender: TObject);
    procedure IP1_1Click(Sender: TObject);
    procedure cbIP2rangeClick(Sender: TObject);
    Procedure WinPing(ip:string;size,ttl,count,wait:integer);
    procedure SpeedButton14Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbIP1rangeClick(Sender: TObject);
    procedure IP3_1Change(Sender: TObject);
    procedure SpeedButton16Click(Sender: TObject);
    procedure SpeedButton15Click(Sender: TObject);
    procedure SpeedButton18Click(Sender: TObject);
    procedure k(Sender: TObject);
    Procedure WinPingHost(ip:string;size,ttl,count,wait:integer);
    procedure PageIPConfigShow(Sender: TObject);
    procedure SpeedButton22Click(Sender: TObject);
    procedure SpeedButton19Click(Sender: TObject);
    procedure SpeedButton20Click(Sender: TObject);
    procedure DBGridEh1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure sbAboutClick(Sender: TObject);
    procedure SpeedButton25Click(Sender: TObject);
    procedure SpeedButton23Click(Sender: TObject);
    procedure DBGridEh1CellClick(Column: TColumnEh);
    procedure SpeedButton26Click(Sender: TObject);
    procedure SpeedButton27Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure sbSaveClick(Sender: TObject);
    procedure ApplyFirewallRules;
    procedure FirewallError(ASender: TObject; const bstrError: WideString);
    procedure FirewallLog(ASender: TObject; const bstrMessage: WideString);
    procedure tmFWlogTimer(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton35Click(Sender: TObject);
    procedure SpeedButton32Click(Sender: TObject);
    procedure sbFWOnClick(Sender: TObject);
    procedure sbFWOffClick(Sender: TObject);
    procedure SpeedButton34Click(Sender: TObject);
    procedure SpeedButton36Click(Sender: TObject);
    procedure FirewallStartFirewall;
    procedure FirewallStopFirewall;
    procedure Stop1Click(Sender: TObject);
    procedure Start2Click(Sender: TObject);
    procedure ListView_FWLogEnter(Sender: TObject);
    procedure mnuRuleChangePermisionClick(Sender: TObject);
    procedure mnuRuleAddnewClick(Sender: TObject);
    procedure DeleteClick(Sender: TObject);
    procedure Tray_OpenClick(Sender: TObject);
    procedure RxTrayIcon1Click(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure TrackBar_LevelChange(Sender: TObject);
    procedure SpeedButton38Click(Sender: TObject);
    procedure SpeedButton37Click(Sender: TObject);
    procedure SpeedButton24Click(Sender: TObject);
//    function GetIPFromIFIndex( InterfaceIndex: integer ): string;
   // procedure InitGrid( MibArr: IpHlpAPI.TMibIFArray );
    procedure CaptureMIBData( InitFlag: boolean );
    procedure ClearCounters;
   // procedure Data2Grid( MIBArr: IpHlpAPI.TMIBIFArray );
    procedure sbTrafficStartClick(Sender: TObject);
    procedure sbTrafficStopClick(Sender: TObject);
    procedure SpeedButton30Click(Sender: TObject);
    procedure tmTrafficTimer(Sender: TObject);
    procedure DOIpStuff;
    procedure lvTraffic2Click(Sender: TObject);
    procedure Adddenyruletofirewall1Click(Sender: TObject);
    procedure Adddenyruletofirewall2Click(Sender: TObject);
    procedure Get_TCPStatistics( List: TStrings );
    procedure Page_Traf_StatShow ( Sender: TObject );
    procedure Get_IPStatistics (  List: TStrings );
    procedure Get_UDPStatistics (  List: TStrings );
    procedure Get_ICMPStats( ICMPIn, ICMPOut: TStrings );
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image17MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image17MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image17MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SpeedButton28Click(Sender: TObject);
    procedure tvmainMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Path_ListEnter(Sender: TObject);
    procedure ListView_FWRuleEnter(Sender: TObject);
    procedure SpeedB6utton27Click(Sender: TObject);
    procedure sbTraceClick(Sender: TObject);
    procedure sbStopClick(Sender: TObject);
    procedure sbRunPingClick(Sender: TObject);
    procedure IP4_1Change(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure BuildHTMLResult(p1,p2:integer);
    procedure cbIP3rangeClick(Sender: TObject);
    procedure raceroute1Click(Sender: TObject);
    procedure IPScan1Click(Sender: TObject);
    procedure SpeedB3utton30Click(Sender: TObject);
    procedure SpeedButton31Click(Sender: TObject);
    procedure CloseShare(s:string);
    procedure BmBtnPortDefaultClick(Sender: TObject);
    procedure BmBtnPortBackDoorClick(Sender: TObject);
    procedure BmBtnPortAllClick(Sender: TObject);
    procedure SpeedButton42Click(Sender: TObject);
    procedure Showall1Click(Sender: TObject);
    procedure Showclosedport1Click(Sender: TObject);
    procedure Showopened1Click(Sender: TObject);
    procedure SpeedButto0n7Click(Sender: TObject);
    procedure tvNetworkClick(Sender: TObject);
    procedure tvNetworkDblClick(Sender: TObject);

  private
    FDestIP    : string;
    FHostName  : string;
    CurrentTTL : integer;
    PingStart  : cardinal;
    FStop      : boolean;
    Thread: TDemoThread;
        
    procedure PingFirst;
    procedure PingNext;
    procedure ProcessResponse( Status: TReplyStatus) ;
    procedure Report( TTL: integer; ResponseTime: integer;Status: TReplyStatus; info: string );
  public

    { Public declarations }
    SessionCloseKey: array [0..512] of SmallInt;
    writeLog:boolean;
    runmini:boolean;
    runatlogin:boolean;
    refreshtime:string;
    popupa:string;
    ShowAlerts:boolean;
    draga:string;
    Deleteafter:string;
    regok:boolean;
    showpopups:boolean;
    srComment,srDir,srName,srPass,srMaxusers:PWChar;
    dialog_result:boolean;
    ClickPageNumber:integer;
    stop:boolean;
    somedigit:integer;
  end;

procedure showwait;
procedure closewait;

 //DDT
 type
  LogInf=record
     mTime: string[30];
     mDirection:string[10];
     mPermit:String[10];
     mIP:string;
     mHostName:shortstring;
     mPort:String[10];
     mPath:shortstring;
     mToltalRec:String[30];
     mToltalSen:String[30];
     mTotalRecSen:String[30];
     mSockNo:String[20];
  end;
  //DDT

const
  MSGUDP  = 'UDP  / RemoteIP: %3d.%3d.%3d.%3d / LocalPort: %5d';
  MSGTCP  = 'TCP  / RemoteIP: %3d.%3d.%3d.%3d / LocalPort: %5d';
  MSGICMP = 'ICMP / RemoteIP: %3d.%3d.%3d.%3d / Type     : %5d / Code: %5d';

  //DDT
  LogBuffSize=1024;
  //DDT


const
  ICMP_TIMEOUT      = 5000;
  ICMP_MAX_HOPS     = 40;
  NULL_IP           = '0.0.0.0';


type

  TStatistics = record
    dwInterfaceIndex: DWORD;
    ActiveCountIn,      { count of samples where something was received }
    ActiveCountOut,     { count of samples where something was sent     }
    PrevCountIn,        { previous byte count in }
    PrevCountOut,       { previous byte count out}
    TotalIn,            { total byte count in    }
    TotalOut,           { total byte count out   }
    InPerSec,           { byte count in of last sample period }
    OutPerSec,          { byte count out of last sample period }
    PeakInPerSec,       { peak byte count in/out }
    PeakOutPerSec : DWORD;
  end;

  TStatArr = array of TStatistics;


var
  StatArr     : TStatArr;
  OS: TOSVersionInfo;
  ChosenRuleType: Integer;
  isLogStarted: Boolean;
  FDriverLoaded:boolean;
  bPortScanning:boolean;

  //DDT
  Logs: array[1..LogBuffSize] of LogInf ;
  LogID: Integer;
  mainHWND: HWND;
  //DDT


  ServerSocket:TServerSocket;

  //update on march 17, imagelist for logging.
  logImages: TImageList;
  logPaths:TStringlist;

  const PATH_RULE_TYPE: Integer =1;
  const IP_RULE_TYPE: Integer=0;
  const REQUEST_TIMEOUT:Integer=1000;



type
  THtmlLoader = class(TThread)
  protected
    procedure Execute; override;
  public
  end;


type
 TShareInfo2 = packed record
  shi2_netname : PWChar;
  shi2_type: DWORD;
  shi2_remark :PWChar;
  shi2_permissions: DWORD;
  shi2_max_uses : DWORD;
  shi2_current_uses : DWORD;
  shi2_path : PWChar;
  shi2_passwd : PWChar;
 end;
 PShareInfo2 = ^ TShareInfo2;
 TShareInfo2Array = array [0..512] of TShareInfo2;
 PShareInfo2Array = ^ TShareInfo2Array;

type
 TShareInfo50 = packed record
  shi50_netname : array [0..12] of Char;
  shi50_type : Byte;
  shi50_flags : Word;
  shi50_remark : PChar;
  shi50_path : PChar;
  shi50_rw_password : array [0..8] of Char;
  shi50_ro_password : array [0..8] of Char;
 end;

type
 TSessionInfo502 = packed record
   Sesi502_cname: PWideChar;
   Sesi502_username: PWideChar;
   Sesi502_num_opens: DWORD;
   Sesi502_time: DWORD;
   Sesi502_idle_time: DWORD;
   Sesi502_user_flags: DWORD;
   Sesi502_cltype_name: PWideChar;
   Sesi502_transport: PWideChar;
 End;
 PSessionInfo502 = ^TSessionInfo502;
 TSessionInfo502Array = array[0..512] of TSessionInfo502;
 PSessionInfo502Array = ^TSessionInfo502Array;

type
 TSessionInfo502_compare = packed record
   Sesi502_cname: PWideChar;
   Sesi502_username: PWideChar;
   Sesi502_num_opens: DWORD;
   Sesi502_time: DWORD;
   Sesi502_idle_time: DWORD;
   Sesi502_user_flags: DWORD;
   Sesi502_cltype_name: PWideChar;
   Sesi502_transport: PWideChar;
   status:PWideChar;
 End;
 PSessionInfo502_compare = ^TSessionInfo502_compare;
 TSessionInfo502Array_compare = array[0..512] of TSessionInfo502_compare;
 PSessionInfo502Array_compare = ^TSessionInfo502Array_compare;

type
 TSessionInfo50 = packed record
   Sesi50_cname       : PChar;
   Sesi50_username    : PChar;
   sesi50_key         : Cardinal;
   sesi50_num_conns   : Word;
   sesi50_num_opens   : Word;
   sesi50_time        : Cardinal;
   sesi50_idle_time   : Cardinal;
   sesi50_protocol    : Byte;
   pad1               : Byte;
 end;

type
 TFileInfo3 = packed record
   fi3_id          : DWORD;
   fi3_permissions : DWORD;
   fi3_num_locks   : DWORD;
   fi3_pathname    : PWChar;
   fi3_username    : PWChar;
 end;
 PFileInfo3 = ^TFileInfo3;
 TFileInfo3Array = array[0..512] of TFileInfo3;
 PFileInfo3Array = ^TFileInfo3Array;

 TFileInfo3_compare = packed record
   fi3_id          : DWORD;
   fi3_permissions : DWORD;
   fi3_num_locks   : DWORD;
   fi3_pathname    : PWChar;
   fi3_username    : PWChar;
   status          : PWChar;
 end;

type
 TFileInfo50 = packed record
   fi50_id          : Cardinal;
   fi50_permissions : WORD;
   fi50_num_locks   : WORD;
   fi50_pathname    : PChar;
   fi50_username    : PChar;
   fi50_sharename   : PChar;
 end;

type
  TMibIfRow = packed record
    wszName            : array[0..255] of WideChar;
    dwIndex            : DWORD;
    dwType             : DWORD;
    dwMtu              : DWORD;
    dwSpeed            : DWORD;
    dwPhysAddrLen      : DWORD;
    bPhysAddr          : array[0..7] of Byte;
    dwAdminStatus      : DWORD;
    dwOperStatus       : DWORD;
    dwLastChange       : DWORD;
    dwInOctets         : DWORD;
    dwInUcastPkts      : DWORD;
    dwInNUCastPkts     : DWORD;
    dwInDiscards       : DWORD;
    dwInErrors         : DWORD;
    dwInUnknownProtos  : DWORD;
    dwOutOctets        : DWORD;
    dwOutUCastPkts     : DWORD;
    dwOutNUCastPkts    : DWORD;
    dwOutDiscards      : DWORD;
    dwOutErrors        : DWORD;
    dwOutQLen          : DWORD;
    dwDescrLen         : DWORD;
    bDescr             : array[0..255] of Char;
  end;
  TMibIfArray = array [0..512] of TMibIfRow;
  PMibIfRow = ^TMibIfRow;
  PMibIfArray = ^TMibIfArray;

type
 TMibIfTable = packed record
   dwNumEntries     : DWORD;
   Table            : TMibIfArray;
 end;
 PMibIfTable = ^TMibIfTable;

type

    ip_option_information = packed record  // Информация заголовка IP (Наполнение
    // этой структуры и формат полей описан в RFC791.
        Ttl : byte;// Время жизни (используется traceroute-ом)
        Tos : byte;// Тип обслуживания, обычно 0
        Flags : byte;// Флаги заголовка IP, обычно 0
        OptionsSize : byte;// Размер данных в заголовке, обычно 0, максимум 40
        OptionsData : Pointer;// Указатель на данные
    end;

   icmp_echo_reply = packed record
        Address : u_long;      // Адрес отвечающего
        Status : u_long;     // IP_STATUS (см. ниже)
        RTTime : u_long;     // Время между эхо-запросом и эхо-ответом
         // в миллисекундах
        DataSize : u_short;      // Размер возвращенных данных
        Reserved : u_short;      // Зарезервировано
        Data : Pointer;  // Указатель на возвращенные данные
        Options : ip_option_information; // Информация из заголовка IP
    end;



    PIPINFO = ^ip_option_information;
    PVOID = Pointer;

        function IcmpCreateFile() : THandle; stdcall; external 'ICMP.DLL' name 'IcmpCreateFile';
        function IcmpCloseHandle(IcmpHandle : THandle) : BOOL; stdcall; external 'ICMP.DLL'  name 'IcmpCloseHandle';
        function IcmpSendEcho(
                          IcmpHandle : THandle;    // handle, возвращенный IcmpCreateFile()
                          DestAddress : u_long;    // Адрес получателя (в сетевом порядке)
                          RequestData : PVOID;     // Указатель на посылаемые данные
                          RequestSize : Word;      // Размер посылаемых данных
                          RequestOptns : PIPINFO;  // Указатель на посылаемую структуру
                                          // ip_option_information (может быть nil)

                         ReplyBuffer : PVOID;     // Указатель на буфер, содержащий ответы.
                          ReplySize : DWORD;       // Размер буфера ответов
                          Timeout : DWORD          // Время ожидания ответа в миллисекундах
                         ) : DWORD; stdcall; external 'ICMP.DLL' name 'IcmpSendEcho';



type

  TPingThread = class(TThread)
  private
    FHost: String;
    FResult: integer;
    FError: integer;
    fIndex : integer;

  protected
    procedure Execute; override;
  public
    constructor Create(Host: string; index:integer; var result, Error: integer);
  end;

  PingResult = record
    host : string;
    hostname : string;
    time , error : integer;
  end;

  CPingResults = array [0..256] of PingResult;

var PingResults : array [1..10] of array [0..256] of PingResult;
    BPingResults : array [0..256] of CPingResults;
    PingStep, MaxPingStep:integer;
    Ini: TIniFile;




var
NetShareEnumNT:function (	servername:PWChar;
                          level:DWORD;
                          bufptr:Pointer;
                          prefmaxlen:DWORD;
                          entriesread,
                          totalentries,
                          resume_handle:LPDWORD): DWORD; stdcall;

var
NetShareEnum:function (	pszServer	: PChar;
                        sLevel		: Cardinal;
                        pbBuffer	: Pchar;
                        cbBuffer	: Cardinal;
                        pcEntriesRead,
                        pcTotalAvail: Pointer):DWORD; stdcall;

var
NetShareDelNT:function (servername: PWideChar;
                        netname: PWideChar;
                        reserved: DWORD): LongInt; stdcall;

var
NetShareDel:function (  pszServer,
                        pszNetName:PChar;
                        usReserved:Word): DWORD; stdcall;

var
NetShareAddNT: function(servername: PWideChar;
                        level: DWORD;
                        buf: Pointer;
                        parm_err: LPDWORD): DWORD; stdcall;

var
NetShareAdd: function (	pszServer:Pchar;
                        sLevel:Cardinal;
                        pbBuffer:PChar;
                        cbBuffer:Word):DWORD; stdcall;

Var
NetSessionEnumNT:function(servername,
                        UncClientName,
                        username:PWChar;
                        level:DWORD;
                        bufptr:Pointer;
                        prefmaxlen:DWORD;
                        entriesread,
                        totalentries,
                        resume_handle:LPDWORD):DWORD; stdcall;


var
NetSessionEnum:function(pszServer:PChar;
                        sLevel: DWORD;
                        pbBuffer:Pointer;
                        cbBuffer:DWORD;
                        pcEntriesRead,
                        pcTotalAvial:Pointer):integer; stdcall;

var
NetSessionDelNT:function(ServerName,
                        UncClientName,
                        username:PWChar):DWORD; stdcall;

var
NetSessionDel:function( pszServer:PChar;
                        pszClientName: PChar;
                        sReserved: SmallInt):DWORD; stdcall;

var
NetFileEnumNT:function(	servername,
                        basepath,
                        username:PWChar;
                        level:DWORD;
                        bufptr:Pointer;
                        prefmaxlen:DWORD;
                        entriesread,
                        totalentries,
                        resume_handle:LPDWORD):DWORD; stdcall;

var
NetFileEnum:function(	  pszServer,
                        pszBasePath:PChar;
                        sLevel:DWORD;
                        pbBuffer:Pointer;
                        cbBuffer:DWORD;
                        pcEntriesRead,
                        pcTotalAvail:pointer):integer; stdcall;

var
NetFileClose:function(	ServerName:PWideChar;
                        FileId:DWORD):DWORD; stdcall;

var
NetFileClose2:function(	pszServer:PChar;
                        ulFileId:LongWord):DWORD; stdcall;

var
GetIfTable:function(    pIfTable    : PMibIfTable;
                        pdwSize     : PULONG;
                        bOrder      : Boolean ): DWORD; stdcall;

type
  PEntry = ^TEntry;
  TEntry = record
    Caption: WideString;
    Image: Integer;
    Size: Int64;
  end;

var
  TreeEntries: array[0..11] of TEntry = (
    (Caption: 'Opened files';               Image: 54; Size: 0),
    (Caption: 'Shared folders';             Image: 191; Size: 0),
    (Caption: 'Firewall';                   Image: 192; Size: 0),
    (Caption: 'Net resources';              Image: 136; Size: 0),
    (Caption: 'Traffic';                    Image: 48; Size: 0),
    (Caption: 'Net utils';                       Image: 194; Size: 10),
    (Caption: 'Logs';                       Image: 63; Size: 0),
    (Caption: 'Configuration';              Image: 90; Size: 0),
    (Caption: 'Register';                   Image: 60; Size: 0),
    (Caption: 'About';                      Image: 196; Size: 0),
    (Caption: 'Miridix site';               Image: 101; Size: 0),
    (Caption: 'Help';                       Image: 195; Size: 0)
  );

procedure Compare_SessionInfo502(x,y:array of TSessionInfo502); forward;


var
  RecentIPs     : TStringList;
  MainForm           : TMainForm;
  FileInfoNT_temp    : array of TFileInfo3;
  FileInfoNT_current : array of TFileInfo3;
  FileInfoNT_compare : array of TFileInfo3_compare;

  SessionInfo502_temp    : array of TSessionInfo502;
  SessionInfo502_current : array of TSessionInfo502;
  SessionInfo502_compare : array of TSessionInfo502_compare;

  stemp              : string;
  x                  : integer;

  apl_path           : string;
  apl_path_long      : string;
  sr                 : TSearchRec;
  _exit              : boolean=false;
  _x,_y              : integer;

var
  FLibHandle : THandle;
  Table: TMibIfTable;
  i : integer;
  Size   : integer;
  spIn_Last,spOut_Last:integer;



implementation

uses  uNewFiles, uLogFiles, uShared, usetup, uLogSes, uWhiteFiles,
 uWhiteSes, uBlackFiles, uBlackSes, ureg, uUnreg,  uhelp, uTrialEnd,
  uBlackAlert, uBlackAlertFiles, uTraffic, uDialog;


 var
  fs:formstates;
     LogWindowParam: Boolean;
     UnInjectLibParam:Boolean;



{$R *.dfm}

{ TMainForm }

//----------------------------------------------------------------------------------------------------------------------

procedure showwait;
begin
  if not assigned(fowait) then
   begin
      Application.CreateForm ( Tfowait, fowait );
   end;
  fowait.Show;
  fowait.repaint;
  fowait.DoubleBuffered:=true;
  screen.Cursor:=crhourglass;
end;

//-----------------------------------------------------------------------------------------------

function GetIPAddress(NetworkName: String): String;
var
 Error: DWORD;
 HostEntry: PHostEnt;
 Data: WSAData;
 Address: In_Addr;
begin
  Delete(NetworkName, 1, 2);
  Error:=WSAStartup(MakeWord(1, 1), Data);
  if Error = 0 then
  begin
    HostEntry:=gethostbyname(PChar(NetworkName));
    Error:=GetLastError;
    if Error = 0 then
    begin
      Address:=PInAddr(HostEntry^.h_addr_list^)^;
      Result:=inet_ntoa(Address);
    end
    else
     Result:='Unknown';
  end
  else
    Result:='Error';
  WSACleanup;
end;

//-----------------------------------------------------------------------------------------------

procedure closewait;
begin
  screen.Cursor:=crdefault;
  fowait.close;
end;

//-----------------------------------------------------------------------------------------------

procedure tmainform.RefreshTrayHint;
begin
    RxTrayIcon1.Hint:='Miridix Shareview '+Version+#13+#10+
    'Files: '+ inttostr(self.lvFiles.Items.Count)+#13+#10+
                    'Sessions: '+ inttostr(self.lvSessions.Items.Count);
end;


//----------------------------------------------------------------------------------------------------------------------

procedure ConvertToHighColor(ImageList: TImageList);

// To show smooth images we have to convert the image list from 16 colors to high color.

var
  IL: TImageList;

begin
  // Have to create a temporary copy of the given list, because the list is cleared on handle creation.
  IL := TImageList.Create(nil);
  IL.Assign(ImageList);

  with ImageList do
    Handle := ImageList_Create(Width, Height, ILC_COLOR16 or ILC_MASK, Count, AllocBy);
  ImageList.Assign(IL);
  IL.Free;
end;

//----------------------------------------------------------------------------------------------------------------------


procedure tmainform.Unregisteredversion;
begin
  if not assigned(founreg) then Application.CreateForm(Tfounreg, founreg);
  founreg.show;
end;

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

//----------------------------------------------------------------------------------------------------------------------

procedure  ShowSomeMessage(i:integer);
begin
  MainForm.somedigit:=i;
  if not assigned(foTrialEnd) then Application.CreateForm(TfoTrialEnd, foTrialEnd);
  foTrialEnd.showmodal;


end;

//----------------------------------------------------------------------------------------------------------------------

//Shell a program [and wait until it finishes]
procedure Shell32Bit(JobToDo:String; booWait: BOOL);
var
    RetVal:Cardinal;
    pi:PROCESS_INFORMATION;
    si:STARTUPINFO;
Begin
  FillMemory(@si, sizeof( si ), 0 );
  si.dwFlags:=STARTF_USESHOWWINDOW;
  si.wShowWindow:=SW_HIDE;
  si.cb := sizeof(STARTUPINFO);
  CreateProcess(nil,Pchar(JobToDo), nil, nil, False, CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS, nil,nil, si,pi);
  if booWait then
    repeat
      //Get the status of the process
      GetExitCodeProcess(pi.hProcess, RetVal);
    until RetVal <> STILL_ACTIVE;
End;

//----------------------------------------------------------------------------------------------------------------------


function FileVersion(const FileName: String;
  const Fmt: String = '%0.4d.%0.4d.%0.4d.%0.4d'): String;
var
  iBufferSize: DWORD;
  iDummy: DWORD;
  pBuffer: Pointer;
  pFileInfo: Pointer;
  iVer: Array[1..4] of Word;
begin
  // set default value
  Result := '9999.9999.9999.9999';
  // get size of version info (0 if no version info exists)
  iBufferSize := GetFileVersionInfoSize(PChar(FileName), iDummy);
  if (iBufferSize > 0) then
  begin
    GetMem(pBuffer, iBufferSize);
    try
    // get fixed file info
    GetFileVersionInfo(PChar(FileName), 0, iBufferSize, pBuffer);
    VerQueryValue(pBuffer, '\', pFileInfo, iDummy);
    // read version blocks
    iVer[1] := HiWord(PVSFixedFileInfo(pFileInfo)^.dwFileVersionMS);
    iVer[2] := LoWord(PVSFixedFileInfo(pFileInfo)^.dwFileVersionMS);
    iVer[3] := HiWord(PVSFixedFileInfo(pFileInfo)^.dwFileVersionLS);
    iVer[4] := LoWord(PVSFixedFileInfo(pFileInfo)^.dwFileVersionLS);
    finally
      FreeMem(pBuffer);
    end;
    // format result string
    Result := Format(Fmt, [iVer[1], iVer[2], iVer[3], iVer[4]]);
  end;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure CheckForNewUpdates();
var
  htmlLoader: THtmlLoader;
begin
  try
    htmlLoader:= THtmlLoader.Create(True);
    htmlLoader.FreeOnTerminate:=True;
    htmlLoader.Resume;
  finally
  end;
end;

//----------------------------------------------------------------------------------------------------------------------

//Perform a simple check about the new version.
procedure THtmlLoader.Execute;
var
  http: TIdHTTP;
  strLatestVersion:string;
begin
  {http:=TIdHTTP.Create(nil);
  try
    try
      Http.Request.UserAgent := 'User-Agent: NULL';
      strLatestVersion := Http.Get('http://miridix.com/latest-ver-shareview.htm');

     // if (strlen(Pchar(strLatestVersion))=strlen('9999.9999.9999.9999')) and (pos('.',strLatestVersion)=5) then
        if strtofloat(strLatestVersion) > VersionFloat then begin
        If MessageBox(0,'There is a new version of Shareview, do you want to check it out?','Shareview',MB_ICONINFORMATION or MB_YESNO)=IDYES then
          Shell32Bit('explorer.exe http://miridix.com/page-6.htm',False);
      end;
    except
      on E: Exception do strLatestVersion := Pchar('Error: ' + E.Message);
    end;
  finally
    Http.Disconnect;
    Http.Free;
  end;    }
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TDemoThread.Execute;
var
  R:TNetResource;
begin
  inherited;
  Priority := tpIdle;
  FreeOnTerminate := True;
  Resume;
  Scan(R, True);
  TreeDomain := nil;
  TreeServer := nil;
  Synchronize(Stop);
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TDemoThread.Scan(Res: TNetResource; Root: boolean);
var
 hEnum: Cardinal;
 nrResource: array[0..512] of TNetResource;
 dwSize: DWORD;
 numEntries: DWORD;
 I: DWORD;
 dwResult: DWORD;
begin
  if Root then
    dwResult := WNetOpenEnum(RESOURCE_GLOBALNET, RESOURCETYPE_ANY,
      0, nil, hEnum)
  else
    dwResult := WNetOpenEnum(RESOURCE_GLOBALNET, RESOURCETYPE_ANY,
      0, @Res, hEnum);
  if dwResult = NO_ERROR then
  begin
    dwSize := SizeOf(nrResource);
    numEntries := DWORD(-1);                                   // ERROR_NO_MORE_ITEMS
    if WNetEnumResource(hEnum, numEntries, @nrResource, dwSize) = NO_ERROR then
    begin
      for i := 0 to numEntries - 1 do
      begin
        if Terminated then Break;
        with nrResource[i] do
        begin
          Param_dwType := dwType;
          Param_dwDisplayType := dwDisplayType;
          Param_lpRemoteName := lpRemoteName;
          if Param_dwDisplayType = RESOURCEDISPLAYTYPE_SERVER then
            Param_lpIP := GetIPAddress(Param_lpRemoteName);
        end;
        if Assigned(nrResource[i].lpRemoteName) then
          Synchronize(AddElement);
        Scan(nrResource[i], false);
      end;
    WNetCloseEnum(hEnum);
    end;
  end;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TDemoThread.AddElement;
begin
  Application.ProcessMessages;
  case Param_dwDisplayType of
    RESOURCEDISPLAYTYPE_NETWORK:
    begin
      TreeNetWrk := MainForm.tvNetwork.Items.Add(nil, Param_lpRemoteName);
      TreeNetWrk.StateIndex := 1;
    end;
    RESOURCEDISPLAYTYPE_DOMAIN:
    begin
      TreeDomain := MainForm.tvNetwork.Items.AddChild(TreeNetWrk, Param_lpRemoteName);
      TreeDomain.StateIndex := 2;
    end;
    RESOURCEDISPLAYTYPE_SERVER:
    begin
      TreeServer := MainForm.tvNetwork.Items.AddChild(TreeDomain, Param_lpRemoteName + ' IP: ' + Param_lpIP);
      TreeServer.StateIndex := 3;
    end;
    RESOURCEDISPLAYTYPE_SHARE:
    begin
      TreeShares := MainForm.tvNetwork.Items.AddChild(TreeServer, Param_lpRemoteName);
      TreeShares.StateIndex := 3 + Param_dwType;
    end;
  end;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TDemoThread.Stop;
begin
  MainForm.StatusBar1.Panels[1].Text := STR_STOPPED;
  MainForm.SpeedButto0n7.Caption := STR_START;
  MainForm.SpeedButto0n7.Enabled := True;
  MainForm.Tag := 0;
end;


//----------------------------------------------------------------------------------------------------------------------

function DoSomething2 ():string;
var
  fp:textFile;
  x,y,z,k,y2:tdatetime;
  windir:pchar;
  s:string;
begin
 if not mainform.regok then
 begin
  GetMem(WinDir, 144);
  GetWindowsDirectory(WinDir, 144);

  AssignFile(fp,StrPas(WinDir)+'\system32\swcheck.dll');
  try
   if FileExists(StrPas(WinDir)+'\system32\swcheck.dll') then reset(fp) else Rewrite(fp);
   try
      begin
      y:=0;
      x:=0;
      k:=0;
       while not eof(fp) do
         begin
           readln(fp,s);
           x:=strtofloatdef(s,0);
           if k=x then begin z:=0;x:=0;k:=0;end;
           if x=0 then begin z:=0;x:=0;k:=0;end;
           if k=0 then k:=x;
           z:=abs(x-k);
           y:=y+z;
       //    MainForm.Memo1.Lines.Add('y='+floattostr(y)+' | '+'z='+floattostr(z)+' | '+'x='+floattostr(x)+' | '+'k='+floattostr(k)+' | ');
           k:=x;

         end;

{       if y>30 then
        begin
          ShowSomeMessage();
        end;
 }     end;
    except
    end;
    CloseFile(fp);
    except
   end;
   FreeMem(WinDir, 144);

///------------

  GetMem(WinDir, 144);
  GetWindowsDirectory(WinDir, 144);

  AssignFile(fp,StrPas(WinDir)+'\temp\comkernel32.ocx');
  try
   if FileExists(StrPas(WinDir)+'\temp\comkernel32.ocx') then reset(fp) else Rewrite(fp);
   try
      begin
      y2:=0;
      x:=0;
      k:=0;
       while not eof(fp) do
         begin
           readln(fp,s);
           x:=strtofloatdef(s,0);
           if k=x then begin z:=0;x:=0;k:=0;end;
           if x=0 then begin z:=0;x:=0;k:=0;end;
           if k=0 then k:=x;
           z:=abs(x-k);
           y2:=y2+z;
       //    MainForm.Memo1.Lines.Add('y='+floattostr(y)+' | '+'z='+floattostr(z)+' | '+'x='+floattostr(x)+' | '+'k='+floattostr(k)+' | ');
           k:=x;

         end;

      end;
    except
    end;
    CloseFile(fp);
    except
   end;
   FreeMem(WinDir, 144);
   if y>y2 then y2:=y;
   if y2>y then y:=y2;

   ShowSomeMessage(trunc(y));
 end;
end;

//----------------------------------------------------------------------------------------------------------------------


function ExecAndWait(const FileName, Params: ShortString; const WinState: Word): boolean; export;
var
StartInfo: TStartupInfo;
ProcInfo: TProcessInformation;
CmdLine: ShortString;
begin
CmdLine := '"' + Filename + '" ' + Params;
FillChar(StartInfo, SizeOf(StartInfo), #0);
with StartInfo do
begin
cb := SizeOf(StartInfo);
dwFlags := STARTF_USESHOWWINDOW;
wShowWindow := WinState;
end;
Result := CreateProcess(nil, PChar( String( CmdLine ) ), nil, nil, false,
CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS, nil,
PChar(ExtractFilePath(Filename)),StartInfo,ProcInfo);
{ Ожидаем завершения приложения }
if Result then
begin
WaitForSingleObject(ProcInfo.hProcess, INFINITE);
{ Free the Handles }
CloseHandle(ProcInfo.hProcess);
CloseHandle(ProcInfo.hThread);
end;
end;

//----------------------------------------------------------------------------------------------------------------------

function TMainForm.IsNT(var Value: Boolean): Boolean;
var Ver: TOSVersionInfo;
    BRes: Boolean;
begin
  Ver.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
  BRes := GetVersionEx(Ver);
  if not BRes then   //Проверка
  begin
    Result := False; //Информация не получена
    Exit;            //уходим
  end else
    Result := True;  //Информация получена

  case Ver.dwPlatformId of //определяемся
    VER_PLATFORM_WIN32_NT       : Value := True;  //Windows NT - подходит
    VER_PLATFORM_WIN32_WINDOWS  : Value := False; //Windows 9x-Me - подходит
    VER_PLATFORM_WIN32s         : Result := False //Windows 3.x - не подходит
  end;
end;


//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.CriticalError(Sender: TObject; E: Exception);
begin
   Showmessage('Fatal error: '+e.Message);
//   KillTask('MultimediaView.exe');
///
//  ShellExecute (0,'OPEN',pchar(getcurrentdir+'\killbill.exe'),nil,nil,sw_show);
//  halt;
end;

//----------------------------------------------------------------------------------------------------------------------

function Host2IP(Name: string): string;
var
  wsdata : TWSAData;
  hostName : array [0..255] of char;
  hostEnt : PHostEnt;
  addr : PChar;
  IP :string;
begin
  WSAStartup ($0101, wsdata);
  try
    gethostname (hostName, sizeof (hostName));
    StrPCopy(hostName, Name);
    hostEnt := gethostbyname (hostName);
    if Assigned (hostEnt) then
      if Assigned (hostEnt^.h_addr_list) then begin
        addr := hostEnt^.h_addr_list^;
        if Assigned (addr) then begin
          IP := Format ('%d.%d.%d.%d', [byte (addr [0]),
          byte (addr [1]), byte (addr [2]), byte (addr [3])]);
          Result := IP;
        end
        else
          Result := '0.0.0.0';
      end
      else
        Result := '0.0.0.0'
    else begin
      Result := '0.0.0.0';
    end;
  finally
    WSACleanup;
  end
end;

//----------------------------------------------------------------------------------------------------------------------

function GetHostByIP(IPAddr: String): String; // Полyчение имени по IP
var
  Error: DWORD;
  SockAddrIn: TSockAddrIn;
  HostEnt: PHostEnt;
  Data: TWSAData;
begin
  Result:='Can`t do this';
  Error:=WSAStartup($101, Data);
  if Error = 0 then begin
   SockAddrIn.sin_addr.s_addr:= inet_addr(PChar(IPAddr));
   HostEnt:= gethostbyaddr(@SockAddrIn.sin_addr.S_addr, 4, AF_INET);
   if HostEnt<>nil then Result:=StrPas(Hostent^.h_name);
  end; // Error=0
  WSACleanup();
end;



////////////////////////////////////////////////////////////////////////////////
//
//  Получение всех открытых общих ресурсов
//


//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.btnGetSharesClick(Sender: TObject);

var
  i:Integer;
  FLibHandle : THandle;
  ShareNT : PShareInfo2Array;     //<= Перемеменные
  entriesread,totalentries:DWORD; //<= для Windows NT
  OS: Boolean;
begin
  lbxShares.Items.Clear;
  if not mainform.IsNT(OS) then Close; //Определяем тип системы

  if OS then begin  //Код для NT
    FLibHandle := LoadLibrary('NETAPI32.DLL'); //Загружаем библиотеку
    if FLibHandle = 0 then Exit;
    //Связываем функцию
    @NetShareEnumNT := GetProcAddress(FLibHandle,'NetShareEnum');
    if not Assigned(NetShareEnumNT) then //Проверка
    begin
      FreeLibrary(FLibHandle);
      Exit;
    end;
    ShareNT := nil; //Очищаем указатель на массив структур
    //Вызов функции
    if NetShareEnumNT(nil,2,@ShareNT,DWORD(-1),
                      @entriesread,@totalentries,nil) <> 0 then
    begin  //Если вызов неудачен выгружаем библиотеку
      FreeLibrary(FLibHandle);
      Exit;
    end;

    //чистим таблицу от мусора
    try
      Mainform.aqSQL.SQL.Clear;
      Mainform.aqSQL.SQL.Add('delete from Shares where status='+#39+'on'+#39);
      Mainform.aqSQL.ExecSQL;
    except
      on EOleException do
    end;

    try
      aqList.SQL.Clear;
      aqList.SQL.Add('select * from Shares where status='+#39+'off'+#39);
      aqList.Open;
    except
      on EOleException do
    end;

    if entriesread > 0 then //Обработка результатов
    for i:= 0 to entriesread - 1 do
     with lbxShares.Items.Add do
       begin
         if aqlist.Locate('shi2_netname',string(ShareNT^[i].shi2_netname),[]) then
           begin
              CloseShare(ShareNT^[i].shi2_netname)
           end
           else
           begin
            caption:=String(ShareNT^[i].shi2_netname);
            subitems.Add(String(ShareNT^[i].shi2_remark));
            ImageIndex:=31;
            with Mainform do
              begin
              try
                aqSQL.SQL.Clear;
                aqSQL.SQL.Add('insert into Shares (shi2_netname, shi2_type, shi2_remark, ');
                aqSQL.SQL.Add(' shi2_permissions, shi2_max_uses, shi2_current_uses, ');
                aqSQL.SQL.Add(' shi2_path, shi2_passwd,status,dtime )  ');
                aqSQL.SQL.Add('  values ('+#39+string(ShareNT^[i].shi2_netname)+#39+', ');
                aqSQL.SQL.Add(   inttostr(ShareNT^[i].shi2_type)+', ');
                aqSQL.SQL.Add(   #39+string(ShareNT^[i].shi2_remark)+#39+', ');
                aqSQL.SQL.Add(   inttostr(ShareNT^[i].shi2_permissions)+', ');
                aqSQL.SQL.Add(   inttostr(ShareNT^[i].shi2_max_uses)+', ');
                aqSQL.SQL.Add(   inttostr(ShareNT^[i].shi2_current_uses)+', ');
                aqSQL.SQL.Add(   #39+string(ShareNT^[i].shi2_path)+#39+', ');
                aqSQL.SQL.Add(   #39+string(ShareNT^[i].shi2_passwd)+#39+', ');
                aqSQL.SQL.Add(   #39+'on'+#39+', ');
                aqSQL.SQL.Add(   ' :date )');
                aqSQL.SQL.SaveToFile('1.sql');
                aqSQL.Parameters.ParameterCollection.Refresh;
                aqSQL.Parameters.Refresh;
                aqSQL.Parameters[0].Value:=datetostr(now);
                aqSQL.ExecSQL;
              except
                on EOleException do
              end;
            end;
       end;
       end;


  lbxShares.Items.Clear;
  if not mainform.IsNT(OS) then Close; //Определяем тип системы

  if OS then begin  //Код для NT
    FLibHandle := LoadLibrary('NETAPI32.DLL'); //Загружаем библиотеку
    if FLibHandle = 0 then Exit;
    //Связываем функцию
    @NetShareEnumNT := GetProcAddress(FLibHandle,'NetShareEnum');
    if not Assigned(NetShareEnumNT) then //Проверка
    begin
      FreeLibrary(FLibHandle);
      Exit;
    end;
    ShareNT := nil; //Очищаем указатель на массив структур
    //Вызов функции
    if NetShareEnumNT(nil,2,@ShareNT,DWORD(-1),
                      @entriesread,@totalentries,nil) <> 0 then
    begin  //Если вызов неудачен выгружаем библиотеку
      FreeLibrary(FLibHandle);
      Exit;
    end;

    //чистим таблицу от мусора
    try
      Mainform.aqSQL.SQL.Clear;
      Mainform.aqSQL.SQL.Add('delete from Shares where status='+#39+'on'+#39);
      Mainform.aqSQL.ExecSQL;
    except
      on EOleException do
    end;

    try
      aqList.SQL.Clear;
      aqList.SQL.Add('select * from Shares where status='+#39+'off'+#39);
      aqList.Open;
    except
      on EOleException do
    end;

    if entriesread > 0 then //Обработка результатов
    for i:= 0 to entriesread - 1 do
     with lbxShares.Items.Add do
       begin
            caption:=String(ShareNT^[i].shi2_netname);
            subitems.Add(String(ShareNT^[i].shi2_remark));
            subitems.Add(String(ShareNT^[i].shi2_path));
            ImageIndex:=31;
            with Mainform do
              begin
              try
                aqSQL.SQL.Clear;
                aqSQL.SQL.Add('insert into Shares (shi2_netname, shi2_type, shi2_remark, ');
                aqSQL.SQL.Add(' shi2_permissions, shi2_max_uses, shi2_current_uses, ');
                aqSQL.SQL.Add(' shi2_path, shi2_passwd,status,dtime )  ');
                aqSQL.SQL.Add('  values ('+#39+string(ShareNT^[i].shi2_netname)+#39+', ');
                aqSQL.SQL.Add(   inttostr(ShareNT^[i].shi2_type)+', ');
                aqSQL.SQL.Add(   #39+string(ShareNT^[i].shi2_remark)+#39+', ');
                aqSQL.SQL.Add(   inttostr(ShareNT^[i].shi2_permissions)+', ');
                aqSQL.SQL.Add(   inttostr(ShareNT^[i].shi2_max_uses)+', ');
                aqSQL.SQL.Add(   inttostr(ShareNT^[i].shi2_current_uses)+', ');
                aqSQL.SQL.Add(   #39+string(ShareNT^[i].shi2_path)+#39+', ');
                aqSQL.SQL.Add(   #39+string(ShareNT^[i].shi2_passwd)+#39+', ');
                aqSQL.SQL.Add(   #39+'on'+#39+', ');
                aqSQL.SQL.Add(   ' :date )');
                aqSQL.SQL.SaveToFile('1.sql');
                aqSQL.Parameters.ParameterCollection.Refresh;
                aqSQL.Parameters.Refresh;
                aqSQL.Parameters[0].Value:=datetostr(now);
                aqSQL.ExecSQL;
              except
                on EOleException do
              end;
           end;
       end;

    //Добавляем в список отключеные подключения
    try
      Mainform.aqSQL.SQL.Clear;
      Mainform.aqSQL.SQL.Add('select * from Shares where status='+#39+'off'+#39);
      Mainform.aqSQL.Open;
    except
      on EOleException do
    end;
    Mainform.aqSQL.First;
    while not Mainform.aqSQL.Eof do
      begin
       with lbxShares.Items.Add do
        begin
         caption:=String(mainform.aqSQL.FieldByName('shi2_netname').AsString);
         subitems.Add(String(mainform.aqSQL.FieldByName('shi2_remark').AsString));
         subitems.Add(String(mainform.aqSQL.FieldByName('shi2_path').AsString));
         ImageIndex:=50;
        end;
        Mainform.aqSQL.Next;
      end;
    Mainform.aqSQL.Close;
    end;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
//
//  Закрытие общего ресурса
//

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.btnCloseSharesClick(Sender: TObject);
var
  OS:Boolean;
  FLibHandle : THandle;
  NameNT:PWChar;
  i:Integer;
  ShareName: String;
begin
  if not mainform.IsNT(OS) then Close; //Определяем тип системы
 // if self.lbxShares.SelCount>0 then
  begin
  if self.lbxShares.Items.Count = 0 then Exit;
  if self.lbxShares.SelCount <1 then Exit;
  for i:= 0 to self.lbxShares.Items.Count -1 do
    if self.lbxShares.Items[i].Selected then Break;  //Ищем выбранный элемент
  if not self.lbxShares.Items[i].Selected then Exit; //Если не найден уходим
  ShareName := self.lbxShares.Items[i].Caption;

  if OS then begin //Код для NT
    FLibHandle := LoadLibrary('NETAPI32.DLL');
    if FLibHandle = 0 then Exit;
    @NetShareDelNT := GetProcAddress(FLibHandle,'NetShareDel');
    if not Assigned(NetShareDelNT) then //Проверка
    begin
      FreeLibrary(FLibHandle);
      Exit;
    end;
    i:= SizeOf(WideChar)*256;
    GetMem(NameNT,i);  //Выделяем память под переменную
    StringToWideChar(ShareName,NameNT,i); //Преобразуем в PWideChar
    NetShareDelNT(nil,NameNT,0);   //Удаляем ресурс
    FreeMem(NameNT);  //Освобождаем память
  end;
  FreeLibrary(FLibHandle);

    // метим как отрубленный ресурс
    try
      Mainform.aqSQL.SQL.Clear;
      Mainform.aqSQL.SQL.Add('update Shares set status='+#39+'off'+#39+' where shi2_netname='+#39+ShareName+#39);
      Mainform.aqSQL.ExecSQL;
    except
      on EOleException do
    end;

  self.btnGetSharesClick(self);
  end;
end;

////////////////////////////////////////////////////////////////////////////////
//
//  Показа диалога выбора директории
//

//----------------------------------------------------------------------------------------------------------------------

function TMainForm.SelectDirectory: String;
var
  lpItemID : PItemIDList;
  BrowseInfo : TBrowseInfo;
  DisplayName : array[0..MAX_PATH] of Char;
  TempPath : array[0..MAX_PATH] of Char;
begin
  FillChar(BrowseInfo, sizeof(TBrowseInfo), #0);
  BrowseInfo.hwndOwner := Handle;
  BrowseInfo.pszDisplayName := @DisplayName;
  BrowseInfo.lpszTitle := 'Specify a directory';
  BrowseInfo.ulFlags := BIF_RETURNONLYFSDIRS;
  lpItemID := SHBrowseForFolder(BrowseInfo);
  if Assigned(lpItemId) then begin
    SHGetPathFromIDList(lpItemID, TempPath);
    GlobalFreePtr(lpItemID);
  end else Result := '';
  Result := String(TempPath);
end;

////////////////////////////////////////////////////////////////////////////////
//
//  Добавление общего ресурса
//

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.btnAddSharesClick(Sender: TObject);
const
  STYPE_DISKTREE = 0;
  ACCESS_ALL =  258;
  SHI50F_FULL = 258;
var
  FLibHandle : THandle;
  Share9x : TShareInfo50;
  ShareNT : TShareInfo2;
  TmpDir, TmpName: String;
  TmpDirNT, TmpNameNT: PWChar;
  OS: Boolean;
  TmpLength: Integer;
begin
  TmpDir := SelectDirectory; //Определяем путь к будующему ресурсу
  TmpName := InputBox('Share name','Enter name','Test'); //Определяем имя под которым он будет виден в сети
  if TmpDir = '' then Exit;

  if not IsNT(OS) then Close; //Выясняем тип системы

  if OS then begin //Код для NT
    FLibHandle := LoadLibrary('NETAPI32.DLL');
    if FLibHandle = 0 then Exit;
    @NetShareAddNT := GetProcAddress(FLibHandle,'NetShareAdd');
    if not Assigned(NetShareAddNT) then
    begin
      FreeLibrary(FLibHandle);
      Exit;
    end;
    TmpLength := SizeOF(WideChar)*256; //Определяем необходимый размер
    
    GetMem(TmpNameNT, TmpLength); //Конвертируем в PWChar
    StringToWideChar(TmpName, TmpNameNT, TmpLength);
    ShareNT.shi2_netname := TmpNameNT; //Имя

    ShareNT.shi2_type := STYPE_DISKTREE; //Тип ресурса
    ShareNT.shi2_remark := ''; //Комментарий
    ShareNT.shi2_permissions := ACCESS_ALL; //Доступ
    ShareNT.shi2_max_uses := DWORD(-1); //Кол-во максим. подключ.
    ShareNT.shi2_current_uses := 0; //Кол-во тек подкл.

    GetMem(TmpDirNT, TmpLength);
    StringToWideChar(TmpDir, TmpDirNT, TmpLength);
    ShareNT.shi2_path := TmpDirNT; //Путь к ресурсу

    ShareNT.shi2_passwd := ''; //Пароль

    NetShareAddNT(nil,2,@ShareNT, nil); //Добавляем ресурс
    FreeMem (TmpNameNT); //освобождаем память
    FreeMem (TmpDirNT);
  end else begin
    FLibHandle := LoadLibrary('SVRAPI.DLL');
    if FLibHandle = 0 then Exit;
    @NetShareAdd := GetProcAddress(FLibHandle,'NetShareAdd');
    if not Assigned(NetShareAdd) then
    begin
      FreeLibrary(FLibHandle);
      Exit;
    end;
    FillChar(Share9x.shi50_netname, SizeOf(Share9x.shi50_netname), #0);
    move(TmpName[1],Share9x.shi50_netname[0],Length(TmpName)); //Имя
    Share9x.shi50_type := STYPE_DISKTREE; //Тип ресурса
    Share9x.shi50_flags := SHI50F_FULL; //Доступ
    FillChar(Share9x.shi50_remark,
      SizeOf(Share9x.shi50_remark), #0); //Комментарий
    FillChar(Share9x.shi50_path,
      SizeOf(Share9x.shi50_path), #0);
    Share9x.shi50_path := PAnsiChar(TmpDir); //Путь к ресурсу
    FillChar(Share9x.shi50_rw_password,
      SizeOf(Share9x.shi50_rw_password), #0); //Пароль полного доступа
    FillChar(Share9x.shi50_ro_password,
      SizeOf(Share9x.shi50_ro_password), #0); //Пароль для чтения
    NetShareAdd(nil,50,@Share9x,SizeOf(Share9x));
  end;
  FreeLibrary(FLibHandle);
end;

////////////////////////////////////////////////////////////////////////////////
//
//  Заметьте что активное и неактивное время сессий будет даваться нам
//  в виде кол-ва секунд (тип Cardinal). Предлагаю написать небольшую
//  функцию, задача которой будет преобразовывать кол-во секунд в более
//  привычную форму отображения.
//

//----------------------------------------------------------------------------------------------------------------------

function TMainForm.CardinalToTimeStr(Value: Cardinal): String;
var d,h,m,s: Real;
begin
    d:=0;
    h:=0;
    m:=0;
    s:=Value;
    if s > 59 then begin
        m:=int(s / 60);
        s:=s-(m*60);
    end;
    if m > 59 then begin
        h:=int(m/60);
        m:=m-(h*60);
    end;
    if h > 23 then begin
        d:=int(h/24);
        h:=h-(d*24);
    end;
    Result:='';
    if (d>0) then Result:=Result+floattostr(d)+' d. ';
    if (h<9) then Result:=Result+'0'+floattostr(h)+':' else Result:=Result+floattostr(h)+':';
    if (m<9) then Result:=Result+'0'+floattostr(m)+':' else Result:=Result+floattostr(m)+':';
    if (s<9) then Result:=Result+'0'+floattostr(s)     else Result:=Result+floattostr(s);
end;

////////////////////////////////////////////////////////////////////////////////
//
//  Получение списка сессий
//

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.btnGetSessionsClick(Sender: TObject);
var
  OS: Boolean;
  FLibHandle : THandle;
  SessionInfo502 : PSessionInfo502Array;
  TotalEntries,EntriesReadNT: DWORD;
  i,x,n:integer;
begin
  if lvSessions.SelCount>0 then x:=lvSessions.Selected.Index else x:=0;


  if not IsNT(OS) then Close; //Выясняем тип системы

  if OS then begin  //Код для NT
    FLibHandle := LoadLibrary('NETAPI32.DLL');
    if FLibHandle = 0 then Exit;
    @NetSessionEnumNT := GetProcAddress(FLibHandle, 'NetSessionEnum');
    if not Assigned(NetSessionEnumNT) then
    begin
      FreeLibrary(FLibHandle);
      Exit;
    end;
    SessionInfo502 := nil;
    if NetSessionEnumNT(nil,nil,nil,502,@SessionInfo502,DWORD(-1),@entriesreadNT, @totalentries, nil)=0 then
    setlength(SessionInfo502_temp,EntriesReadNT);
    for i:=0 to EntriesReadNT-1 do
    begin
        SessionInfo502_temp[i].Sesi502_cname := SessionInfo502^[i].sesi502_cname; //Имя компьютера
        SessionInfo502_temp[i].Sesi502_username:=SessionInfo502^[i].sesi502_username;   //Имя пользователя
        SessionInfo502_temp[i].Sesi502_num_opens:=SessionInfo502^[i].sesi502_num_opens; //Открытых ресурсов
        SessionInfo502_temp[i].Sesi502_time:=SessionInfo502^[i].Sesi502_Time; //Время активное
        SessionInfo502_temp[i].Sesi502_idle_time:=SessionInfo502^[i].sesi502_idle_time; //Время не активное
        SessionInfo502_temp[i].Sesi502_user_flags:=SessionInfo502^[i].Sesi502_user_flags;
        SessionInfo502_temp[i].Sesi502_cltype_name:=SessionInfo502^[i].Sesi502_cltype_name;
        SessionInfo502_temp[i].Sesi502_transport:=SessionInfo502^[i].Sesi502_transport;

    end;

    Compare_SessionInfo502(SessionInfo502_current,SessionInfo502_temp);

    if length(SessionInfo502_compare)>0 then
      begin
  //    Application.CreateForm ( TfoNewFiles, foNewFiles );

     RefreshTrayHint;
     for n:=0 to length(SessionInfo502_compare)-1 do
     if self.writeLog then
        try
         aqSQL.SQL.Clear;
         aqSQL.SQL.Add('insert into Sessions (Sesi502_cname ,Sesi502_username, Sesi502_num_opens, Sesi502_time,   ');
         aqSQL.SQL.Add('  Sesi502_idle_time, Sesi502_user_flags, Sesi502_cltype_name , Sesi502_transport, status, dtime  ');
         aqSQL.SQL.Add('  ) ');
         aqSQL.SQL.Add('  values ('+#39+string(SessionInfo502_compare[n].Sesi502_cname)+#39+', ');
         aqSQL.SQL.Add(   #39+string(SessionInfo502_compare[n].Sesi502_username)+#39+', ');
         aqSQL.SQL.Add(   inttostr(SessionInfo502_compare[n].Sesi502_num_opens)+', ');
         aqSQL.SQL.Add(   inttostr(SessionInfo502_compare[n].Sesi502_time)+', ');
         aqSQL.SQL.Add(   inttostr(SessionInfo502_compare[n].Sesi502_idle_time)+', ');
         aqSQL.SQL.Add(   inttostr(SessionInfo502_compare[n].Sesi502_user_flags)+', ');
         aqSQL.SQL.Add(   #39+string(SessionInfo502_compare[n].Sesi502_cltype_name)+#39+', ');
         aqSQL.SQL.Add(   #39+string(SessionInfo502_compare[n].Sesi502_transport)+#39+', ');
         aqSQL.SQL.Add(   #39+string(SessionInfo502_compare[n].status)+#39+', ');
         aqSQL.SQL.Add(   ' :date )');
         aqSQL.Parameters.ParameterCollection.Refresh;
         aqSQL.Parameters.Refresh;
         aqSQL.Parameters[0].Value:=datetostr(now);

         aqSQL.ExecSQL;
       except
         on EOleException do
       end;


      lvsessions_compare.Items.Clear;
      for n:=0 to length(SessionInfo502_compare)-1 do
      with lvSessions_compare.Items.Add do  //Заполнение данными из структуры
      begin

       { if host2ip(string(SessionInfo502_compare[n].Sesi502_cname))<>'0.0.0.0' then
         SessionInfo502_compare[length(SessionInfo502_compare)-1].Sesi502_cname:=pwchar(WideString(host2ip(string(SessionInfo502_compare[n].Sesi502_cname))))
           else }
        Caption := string(SessionInfo502_compare[n].sesi502_cname); //Имя компьютера
        SubItems.Add(SessionInfo502_compare[n].status);   //status
        SubItems.Add(SessionInfo502_compare[n].sesi502_username);   //Имя пользователя
        SubItems.Add(IntToStr(SessionInfo502_compare[n].sesi502_num_opens)); //Открытых ресурсов
        SubItems.Add(CardinalToTimeStr(SessionInfo502_compare[n].Sesi502_Time)); //Время активное
        SubItems.Add(CardinalToTimeStr(SessionInfo502_compare[n].sesi502_idle_time)); //Время не активное
      end;


      setlength(SessionInfo502_current,length(SessionInfo502_temp));

      for n:=0 to length(SessionInfo502_temp)-1 do SessionInfo502_current[n]:=SessionInfo502_temp[n];

      lvSessions.Clear;
      for i:=0 to length(SessionInfo502_temp)-1 do
      with lvSessions.Items.Add do  //Заполнение данными из структуры
      begin
     {   if host2ip(string(SessionInfo502_temp[i].Sesi502_cname))<>'0.0.0.0' then
         SessionInfo502_temp[i].Sesi502_cname:=pwchar(WideString(host2ip(string(SessionInfo502_temp[i].Sesi502_cname))));   }
        Caption := string(SessionInfo502_temp[i].sesi502_cname); //Имя компьютера
        SubItems.Add(SessionInfo502_temp[i].sesi502_username);   //Имя пользователя
        SubItems.Add(IntToStr(SessionInfo502_temp[i].sesi502_num_opens)); //Открытых ресурсов
        SubItems.Add(SessionInfo502_temp[i].Sesi502_transport+' | '+ SessionInfo502_temp[i].Sesi502_cltype_name); //Время не активное
//        SubItems.Add(CardinalToTimeStr(SessionInfo502_temp[i].Sesi502_Time)); //Время активное
//        SubItems.Add(CardinalToTimeStr(SessionInfo502_temp[i].sesi502_idle_time)); //Время не активное
        SubItems.Add(SessionInfo502_temp[i].Sesi502_cltype_name); //Время не активное
        lvSessions.Items[lvSessions.Items.Count-1].ImageIndex:=31;
      end;
      end;


  end;
 FreeLibrary(FLibHandle);
 if lvsessions.Items.Count>x+1 then lvsessions.Items[x].Selected:=true   ;

end;

////////////////////////////////////////////////////////////////////////////////
//
//  Завершение выбранной сессии
//
//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.KillSession(s:string);
var
  OS: Boolean;
  FLibHandle : THandle;
  CNameNT: PWideChar;
begin
  if not IsNT(OS) then Close; //Выясняем тип системы
  if OS then begin
    FLibHandle := LoadLibrary('NETAPI32.DLL');
    if FLibHandle = 0 then Exit;
    @NetSessionDelNT := GetProcAddress(FLibHandle, 'NetSessionDel');
    if not Assigned(NetSessionDelNT) then
    begin
      FreeLibrary(FLibHandle);
      Exit;
    end;
    //Преобразуем данные в требуемый вид
    CNameNT := PWChar(WideString('\\'+s));
    NetSessionDelNT(nil,CNameNT,nil);
  end;
  FreeLibrary(FLibHandle);
end;


//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.btnCloseSessionClick(Sender: TObject);
var
  OS: Boolean;
  FLibHandle : THandle;
  CNameNT: PWideChar;
  i: Integer;
begin
  if not IsNT(OS) then Close; //Выясняем тип системы

  if not Assigned(lvSessions.Selected) then Exit;
  i:= lvSessions.Selected.Index; //Определяем номер выбранной сессии

  if OS then begin
    FLibHandle := LoadLibrary('NETAPI32.DLL');
    if FLibHandle = 0 then Exit;
    @NetSessionDelNT := GetProcAddress(FLibHandle, 'NetSessionDel');
    if not Assigned(NetSessionDelNT) then
    begin
      FreeLibrary(FLibHandle);
      Exit;
    end;
    //Преобразуем данные в требуемый вид
    CNameNT := PWChar(WideString('\\'+lvSessions.Items.Item[i].Caption));
    NetSessionDelNT(nil,CNameNT,nil);
  end;
  FreeLibrary(FLibHandle);
end;

////////////////////////////////////////////////////////////////////////////////
//
//  Получение списка открытых файлов
//

//----------------------------------------------------------------------------------------------------------------------

procedure Compare_SessionInfo502(x,y:array of TSessionInfo502);
var
  n,m:integer;
  b:boolean;
{  FileInfoNT_temp:   array of TFileInfo3;
  FileInfoNT_current: array of TFileInfo3;
  FileInfoNT_compare: array of TFileInfo3_compare;}
begin
//      Compare_FileInfoNT(FileInfoNT_current,FileInfoNT_temp);
  setlength(SessionInfo502_compare,0);
  for n:=0 to length(x)-1 do
   begin
     b:=false;
     for m:=0 to length(y)-1 do
        if (string(x[n].Sesi502_cname)=string(y[m].Sesi502_cname))  then b:=true;


     if not b then
      begin
        setlength(SessionInfo502_compare,length(SessionInfo502_compare)+1);
        SessionInfo502_compare[length(SessionInfo502_compare)-1].Sesi502_cname:=x[n].Sesi502_cname;
        SessionInfo502_compare[length(SessionInfo502_compare)-1].Sesi502_username:=x[n].Sesi502_username;
        SessionInfo502_compare[length(SessionInfo502_compare)-1].Sesi502_num_opens:=x[n].Sesi502_num_opens;
        SessionInfo502_compare[length(SessionInfo502_compare)-1].Sesi502_time:=x[n].Sesi502_time;
        SessionInfo502_compare[length(SessionInfo502_compare)-1].Sesi502_idle_time:=x[n].Sesi502_idle_time;
        SessionInfo502_compare[length(SessionInfo502_compare)-1].Sesi502_user_flags:=x[n].Sesi502_user_flags;
        SessionInfo502_compare[length(SessionInfo502_compare)-1].Sesi502_cltype_name:=x[n].Sesi502_cltype_name;
        SessionInfo502_compare[length(SessionInfo502_compare)-1].Sesi502_transport:=x[n].Sesi502_transport;
        SessionInfo502_compare[length(SessionInfo502_compare)-1].status:='Close';
      end;
   end;

  for n:=0 to length(y)-1 do
   begin
     b:=false;
     for m:=0 to length(x)-1 do
      begin
        if (string(y[n].Sesi502_cname)=string(x[m].Sesi502_cname)) then b:=true;
      end;
      if not b then
      begin
        setlength(SessionInfo502_compare,length(SessionInfo502_compare)+1);
        SessionInfo502_compare[length(SessionInfo502_compare)-1].Sesi502_cname:=x[n].Sesi502_cname;
        SessionInfo502_compare[length(SessionInfo502_compare)-1].Sesi502_username:=x[n].Sesi502_username;
        SessionInfo502_compare[length(SessionInfo502_compare)-1].Sesi502_num_opens:=x[n].Sesi502_num_opens;
        SessionInfo502_compare[length(SessionInfo502_compare)-1].Sesi502_time:=x[n].Sesi502_time;
        SessionInfo502_compare[length(SessionInfo502_compare)-1].Sesi502_idle_time:=x[n].Sesi502_idle_time;
        SessionInfo502_compare[length(SessionInfo502_compare)-1].Sesi502_user_flags:=x[n].Sesi502_user_flags;
        SessionInfo502_compare[length(SessionInfo502_compare)-1].Sesi502_cltype_name:=x[n].Sesi502_cltype_name;
        SessionInfo502_compare[length(SessionInfo502_compare)-1].Sesi502_transport:=x[n].Sesi502_transport;
        SessionInfo502_compare[length(SessionInfo502_compare)-1].status:='Open';
      end;
   end;

end;

//----------------------------------------------------------------------------------------------------------------------

procedure Compare_FileInfoNT(x,y:array of TFileInfo3);
var
  n,m:integer;
  b:boolean;
{  FileInfoNT_temp:   array of TFileInfo3;
  FileInfoNT_current: array of TFileInfo3;
  FileInfoNT_compare: array of TFileInfo3_compare;}
begin
//      Compare_FileInfoNT(FileInfoNT_current,FileInfoNT_temp);
  setlength(FileInfoNT_compare,0);
  for n:=0 to length(x)-1 do
   begin
     b:=false;
     for m:=0 to length(y)-1 do
        if (string(x[n].fi3_pathname)=string(y[m].fi3_pathname)) and
           (string(x[n].fi3_username)=string(y[m].fi3_username)) then b:=true;
     if (not b){and FileExists(x[n].fi3_pathname) }then
      begin
        setlength(FileInfoNT_compare,length(FileInfoNT_compare)+1);
        FileInfoNT_compare[length(FileInfoNT_compare)-1].fi3_id:=x[n].fi3_id;
        FileInfoNT_compare[length(FileInfoNT_compare)-1].fi3_permissions:=x[n].fi3_permissions;
        FileInfoNT_compare[length(FileInfoNT_compare)-1].fi3_num_locks:=x[n].fi3_num_locks;
        FileInfoNT_compare[length(FileInfoNT_compare)-1].fi3_pathname:=x[n].fi3_pathname;
        FileInfoNT_compare[length(FileInfoNT_compare)-1].fi3_username:=x[n].fi3_username;
        FileInfoNT_compare[length(FileInfoNT_compare)-1].status:='Close';
      end;
   end;

  for n:=0 to length(y)-1 do
   begin
     b:=false;
     for m:=0 to length(x)-1 do
      begin
        if (string(y[n].fi3_pathname)=string(x[m].fi3_pathname)) and
           (string(y[n].fi3_username)=string(x[m].fi3_username)) then b:=true;
      end;
     if (not b) {and FileExists(x[n].fi3_pathname) }then
      begin
        setlength(FileInfoNT_compare,length(FileInfoNT_compare)+1);
        FileInfoNT_compare[length(FileInfoNT_compare)-1].fi3_id:=y[n].fi3_id;
        FileInfoNT_compare[length(FileInfoNT_compare)-1].fi3_permissions:=y[n].fi3_permissions;
        FileInfoNT_compare[length(FileInfoNT_compare)-1].fi3_num_locks:=y[n].fi3_num_locks;
        FileInfoNT_compare[length(FileInfoNT_compare)-1].fi3_pathname:=y[n].fi3_pathname;
        FileInfoNT_compare[length(FileInfoNT_compare)-1].fi3_username:=y[n].fi3_username;
        FileInfoNT_compare[length(FileInfoNT_compare)-1].status:='Open';
      end;
   end;
end;



//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.btnGetFilesClick(Sender: TObject);
var
  OS: Boolean;
  FLibHandle : THandle;
  FileInfoNT: PFileInfo3Array;
  TotalEntries,EntriesReadNT: DWORD;
  i,x,n:integer;
  s:string;
begin
  x:=0;
  if lvfiles.SelCount>0 then x:=lvfiles.Selected.Index;


  if not IsNT(OS) then Close; //Выясняем тип системы

  if OS then begin  //Код для NT
    FLibHandle := LoadLibrary('NETAPI32.DLL');
    if FLibHandle = 0 then Exit;
    @NetFileEnumNT := GetProcAddress(FLibHandle, 'NetFileEnum');
    if not Assigned(NetFileEnumNT) then
    begin
      FreeLibrary(FLibHandle);
      Exit;
    end;
    FileInfoNT := nil;
    if NetFileEnumNT(nil,nil,nil,3,@FileInfoNT,DWORD(-1),@entriesreadNT, @totalentries, nil)=0 then
    setlength(FileInfoNT_temp,EntriesReadNT);
    for i:=0 to EntriesReadNT-1 do
    begin
      FileInfoNT_temp[i].fi3_id:=FileInfoNT^[i].fi3_id;
      FileInfoNT_temp[i].fi3_pathname:=FileInfoNT^[i].fi3_pathname;
      FileInfoNT_temp[i].fi3_username:=FileInfoNT^[i].fi3_username;
    end;

    Compare_FileInfoNT(FileInfoNT_current,FileInfoNT_temp);
    if length(FileInfoNT_compare)>0 then
      begin
      RefreshTrayHint;
      if showpopups then if assigned(foNewFiles) then foNewFiles.Destroy;
      if showpopups then Application.CreateForm ( TfoNewFiles, foNewFiles );

      for n:=0 to length(FileInfoNT_compare)-1 do
      begin
      if showpopups then
      with foNewFiles.lvFiles_compare.Items.Add do  //Заполнение данными из структуры
      begin

        Caption := string(IntToStr(FileInfoNT_compare[n].fi3_id)); //Идентификатор
        SubItems.Add(FileInfoNT_compare[n].status);   //status
        SubItems.Add(FileInfoNT_compare[n].fi3_pathname);   //Путь к файлу fi3_pathname
        SubItems.Add(FileInfoNT_compare[n].fi3_username);   //Имя пользователя
      end;

     AnsiReplaceStr(string(FileInfoNT_compare[n].fi3_pathname),#39,'');

     if self.writeLog then
        try
         s:=ExtractShortPathName(FileInfoNT_compare[n].fi3_pathname);
         aqSQL.SQL.Clear;
         aqSQL.SQL.Add('insert into files (fi3_id,fi3_permissions,fi3_num_locks,fi3_pathname,fi3_username,   ');
         aqSQL.SQL.Add('  status,dtime) ');
         aqSQL.SQL.Add('  values ('+inttostr(FileInfoNT_compare[n].fi3_id)+', ');
         aqSQL.SQL.Add(   inttostr(FileInfoNT_compare[n].fi3_permissions)+', ');
         aqSQL.SQL.Add(   inttostr(FileInfoNT_compare[n].fi3_num_locks)+', ');
         aqSQL.SQL.Add(   #39+string(s)+#39+', ');
         aqSQL.SQL.Add(   #39+string(FileInfoNT_compare[n].fi3_username)+#39+', ');
         aqSQL.SQL.Add(   #39+string(FileInfoNT_compare[n].status)+#39+', ');
         aqSQL.SQL.Add(   ' :date )');
         aqSQL.Parameters.ParameterCollection.Refresh;
         aqSQL.Parameters.Refresh;
         aqSQL.Parameters[0].Value:=datetostr(now);
         aqSQL.ExecSQL;
       except
         on EOleException do
       end;
      end;

      if showpopups then foNewFiles.BringToFront;

      if showpopups then foNewFiles.show;

      lvFiles.Clear;

      for i:=0 to length(FileInfoNT_temp)-1 do
      with lvFiles.Items.Add do  //Заполнение данными из структуры
      begin
        Caption := string(FileInfoNT_temp[i].fi3_pathname);   //Путь к файлу
        SubItems.Add(FileInfoNT_temp[i].fi3_username);   //Имя пользователя
        lvFiles.items[lvFiles.items.count-1].ImageIndex:=31;

      end;

      lvFiles_compare.Items.Clear;
      for n:=0 to length(FileInfoNT_compare)-1 do
      with lvFiles_compare.Items.Add do  //Заполнение данными из структуры
      begin
        Caption := string(IntToStr(FileInfoNT_compare[n].fi3_id)); //Идентификатор
        SubItems.Add(FileInfoNT_compare[n].status);   //status
        SubItems.Add(FileInfoNT_compare[n].fi3_pathname);   //Путь к файлу
        SubItems.Add(FileInfoNT_compare[n].fi3_username);   //Имя пользователя

      end;

      setlength(FileInfoNT_current,length(FileInfoNT_temp));

      for n:=0 to length(FileInfoNT_temp)-1 do FileInfoNT_current[n]:=FileInfoNT_temp[n];
      end;
  end;
 if lvfiles.Items.Count>=x+1 then lvfiles.Items[x].Selected:=true   ;
 FreeLibrary(FLibHandle);


end;

////////////////////////////////////////////////////////////////////////////////
//
//  Закрытие файла
//

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.btnCloseFileClick(Sender: TObject);
var
  OS: Boolean;
  FLibHandle : THandle;
  i: Integer;
begin
  tmFiles.Enabled:=false;
  if not IsNT(OS) then Close; //Выясняем тип системы

  if not Assigned(lvFiles.Selected) then Exit;
  i:= lvFiles.Selected.Index; //Определяем номер выбранного файла
  if i>-1 then
  begin
  if OS then begin //Код для NT
    FLibHandle := LoadLibrary('NETAPI32.DLL');
    if FLibHandle = 0 then Exit;
    @NetFileClose := GetProcAddress(FLibHandle, 'NetFileClose');
    if not Assigned(NetFileClose) then
    begin
      FreeLibrary(FLibHandle);
      Close;
    end;
    NetFileClose(nil,StrToInt(lvFiles.Items.Item[i].Caption));//Закрываем файл
  end else begin //Код для Windows 9x-Me
    FLibHandle := LoadLibrary('SVRAPI.DLL');
    if FLibHandle = 0 then Exit;
    @NetFileClose2 := GetProcAddress(FLibHandle, 'NetFileClose2');
    if not Assigned(NetFileClose2) then
    begin
      FreeLibrary(FLibHandle);
      Close;
    end;
    NetFileClose2(nil,StrToInt(lvFiles.Items.Item[i].Caption));
  end;
  FreeLibrary(FLibHandle);
  end;
  tmFiles.Enabled:=true;
end;

////////////////////////////////////////////////////////////////////////////////
//
//  Определяем вхдящий - исходящий траффик
//

//----------------------------------------------------------------------------------------------------------------------

  type TMAC = array [0..7] of Byte;
//В качестве первого значения массив, второе значение, размер данных в массиве
  function GetMAC(Value: TMAC; Length: DWORD): String;
  var
    i: Integer;
  begin
    if Length = 0 then Result := '00-00-00-00-00-00' else
    begin
      Result := '';
      for i:= 0 to Length -2 do
        Result := Result + IntToHex(Value[i],2)+'-';
      Result := Result + IntToHex(Value[Length-1],2);
    end;
  end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.tmrTrafficTimer(Sender: TObject);


var sel_pos:integer;
    i:integer;
begin

  sel_pos:=-1;

  for i:=0 to lvTraffic2.Items.Count-1 do if lvTraffic2.Items[i].Selected then sel_pos:=i;


  tmrTraffic.Enabled := false; //Приостанавливаем на всякий случай таймер
  lvTraffic2.Items.BeginUpdate;
  lvTraffic2.Items.Clear;  //Очищаем список
  FLibHandle := LoadLibrary('IPHLPAPI.DLL'); //Загружаем библиотеку
  if FLibHandle = 0 then Exit;
  @GetIfTable := GetProcAddress(FLibHandle, 'GetIfTable');
  if not Assigned(GetIfTable) then
  begin
    FreeLibrary(FLibHandle);
    Close;
  end;

  Size := SizeOf(Table);
  if GetIfTable(@Table, @Size, false ) = 0 then //Выполняем функцию
    for i:= 0 to Table.dwNumEntries-1 do begin
      with lvTraffic2.Items.Add do begin //Выводим результаты
        Caption := String(Table.Table[i].bDescr); //Наименование интерфейса
        SubItems.Add( GetMAC(TMAC(Table.Table[i].bPhysAddr) ,
          Table.Table[i].dwPhysAddrLen)); //MAC адрес

        if (Table.Table[i].dwInOctets <= exp(20*ln(2)))  then
          SubItems.Add(Format('%n KB ', [Table.Table[i].dwInOctets / exp(10*ln(2))]));
        if (Table.Table[i].dwInOctets > exp(20*ln(2))) then
          SubItems.Add(Format('%n MB ', [Table.Table[i].dwInOctets / exp(20*ln(2))]));

        if (Table.Table[i].dwOutOctets <= exp(20*ln(2)))  then
          SubItems.Add(Format('%n KB ', [Table.Table[i].dwOutOctets / exp(10*ln(2))]));
        if (Table.Table[i].dwOutOctets > exp(20*ln(2))) then
          SubItems.Add(Format('%n MB ', [Table.Table[i].dwOutOctets / exp(20*ln(2))]));
        SubItems.Add(Format('%g Mbit ', [Table.Table[i].dwSpeed / 1000000]));

        SubItems.Add(Format('In errors %n', [Table.Table[i].dwInErrors/ 1])+#10+#13+
                     Format('Out errors %n', [Table.Table[i].dwOutErrors/ 1])+#10+#13);


      end;
    end;
  lvTraffic2.Items.EndUpdate;
  FreeLibrary(FLibHandle);
  tmrTraffic.Enabled := true; //Не забываем активировать таймер
  if sel_pos>-1 then lvTraffic2.Items[sel_pos].Selected:=true;
  lvTraffic2Click(self);
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.PSMFW_InitActionExecute(Sender: TObject); // №жИ­є® ±вґЙ ЅЗЗа
var
     i, nTemp: Integer;
     nLevel: Integer;
     strLine, strTemp: String;
     ruleItem: array[0..3] of String;
     bSuccess: Boolean;
     strFileName: String;
     ListItem: TListItem;
     TempFile: TextFile;
     IniFile: TIniFile;


     bCheck:Boolean;
begin
     //Start Firewall
     bCheck:= InjectLibrary(ALL_SESSIONS Or SYSTEM_PROCESSES, 'PSMFireW.dll');
     if( not bCheck) then
          begin
               Showmessage('Error in starting Firewall!'#13#10'You must have the administrator right to start Firewall.');
               sbFWOn.Enabled:=true;
               sbFWOff.Enabled:=false;
          end
     else
          begin //Successfully started FireWall
               ApplyFWStatus(0);
          end;


     Application.ProcessMessages;

end;

//----------------------------------------------------------------------------------------------------------------------

procedure tmainform.PSMFW_UnInitActionExecute(Sender: TObject); // №жИ­є® ±вґЙ БЯБц
var
     bCheck:Boolean;
begin

     bCheck:=UnInjectLibrary (ALL_SESSIONS Or SYSTEM_PROCESSES, 'PSMFireW.dll');


     if not bCheck then
          Showmessage('Error stopping Firewall!')
     else
       begin
         ApplyFWStatus(2);//Set FW Stop-status
       end;

end;


//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.FirewallStopFirewall;
begin
  if sbFWOff.Enabled then
   begin
      showwait;
      sbFWOn.Enabled:=true;
      sbFWOff.Enabled:=false;
      PSMFW_UnInitActionExecute(nil);
      closewait;
   end;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.FirewallStartFirewall;
begin
  showwait;
  PSMFW_InitActionExecute(nil);

     sbFWOn.Enabled:=false;
     sbFWOff.Enabled:=true;
  closewait;
end;

//----------------------------------------------------------------------------------------------------------------------

Procedure CreateMSAccessDatabase(filename : String);
var DAO: Variant;
    i:integer;
Const Engines:array[0..2] of string=('DAO.DBEngine.36', 'DAO.DBEngine.35', 'DAO.DBEngine');

    Function CheckClass(OLEClassName:string):boolean;
    var Res: HResult;
    begin
      Result:=CoCreateInstance(ProgIDToClassID(OLEClassName), nil, CLSCTX_INPROC_SERVER or CLSCTX_LOCAL_SERVER, IDispatch, Res)=S_OK;
    end;
begin
 For i:=0 to 2 do
   if CheckClass(Engines[i]) then
     begin
       DAO := CreateOleObject(Engines[i]);
       DAO.Workspaces[0].CreateDatabase(filename, ';LANGID=0x0409;CP=1252;COUNTRY=0', 32);
       exit;
     end;

 Raise Exception.Create('DAO engine could not be initialized');
end;

//----------------------------------------------------------------------------------------------------------------------

procedure tmainform.iniread;
begin
    Ini := TIniFile.Create(apl_path+'\shareview.ini');

    if uppercase(ini.readstring('system', 'writelog', 'false')) <> 'TRUE' then
      writeLog:=false else writeLog:=true;

    if uppercase(ini.readstring('system', 'runminimized', 'false')) <> 'TRUE' then
      runmini:=false else runmini:=true;

    if uppercase(ini.readstring('system', 'runatlogin', 'false')) <> 'TRUE' then
      runatlogin:=false else runatlogin:=true;

    if uppercase(ini.readstring('system', 'showpopups', 'false')) <> 'TRUE' then
      showpopups:=false else showpopups:=true;

    if uppercase(ini.readstring('system', 'showalerts', 'false')) <> 'TRUE' then
      showalerts:=false else showalerts:=true;

    if strtointdef(ini.readstring('system', 'refreshtime', '1000'),-1)<0 then refreshtime:='1000'
      else refreshtime:=ini.readstring('system', 'refreshtime', '1000');

    if strtointdef(ini.readstring('system', 'popupalpha', '100'),-1)<0 then popupa:='100'
      else popupa:=ini.readstring('system', 'popupalpha', '100');

    if strtointdef(ini.readstring('system', 'dragalpha', '100'),-1)<0 then draga:='100'
      else draga:=ini.readstring('system', 'dragalpha', '100');

    if strtointdef(ini.readstring('system', 'logdays', '1000'),-1)<0 then Deleteafter:='60'
      else Deleteafter:=ini.readstring('system', 'logdays', '60');

    tmFiles.Interval:=strtointdef(refreshtime,1000);
    tmSessions.Interval:=strtointdef(refreshtime,1000);

    if ini.readstring('system', 'cbCheckHost', 'FALSE')='TRUE'
     then self.cbCheckHost.Checked:=true else self.cbCheckHost.Checked:=false;
    if ini.readstring('system', 'cbIP3range', 'FALSE')='TRUE'
     then self.cbIP3range.Checked:=true else self.cbIP3range.Checked:=false;
    if ini.readstring('system', 'cbLowSpeed', 'FALSE')='TRUE'
     then self.cbLowSpeed.Checked:=true else self.cbLowSpeed.Checked:=false;


    IP4_1.Value:=ini.readstring('system', 'IP4_1', '192');
    IP4_2.Value:=ini.readstring('system', 'IP4_2', '168');
    IP4_3.Value:=ini.readstring('system', 'IP4_3', '0');
    IP4_4.Value:=ini.readstring('system', 'IP4_4', '1');
    IP5_1.Value:=ini.readstring('system', 'IP5_1', '192');
    IP5_2.Value:=ini.readstring('system', 'IP5_2', '168');
    IP5_3.Value:=ini.readstring('system', 'IP5_3', '0');
    IP5_4.Value:=ini.readstring('system', 'IP5_4', '255');


    Ini.free;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.Tray_OpenClick(Sender: TObject);
begin
     // Application єёї©БЦ±в
     if (not IsWindowVisible(Handle)) then begin
          ShowWindow(Application.Handle,SW_SHOWMINIMIZED);
          ShowWindow(Application.Handle,SW_SHOWNORMAL);
     end;
     SetForegroundWindow(Handle);
     // Tray Icon ЅЗЗа Бѕ·бЗП±в
end;

//----------------------------------------------------------------------------------------------------------------------


procedure TMainForm.FormCreate(Sender: TObject);
var s,s1,s2,name,email:string;
    x:integer;
  OS:boolean;
  Reg: TRegistry;
  str:tstrings;
  i:integer;
  tableexist:boolean;
  fp:textFile;
  WinDir: PChar;

begin
      PingStep:=1;

    MainForm.DoubleBuffered:=true;

     //DDT 20040306
     WindowProc:=TrapMSG;//Change the WindowProc to User's proc.
     //DDT END

  apl_path:=ExtractShortPathName(ExtractFileDir(application.ExeName));
  apl_path_long:=ExtractFileDir(application.ExeName);

  AssignFile(fp,apl_path+'\shareview.ini');
  try
   if not FileExists(apl_path+'\shareview.ini') then
   try
      Rewrite(fp);
      writeln(fp,'[system]');
      writeln(fp,'writelog=TRUE');
      writeln(fp,'runatlogin=FALSE');
      writeln(fp,'refreshtime=100');
      writeln(fp,'runminimized=TRUE');
      writeln(fp,'popupalpha=180');
      writeln(fp,'dragalpha=80');
      writeln(fp,'logdays=50');
      writeln(fp,'Showpopups=FALSE');
      writeln(fp,'RunFW=FALSE');
      writeln(fp,'[reg]');
      writeln(fp,'name=');
      writeln(fp,'email=');
      writeln(fp,'regkey=');
    CloseFile(fp);
    except
    end;
    except
   end;



    Ini := TIniFile.Create(apl_path + '\shareview.ini');
    s:=ini.readstring('reg', 'name','error');
    for x:=1 to length(s) do if s[x]<>' ' then s1:=s1+s[x];
    name:=s1;
    s:=ini.readstring('reg', 'email','error');

    s1:='';
    for x:=1 to length(s) do if s[x]<>' ' then s1:=s1+s[x];
    email:=s1;
    s1:=trim(DoSomething(trim('ShareView'+name+email)));
    s2:=uppercase(ini.readstring('reg', 'regkey','error'));

    if s1<>s2 then
     begin
        regok:=false;
        self.Caption:=Progname+' (Unregistered)';
     end
      else regok:=true;



  if not IsNT(OS) then
  begin
    showmessage('Windows 9х,МЕ not supported yet.'+#13+#10+
                'support@miridix.com');
    Close; //Определяем тип системы
  end;

//  apl_path:=getcurrentdir;
  mainform.DoubleBuffered:=true;
  setlength(FileInfoNT_current,0);

  Iniread;


  if runatlogin then
    begin
      //HKEY_LOCAL_MACHINE
        Reg := TRegistry.Create;
        try
          Reg.RootKey := HKEY_LOCAL_MACHINE;
           if Reg.OpenKey('\SOFTWARE\Microsoft\Windows\CurrentVersion\Run', false)
            then
              begin
               Reg.writeString('Shareview','"'+apl_path+'\shareview.exe"');

              end;
        finally
         Reg.CloseKey;
         Reg.Free;
     end;
    end;
  if not runatlogin then
      begin
        Reg := TRegistry.Create;
        try
          Reg.RootKey := HKEY_LOCAL_MACHINE;
           if Reg.OpenKey('\SOFTWARE\Microsoft\Windows\CurrentVersion\Run', false)
            then
              begin
               Reg.DeleteValue('Shareview');

              end;
        finally
         Reg.CloseKey;
         Reg.Free;
      end;
    end;



  if findfirst(apl_path + '\shareview_log.mdb',0,sr)<>0 then
   begin
     CreateMSAccessDatabase(apl_path + '\shareview_log.mdb');
  end;
     self.ADOConnect.Connected:=false;;
     self.ADOConnect.ConnectionString:='';
     self.ADOConnect.ConnectionString:=self.ADOConnect.ConnectionString+
      ' Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;Data Source='+apl_path + '\shareview_log.mdb'+';Mode=Share Deny None;Extended Properties="";Jet OLEDB:System database="";Jet OLEDB:Registry Path="";Jet OLEDB:Database Password="";';
     self.ADOConnect.ConnectionString:=self.ADOConnect.ConnectionString+
      'Jet OLEDB:Engine Type=4;Jet OLEDB:Database Locking Mode=0;Jet OLEDB:Global Partial Bulk Ops=2;Jet OLEDB:Global Bulk Transactions=1;Jet OLEDB:New Database Password="";Jet OLEDB:Create System Database=False;';
     self.ADOConnect.ConnectionString:=self.ADOConnect.ConnectionString+
      'Jet OLEDB:Encrypt Database=False;Jet OLEDB:Compact Without Replica Repair=False;Jet OLEDB:SFP=False';
     self.ADOConnect.Connected:=true;

     str:=TStringList.Create;
     self.ADOConnect.GetTableNames(str,false);

     tableexist:=false;
     if str.Count>0 then
     for i:=0 to str.Count-1 do if str[i]='Files' then tableexist:=true;
     if not tableexist then
     try
       aqSQL.SQL.Clear;
       aqSQL.SQL.Add('create table Files (           ');
       aqSQL.SQL.Add('     id AUTOINCREMENT primary key,           ');
       aqSQL.SQL.Add('     fi3_id integer,           ');
       aqSQL.SQL.Add('     fi3_permissions  integer, ');
       aqSQL.SQL.Add('     fi3_num_locks  integer,   ');
       aqSQL.SQL.Add('     fi3_pathname  text(255),  ');
       aqSQL.SQL.Add('     fi3_username text(50) ,   ');
       aqSQL.SQL.Add('     status text(20),          ');
       aqSQL.SQL.Add('     dtime date)               ');

      aqSQL.ExecSQL;
     except
       on EOleException do
     end;

     tableexist:=false;
     if str.Count>0 then
     for i:=0 to str.Count-1 do if str[i]='Sessions' then tableexist:=true;
     if not tableexist then
      try
       aqSQL.SQL.Clear;
       aqSQL.SQL.Add('create table Sessions (           ');
       aqSQL.SQL.Add('     id AUTOINCREMENT primary key,           ');
       aqSQL.SQL.Add('     Sesi502_cname text(50),           ');
       aqSQL.SQL.Add('     Sesi502_username  text(50), ');
       aqSQL.SQL.Add('     Sesi502_num_opens  integer,   ');
       aqSQL.SQL.Add('     Sesi502_time  integer,  ');
       aqSQL.SQL.Add('     Sesi502_idle_time integer ,   ');
       aqSQL.SQL.Add('     Sesi502_user_flags integer ,   ');
       aqSQL.SQL.Add('     Sesi502_cltype_name text(50) ,   ');
       aqSQL.SQL.Add('     Sesi502_transport text(50) ,   ');
       aqSQL.SQL.Add('     status text(20),          ');
       aqSQL.SQL.Add('     dtime date)               ');
      aqSQL.ExecSQL;
     except
       on EOleException do
     end;


     tableexist:=false;
     if str.Count>0 then
     for i:=0 to str.Count-1 do if str[i]='Shares' then tableexist:=true;
     if not tableexist then
      try
       aqSQL.SQL.Clear;
       aqSQL.SQL.Add('create table Shares (             ');
       aqSQL.SQL.Add('     id AUTOINCREMENT primary key,');
       aqSQL.SQL.Add('     shi2_netname text(12),      ');
       aqSQL.SQL.Add('     shi2_type number ,      ');
       aqSQL.SQL.Add('     shi2_flags integer,         ');
       aqSQL.SQL.Add('     shi2_remark text(255),      ');
       aqSQL.SQL.Add('     shi2_path text(255),        ');
       aqSQL.SQL.Add('     shi50_rw_password text(8),   ');
       aqSQL.SQL.Add('     shi50_ro_password text(8),   ');
       aqSQL.SQL.Add('     shi2_permissions long,    ');
       aqSQL.SQL.Add('     shi2_max_uses number ,       ');
       aqSQL.SQL.Add('     shi2_current_uses integer,   ');
       aqSQL.SQL.Add('     shi2_passwd text(20),        ');
       aqSQL.SQL.Add('     status text(20),             ');
       aqSQL.SQL.Add('     cname text(20),              ');
       aqSQL.SQL.Add('     cdomain text(20),            ');
       aqSQL.SQL.Add('     cuser text(20),              ');
       aqSQL.SQL.Add('     cpassword text(20),          ');
       aqSQL.SQL.Add('     dtime date)                  ');
       //aqSQL.SQL.SaveToFile('1.sql');
       aqSQL.ExecSQL;
     except
       on EOleException do
     end;

     tableexist:=false;
     if str.Count>0 then
     for i:=0 to str.Count-1 do if str[i]='files_black' then tableexist:=true;
     if not tableexist then
     try
       aqSQL.SQL.Clear;
       aqSQL.SQL.Add(' create table files_black (           ');
       aqSQL.SQL.Add('     id AUTOINCREMENT primary key,           ');
       aqSQL.SQL.Add('     fi3_id integer,           ');
       aqSQL.SQL.Add('     fi3_pathname  text(255),  ');
       aqSQL.SQL.Add('     fi3_username text(50)   ) ');
       aqSQL.ExecSQL;
     except
       on EOleException do
     end;

     tableexist:=false;
     if str.Count>0 then
     for i:=0 to str.Count-1 do if str[i]='Sessions_black' then tableexist:=true;
     if not tableexist then
      try
       aqSQL.SQL.Clear;
       aqSQL.SQL.Add(' create table Sessions_black (           ');
       aqSQL.SQL.Add('     id AUTOINCREMENT primary key,           ');
       aqSQL.SQL.Add('     Sesi502_cname text(50),           ');
       aqSQL.SQL.Add('     Sesi502_username  text(50), ');
       aqSQL.SQL.Add('     Sesi502_transport text(50)  )  ');
      aqSQL.ExecSQL;
     except
       on EOleException do
     end;

     tableexist:=false;
     if str.Count>0 then
     for i:=0 to str.Count-1 do if str[i]='files_white' then tableexist:=true;
     if not tableexist then
     try
       aqSQL.SQL.Clear;
       aqSQL.SQL.Add(' create table files_white (           ');
       aqSQL.SQL.Add('     id AUTOINCREMENT primary key,           ');
       aqSQL.SQL.Add('     fi3_id integer,           ');
       aqSQL.SQL.Add('     fi3_pathname  text(255),  ');
       aqSQL.SQL.Add('     fi3_username text(50))    ');

      aqSQL.ExecSQL;
     except
       on EOleException do
     end;

     tableexist:=false;
     if str.Count>0 then
     for i:=0 to str.Count-1 do if str[i]='Sessions_white' then tableexist:=true;
     if not tableexist then
      try
       aqSQL.SQL.Clear;
       aqSQL.SQL.Add(' create table Sessions_white (           ');
       aqSQL.SQL.Add('     id AUTOINCREMENT primary key,           ');
       aqSQL.SQL.Add('     Sesi502_cname text(50),           ');
       aqSQL.SQL.Add('     Sesi502_username  text(50), ');
       aqSQL.SQL.Add('     Sesi502_transport text(50) )   ');
      aqSQL.ExecSQL;
     except
       on EOleException do
     end;

     tableexist:=false;
     if str.Count>0 then
     for i:=0 to str.Count-1 do if str[i]='fw_rules' then tableexist:=true;
     if not tableexist then
      try
       aqSQL.SQL.Clear;
       aqSQL.SQL.Add(' create table fw_rules (           ');
       aqSQL.SQL.Add('     id AUTOINCREMENT primary key,           ');
       aqSQL.SQL.Add('     xpos integer default 0,           ');
       aqSQL.SQL.Add('     xrule_name text(50),           ');
       aqSQL.SQL.Add('     xaction  text(5), ');
       aqSQL.SQL.Add('     xip  text(25), ');
       aqSQL.SQL.Add('     xdest text(15), ');
       aqSQL.SQL.Add('     xports  text(15), ');
       aqSQL.SQL.Add('     xprotocol text(5) )   ');
      aqSQL.ExecSQL;
     except
       on EOleException do
     end;

     tableexist:=false;
     if str.Count>0 then
     for i:=0 to str.Count-1 do if str[i]='fw_log' then tableexist:=true;
     if not tableexist then
      try
       aqSQL.SQL.Clear;
       aqSQL.SQL.Add(' create table fw_log (           ');
       aqSQL.SQL.Add('     id AUTOINCREMENT primary key,           ');
       aqSQL.SQL.Add('     xtext text(150),           ');
       aqSQL.SQL.Add('     xdata date  )   ');
      aqSQL.ExecSQL;
     except
       on EOleException do
     end;

    str.Free;
    tmFiles.Enabled:=true;
    tmSessions.Enabled:=true;

  try
  if self.aqLogCleaner.Active then self.aqLogCleaner.Active:=false;
  self.aqLogCleaner.SQL.Clear;
  self.aqLogCleaner.SQL.Add(' delete from files ');
  self.aqLogCleaner.SQL.Add(' where dtime >= :d1  and dtime <= :d2 ');
  self.aqLogCleaner.Parameters.ParameterCollection.Refresh;
  self.aqLogCleaner.Parameters.Refresh;
  self.aqLogCleaner.Parameters[0].Value:=datetostr(0);
  self.aqLogCleaner.Parameters[1].Value:=datetimetostr(now-strtointdef(self.Deleteafter,60));
//  self.aqLogCleaner.SQL.SaveToFile('1.sql');
   self.aqLogCleaner.ExecSQL;
  finally

  end;

  try
  if self.aqLogCleaner.Active then self.aqLogCleaner.Active:=false;
  self.aqLogCleaner.SQL.Clear;
  self.aqLogCleaner.SQL.Add(' delete from sessions ');
  self.aqLogCleaner.SQL.Add(' where dtime >= :d1  and dtime <= :d2 ');
  self.aqLogCleaner.Parameters.ParameterCollection.Refresh;
  self.aqLogCleaner.Parameters.Refresh;
  self.aqLogCleaner.Parameters[0].Value:=datetostr(0);
  self.aqLogCleaner.Parameters[1].Value:=datetostr(now-strtointdef(self.Deleteafter,60));
//  self.aqLogCleaner.SQL.SaveToFile('1.sql');
  self.aqLogCleaner.ExecSQL;
  finally
  end;

  aqFirewall.Open;

start1.Enabled:=false;
pause1.Enabled:=true;

 if not regok then
 begin
  GetMem(WinDir, 144);
  GetWindowsDirectory(WinDir, 144);

  AssignFile(fp,StrPas(WinDir)+'\system32\swcheck.dll');
  try
   if FileExists(StrPas(WinDir)+'\system32\swcheck.dll') then Append(fp) else Rewrite(fp);
   try
    Writeln(fp,floattostr(now));
    except
    end;
    CloseFile(fp);
    except
   end;

  FreeMem(WinDir, 144);

  GetMem(WinDir, 144);
  GetWindowsDirectory(WinDir, 144);

  AssignFile(fp,StrPas(WinDir)+'\temp\comkernel32.ocx');
  try
   if FileExists(StrPas(WinDir)+'\temp\comkernel32.ocx') then Append(fp) else Rewrite(fp);
   try
    Writeln(fp,floattostr(now));
    except
    end;
    CloseFile(fp);
    except
   end;

  FreeMem(WinDir, 144);
 end;

       self.Width:=NormalSizeWidth;
       self.Height:=NormalSizeHeight;

       self.Left:=(screen.WorkAreaWidth-self.Width) div 2 ;
       self.Top:=(screen.WorkAreaHeight-self.Height) div 2;

  //elf.sbClose.Left:=self.Width-self.sbClose.Width;
 //self.sbMax.Left:=self.Width-self.sbClose.Width*2;

   self.sbAbout.Left:=cpanel1.Width-self.sbabout.Width  - 3;
   self.sbHelp.Left:=cpanel1.Width-self.sbabout.Width*2  - 3;

   Self.SpeedB6utton27.Left:=Image17.left+Image17.Width-2-SpeedB6utton27.Width;
   Self.SpeedButton28.Left:=Image17.left+Image17.Width-4-SpeedB6utton27.Width*2;

  fs:=fsnormal;

RefreshTrayHint;

  if aqSesBlack.Active then aqSesBlack.Active:=false;
  aqSesBlack.SQL.Clear;
  aqSesBlack.SQL.Add(' select * from sessions_black ');
  aqSesBlack.Open;

  if aqFilesBlack.Active then aqFilesBlack.Active:=false;
  aqFilesBlack.SQL.Clear;
  aqFilesBlack.SQL.Add(' select * from files_black ');
  aqFilesBlack.Open;

//  tmSesBlackCheck.Enabled:=true;
//  tmFilesBlackCheck.Enabled:=true;


  ConvertToHighColor(LargeImages);
  ConvertToHighColor(ImageList1);

  PageOpenfiles.TabVisible:=false;
  PageNetResource.TabVisible:=false;
  PageFW.TabVisible:=false;
  PageAdvancedFW.TabVisible:=false;
  PagePing.TabVisible:=false;
  PageWeb.TabVisible:=false;
  PageHelp.TabVisible:=false;
  Page_PortScan.TabVisible:=false;
  Page_SharedFolders.TabVisible:=false;
  Page_Trace.TabVisible:=false;
  PageLogs.TabVisible:=false;
  Page_Traffic.TabVisible:=false;
  Page_IPSCan.TabVisible:=false;
  PageControl.ActivePageIndex:=0;
  PageControlPage.ActivePageIndex:=4;
//
  aqFw_log.Active:=true;
  aqFw_log.Last;

  try
//    Firewall.StopFirewall;
  except
  end;

      x:=FindWindow('TApplication','shareview_firewall');
      if x >1 then
        sendmessage(x,wm_close,0,0);

  timer3.Enabled:=true;
  lvFiles.Items.Clear;

  CheckForNewUpdates;

  // firewall create
    LogID:=0;
    mainHWND:=self.Handle;
    WindowProc:=TrapMSG;//Change the WindowProc to User's proc.
    //DDT

     // єЇјц ГК±вјіБ¤
     FDriverLoaded:= False;
     bPortScanning:= False;

     // OS №цАь Б¤єё ѕЛѕЖі»±в
     {ZeroMemory(@OS,SizeOf(OS));
     OS.dwOSVersionInfoSize:=SizeOf(OS);
     GetVersionEx(OS); }

     // ЕёАМёУ ГК±вИ­
     //Timer_Init.Enabled:= True;



     isLogStarted:=False;

     //Init log-image list.
     logImages:=TImageList.Create(Self);
     logPaths:=TStringList.Create;

     logImages.AddIcon(NIl);
     logPaths.Add('%$default$%');

     ListView_FWLog.SmallImages:= logImages;

     ServerSocket:=TServerSocket.Create(mainform);

  (*
    ***do not change: all calculations
   are based on a sample interval of =1= second***
  *)

 // CaptureMIBData( true );

  if LoadIpHlp then
  begin
      DOIpStuff;
  end
  else
      ShowMessage( 'Internet Helper DLL Not Available or Not Supported') ;

  tmTraffic.Interval := 1000;

  Tag := 0;

//  tmTraffic.Enabled:=true;
//  tmrTraffic.Enabled:=true;

  RecentIPs:=TStringList.Create;

end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.N2Click(Sender: TObject);
var
    HMapMutex:THandle;
begin

    Ini := TIniFile.Create(apl_path + '\shareview.ini');

    if self.cbCheckHost.Checked then ini.writestring('system', 'cbCheckHost', 'TRUE')
      else ini.writestring('system', 'cbCheckHost', 'FALSE');

    if self.cbIP3range.Checked then ini.writestring('system', 'cbIP3range', 'TRUE')
      else ini.writestring('system', 'cbIP3range', 'FALSE');

    if self.cbLowSpeed.Checked then ini.writestring('system', 'cbLowSpeed', 'TRUE')
      else ini.writestring('system', 'cbLowSpeed', 'FALSE');



    ini.writestring('system', 'IP4_1', IP4_1.Value);
    ini.writestring('system', 'IP4_2', IP4_2.Value);
    ini.writestring('system', 'IP4_3', IP4_3.Value);
    ini.writestring('system', 'IP4_4', IP4_4.Value);
    ini.writestring('system', 'IP5_1', IP5_1.Value);
    ini.writestring('system', 'IP5_2', IP5_2.Value);
    ini.writestring('system', 'IP5_3', IP5_3.Value);
    ini.writestring('system', 'IP5_4', IP5_4.Value);

    ini.free;


     //Hide form

     if isLogStarted then begin
          //Stop Logging function.
          DestroyIpcQueue('PSMFirewall');
          isLogStarted:=False;
     end;

     ListView_FWRule.Clear;

     HMapMutex := CreateMutex(nil, false, pchar('PSMFirewallApplication'));
     if HMapMutex <> 0 then begin
          if WaitForSingleObject(HMapMutex,100) = WAIT_OBJECT_0 then
          begin
                ListView_FWLog.Clear;
          end;
     end;
     ReleaseMutex(HMapMutex);
     CloseHandle(HMapMutex);

     Path_List.Clear;

     while bPortScanning do begin
          Sleep(100);
          Application.ProcessMessages;
     end;
 if  ADOConnect.InTransaction then ADOConnect.CommitTrans;
 FirewallStopFirewall;
 halt;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.N1Click(Sender: TObject);
begin
  Application.Restore;


end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if not _exit then action:=canone;
  Application.Minimize;
  self.AppMinimize(self);
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.TrayIcon1DblClickLeft(Sender: TObject);
begin
 // mainform.TrayIcon1.Restore;
//  mainform.TrayIcon1.Visible:=true;
  if regok then
    begin
    end
  else
   Unregisteredversion;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.IP1Click(Sender: TObject);
var s:string;
   i:integer;
begin
  if not Assigned(lvSessions.Selected) then Exit;
  i:= lvSessions.Selected.Index; //Определяем номер выбранной сессии
  s:=lvSessions.Items.Item[i].Caption;
  ShellExecute (0,'open', pchar('\\'+s+'\'),pchar(''), nil, SW_show);

end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.SpeedButton1Click(Sender: TObject);
begin
 // self.sbSave.PopupMenu.Popup(mouse.CursorPos.X,mouse.CursorPos.y);
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.dxButton4Click(Sender: TObject);
VAR I:INTEGER;
begin
  Application.CreateForm(TfoAbout, foAbout);
  foAbout.show;
  self.AlphaBlendValue:=0;
  for i:=0 to 12 do
    begin
      foAbout.AlphaBlendValue:=i*20;
       sleep(25);
      application.ProcessMessages;
      foabout.Refresh;
    end;
  foAbout.AlphaBlendValue:=255;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.dxButton5Click(Sender: TObject);
begin
  Application.CreateForm(TfoShared, foShared);
  showmodal;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.dxButton6Click(Sender: TObject);
begin
   if MessageDlg('Want to exit?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes  then
      begin
         _exit:=true;
        self.Close;
      end;

end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.Timer3Timer(Sender: TObject);
var runnow:boolean;
begin
  timer3.Enabled:=false;

  DoSomething2;

  FormResize(self);

  if mainform.runmini then
    begin
      close;
    end;

    Ini := TIniFile.Create(apl_path+'\shareview.ini');
    if uppercase(ini.readstring('system', 'RunFW', 'false')) <> 'TRUE' then
      runnow:=false else runnow:=true;
   Ini.free;

   if runnow then FirewallStartFirewall;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.Image3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
{ image3.OnMouseMove:=Image3MouseMove;
  _x:=x;
  _y:=y;  }
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.Image3MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
    left:=x-_x+left;
    top:=y-_y+top;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.Image3MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 //mage3.OnMouseMove:=nil;

end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.lbFormCaptionMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 //bFormCaption.OnMouseMove:=lbFormCaptionMouseMove;
  _x:=x;
  _y:=y;

end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.lbFormCaptionMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
    left:=x-_x+left;
    top:=y-_y+top;

end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.lbFormCaptionMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
//lbFormCaption.OnMouseMove:=nil;

end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.sbhelpClick(Sender: TObject);
begin
//  self.TrayIcon1.Minimized:=true;
  //ShellExecute (0,'open', pchar(apl_path + '\help.pdf'), pchar(''),nil, SW_show);
//     Application.CreateForm(TfoHelp, foHelp);
  //foHelp.show;

   MainForm.PageControl.ActivePageIndex:=7; //Miridix
   MainForm.WebBrowserHelp.Navigate(apl_path+'\help\help.htm');  
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.sbCloseClick(Sender: TObject);
begin
close;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.SpeedButton57Click(Sender: TObject);
begin
  Application.CreateForm(TfoSetup, foSetup);
  foSetup.showmodal;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.Killall1Click(Sender: TObject);
var
  OS: Boolean;
  FLibHandle : THandle;
  i: Integer;
begin
  if regok then
    begin
  tmFiles.Enabled:=false;
  if not IsNT(OS) then Close; //Выясняем тип системы

  if lvFiles.Items.Count>0 then
  for i:=0 to lvFiles.Items.Count-1 do
  begin
  if OS then begin //Код для NT
    FLibHandle := LoadLibrary('NETAPI32.DLL');
    if FLibHandle = 0 then Exit;
    @NetFileClose := GetProcAddress(FLibHandle, 'NetFileClose');
    if not Assigned(NetFileClose) then
    begin
      FreeLibrary(FLibHandle);
      Close;
    end;
    NetFileClose(nil,StrToInt(lvFiles.Items.Item[i].Caption));//Закрываем файл
  end;
  FreeLibrary(FLibHandle);
  end;
  tmFiles.Enabled:=true;
    end
  else
   Unregisteredversion;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.Killall2Click(Sender: TObject);
var
  OS: Boolean;
  FLibHandle : THandle;
  CNameNT: PWideChar;
  i: Integer;
begin
  if regok then
    begin
  if not IsNT(OS) then Close; //Выясняем тип системы

   if lvSessions.Items.Count>0 then
  for i:=0 to lvSessions.Items.Count-1 do
  if OS then begin
    FLibHandle := LoadLibrary('NETAPI32.DLL');
    if FLibHandle = 0 then Exit;
    @NetSessionDelNT := GetProcAddress(FLibHandle, 'NetSessionDel');
    if not Assigned(NetSessionDelNT) then
    begin
      FreeLibrary(FLibHandle);
      Exit;
    end;
    //Преобразуем данные в требуемый вид
    CNameNT := PWChar(WideString('\\'+lvSessions.Items.Item[i].Caption));
    NetSessionDelNT(nil,CNameNT,nil);
  end;
  FreeLibrary(FLibHandle);
    end
  else
   Unregisteredversion;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.IP2Click(Sender: TObject);
var i:integer;
begin
  if not Assigned(lvSessions.Selected) then Exit;
    i:= lvSessions.Selected.Index; //Определяем номер выбранной сессии
  Showmessage(GetHostByIP(PWChar(WideString(lvSessions.Items.Item[i].Caption))));
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.ApplicationEvents1Restore(Sender: TObject);
begin
  ShowWindow(Application.Handle, SW_RESTORE);
  BringToFront;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.Viewlog2Click(Sender: TObject);
begin
  if regok then
    begin
  Application.CreateForm(TfoLogSes, foLogSes);
  foLogSes.showmodal;
    end
  else
   Unregisteredversion;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.Viewlog1Click(Sender: TObject);
begin
  Application.CreateForm(TfoLogFiles, foLogFiles);
  foLogFiles.showmodal;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.Addtowhitelist1Click(Sender: TObject);
var i:integer;
begin

  if not Assigned(lvFiles.Selected) then Exit;
  i:= lvFiles.Selected.Index; //Определяем номер выбранной сессии
//files
  self.writeLog:=false;

        try
         aqList.SQL.Clear;
         aqList.SQL.Add('insert into files_white (fi3_pathname,fi3_username   ');
         aqList.SQL.Add('  ) ');
         aqList.SQL.Add('  values ('+#39+string(PWChar(WideString(lvFiles.Items[i].caption)))+#39+', ');
         aqList.SQL.Add(   #39+string(PWChar(WideString(lvFiles.Items.Item[i].SubItems[0])))+#39+') ');
//         aqList.SQL.SaveToFile('1.sql');
         aqList.ExecSQL;
       except
         on EOleException do
       end;
  self.writeLog:=true;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.Addtoblacklist1Click(Sender: TObject);
var i:integer;
begin

  if not Assigned(lvFiles.Selected) then Exit;
  i:= lvFiles.Selected.Index; //Определяем номер выбранной сессии
//files
  self.writeLog:=false;

        try
         aqList.SQL.Clear;
         aqList.SQL.Add('insert into files_black (fi3_pathname,fi3_username   ');
         aqList.SQL.Add('  ) ');
         aqList.SQL.Add('  values ('+#39+string(PWChar(WideString(lvFiles.Items[i].caption)))+#39+', ');
         aqList.SQL.Add(   #39+string(PWChar(WideString(lvFiles.Items.Item[i].SubItems[0])))+#39+') ');
//         aqList.SQL.SaveToFile('1.sql');
         aqList.ExecSQL;
       except
         on EOleException do
       end;
  self.writeLog:=true;
  aqFilesBlack.Refresh;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.Addtowhitelist2Click(Sender: TObject);
var i:integer;
begin

  if not Assigned(lvSessions.Selected) then Exit;
  i:= lvSessions.Selected.Index; //Определяем номер выбранной сессии
  self.writeLog:=false;

        try
         aqList.SQL.Clear;
         aqList.SQL.Add('insert into Sessions_white (Sesi502_cname ,Sesi502_username) ');
         aqList.SQL.Add('  values ('+#39+string(PWChar(WideString(lvSessions.Items.Item[i].Caption)))+#39+', ');
         aqList.SQL.Add(   #39+string(PWChar(WideString(lvSessions.Items.Item[i].SubItems[0])))+#39+') ');
//         aqSQL.SQL.SaveToFile('1.sql');
         aqList.ExecSQL;
       except
         on EOleException do
       end;
  self.writeLog:=true;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.Addtoblacklist2Click(Sender: TObject);
var i:integer;
begin
//ses

  if not Assigned(lvSessions.Selected) then Exit;
  i:= lvSessions.Selected.Index; //Определяем номер выбранной сессии
  self.writeLog:=false;
        try
         aqList.SQL.Clear;
         aqList.SQL.Add('insert into Sessions_black (Sesi502_cname ,Sesi502_username) ');
         aqList.SQL.Add('  values ('+#39+string(PWChar(WideString(lvSessions.Items.Item[i].Caption)))+#39+', ');
         aqList.SQL.Add(   #39+string(PWChar(WideString(lvSessions.Items.Item[i].SubItems[0])))+#39+') ');
//         qSQL.SQL.SaveToFile('1.sql');
         aqList.ExecSQL;
       except
         on EOleException do
       end;
  self.writeLog:=true;
  aqSesBlack.Refresh;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.Files1Click(Sender: TObject);
begin
  Application.CreateForm(TfoWhiteFiles, foWhiteFiles);
  foWhiteFiles.showmodal;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.Sessions1Click(Sender: TObject);
begin
  Application.CreateForm(TfoWhiteSes, foWhiteSes);
  foWhiteSes.showmodal;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.Files2Click(Sender: TObject);
begin
  Application.CreateForm(TfoBlackFiles, foBlackFiles);
  foBlackFiles.showmodal;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.Sessions2Click(Sender: TObject);
begin
   Application.CreateForm(TfoBlackSes, foBlackSes);
  foBlackSes.showmodal;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.SpeedButton7Click(Sender: TObject);
begin
//   ShellTreeView1. Repaint;


end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.SpeedButton8Click(Sender: TObject);
begin
  if regok then
 ///// self.SpeedButton8.PopupMenu.Popup(mouse.CursorPos.X,mouse.CursorPos.y)
  else
   Unregisteredversion;

end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.NameIP1Click(Sender: TObject);
var i:integer;
begin
  if not Assigned(lvSessions.Selected) then Exit;
    i:= lvSessions.Selected.Index; //Определяем номер выбранной сессии
  Showmessage(WideString(lvSessions.Items.Item[i].Caption)+'->'+Host2IP((WideString(lvSessions.Items.Item[i].Caption))));
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.SpeedButton10Click(Sender: TObject);
begin
  tmFiles.Enabled:=false;
  tmSessions.Enabled:=false;
  start1.Enabled:=true;
  pause1.Enabled:=false;
SpeedButton10.Enabled:=false;
SpeedButton9.enabled:=true;
  self.Caption:=Progname+' | paused ';
  if not regok then self.Caption:=Progname+' (Unregistered)';
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.SpeedButton9Click(Sender: TObject);
begin
tmFiles.Enabled:=true;
tmSessions.Enabled:=true;
start1.Enabled:=false;
pause1.Enabled:=true;
SpeedButton9.Enabled:=false;
SpeedButton10.enabled:=true;
  self.caption:=Progname;
if not regok then self.Caption:=Progname+' (Unregistered)';
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.sbRegClick(Sender: TObject);
begin
  if not assigned(foreg) then Application.CreateForm(Tforeg, foreg);
  foreg.showmodal;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.Files3Click(Sender: TObject);
begin
  Application.CreateForm(TfoLogFiles, foLogFiles);
  foLogFiles.showmodal;

end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.Sessions3Click(Sender: TObject);
begin
  if regok then
    begin
     Application.CreateForm(TfoLogSes, foLogSes);
     foLogSes.showmodal;
    end
  else
   Unregisteredversion;


end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.sbMaxClick(Sender: TObject);
begin
 { image3.OnMouseDown:=nil;
  image3.OnMouseMove:=nil;  }

   if fs=fsMaximized then fs:=fsNormal else fs:=fsMaximized;

   if fs=fsMaximized then
     begin
       self.Left:=screen.WorkAreaRect.Left;
       self.Top:=screen.WorkAreaRect.Top;
       self.Width:=screen.WorkAreaRect.Right+screen.WorkAreaRect.Left;
       self.Height:=screen.WorkAreaRect.Bottom+screen.WorkAreaRect.Top;
     end;

   if fs=fsNormal then
     begin
       self.Width:=NormalSizeWidth;
       self.Height:=NormalSizeHeight;
       self.Left:=(screen.WorkAreaWidth-self.Width) div 2;
       self.Top:=(screen.WorkAreaHeight-self.Height) div 2;
     end;

  { self.sbClose.Left:=self.Width-self.sbClose.Width;
   self.sbMax.Left:=self.Width-self.sbClose.Width*2; }

   {self.sbReg.Left:=self.Width-self.sbReg.Width;
   self.sbAbout.Left:=self.Width-self.sbReg.Width*2;
   self.sbHelp.Left:=self.Width-self.sbReg.Width*3;  }
//   self.imDelim1.Left:=self.Width-self.sbReg.Width*3-self.imDelim1.Width-3;

 //  image3.OnMouseDown:=Image3MouseDown;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.sbShareviewClick(Sender: TObject);
begin
  self.sbShareview.PopupMenu.Popup(mouse.CursorPos.X,mouse.CursorPos.y);
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.tmSesBlackCheckTimer(Sender: TObject);
var n:integer;
    b:boolean;
begin
if ShowAlerts then
begin
     //преверяем есть ли сессия в блеклисте и если есть то мочим
       b:=false;
        try
         aqSesBlack.first;
         while not aqSesBlack.Eof do
           begin

            for n:=0 to lvSessions.Items.Count-1 do
              begin
               //lvSessions.Items[n].ImageIndex:=32;
               if (aqSesBlack.FieldByName('Sesi502_cname').AsString=lvSessions.Items[n].caption)
                   and (lvSessions.Items[n].ImageIndex<> 32) then
                 begin
                   lvSessions.Items[n].ImageIndex:=32;
                  // b:=true;
                 end;
               end;
            aqSesBlack.next;
           end;

         If b then
           begin
             lvsessions.Refresh;
             ShowAlert;
           end;
       except
         on EOleException do
       end;
end;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.ShowAlert;
begin
     tmSesBlackCheck.Enabled:=false;
     Application.CreateForm(TfoBlackAlert, foBlackAlert);
     foBlackAlert.show;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.tmFilesBlackCheckTimer(Sender: TObject);
var n:integer;
    b:boolean;
begin
if ShowAlerts then
begin
     //преверяем есть ли Файлы в блеклисте и если есть то мочим
     //SubItems.Add(FileInfoNT_compare[n].fi3_pathname);   //Путь к файлу fi3_pathname
        try
         aqFilesBlack.first;
         b:=false;
         while not aqFilesBlack.Eof do
           begin
            for n:=0 to lvFiles.Items.Count-1 do
               if (aqFilesBlack.FieldByName('fi3_pathname').AsString=lvFiles.Items[n].caption)
                   and (lvFiles.Items[n].ImageIndex=31) then
                 begin
                     lvFiles.Items[n].ImageIndex:=32;
                     b:=true;
                   end;
            aqFilesBlack.next;
           end;
         If b then ShowAlertFiles;
       except
         on EOleException do
       end;
 end;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.ShowAlertFiles;
begin
     tmFilesBlackCheck.Enabled:=false;
     Application.CreateForm(TfoBlackAlertFiles, foBlackAlertFiles);
     foBlackAlertFiles.show;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.Killblack1Click(Sender: TObject);
var
  OS: Boolean;
  FLibHandle : THandle;
  CNameNT: PWideChar;
  i: Integer;
begin
  if regok then
    begin
  if not IsNT(OS) then Close; //Выясняем тип системы

   if lvSessions.Items.Count>0 then
  for i:=0 to lvSessions.Items.Count-1 do
  if (OS)and (lvSessions.Items[i].ImageIndex=32) then begin
    FLibHandle := LoadLibrary('NETAPI32.DLL');
    if FLibHandle = 0 then Exit;
    @NetSessionDelNT := GetProcAddress(FLibHandle, 'NetSessionDel');
    if not Assigned(NetSessionDelNT) then
    begin
      FreeLibrary(FLibHandle);
      Exit;
    end;
    //Преобразуем данные в требуемый вид
    CNameNT := PWChar(WideString('\\'+lvSessions.Items.Item[i].Caption));
    NetSessionDelNT(nil,CNameNT,nil);
  end;
  FreeLibrary(FLibHandle);
    end
  else
   Unregisteredversion;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.Killblack2Click(Sender: TObject);

var
  OS: Boolean;
  FLibHandle : THandle;
  i: Integer;
begin
  if regok then
    begin
  tmFiles.Enabled:=false;
  if not IsNT(OS) then Close; //Выясняем тип системы

  if lvFiles.Items.Count>0 then
  for i:=0 to lvFiles.Items.Count-1 do
  begin
  if (OS)and (lvFiles.Items[i].ImageIndex=32) then begin //Код для NT
    FLibHandle := LoadLibrary('NETAPI32.DLL');
    if FLibHandle = 0 then Exit;
    @NetFileClose := GetProcAddress(FLibHandle, 'NetFileClose');
    if not Assigned(NetFileClose) then
    begin
      FreeLibrary(FLibHandle);
      Close;
    end;
    NetFileClose(nil,StrToInt(lvFiles.Items.Item[i].Caption));//Закрываем файл
  end;
  FreeLibrary(FLibHandle);
  end;
  tmFiles.Enabled:=true;
    end
  else
   Unregisteredversion;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.sbShowTrafficClick(Sender: TObject);
begin
     Application.CreateForm(TfoTraffic, foTraffic);
     foTraffic.showmodal;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.SpeedButton3Click(Sender: TObject);
var i:integer;
    ShareName:string;
begin
  showwait;
  if self.lbxShares.Items.Count = 0 then Exit;
  for i:= 0 to self.lbxShares.Items.Count -1 do
    begin
      ShareName := self.lbxShares.Items[i].Caption;
      if self.lbxShares.Items[i].ImageIndex=31 then CloseShare(ShareName);
    end;


    btnGetSharesClick(self);
   closewait;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.SpeedButt8on1Click(Sender: TObject);
const
  STYPE_DISKTREE = 0;
  ACCESS_ALL =  258;
  SHI50F_FULL = 258;
var
  ShareName:String;
  FLibHandle : THandle;
  ShareNT : TShareInfo2;
  i:integer;
  TmpDir, TmpName: String;
  TmpDirNT, TmpNameNT: PWChar;
  OS: Boolean;
  TmpLength: Integer;

begin
   showwait;
  if regok then
   begin




    try
      aqList.SQL.Clear;
      aqList.SQL.Add('select * from Shares where status='+#39+'off'+#39);
      aqList.Open;
    except
      on EOleException do
    end;


 if self.lbxShares.Items.Count = 0 then Exit;
  for i:= 0 to self.lbxShares.Items.Count -1 do
    begin
      ShareName := self.lbxShares.Items[i].Caption;
      if self.lbxShares.Items[i].ImageIndex=50 then
        begin

          ShareName := self.lbxShares.Items[i].Caption;

          if not aqlist.Locate('shi2_netname',string(ShareName),[]) then exit;
          aqlist.Locate('shi2_netname',string(ShareName),[]);

           GetMem(MainForm.srDir, SizeOF(WideChar)*256);
           GetMem(MainForm.srComment, SizeOF(WideChar)*256);
           GetMem(MainForm.srName, SizeOF(WideChar)*256);
           GetMem(MainForm.srPass, SizeOF(WideChar)*256);
           GetMem(MainForm.srMaxusers, SizeOF(WideChar)*256);
           StringToWideChar(aqList.fieldbyname('shi2_path').AsString, MainForm.srDir, SizeOF(WideChar)*256);
           StringToWideChar(aqList.fieldbyname('shi2_netname').AsString, MainForm.srName, SizeOF(WideChar)*256);
           StringToWideChar(aqList.fieldbyname('shi2_remark').AsString, MainForm.srComment, SizeOF(WideChar)*256);
           StringToWideChar(aqList.fieldbyname('shi2_passwd').AsString, MainForm.srPass, SizeOF(WideChar)*256);
           StringToWideChar(aqList.fieldbyname('shi2_max_uses').AsString, MainForm.srMaxusers, SizeOF(WideChar)*256);


          if MainForm.srDir = '' then Exit;

          if not MainForm.IsNT(OS) then Close; //Выясняем тип системы

          if OS then begin //Код для NT
            TmpDir:=MainForm.srDir;
            FLibHandle := LoadLibrary('NETAPI32.DLL');
            if FLibHandle = 0 then Exit;
            @NetShareAddNT := GetProcAddress(FLibHandle,'NetShareAdd');
            if not Assigned(NetShareAddNT) then
            begin
              FreeLibrary(FLibHandle);
              Exit;
            end;
            TmpLength := SizeOF(WideChar)*256; //Определяем необходимый размер

            GetMem(TmpNameNT, TmpLength); //Конвертируем в PWChar
            StringToWideChar(TmpName, TmpNameNT, TmpLength);
            ShareNT.shi2_netname := MainForm.srName; //Имя

            ShareNT.shi2_type := STYPE_DISKTREE; //Тип ресурса
            ShareNT.shi2_remark := MainForm.srComment; //Комментарий
            ShareNT.shi2_permissions := ACCESS_ALL; //Доступ
            ShareNT.shi2_max_uses := DWORD(strtointdef(MainForm.srMaxusers,-1)); //Кол-во максим. подключ.
            ShareNT.shi2_current_uses := 0; //Кол-во тек подкл.

            GetMem(TmpDirNT, TmpLength);
            StringToWideChar(TmpDir, TmpDirNT, TmpLength);
            ShareNT.shi2_path := TmpDirNT; //Путь к ресурсу

            ShareNT.shi2_passwd := MainForm.srPass; //Пароль

            NetShareAddNT(nil,2,@ShareNT, nil); //Добавляем ресурс

            try
              MainForm.aqSQL.SQL.Clear;
              MainForm.aqSQL.SQL.Add('delete from shares where shi2_netname='+#39+aqList.fieldbyname('shi2_netname').AsString+#39);
              MainForm.aqSQL.ExecSQL;
            except
              on EOleException do
            end;

            FreeMem (TmpNameNT); //освобождаем память
            FreeMem (TmpDirNT);
            FreeMem (MainForm.srDir);
            FreeMem (MainForm.srComment);
            FreeMem (MainForm.srName);
            FreeMem (MainForm.srPass);
            FreeMem (MainForm.srMaxusers);
          end;
        end;
    end;
  FreeLibrary(FLibHandle);
 btnGetSharesClick(self);
   end
  else
   Unregisteredversion;
   closewait;

end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.Addnew1Click(Sender: TObject);
const
  STYPE_DISKTREE = 0;
  ACCESS_ALL =  258;
  SHI50F_FULL = 258;
var
  FLibHandle : THandle;
  ShareNT : TShareInfo2;
  TmpDir, TmpName: String;
  TmpDirNT, TmpNameNT: PWChar;
  OS: Boolean;
  TmpLength: Integer;
begin
  if not assigned(foDialog) then Application.CreateForm(TfoDialog, foDialog);

  foDialog.ShowModal;

  Self.BringToFront;
  if MainForm.srDir = '' then Exit;

  if not MainForm.IsNT(OS) then Close; //Выясняем тип системы

  if OS then begin //Код для NT
    TmpDir:=MainForm.srDir;
    FLibHandle := LoadLibrary('NETAPI32.DLL');
    if FLibHandle = 0 then Exit;
    @NetShareAddNT := GetProcAddress(FLibHandle,'NetShareAdd');
    if not Assigned(NetShareAddNT) then
    begin
      FreeLibrary(FLibHandle);
      Exit;
    end;
    TmpLength := SizeOF(WideChar)*256; //Определяем необходимый размер

    GetMem(TmpNameNT, TmpLength); //Конвертируем в PWChar
    StringToWideChar(TmpName, TmpNameNT, TmpLength);
    ShareNT.shi2_netname := MainForm.srName; //Имя

    ShareNT.shi2_type := STYPE_DISKTREE; //Тип ресурса
    ShareNT.shi2_remark := MainForm.srComment; //Комментарий
    ShareNT.shi2_permissions := ACCESS_ALL; //Доступ
    ShareNT.shi2_max_uses := DWORD(strtointdef(MainForm.srMaxusers,-1)); //Кол-во максим. подключ.
    ShareNT.shi2_current_uses := 0; //Кол-во тек подкл.

    GetMem(TmpDirNT, TmpLength);
    StringToWideChar(TmpDir, TmpDirNT, TmpLength);
    ShareNT.shi2_path := TmpDirNT; //Путь к ресурсу

    ShareNT.shi2_passwd := MainForm.srPass; //Пароль

    NetShareAddNT(nil,2,@ShareNT, nil); //Добавляем ресурс
    FreeMem (TmpNameNT); //освобождаем память
    FreeMem (TmpDirNT);
    FreeMem (MainForm.srDir);
    FreeMem (MainForm.srComment);
    FreeMem (MainForm.srName);
    FreeMem (MainForm.srPass);
    FreeMem (MainForm.srMaxusers);
  end;
  FreeLibrary(FLibHandle);
 btnGetSharesClick(self);
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.Miridix1Click(Sender: TObject);
begin
  ShellExecute (0,'open', pchar('http://www.miridix.com/'), pchar(''),nil, SW_show);
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.RxTrayIcon1DblClick(Sender: TObject);
begin
  Application.Restore;  Application.BringToFront;
  self.AppRestore(self);
//  mainform.TrayIcon1.Visible:=true;
  if regok then
    begin
    end
  else
   Unregisteredversion;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.FormActivate(Sender: TObject);
begin
{$IFNDEF WIN32}
  if Screen.ActiveForm <> nil then Screen.ActiveForm.BringToFront;
{$ENDIF}

end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.AppRestore(Sender: TObject);
begin
{$IFDEF WIN32}
  if NewStyleControls then ShowWindow(Application.Handle, SW_SHOW);
{$ENDIF}
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.AppMinimize(Sender: TObject);
begin
{$IFDEF WIN32}
  if NewStyleControls then ShowWindow(Application.Handle, SW_HIDE);
{$ENDIF}
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.OpenPage(page:integer);
begin
{
var
  TreeEntries: array[0..12] of TEntry = (
   0 (Caption: 'Opened files';               Image: 54; Size: 0),
   1 (Caption: 'Shared folders';             Image: 191; Size: 0),
   2 (Caption: 'Firewall';                   Image: 192; Size: 0),
   3 (Caption: 'Net resourses';              Image: 136; Size: 0),
   4 (Caption: 'Traffic';                    Image: 48; Size: 0),
   5 (Caption: 'Ping';                       Image: 194; Size: 10),
   6 (Caption: 'Logs';                       Image: 63; Size: 0),
   7 (Caption: 'Configuration';              Image: 90; Size: 0),
   8 (Caption: 'Register';                   Image: 60; Size: 0),
   9  (Caption: 'About';                      Image: 196; Size: 0),
   10 (Caption: 'Miridix site';               Image: 101; Size: 0),
   11 (Caption: 'Help';                       Image: 195; Size: 0)
  );}
    tmTraffic.Enabled:=false;
    tmrTraffic.Enabled:=false;

    case page of
    0: begin
         PageControl.ActivePageIndex:=0; //open files
       end;
    1: begin

         RefreshRecordsLabels(self);
         PageControl.ActivePageIndex:=10; //sharedfolders
         btnGetSharesClick(self);
       end;
{   2: begin
         if not regok then Unregisteredversion;
         PageControl.ActivePageIndex:=2;  //Firewall
         if ADOConnect.InTransaction then ADOConnect.CommitTrans;
         ADOConnect.BeginTrans;
       end;}
    2: begin
         PageControl.ActivePageIndex:=12; //net resources
       end;
    3: begin
         tmrTraffic.Enabled:=true;
         tmTraffic.Enabled:=true;
         PageControl.ActivePageIndex:=7;  //Logs
         //sbShowTrafficClick(self);  //traffic
       end;
    4: begin
         if not regok then Unregisteredversion;
         PageControl.ActivePageIndex:=3;  //Ping
         self.Repaint;
       end;
    5: begin

         RefreshRecordsLabels(self);
         PageControl.ActivePageIndex:=8;  //Tracert
       end;
    6: begin

         RefreshRecordsLabels(self);
         PageControl.ActivePageIndex:=9;  //PingScan
       end;
    7: begin

         RefreshRecordsLabels(self);
         PageControl.ActivePageIndex:=11;  //Port scan
       end;
    8: begin

         RefreshRecordsLabels(self);
         PageControl.ActivePageIndex:=4;  //Logs
       end;
    9: begin
         SpeedButton57Click(self);   //setup
       end;
   10: begin
         sbRegClick(self);   //Register
       end;
   11: begin
          PageControl.ActivePageIndex:=5; //Miridix
         WebBrowser1.Navigate('http://miridixsoft.com/');
       end;
   12: begin
         PageControl.ActivePageIndex:=5; //Miridix
         WebBrowser1.Navigate('http://miridixsoft.com/');
       end;
   13: begin
         PageControl.ActivePageIndex:=6; //help
         WebBrowserHelp.Navigate(apl_path+'\help\help.htm');
       end;
    end;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.XPTreeClick(Sender: TObject);
begin
  OpenPage(ClickPageNumber);
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.SpeedButton12Click(Sender: TObject);
begin
   if MessageDlg('You want to clear log?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes  then
      begin
  try
  if self.aqLogCleaner.Active then self.aqLogCleaner.Active:=false;
  self.aqLogCleaner.SQL.Clear;
  self.aqLogCleaner.SQL.Add(' delete from files ');
  self.aqLogCleaner.ExecSQL;
  finally
  end;
  RefreshRecordsLabels(self);
  end;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.SpeedButton13Click(Sender: TObject);
begin
   if MessageDlg('You want to clear log?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes  then
      begin
  try
  if self.aqLogCleaner.Active then self.aqLogCleaner.Active:=false;
  self.aqLogCleaner.SQL.Clear;
  self.aqLogCleaner.SQL.Add(' delete from sessions ');
  self.aqLogCleaner.ExecSQL;
  finally
  end;
  RefreshRecordsLabels(self);
  end;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.RefreshRecordsLabels(Sender: TObject);
begin
        try
         if self.aqLogCleaner.Active then self.aqLogCleaner.Active:=false;
         self.aqLogCleaner.Active:=false;
         self.aqLogCleaner.SQL.Clear;
         self.aqLogCleaner.SQL.Add(' select count(*) as cnt from files ');
         self.aqLogCleaner.open;
         lbRecordinFiles.Caption:=self.aqLogCleaner.fieldbyname('cnt').AsString;
        finally
        end;

        try
         if self.aqLogCleaner.Active then self.aqLogCleaner.Active:=false;
         self.aqLogCleaner.Active:=false;
         self.aqLogCleaner.SQL.Clear;
         self.aqLogCleaner.SQL.Add(' select count(*) as cnt from sessions ');
         self.aqLogCleaner.open;
         lbRecordsinSessions.Caption:=self.aqLogCleaner.fieldbyname('cnt').AsString;
        finally
        end;

        try
         if self.aqLogCleaner.Active then self.aqLogCleaner.Active:=false;
         self.aqLogCleaner.Active:=false;
         self.aqLogCleaner.SQL.Clear;
         self.aqLogCleaner.SQL.Add(' select count(*) as cnt from fw_log ');
         self.aqLogCleaner.open;
         lbFireCount.Caption:=self.aqLogCleaner.fieldbyname('cnt').AsString;
        finally
        end;
end;

//----------------------------------------------------------------------------------------------------------------------

Function Dos2Win(in_:pchar):pchar;
var Str:array[0..20000] of Char;
begin
OemToAnsi(StrPCopy(Str,in_),Str);
Result:=Str;
end;

//----------------------------------------------------------------------------------------------------------------------

Procedure TMainForm.WinPing(ip:string;size,ttl,count,wait:integer);
var t:textfile;
    x:integer;
var
  Src, Str: PansiChar;
  sttl,scount,swait,ssize:string;
begin

      if ttl>0 then sttl:=' -i '+inttostr(ttl) else sttl:='';
      if size>0 then ssize:=' -l '+inttostr(size) else ssize:='';
      if count>0 then scount:=' -n '+inttostr(count) else scount:='';
      if wait>0 then swait:=' -w '+inttostr(wait) else swait:='';

      deletefile(apl_path+'\ping2.bat');
      assignfile(t,apl_path+'\ping2.bat');
      rewrite(t);
      writeln(t,'ping '+ ip+ sttl+ssize+scount+swait+' >'+apl_path+'\ping2.bak');
      closefile(t);
      ExecAndWait(apl_path+'\ping2.bat','' ,0);
      deletefile(apl_path+'\ping2.bat');
      mmTemp.Lines.LoadFromFile(apl_path+'\ping2.bak');
      deletefile(apl_path+'\ping2.bak');

      Src := mmTemp.Lines.GetText; //Берем текст из TMemo как тип PChar
      str := src;
      OemToChar(src, Str); //API функция для перевода текста
      mmTemp.Lines.Text := StrPas(Str);//Записываем назад
      for x:=0 to mmtemp.Lines.count-1 do mmWinPing.Lines.Add(mmtemp.Lines[x])
end;

//----------------------------------------------------------------------------------------------------------------------

Procedure TMainForm.WinPingHost(ip:string;size,ttl,count,wait:integer);
var t:textfile;
    x:integer;
var
  Src, Str: PansiChar;
  sttl,scount,swait,ssize:string;
begin

      if ttl>0 then sttl:=' -i '+inttostr(ttl) else sttl:='';
      if size>0 then ssize:=' -l '+inttostr(size) else ssize:='';
      if count>0 then scount:=' -n '+inttostr(count) else scount:='';
      if wait>0 then swait:=' -w '+inttostr(wait) else swait:='';

      deletefile(apl_path+'\ping2.bat');
      assignfile(t,apl_path+'\ping2.bat');
      rewrite(t);
      writeln(t,'ping '+ ip+ sttl+ssize+scount+swait+' >'+apl_path+'\ping2.bak');
      closefile(t);
      ExecAndWait(apl_path+'\ping2.bat','' ,0);
      deletefile(apl_path+'\ping2.bat');
      mmTemp.Lines.LoadFromFile(apl_path+'\ping2.bak');
      deletefile(apl_path+'\ping2.bak');

      Src := mmTemp.Lines.GetText; //Берем текст из TMemo как тип PChar
      str := src;
      OemToChar(src, Str); //API функция для перевода текста
      mmTemp.Lines.Text := StrPas(Str);//Записываем назад
      for x:=0 to mmtemp.Lines.count-1 do mmWinPingHost.Lines.Add(mmtemp.Lines[x])
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.SpeedButton6Click(Sender: TObject);
var x:integer;

begin
  if not cbIP1range.Checked then
    begin
      Showwait;
      WinPing(ip1_1.text+'.'+ip1_2.text+'.'+ip1_3.text+'.'+ip1_4.text,
           edSize.Value,edTTL.Value,edcount.Value,edwait.Value);
      Closewait;
    end
    else
    begin
      Showwait;
      self.Stop:=false;
      if ip1_4.Value<ip2_4.Value then
      for x:=ip1_4.Value to ip2_4.Value do
        begin
           WinPing(ip1_1.text+'.'+ip1_2.text+'.'+ip1_3.text+'.'+inttostr(x),
              edSize.Value,edTTL.Value,edcount.Value,edwait.Value);
           if self.Stop then continue;
           Application.ProcessMessages;
        end else showmessage('IP range input error');
      closewait;
    end;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.IP1_1Change(Sender: TObject);
begin
    if (sender as TDBNumberEditEh).Value>99 then
     begin
        FindNextControl( (sender as TDBNumberEditEh),true,true,false).SetFocus;
        (FindNextControl( (sender as TDBNumberEditEh),true,true,false) as TDBNumberEditEh).SelectAll
     end;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.IP1_1Click(Sender: TObject);
begin
  (sender as TDBNumberEditEh).SelectAll;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.cbIP2rangeClick(Sender: TObject);
begin
 { IP4_1.Enabled:=cbIP2range.Checked;
  IP4_2.Enabled:=cbIP2range.Checked;
  IP4_3.Enabled:=cbIP2range.Checked;
  IP4_4.Enabled:=cbIP2range.Checked;

  lbIP_to2.Enabled:=cbIP2range.Checked;
//  lbdot4.Enabled:=cbIP2range.Checked;
//  lbdot5.Enabled:=cbIP2range.Checked;
//  lbdot6.Enabled:=cbIP2range.Checked;


  if IP4_1.Enabled then
   begin
     IP4_1.Value:=IP3_1.Value;
     IP4_2.Value:=IP3_2.Value;
     IP4_3.Value:=IP3_3.Value;
     IP4_4.Value:=IP3_4.Value;
   end;  }
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.SpeedButton14Click(Sender: TObject);
begin
  mmWinPing.Lines.Clear;
end;

//----------------------------------------------------------------------------------------------------------------------


procedure TMainForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_ESCAPE then
    begin
      mainform.stop:=true;
    end;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.cbIP1rangeClick(Sender: TObject);
begin
   IP2_1.Enabled:=cbIP1range.Checked;
  IP2_2.Enabled:=cbIP1range.Checked;
  IP2_3.Enabled:=cbIP1range.Checked;
  IP2_4.Enabled:=cbIP1range.Checked;

  lbIP_to1.Enabled:=cbIP1range.Checked;
  lbdot1.Enabled:=cbIP1range.Checked;
  lbdot2.Enabled:=cbIP1range.Checked;
  lbdot3.Enabled:=cbIP1range.Checked;


  if IP2_1.Enabled then
   begin
     IP2_1.Value:=IP1_1.Value;
     IP2_2.Value:=IP1_2.Value;
     IP2_3.Value:=IP1_3.Value;
     IP2_4.Value:=IP1_4.Value;
   end;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.IP3_1Change(Sender: TObject);
begin
    if (sender as TDBNumberEditEh).Value>99 then
     begin
        FindNextControl( (sender as TDBNumberEditEh),true,true,false).SetFocus;
        (FindNextControl( (sender as TDBNumberEditEh),true,true,false) as TDBNumberEditEh).SelectAll
     end;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.SpeedButton16Click(Sender: TObject);
const
  STYPE_DISKTREE = 0;
  ACCESS_ALL =  258;
  SHI50F_FULL = 258;
var
  ShareName:String;
  FLibHandle : THandle;
  ShareNT : TShareInfo2;
  i:integer;
  TmpDir, TmpName: String;
  TmpDirNT, TmpNameNT: PWChar;
  OS: Boolean;
  TmpLength: Integer;
begin


    try
      aqList.SQL.Clear;
      aqList.SQL.Add('select * from Shares where status='+#39+'off'+#39);
      aqList.Open;
    except
      on EOleException do
    end;


  if self.lbxShares.Items.Count = 0 then Exit;
  if self.lbxShares.SelCount <1 then Exit;
  for i:= 0 to self.lbxShares.Items.Count -1 do
    if self.lbxShares.Items[i].Selected then Break;  //Ищем выбранный элемент
  if not self.lbxShares.Items[i].Selected then Exit; //Если не найден уходим
  ShareName := self.lbxShares.Items[i].Caption;

  if not aqlist.Locate('shi2_netname',string(ShareName),[]) then exit;
  aqlist.Locate('shi2_netname',string(ShareName),[]);

   GetMem(MainForm.srDir, SizeOF(WideChar)*256);
   GetMem(MainForm.srComment, SizeOF(WideChar)*256);
   GetMem(MainForm.srName, SizeOF(WideChar)*256);
   GetMem(MainForm.srPass, SizeOF(WideChar)*256);
   GetMem(MainForm.srMaxusers, SizeOF(WideChar)*256);
   StringToWideChar(aqList.fieldbyname('shi2_path').AsString, MainForm.srDir, SizeOF(WideChar)*256);
   StringToWideChar(aqList.fieldbyname('shi2_netname').AsString, MainForm.srName, SizeOF(WideChar)*256);
   StringToWideChar(aqList.fieldbyname('shi2_remark').AsString, MainForm.srComment, SizeOF(WideChar)*256);
   StringToWideChar(aqList.fieldbyname('shi2_passwd').AsString, MainForm.srPass, SizeOF(WideChar)*256);
   StringToWideChar(aqList.fieldbyname('shi2_max_uses').AsString, MainForm.srMaxusers, SizeOF(WideChar)*256);


  if MainForm.srDir = '' then Exit;

  if not MainForm.IsNT(OS) then Close; //Выясняем тип системы

  if OS then begin //Код для NT
    TmpDir:=MainForm.srDir;
    FLibHandle := LoadLibrary('NETAPI32.DLL');
    if FLibHandle = 0 then Exit;
    @NetShareAddNT := GetProcAddress(FLibHandle,'NetShareAdd');
    if not Assigned(NetShareAddNT) then
    begin
      FreeLibrary(FLibHandle);
      Exit;
    end;
    TmpLength := SizeOF(WideChar)*256; //Определяем необходимый размер

    GetMem(TmpNameNT, TmpLength); //Конвертируем в PWChar
    StringToWideChar(TmpName, TmpNameNT, TmpLength);
    ShareNT.shi2_netname := MainForm.srName; //Имя

    ShareNT.shi2_type := STYPE_DISKTREE; //Тип ресурса
    ShareNT.shi2_remark := MainForm.srComment; //Комментарий
    ShareNT.shi2_permissions := ACCESS_ALL; //Доступ
    ShareNT.shi2_max_uses := DWORD(strtointdef(MainForm.srMaxusers,-1)); //Кол-во максим. подключ.
    ShareNT.shi2_current_uses := 0; //Кол-во тек подкл.

    GetMem(TmpDirNT, TmpLength);
    StringToWideChar(TmpDir, TmpDirNT, TmpLength);
    ShareNT.shi2_path := TmpDirNT; //Путь к ресурсу

    ShareNT.shi2_passwd := MainForm.srPass; //Пароль

    NetShareAddNT(nil,2,@ShareNT, nil); //Добавляем ресурс

    try
      MainForm.aqSQL.SQL.Clear;
      MainForm.aqSQL.SQL.Add('delete from shares where shi2_netname='+#39+aqList.fieldbyname('shi2_netname').AsString+#39);
      MainForm.aqSQL.ExecSQL;
    except
      on EOleException do
    end;

    FreeMem (TmpNameNT); //освобождаем память
    FreeMem (TmpDirNT);
    FreeMem (MainForm.srDir);
    FreeMem (MainForm.srComment);
    FreeMem (MainForm.srName);
    FreeMem (MainForm.srPass);
    FreeMem (MainForm.srMaxusers);
  end;
  FreeLibrary(FLibHandle);
 btnGetSharesClick(self);
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.SpeedButton15Click(Sender: TObject);

var
  OS:Boolean;
  FLibHandle : THandle;
  NameNT:PWChar;
  i:Integer;
  ShareName: String;
begin
  if not mainform.IsNT(OS) then Close; //Определяем тип системы
 // if self.lbxShares.SelCount>0 then
  begin
  if self.lbxShares.Items.Count = 0 then Exit;
  if self.lbxShares.SelCount <1 then Exit;
  for i:= 0 to self.lbxShares.Items.Count -1 do
    if self.lbxShares.Items[i].Selected then Break;  //Ищем выбранный элемент
  if not self.lbxShares.Items[i].Selected then Exit; //Если не найден уходим
  ShareName := self.lbxShares.Items[i].Caption;

  if OS then begin //Код для NT
    FLibHandle := LoadLibrary('NETAPI32.DLL');
    if FLibHandle = 0 then Exit;
    @NetShareDelNT := GetProcAddress(FLibHandle,'NetShareDel');
    if not Assigned(NetShareDelNT) then //Проверка
    begin
      FreeLibrary(FLibHandle);
      Exit;
    end;
    i:= SizeOf(WideChar)*256;
    GetMem(NameNT,i);  //Выделяем память под переменную
    StringToWideChar(ShareName,NameNT,i); //Преобразуем в PWideChar
    NetShareDelNT(nil,NameNT,0);   //Удаляем ресурс
    FreeMem(NameNT);  //Освобождаем память
  end;
  FreeLibrary(FLibHandle);

    // метим как отрубленный ресурс
    try
      Mainform.aqSQL.SQL.Clear;
      Mainform.aqSQL.SQL.Add('update Shares set status='+#39+'off'+#39+' where shi2_netname='+#39+ShareName+#39);
      Mainform.aqSQL.ExecSQL;
    except
      on EOleException do
    end;

  self.btnGetSharesClick(self);
  end;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.SpeedButton18Click(Sender: TObject);
begin
  mmWinPingHost.Lines.Clear;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.k(Sender: TObject);
begin
   Showwait;
   WinPingHost(edpinghost.Text, edSizehost.Value,edTTLhost.Value,
               edcounthost.Value,edwaithost.Value);
   Closewait;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.PageIPConfigShow(Sender: TObject);
var t:textfile;
    x:integer;
var
  Src, Str: PansiChar;
begin
      mmIPConf.Lines.Clear;
      deletefile(apl_path+'\ping2.bat');
      assignfile(t,apl_path+'\ping2.bat');
      rewrite(t);
      writeln(t,'ipconfig /all >'+apl_path+'\ping2.bak');
      closefile(t);
      ExecAndWait(apl_path+'\ping2.bat','' ,0);
      deletefile(apl_path+'\ping2.bat');
      mmTemp.Lines.LoadFromFile(apl_path+'\ping2.bak');
      deletefile(apl_path+'\ping2.bak');

      Src := mmTemp.Lines.GetText; //Берем текст из TMemo как тип PChar
      str := src;
      //OemToChar(src, Str); //API функция для перевода текста
      mmTemp.Lines.Text := StrPas(Str);//Записываем назад
      for x:=0 to mmtemp.Lines.count-1 do mmIPConf.Lines.Add(mmtemp.Lines[x])
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.SpeedButton22Click(Sender: TObject);
begin
 mmIPConf.Lines.Clear;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.SpeedButton19Click(Sender: TObject);
var t:textfile;
    x:integer;
var
  Src, Str: PansiChar;
begin
      showwait;

      deletefile(apl_path+'\ping2.bat');
      assignfile(t,apl_path+'\ping2.bat');
      rewrite(t);
      writeln(t,'tracert ' + edTracehost.text + ' >' + apl_path + '\ping2.bak');
      closefile(t);
      ExecAndWait(apl_path+'\ping2.bat','' ,0);
      deletefile(apl_path+'\ping2.bat');
      mmTemp.Lines.LoadFromFile(apl_path+'\ping2.bak');
      deletefile(apl_path+'\ping2.bak');

      Src := mmTemp.Lines.GetText; //Берем текст из TMemo как тип PChar
      str := src;
      OemToChar(src, Str); //API функция для перевода текста
      mmTemp.Lines.Text := StrPas(Str);//Записываем назад
      for x:=0 to mmtemp.Lines.count-1 do mmTrace.Lines.Add(mmtemp.Lines[x]);

      closewait;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.SpeedButton20Click(Sender: TObject);
begin
  mmTrace.Lines.Clear;
end;


//----------------------------------------------------------------------------------------------------------------------

procedure RefreshQuery ( Query: TDataSet );
  var BookMark: TBookMark;
begin
  BookMark := nil;
  if Query.Active
  then BookMark := Query.GetBookmark;
  Query.Close;
  Query.Open;
  try
    try
      if Assigned ( BookMark )
      then Query.GotoBookmark ( BookMark );
    except
      sleep ( 1 );
    end;
  finally
    if Assigned ( BookMark )
    then Query.FreeBookmark ( BookMark );
  end;
end;


//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.DBGridEh1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=vk_insert then
   begin
        aqSQL.SQL.Clear;
        aqSQL.SQL.Add('select max(xpos) as maxpos from fw_rules');
        aqSQL.open;

        aqFirewall.Edit;
        aqFirewall.Insert;
        aqFirewall.Fieldbyname('xprotocol').Asstring:='TCP';
        aqFirewall.Fieldbyname('xdest').Asstring:='ANY';
        aqFirewall.Fieldbyname('xaction').Asstring:='DROP';
        aqFirewall.Fieldbyname('xpos').AsInteger:=aqSQL.Fieldbyname('maxpos').AsInteger+1;
        aqFirewall.Post;
        aqSQL.Close;
        key:=0;
        RefreshQuery(aqFirewall);
   end;

  if key=vk_return then
   begin
        if aqFirewall.State in [dsedit] then aqFirewall.Post;
   end;

  if key=vk_down then
   begin
        if aqFirewall.eof then key:=0;
       aqFirewall.Next;
       if not aqFirewall.Eof then aqFirewall.Prior;
   end;

  if key=vk_delete then
   begin
   if MessageDlg('You want to delete this rule?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes  then
      begin
        aqFirewall.Delete;
      end;
   end;

end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.sbAboutClick(Sender: TObject);
begin
dxButton4Click(self)


end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.SpeedButton25Click(Sender: TObject);
begin
       {  if aqFirewall.State in [dsedit] then aqFirewall.Post;
         if ADOConnect.InTransaction then ADOConnect.RollbackTrans;
         ADOConnect.BeginTrans;
         RefreshQuery(aqFirewall);     }
         mmNetstat.Lines.Clear;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.SpeedButton23Click(Sender: TObject);
begin
{        aqSQL.SQL.Clear;
        aqSQL.SQL.Add('select max(xpos) as maxpos from fw_rules');
        aqSQL.open;

        aqFirewall.Edit;
        aqFirewall.Insert;
        aqFirewall.Fieldbyname('xprotocol').Asstring:='IP';
        aqFirewall.Fieldbyname('xdest').Asstring:='BOTH';
        aqFirewall.Fieldbyname('xaction').Asstring:='DROP';
        aqFirewall.Fieldbyname('xpos').AsInteger:=aqSQL.Fieldbyname('maxpos').AsInteger+1;
        aqFirewall.Post;
        aqSQL.Close;
        RefreshQuery(aqFirewall); }

            Form_FWRule.FWRule.ActivePage:=Form_FWRule.IpRulePage;
            Form_FWRule.ShowModal;

end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.DBGridEh1CellClick(Column: TColumnEh);
begin
  if aqFirewall.State in [dsedit] then aqFirewall.Post;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.SpeedButton26Click(Sender: TObject);
var t:textfile;
    x:integer;
  Src, Str: PansiChar;
  s:string;
begin
      mmNetstat.Lines.Clear;
      mmTemp.Lines.LoadFromFile(apl_path+'\help\netstat.txt');

      Src := mmTemp.Lines.GetText; //Берем текст из TMemo как тип PChar
      str := src;
      OemToChar(src, Str); //API функция для перевода текста
      mmTemp.Lines.Text := StrPas(Str);//Записываем назад
      for x:=0 to mmtemp.Lines.count-1 do mmNetstat.Lines.Add(mmtemp.Lines[x])


end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.SpeedButton27Click(Sender: TObject);
begin
         PageControl.ActivePageIndex:=6; //help
         WebBrowserHelp.Navigate(apl_path+'\help\help.htm');

end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.SpeedButton2Click(Sender: TObject);
begin
    Form_FWRule.FWRule.ActivePage:=Form_FWRule.PathRulePage;
    Form_FWRule.ShowModal;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.sbSaveClick(Sender: TObject);
begin
  DeleteClick(self);
end;

//----------------------------------------------------------------------------------------------------------------------

function GetLocalIP : string;
type TaPInAddr = array [0..10] of PInAddr;
     PaPInAddr = ^TaPInAddr;
var  phe  : PHostEnt;
     pptr : PaPInAddr;
     Buffer : array [0..63] of char;
     I    : Integer;
     GInitData      : TWSADATA;
begin
    WSAStartup($101, GInitData);
    Result := '';
    GetHostName(Buffer, SizeOf(Buffer));
    phe :=GetHostByName(buffer);
    if phe = nil then Exit;
    pptr := PaPInAddr(Phe^.h_addr_list);
    I := 0;
    while pptr^[I] <> nil do
    begin
      result:=StrPas(inet_ntoa(pptr^[I]^));
      Inc(I);
    end;
    WSACleanup;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.ApplyFirewallRules;
var t:textfile;
    s:string;
begin

  showwait;
 // s:=Firewall.GetNamePath;

  FirewallStopFirewall;
  {sleep(500);
      assignfile(t,apl_path+'\fw_hook.policy');
      rewrite(t);
      aqFirewall.First;
      while not aqFirewall.Eof do
        begin
          s:=aqFirewall.FieldByName('xaction').Asstring + ' ' +
                    aqFirewall.FieldByName('xprotocol').Asstring + ' '+
                    aqFirewall.FieldByName('xdest').Asstring + ' FROM  ANY TO '+
                    aqFirewall.FieldByName('xip').Asstring;
          if s[1]=' ' then delete(s,1,1);
          writeln(t,s);

          aqFirewall.Next;
        end;
      closefile(t);  }

  FirewallStartFirewall;
  closewait;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure ReplaceText( reptext, strOLD, strNEW: string);
 var
   x, Position: integer;
   tmpstr, tmpstr2: string;
 begin
   tmpstr := reptext;
   for x := 0 to Length(reptext) do
   begin
     if Copy(reptext, x, Length(strold)) = strold then
     begin
       tmpstr   := Copy(reptext, 0, x - 1) + strnew;
       Position := x;
     end;
   end;
   tmpstr2 := reptext;
   if Position <> 0 then
     reptext := tmpstr + Copy(tmpstr2, Position + Length(strOLD), Length(tmpstr2))
   else
     reptext := tmpstr;
 end;


//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.FirewallError(ASender: TObject;
  const bstrError: WideString);
begin
      mmTemp_fwlog.Lines.Add('Error: ' + string( bstrError ))
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.FirewallLog(ASender: TObject;
  const bstrMessage: WideString);
begin
      mmTemp_fwlog.Lines.Add(string( bstrMessage ))
end;

//----------------------------------------------------------------------------------------------------------------------


procedure TMainForm.tmFWlogTimer(Sender: TObject);
var x:integer;
begin
{  if FileExists(apl_path+'\log.fw') then mmTemp_fwlog.Lines.LoadFromFile(apl_path+'\log.fw');
  if FileExists(apl_path+'\log.fw') then deletefile(apl_path+'\log.fw');
  if mmTemp_fwlog.Lines.Count > 0 then
    begin
      for x:=0 to mmTemp_fwlog.Lines.Count-1 do
        begin
          aqFw_log.Insert;
          aqFw_log.FieldByName('xtext').AsString:=mmTemp_fwlog.Lines[x];
          aqFw_log.FieldByName('xdata').Asdatetime:=now;
          aqFw_log.Post;
        end;
      mmTemp_fwlog.lines.Clear;
    end;}
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.SpeedButton5Click(Sender: TObject);
var t:textfile;
    s:string;
begin
  {    assignfile(t,apl_path+'\fw_hook.policy');
      rewrite(t);
      aqFirewall.First;
      while not aqFirewall.Eof do
        begin
          s:=aqFirewall.FieldByName('xaction').Asstring + ' ' +
                    aqFirewall.FieldByName('xprotocol').Asstring + ' '+
                    aqFirewall.FieldByName('xdest').Asstring + ' FROM '+
                    aqFirewall.FieldByName('xip').Asstring + ' TO ANY ';
          writeln(t,s);
          aqFirewall.Next;
        end;
      closefile(t);
      
  mmAFireWall.Lines.LoadFromFile(apl_path+'\fw_hook.policy');    }
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.SpeedButton35Click(Sender: TObject);
begin
 { mmAFireWall.Lines.SaveToFile(apl_path+'\fw_hook.policy');   }
  FirewallStopFirewall;
  FirewallStartFirewall;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.SpeedButton32Click(Sender: TObject);
const
  STYPE_DISKTREE = 0;
  ACCESS_ALL =  258;
  SHI50F_FULL = 258;
var
  FLibHandle : THandle;
  ShareNT : TShareInfo2;
  TmpDir, TmpName: String;
  TmpDirNT, TmpNameNT: PWChar;
  OS: Boolean;
  TmpLength: Integer;
begin
  if not assigned(foDialog) then Application.CreateForm(TfoDialog, foDialog);

  foDialog.ShowModal;

  Self.BringToFront;
  if MainForm.srDir = '' then Exit;

  if not MainForm.IsNT(OS) then Close; //Выясняем тип системы

  if OS then begin //Код для NT
    TmpDir:=MainForm.srDir;
    FLibHandle := LoadLibrary('NETAPI32.DLL');
    if FLibHandle = 0 then Exit;
    @NetShareAddNT := GetProcAddress(FLibHandle,'NetShareAdd');
    if not Assigned(NetShareAddNT) then
    begin
      FreeLibrary(FLibHandle);
      Exit;
    end;
    TmpLength := SizeOF(WideChar)*256; //Определяем необходимый размер

    GetMem(TmpNameNT, TmpLength); //Конвертируем в PWChar
    StringToWideChar(TmpName, TmpNameNT, TmpLength);
    ShareNT.shi2_netname := MainForm.srName; //Имя

    ShareNT.shi2_type := STYPE_DISKTREE; //Тип ресурса
    ShareNT.shi2_remark := MainForm.srComment; //Комментарий
    ShareNT.shi2_permissions := ACCESS_ALL; //Доступ
    ShareNT.shi2_max_uses := DWORD(strtointdef(MainForm.srMaxusers,-1)); //Кол-во максим. подключ.
    ShareNT.shi2_current_uses := 0; //Кол-во тек подкл.

    GetMem(TmpDirNT, TmpLength);
    StringToWideChar(TmpDir, TmpDirNT, TmpLength);
    ShareNT.shi2_path := TmpDirNT; //Путь к ресурсу

    ShareNT.shi2_passwd := MainForm.srPass; //Пароль

    NetShareAddNT(nil,2,@ShareNT, nil); //Добавляем ресурс
    FreeMem (TmpNameNT); //освобождаем память
    FreeMem (TmpDirNT);
    FreeMem (MainForm.srDir);
    FreeMem (MainForm.srComment);
    FreeMem (MainForm.srName);
    FreeMem (MainForm.srPass);
    FreeMem (MainForm.srMaxusers);
  end;
  FreeLibrary(FLibHandle);
 btnGetSharesClick(self);
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.sbFWOnClick(Sender: TObject);
begin
  FirewallStartFirewall;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.sbFWOffClick(Sender: TObject);
begin
  FirewallStopFirewall;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.SpeedButton34Click(Sender: TObject);
begin
   OpenPage(2);
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.SpeedButton36Click(Sender: TObject);
begin
   if MessageDlg('You want to clear log?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes  then
      begin
 { try
  if self.aqLogCleaner.Active then self.aqLogCleaner.Active:=false;
  self.aqLogCleaner.SQL.Clear;
  self.aqLogCleaner.SQL.Add(' delete from fw_log ');
  self.aqLogCleaner.ExecSQL;
  finally
  end;
  aqFw_log.Active:=false;
  aqFw_log.Active:=true;
  RefreshRecordsLabels(self);     }
      end;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.Stop1Click(Sender: TObject);
begin
  FirewallStopFirewall
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.Start2Click(Sender: TObject);
begin
  FirewallStartFirewall
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.ListView_FWLogEnter(Sender: TObject);
begin
     if(ListView_FWLog.Selected<>Nil) then
          ListView_FWLog.Selected.MakeVisible(False);
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

procedure TMainForm.mnuRuleChangePermisionClick(Sender: TObject);
var
    FWRule :TPSMFWRule;
    RuleIdentify:string;
    nIndex:Integer;
    Delim:Integer;

    FromIP:string;
    ToIP:string;

    FromPort:string;
    ToPort:string;
    PortRange:string;

    SlectedItem:TListItem;
    Permision:String;

    PermissionValue:Integer;

    strmsg:string;
begin
     if(ChosenRuleType=IP_RULE_TYPE) then
           begin
               nIndex:=  ListView_FWRule.ItemIndex;
               if(nIndex>=0) then
               begin
                      SlectedItem:= ListView_FWRule.Items.Item[nIndex];
                      RuleIdentify:= SlectedItem.Caption;
                      Delim:=Pos('-',RuleIdentify);
                      FromIP:=Trim(LeftStr(RuleIdentify,Delim-1));
                      ToIP:=Trim(RightStr(RuleIdentify,Length(RuleIdentify)-Delim));


                      PortRange:= SlectedItem.SubItems[0];
                      Permision:= SlectedItem.SubItems[2];

                      Delim:=Pos('-',PortRange);
                      FromPort:=Trim(LeftStr(PortRange,Delim-1));
                      ToPort:=Trim(RightStr(PortRange,Length(PortRange)-Delim));

                      if(Permision='DENY') then PermissionValue:=0
                        else  PermissionValue:=1;

                      strmsg:='IP Rule : '#13#10'IP range:   [From '+ FromIP+' , To '+ ToIP+']'#13#10;
                      strmsg:=strmsg+'Port range:   ['+FromPort+', '+ ToPort+']'#13#10;
                      strmsg:=strmsg+'Permission:   '+ Permision+''#13#10;
                      strmsg:=strmsg+'**********************'#13#10;
                      if(Permision='DENY') then
                           strmsg:=strmsg+'Change permission to (Allow)?'
                      else  strmsg:=strmsg+'Change permission to (Deny)?';



                      if Application.MessageBox(PChar(strmsg),'PSM Firewall', MB_YESNO) = IDYES then
                        begin
                            if(Permision='DENY') then
                                begin
                                        FWRule.ModifyIPrule(Pchar(fromIP),PChar(toIP),StrToInt(fromPort),strtoint(toPort),StrToInt(fromPort),strtoint(toPort),1);
                                        SlectedItem.SubItems[2]:='ALLOW';
                                end
                            else
                                begin
                                        FWRule.ModifyIPrule(Pchar(fromIP),PChar(toIP),StrToInt(fromPort),strtoint(toPort),strtoint(fromPort),strtoint(toPort),0) ;
                                        SlectedItem.SubItems[2]:='DENY' ;
                                end;
                            if(Mainform.sbFWOn.Enabled) then ApplyFWStatus(1);
                        end

                        //   Application.MessageBox('No rule is selected', 'PSM Firewall', MB_OK);
               end;
           end
        else if(ChosenRuleType=PATH_RULE_TYPE) then
           begin
                nIndex:=  Path_List.ItemIndex;
                if(nIndex>=0) then
                    begin
                         SlectedItem:=Path_List.Items.Item[nIndex];
                         RuleIdentify:= SlectedItem.Caption;
                         Permision:= SlectedItem.SubItems[0];

                         strmsg:='Application rule : '#13#10'program path =   '+RuleIdentify+' '#13#10;
                         strmsg:=strmsg+'Permission:   '+ Permision+''#13#10;
                         strmsg:=strmsg+'**********************'#13#10;
                         if(Permision='DENY') then
                           strmsg:=strmsg+'Change permission to (Allow)?'
                         else  strmsg:=strmsg+'Change permission to (Deny)?';

                        if Application.MessageBox(PChar(strmsg),'PSM Firewall', MB_YESNO) = IDYES then
                             begin
                                   if(Permision='DENY') then
                                         begin
                                             FWRule.ModifyPathrule(Pchar(RuleIdentify),1) ;
                                             SlectedItem.SubItems[0]:='ALLOW';
                                          end
                                   else
                                         begin
                                            FWRule.ModifyPathrule(Pchar(RuleIdentify),0) ;
                                            SlectedItem.SubItems[0]:='DENY' ;
                                          end;
                                    if(Mainform.sbFWOn.Enabled) then
                                             ApplyFWStatus(1);
                             end;
                    end
                else
                        begin
                              Application.MessageBox('No rule is selected', 'PSM Firewall', MB_OK);
                        end;
           end;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.mnuRuleAddnewClick(Sender: TObject);

begin
            Form_FWRule.FWRule.ActivePage:=Form_FWRule.IpRulePage;
            Form_FWRule.ShowModal;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.DeleteClick(Sender: TObject);
var
     nIndex: Integer;
     //strFileName: String;
     //bSuccess: Boolean;
     //TempFile: TextFile;
     //Huy
     RuleIdentify: String;
     //StrTmp:String;
     FromIP,ToIP:string;
     FWRule: TPSMFWRule;
     Delim: Integer;

     //h:String;
begin
        nIndex:= ListView_FWRule.ItemIndex;

     if((nIndex >= 0) and (ChosenRuleType=IP_RULE_TYPE)) then begin
          if Application.MessageBox('Delete the selected IP/Port rule?', 'Firewall', MB_YESNO) = IDYES then begin
               {Remove from Registry}
               RuleIdentify:= ListView_FWRule.Items.Item[nIndex].Caption;
               Delim:=Pos('-',RuleIdentify);
               FromIP:=Trim(LeftStr(RuleIdentify,Delim-1));
               ToIP:=Trim(RightStr(RuleIdentify,Length(RuleIdentify)-Delim));
               //AnsiReplaceStr(RuleIdentify,'-','|');
               FWRule.RemoveIPRule(PChar(FromIP),PChar(ToIP));
               {Remore from Displaying List}
               ListView_FWRule.Items.Delete(nIndex);

               if(Mainform.sbFWOn.Enabled)then
                ApplyFWStatus(1);

          end;

     end else begin //No rule is selected in IP Rule list, then try with Path List
          nIndex:= Path_List.ItemIndex;
          if(( nIndex>=0) and (ChosenRuleType=PATH_RULE_TYPE)) then
               begin
                    if Application.MessageBox('Delete the selected application rule?', 'PSM Firewall', MB_YESNO) = IDYES then begin
                        //delete from registry
                        RuleIdentify:= Path_List.Items.Item[nIndex].Caption;
                        FWRule.RemovePathRule(Pchar(RuleIdentify));
                        //delre from List
                        Path_List.Items.Delete(nIndex);
                        if(Mainform.sbFWOn.Enabled)then
                              ApplyFWStatus(1);
                    end;
               end
          else
           Application.MessageBox('Select the rule first!', 'Shareview', MB_OK);
     end;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.RxTrayIcon1Click(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  RxTrayIcon1DblClick(self);
end;

//----------------------------------------------------------------------------------------------------------------------

{Implement Log process call back function}//20040226
Procedure PSMFW_Callback(name : pchar;
                                messageBuf : pointer; messageLen : dword;
                                answerBuf  : pointer    ; answerLen  : dword); stdcall;

Var
     HMapMutex: THandle;
     LogItems:TPSMFWLog;
     //ListItem: TListItem;
     //strTmp:String;
     //NumberOflogLine: Integer;

     MyLogID:Integer;
begin
    //Check where there is space character
    //at the beginning of the line
    //OutputDebugString(messageBuf);
    if(String(messageBuf)[1]=' ') then Exit;

    MyLogID:=-1;
    HMapMutex := CreateMutex(nil, false, pchar('PSMFirewallApplication'));
    if HMapMutex <> 0 then begin
      if WaitForSingleObject(HMapMutex,100) = WAIT_OBJECT_0 then  begin
        LogID:=(LogID mod LogBuffSize) + 1;
        MyLogID:=LogID;
      end;
      ReleaseMutex(HMapMutex);
      CloseHandle(HMapMutex);
    end;

    if MyLogID>=0 then
    with LogItems do begin
      LogItems:= TPSMFWLog.Create;
      LogItems.AssignLogItems(messageBuf);

      Logs[MyLogID].mTime:=mTime;
      Logs[MyLogID].mDirection:=mDirection;
      Logs[MyLogID].mPermit:=mPermit;
      Logs[MyLogID].mIP:=mIP;
      Logs[MyLogID].mHostName:=mHostName;
      Logs[MyLogID].mPort:=mPort;
      Logs[MyLogID].mPath:=mPath;
      Logs[MyLogID].mToltalRec:=mToltalRec;
      Logs[MyLogID].mToltalSen:=mToltalSen;
      Logs[MyLogID].mTotalRecSen:=mTotalRecSen;
      Logs[MyLogID].mSockNo:=mSockNo;
      Free;
      PostMessage(mainHWND,WM_USER,MyLogID,MyLogID);
    end;//with LogItems do begin
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.FormShow(Sender: TObject);
var
     fwRule:TPSMFWRule;
     ruleList:TStringList;


     ListItem: TListItem;
     i: Integer;
     //for IP rules
     fromIP: string;
     toIP: string;
     fromPort: Integer;
     toPort: Integer;
     //for Path rules
     Path: string;
     Permit: Integer;

     bCheck: boolean;

     imIndex:Integer;
begin

  //Start FireWall Log here--huynote

     bCheck:= CreateIpcQueue('PSMFirewall', PSMFW_Callback);
     if(not bCheck)then
        Showmessage('Error when starting logging Firewall!')
     else
         isLogStarted:=True;

  ruleList:=TStringList.Create;
  fwRule.GetIPRuleList(ruleList);
  //For IP Rule
  for i:=0 to ruleList.Count-1 do
  begin
      fwRule.ExtractIPRule(ruleList[i],fromIP,toIP,fromPort,toPort,Permit);
      ListItem:= ListView_FWRule.Items.Add;
      ListItem.ImageIndex:=5;
      ListItem.Caption:= fromIp+' -'+toIP;
      ListItem.SubItems.Add(Format('%d -%d',[fromPort,toPort])) ;
      ListItem.SubItems.Add('TCP/UDP');
      if( permit=1) then
          ListItem.SubItems.Add('ALLOW')
      else
          ListItem.SubItems.Add('DENY');
  end;
  //For Path Rule
  ruleList.Clear;
  ImageListForAppPath.Clear;

  fwRule.GetPathRuleList(ruleList);
  for i:=0 to ruleList.Count-1 do
  begin
      fwRule.ExtractPathRule(ruleList[i],path, Permit);
      imIndex:=ImageListForAppPath.AddIcon(Form_FWRule.GetICON(path));

      ListItem:= Path_List.Items.Add;
      ListItem.Caption:= path;
      ListItem.ImageIndex:=  imIndex;
      if permit=1 then
          ListItem.SubItems.Add('ALLOW')
          //ListItem.SubItems.i
      else
          ListItem.SubItems.Add('DENY');
  end;
  ruleList.Free;

  //For security level.
   TrackBar_Level.Position:=2-fwRule.GetSecurityLevel;

   TrackBar_LevelChange(nil);
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.TrackBar_LevelChange(Sender: TObject);

var
     nLevel: Integer;
begin
     nLevel:= 2 - TrackBar_Level.Position;
     if (nLevel = 0) then begin
          Label_Level0.Caption:= 'Low';
          Label_Level2.Caption:= '- All IP/Ports are allow except:';
          Label_Level3.Caption:= '- All dened IP/Ports in the rule set are blocked';
     end else if (nLevel = 1) then begin
          Label_Level0.Caption:= 'Medium';
          Label_Level2.Caption:= '- Allow only Well - Known Ports';
          Label_Level3.Caption:= '- All dened IP/Ports in the rule set are blocked'
     end else if (nLevel = 2) then begin
          Label_Level0.Caption:= 'High';
          Label_Level2.Caption:= '- Block all IP/Ports except:';
          Label_Level3.Caption:= '- All allowed IP/Ports in the rule set are allowed'
     end;
     //Btn_Level_OK.Enabled:= True;

end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.SpeedButton38Click(Sender: TObject);

var
     nLevel: Integer;
     fwRuler:TPSMFWRule;
begin
     nLevel:= 2 - TrackBar_Level.Position;
     fwRuler.SetSecurityLevel(nLevel);

     if(MainForm.sbFWOn.Enabled)then ApplyFWStatus(1);
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.SpeedButton37Click(Sender: TObject);
var
     nLevel: Integer;
     fwRule:TPSMFWRule;
begin
     nLevel:=fwRule.GetSecurityLevel;
     TrackBar_Level.Position:= 2 - nLevel;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.SpeedButton24Click(Sender: TObject);
var t:textfile;
    x:integer;
  Src, Str: PansiChar;
  s:string;
begin
      showwait;
      mmNetstat.Lines.Clear;
      deletefile(apl_path+'\ping2.bat');
      assignfile(t,apl_path+'\ping2.bat');
      rewrite(t);
      s:='';
      if cbNetstat_a.Checked then s:=s+' -a ';
      if cbNetstat_b.Checked then s:=s+' -b ';
      if cbNetstat_n.Checked then s:=s+' -n ';
      if cbNetstat_e.Checked then s:=s+' -e ';
      if cbNetstat_r.Checked then s:=s+' -r ';
      if cbNetstat_o.Checked then s:=s+' -o ';
      if cbNetstat_v.Checked then s:=s+' -v ';
      if cbNetstat_s.Checked then s:=s+' -s ';
      writeln(t,'netstat ' + s + ' >' + apl_path + '\ping2.bak');
      closefile(t);
      ExecAndWait(apl_path+'\ping2.bat','' ,0);
      deletefile(apl_path+'\ping2.bat');
      mmTemp.Lines.LoadFromFile(apl_path+'\ping2.bak');
      deletefile(apl_path+'\ping2.bak');

      Src := mmTemp.Lines.GetText; //Берем текст из TMemo как тип PChar
      str := src;
      OemToChar(src, Str); //API функция для перевода текста
      mmTemp.Lines.Text := StrPas(Str);//Записываем назад
      for x:=0 to mmtemp.Lines.count-1 do mmNetstat.Lines.Add(mmtemp.Lines[x]);
      closewait;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.CaptureMIBData( InitFlag: boolean );

//var
// MibArr : IpHlpAPI.TMIBIfArray;
begin
 { Get_IfTableMIB( MibArr );  // get current MIB data
  if InitFlag  then
    InitGrid( MibArr ) // initialise grid & counters
  else
    Data2Grid( MibArr );  // show data     }
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainform.ClearCounters;
begin
 CaptureMIBData( true );
 CaptureMIBData( false);
end;

//----------------------------------------------------------------------------------------------------------------------

{procedure TMainform.Data2Grid( MIBArr: IpHlpAPI.TMIBIFArray );
var
 i : integer;
begin

  for i := low(MIBArr) to High(MIBArr) do
    with MIBArr[i] do
    begin

     with StatArr[i] do
     begin
       InPerSec  := dwInOctets - PrevCountIn;
       inc(TotalIn, InPerSec);
       if InPerSec > 0 then
          inc(ActivecountIn);
       PrevCountIn := dwInOctets;
       //
       OutPerSec := dwOutOctets - PrevCountOut;
       inc(TotalOut,OutPerSec);
       if OutPerSec > 0 then
          inc(ActivecountOut);
       PrevCountOut  := dwOutOctets;
       // peak values
       if InPerSec > PeakInPerSec then
           PeakInPersec := InPersec;
       if OutPerSec > PeakOutPerSec then
           PeakOutPerSec := OutPerSec;

       // update grid
        sgMIB.Cells[3, i+1] :=  IntToStr( InPerSec) ;
        sgMIB.Cells[4, i+1] :=  IntToStr( PeakInPerSec ) ;
        if ActiveCountIn > 0 then
          sgMIB.Cells[5, i+1] :=  IntToStr( TotalIn div ActiveCountIn)
        else
          sgMIB.Cells[5, i+1] := '  --  ';
        sgMIB.Cells[6, i+1] :=  IntToStr( OutPerSec) ;
        sgMIB.Cells[7, i+1] :=  IntToStr( PeakOutPerSec) ;
        if ActiveCountOut > 0 then
         sgMIB.Cells[8, i+1] :=  IntToStr( TotalOut div ActiveCountOut)
        else
          sgMIB.Cells[8, i+1] := '  --  ';
     end;


    end;
end; }

//----------------------------------------------------------------------------------------------------------------------

{function TMainform.GetIPFromIFIndex( InterfaceIndex: integer ): string;
var
 i:  integer;
 IPArr : TMIBIPAddrArray;
begin
   Result := '!not_found!';  // shouldn't happen...
   Get_IPAddrTableMIB( IpArr );  // get IP-address table
   if Length(IPArr) > 0 then
     for i := low(IPArr) to High(IPArr) do  // look for matching index...
       if IPArr[i].dwIndex = InterfaceIndex then
       begin
         Result := IPAddr2Str(IParr[i].dwAddr);
         BREAK;
       end;
end; }


//----------------------------------------------------------------------------------------------------------------------

// initialise stat variables & grid
{procedure TMainform.InitGrid( MibArr: IpHlpAPI.TMibIFArray );
var
 i     : integer;
 IPArr : TMibIPAddrArray;

 Descr: string;
begin
  if Length(MibArr) > 0 then
  begin
    sgMib.RowCount := succ(Length( MibArr ));
    SetLength( StatArr, Length(MibArr));
    for i := low(MIBArr) to High(MIBArr) do
    with MIBArr[i] do
    begin
     StatArr[i].ActiveCountIn := 0;
     StatArr[i].ActiveCountOut:= 0;
     StatArr[i].PrevCountIn := dwInOctets;
     StatArr[i].PrevCountOut:= dwOutOctets;
     StatArr[i].TotalIn := 0;
     StatArr[i].TotalOut:= 0;
     StatArr[i].InPerSec:= 0;
     StatArr[i].OutPerSec:= 0;
     StatArr[i].PeakInPerSec := 0;
     StatArr[i].PeakOutPerSec:=0;
     SetLength( Descr, pred(dwDescrLen));
     move(bDescr, Descr[1], pred(dwDescrLen));
     // adapter description
     sgMIB.Cells[0, succ(i)] := Trim(Descr) ;
     // adapter MAC address
     sgMIB.Cells[1, succ(i)] := MacAddr2Str( TMacAddress( bPhysAddr ), dwPhysAddrLen );
     // adapter IP address
     sgMIB.Cells[2, succ(i)] := GetIPFromIFIndex( MIBArr[i].dwIndex);
     //
    end;
  end;
end;  }


//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.sbTrafficStartClick(Sender: TObject);
begin
{  sbTrafficStart.Enabled := false;
  sbTrafficStop.Enabled  := true;
  tmrTraffic.Enabled := true;}
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.sbTrafficStopClick(Sender: TObject);
begin
{  sbTrafficStart.Enabled := true;
  sbTrafficStop.Enabled  := false;
  tmrTraffic.Enabled := true;}
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.SpeedButton30Click(Sender: TObject);
begin
   ClearCounters;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.tmTrafficTimer(Sender: TObject);
begin
  tmTraffic.Enabled := false;
  CaptureMIBData( false );
  mainform.Get_TCPTable();
  tmTraffic.Enabled := true;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.Get_TCPTable;
var
  UDPRow        : TMIBUDPRow;
  TCPRow        : TMIBTCPRow;
  i, NumEntries : integer;
  TableSize     : DWORD;
  ErrorCode     : DWORD;
  DestIP        : string;
  pBuf          : PChar;
  recs          : integer;
begin
// calc records count
 // RecentIPs.Clear;
  // first call : get size of table
  TableSize := 0;
  NumEntries := 0 ;
  recs := 0;
  ErrorCode := GetTCPTable(Nil, @TableSize, false );  // Angus
  if Errorcode <> ERROR_INSUFFICIENT_BUFFER then
    EXIT;

  // get required memory size, call again
  GetMem( pBuf, TableSize );
  // get table

  ErrorCode := GetTCPTable( PTMIBTCPTable( pBuf ), @TableSize, false );
  if ErrorCode = NO_ERROR then
  begin

    NumEntries := PTMIBTCPTable( pBuf )^.dwNumEntries;
    if NumEntries > 0 then recs:=recs + NumEntries;
  end;

  FreeMem( pBuf );

  // first call : get size of table
  TableSize := 0;
  NumEntries := 0 ;
  ErrorCode := GetUDPTable(Nil, @TableSize, false );
  if Errorcode <> ERROR_INSUFFICIENT_BUFFER then
    EXIT;

  // get required size of memory, call again
  GetMem( pBuf, TableSize );

  // get table
  ErrorCode := GetUDPTable( PTMIBUDPTable( pBuf ), @TableSize, false );
  if ErrorCode = NO_ERROR then
  begin
    NumEntries := PTMIBUDPTable( pBuf )^.dwNumEntries;
    if NumEntries > 0 then recs:=recs + NumEntries;
  end;

  FreeMem( pBuf );

// fill listview
 if recs<>lvTCPConnections.Items.Count then
 begin
 // RecentIPs.Clear;
  // first call : get size of table
  TableSize := 0;
  NumEntries := 0 ;
  ErrorCode := GetTCPTable(Nil, @TableSize, false );  // Angus
  if Errorcode <> ERROR_INSUFFICIENT_BUFFER then
    EXIT;

  // get required memory size, call again
  GetMem( pBuf, TableSize );
  // get table
  lvTCPConnections.Items.Clear;
  ErrorCode := GetTCPTable( PTMIBTCPTable( pBuf ), @TableSize, false );
  if ErrorCode = NO_ERROR then
  begin

    NumEntries := PTMIBTCPTable( pBuf )^.dwNumEntries;
    if NumEntries > 0 then
    begin
      inc( pBuf, SizeOf( DWORD ) ); // get past table size
      for i := 1 to NumEntries do
      begin
        TCPRow := PTMIBTCPRow( pBuf )^; // get next record
        with TCPRow do
        begin
          if dwRemoteAddr = 0 then
            dwRemotePort := 0;
          DestIP := IPAddr2Str( dwRemoteAddr );
      with lvTCPConnections.Items.Add do  //Заполнение данными из структуры
      begin

       { if host2ip(string(SessionInfo502_compare[n].Sesi502_cname))<>'0.0.0.0' then
         SessionInfo502_compare[length(SessionInfo502_compare)-1].Sesi502_cname:=pwchar(WideString(host2ip(string(SessionInfo502_compare[n].Sesi502_cname))))
           else }
        Caption := string('TCP');
        SubItems.Add(trim(string(IpAddr2Str( dwLocalAddr ))));
        SubItems.Add(trim(string(Port2Svc( Port2Wrd( dwLocalPort ) ))));
        SubItems.Add(trim(string(DestIP)));
        SubItems.Add(trim(string(Port2Svc( Port2Wrd( dwRemotePort ) ))));
        SubItems.Add(trim(string(TCPConnState[dwState])));
      end;
           { if (not ( dwRemoteAddr = 0 ))
            and ( RecentIps.IndexOf(DestIP) = -1 ) then
               RecentIPs.Add( DestIP );   }
        end;
        inc( pBuf, SizeOf( TMIBTCPRow ) );
      end;
    end;
  end;
  dec( pBuf, SizeOf( DWORD ) + NumEntries * SizeOf( TMibTCPRow ) );
  FreeMem( pBuf );



  // first call : get size of table
  TableSize := 0;
  NumEntries := 0 ;
  ErrorCode := GetUDPTable(Nil, @TableSize, false );
  if Errorcode <> ERROR_INSUFFICIENT_BUFFER then
    EXIT;

  // get required size of memory, call again
  GetMem( pBuf, TableSize );

  // get table
  ErrorCode := GetUDPTable( PTMIBUDPTable( pBuf ), @TableSize, false );
  if ErrorCode = NO_ERROR then
  begin
    NumEntries := PTMIBUDPTable( pBuf )^.dwNumEntries;
    if NumEntries > 0 then
    begin
      inc( pBuf, SizeOf( DWORD ) ); // get past table size
      for i := 1 to NumEntries do
      begin
        UDPRow := PTMIBUDPRow( pBuf )^; // get next record

      with lvTCPConnections.Items.Add do  //Заполнение данными из структуры
      begin

        Caption := string('UDP');
        SubItems.Add(trim(IpAddr2Str(UDPRow.dwLocalAddr )));
        SubItems.Add(trim(Port2Svc( Port2Wrd( UDPRow.dwLocalPort ) )));
      end;
        inc( pBuf, SizeOf( TMIBUDPRow ) );
      end;
    end;

  end;
  dec( pBuf, SizeOf( DWORD ) + NumEntries * SizeOf( TMibUDPRow ) );
  FreeMem( pBuf );
 end;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.DOIpStuff;
begin
//  Get_NetworkParams( NwMemo.Lines );
//  Get_ARPTable( ARPMemo.Lines );
  Get_TCPTable(  );
//  Get_TCPStatistics( TCPStatMemo.Lines );
//  Get_UDPTable( UDPMemo.Lines );
//  Get_IPStatistics( IPStatsMemo.Lines );
//  Get_IPAddrTable( IPAddrMemo.Lines );
//  Get_IPForwardTable( IPForwMemo.Lines );
//  Get_UDPStatistics( UDPStatsMemo.Lines );
//  Get_AdaptersInfo( AdaptMemo.Lines );
//  Get_ICMPStats( ICMPInMemo.Lines, ICMPOutMemo.Lines );
//  Get_IfTable( IfMemo.Lines );
//  Get_RecentDestIPs( cbRecentIPs.Items );
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.lvTraffic2Click(Sender: TObject);
var i:integer;
    spIn,spOut:integer;
begin
  for i:=0 to lvTraffic2.Items.Count-1 do
   if lvTraffic2.Items[i].Selected then
    begin
      lbConnection.Caption:=Table.Table[i].bDescr;

      lbMac.Caption:=GetMAC(TMAC(Table.Table[i].bPhysAddr), Table.Table[i].dwPhysAddrLen);
      lbSpeed.Caption:=Format('%g Mbit ', [Table.Table[i].dwSpeed / 1000000]);

      spIn:=Table.Table[i].dwInOctets-spIn_Last;
      spOut:=Table.Table[i].dwOutOctets-spOut_Last;

        if (spin <= exp(20*ln(2)))  then
          lbSpIn.Caption:=Format('%n KB ', [spin / exp(10*ln(2))]);
        if (spin > exp(20*ln(2)))  then
          lbSpIn.Caption:=Format('%n MB ', [spin / exp(20*ln(2))]);

        if (spout <= exp(20*ln(2)))  then
          lbSpout.Caption:=Format('%n KB ', [spout / exp(10*ln(2))]);
        if (spout > exp(20*ln(2)))  then
          lbSpout.Caption:=Format('%n MB ', [spout / exp(20*ln(2))]);

      lbin.caption:=Format('%n MB', [Table.Table[i].dwInOctets / exp(20*ln(2))]);
      lbOut.caption:=Format('%n MB', [Table.Table[i].dwOutOctets / exp(20*ln(2))]);
      lbErrorsin.caption:=Format('%g ', [Table.Table[i].dwInErrors / 1]);
      lbErrorsout.caption:=Format('%g ', [Table.Table[i].dwOutErrors / 1]);

      lbmtu.caption:=Format('%g ', [Table.Table[i].dwMtu / 1]);
      lbPacketsin.caption:=Format('%g ', [Table.Table[i].dwInUcastPkts / 1]);
      lbPacketsOut.caption:=Format('%g ', [Table.Table[i].dwOutUcastPkts / 1]);

      lbDiscardsIn.caption:=Format('%g ', [Table.Table[i].dwInDiscards / 1]);
      lbDiscardsOut.caption:=Format('%g ', [Table.Table[i].dwOutDiscards / 1]);
      spIn_Last:=Table.Table[i].dwInOctets;
      spOut_Last:=Table.Table[i].dwOutOctets;
 //     lbDiscardsOut.caption:=Table.Table[i].bDescr;
//      lbDiscardsOut.caption:=Format('%g ', [Table.Table[i].dwLastChange/ 1]);


    end;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.Adddenyruletofirewall1Click(Sender: TObject);

var psmFWRule:TPSMFWRule;
    s:string;
    ListItem: TListItem;

begin
  s:=Host2IP((WideString(lvSessions.Items.Item[i].Caption)));
  if(psmFWRule.IPRuleExisted(pchar(s),pchar(s),1,65535,0)=False)then
    begin
      ListItem:= mainform.ListView_FWRule.Items.Add;
      ListItem.ImageIndex:=5;
      ListItem.Caption:= s + ' - ' + s;
      ListItem.SubItems.Add('00001 - 65535');
      ListItem.SubItems.Add('TCP/UDP');
      ListItem.SubItems.Add('DENY');

      psmFWRule.AddIPRule(pchar(s),pchar(s),1,65535,0);
      ApplyFWStatus(1)
    end;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.Adddenyruletofirewall2Click(Sender: TObject);
var psmFWRule:TPSMFWRule;
    s:string;
    ListItem: TListItem;

begin
  s:=Host2IP((WideString(lvSessions.Items.Item[i].Caption)));
  if(psmFWRule.IPRuleExisted(pchar(s),pchar(s),1,65535,1)=False)then
    begin
      ListItem:= mainform.ListView_FWRule.Items.Add;
      ListItem.ImageIndex:=5;
      ListItem.Caption:= s + ' - ' + s;
      ListItem.SubItems.Add('00001 - 65535');
      ListItem.SubItems.Add('TCP/UDP');
      ListItem.SubItems.Add('DENY');

      psmFWRule.AddIPRule(pchar(s),pchar(s),1,65535,1);
      ApplyFWStatus(1)
    end;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.Get_TCPStatistics( List: TStrings );
var
  TCPStats      : TMibTCPStats;
  ErrorCode     : DWORD;
begin
  if not Assigned( List ) then EXIT;
  List.Clear;
  if NOT LoadIpHlp then exit ;
  ErrorCode := GetTCPStatistics( @TCPStats );
  if ErrorCode = NO_ERROR then
    with TCPStats do
    begin
      List.Add( 'Retransmission algorithm : ' + TCPToAlgo[dwRTOAlgorithm] );
      List.Add( 'Minimum Time-Out         : ' + IntToStr( dwRTOMin ) + ' ms' );
      List.Add( 'Maximum Time-Out         : ' + IntToStr( dwRTOMax ) + ' ms' );
      List.Add( 'Maximum Pend.Connections : ' + IntToStr( dwRTOAlgorithm ) );
      List.Add( 'Active Opens             : ' + IntToStr( dwActiveOpens ) );
      List.Add( 'Passive Opens            : ' + IntToStr( dwPassiveOpens ) );
      List.Add( 'Failed Open Attempts     : ' + IntToStr( dwAttemptFails ) );
      List.Add( 'Established conn. Reset  : ' + IntToStr( dwEstabResets ) );
      List.Add( 'Current Established Conn.: ' + IntToStr( dwCurrEstab ) );
      List.Add( 'Segments Received        : ' + IntToStr( dwInSegs ) );
      List.Add( 'Segments Sent            : ' + IntToStr( dwOutSegs ) );
      List.Add( 'Segments Retransmitted   : ' + IntToStr( dwReTransSegs ) );
      List.Add( 'Incoming Errors          : ' + IntToStr( dwInErrs ) );
      List.Add( 'Outgoing Resets          : ' + IntToStr( dwOutRsts ) );
      List.Add( 'Cumulative Connections   : ' + IntToStr( dwNumConns ) );
    end
  else
    List.Add( SyserrorMessage( ErrorCode ) );
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.Get_IPStatistics( List: TStrings );
var
  IPStats       : TMibIPStats;
  ErrorCode     : integer;
begin
  if not Assigned( List ) then EXIT;
  if NOT LoadIpHlp then exit ;
  ErrorCode := GetIPStatistics( @IPStats );
  if ErrorCode = NO_ERROR then
  begin
    List.Clear;
    with IPStats do
    begin
      if dwForwarding = 1 then
        List.add( 'Forwarding Enabled      : ' + 'Yes' )
      else
        List.add( 'Forwarding Enabled      : ' + 'No' );
      List.add( 'Default TTL             : ' + inttostr( dwDefaultTTL ) );
      List.add( 'Datagrams Received      : ' + inttostr( dwInReceives ) );
      List.add( 'Header Errors     (In)  : ' + inttostr( dwInHdrErrors ) );
      List.add( 'Address Errors    (In)  : ' + inttostr( dwInAddrErrors ) );
      List.add( 'Datagrams Forwarded     : ' + inttostr( dwForwDatagrams ) );   // Angus
      List.add( 'Unknown Protocols (In)  : ' + inttostr( dwInUnknownProtos ) );
      List.add( 'Datagrams Discarded     : ' + inttostr( dwInDiscards ) );
      List.add( 'Datagrams Delivered     : ' + inttostr( dwInDelivers ) );
      List.add( 'Requests Out            : ' + inttostr( dwOutRequests ) );
      List.add( 'Routings Discarded      : ' + inttostr( dwRoutingDiscards ) );
      List.add( 'No Routes        (Out)  : ' + inttostr( dwOutNoRoutes ) );
      List.add( 'Reassemble TimeOuts     : ' + inttostr( dwReasmTimeOut ) );
      List.add( 'Reassemble Requests     : ' + inttostr( dwReasmReqds ) );
      List.add( 'Succesfull Reassemblies : ' + inttostr( dwReasmOKs ) );
      List.add( 'Failed Reassemblies     : ' + inttostr( dwReasmFails ) );
      List.add( 'Succesful Fragmentations: ' + inttostr( dwFragOKs ) );
      List.add( 'Failed Fragmentations   : ' + inttostr( dwFragFails ) );
      List.add( 'Datagrams Fragmented    : ' + inttostr( dwFRagCreates ) );
      List.add( 'Number of Interfaces    : ' + inttostr( dwNumIf ) );
      List.add( 'Number of IP-addresses  : ' + inttostr( dwNumAddr ) );
      List.add( 'Routes in RoutingTable  : ' + inttostr( dwNumRoutes ) );
    end;
  end
  else
    List.Add( SysErrorMessage( ErrorCode ) );
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.Get_UdpStatistics( List: TStrings );
var
  UdpStats      : TMibUDPStats;
  ErrorCode     : integer;
begin
  if not Assigned( List ) then EXIT;
  ErrorCode := GetUDPStatistics( @UdpStats );
  if ErrorCode = NO_ERROR then
  begin
    List.Clear;
    with UDPStats do
    begin
      List.add( 'Datagrams (In)    : ' + inttostr( dwInDatagrams ) );
      List.add( 'Datagrams (Out)   : ' + inttostr( dwOutDatagrams ) );
      List.add( 'No Ports          : ' + inttostr( dwNoPorts ) );
      List.add( 'Errors    (In)    : ' + inttostr( dwInErrors ) );
      List.add( 'UDP Listen Ports  : ' + inttostr( dwNumAddrs ) );
    end;
  end
  else
    List.Add( SysErrorMessage( ErrorCode ) );
end;

//----------------------------------------------------------------------------------------------------------------------

function IpHlpUdpStatistics (UdpStats: TMibUDPStats): integer ;     // Angus
begin
    result := ERROR_NOT_SUPPORTED ;
    if NOT LoadIpHlp then exit ;
    result := GetUDPStatistics (@UdpStats) ;
end ;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.Get_ICMPStats( ICMPIn, ICMPOut: TStrings );
var
  ErrorCode     : DWORD;
  ICMPStats     : PTMibICMPInfo;
begin
  if ( ICMPIn = nil ) or ( ICMPOut = nil ) then EXIT;
  ICMPIn.Clear;
  ICMPOut.Clear;
  New( ICMPStats );
  ErrorCode := GetICMPStatistics( ICMPStats );
  if ErrorCode = NO_ERROR then
  begin
    with ICMPStats.InStats do
    begin
      ICMPIn.Add( 'Messages received    : ' + IntToStr( dwMsgs ) );
      ICMPIn.Add( 'Errors               : ' + IntToStr( dwErrors ) );
      ICMPIn.Add( 'Dest. Unreachable    : ' + IntToStr( dwDestUnreachs ) );
      ICMPIn.Add( 'Time Exceeded        : ' + IntToStr( dwTimeEcxcds ) );
      ICMPIn.Add( 'Param. Problems      : ' + IntToStr( dwParmProbs ) );
      ICMPIn.Add( 'Source Quench        : ' + IntToStr( dwSrcQuenchs ) );
      ICMPIn.Add( 'Redirects            : ' + IntToStr( dwRedirects ) );
      ICMPIn.Add( 'Echo Requests        : ' + IntToStr( dwEchos ) );
      ICMPIn.Add( 'Echo Replies         : ' + IntToStr( dwEchoReps ) );
      ICMPIn.Add( 'Timestamp Requests   : ' + IntToStr( dwTimeStamps ) );
      ICMPIn.Add( 'Timestamp Replies    : ' + IntToStr( dwTimeStampReps ) );
      ICMPIn.Add( 'Addr. Masks Requests : ' + IntToStr( dwAddrMasks ) );
      ICMPIn.Add( 'Addr. Mask Replies   : ' + IntToStr( dwAddrReps ) );
    end;
     //
    with ICMPStats.OutStats do
    begin
      ICMPOut.Add( 'Messages sent        : ' + IntToStr( dwMsgs ) );
      ICMPOut.Add( 'Errors               : ' + IntToStr( dwErrors ) );
      ICMPOut.Add( 'Dest. Unreachable    : ' + IntToStr( dwDestUnreachs ) );
      ICMPOut.Add( 'Time Exceeded        : ' + IntToStr( dwTimeEcxcds ) );
      ICMPOut.Add( 'Param. Problems      : ' + IntToStr( dwParmProbs ) );
      ICMPOut.Add( 'Source Quench        : ' + IntToStr( dwSrcQuenchs ) );
      ICMPOut.Add( 'Redirects            : ' + IntToStr( dwRedirects ) );
      ICMPOut.Add( 'Echo Requests        : ' + IntToStr( dwEchos ) );
      ICMPOut.Add( 'Echo Replies         : ' + IntToStr( dwEchoReps ) );
      ICMPOut.Add( 'Timestamp Requests   : ' + IntToStr( dwTimeStamps ) );
      ICMPOut.Add( 'Timestamp Replies    : ' + IntToStr( dwTimeStampReps ) );
      ICMPOut.Add( 'Addr. Masks Requests : ' + IntToStr( dwAddrMasks ) );
      ICMPOut.Add( 'Addr. Mask Replies   : ' + IntToStr( dwAddrReps ) );
    end;
  end
  else
    IcmpIn.Add( SysErrorMessage( ErrorCode ) );
  Dispose( ICMPStats );
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.Page_Traf_StatShow(Sender: TObject);
begin
  mainform.Get_TCPStatistics( TCPStatMemo.Lines );
  mainform.Get_IPStatistics( IPStatsMemo.Lines );
  mainform.Get_UDPStatistics( UDPStatsMemo.Lines );
  mainform.Get_ICMPStats( ICMPInMemo.Lines, ICMPOutMemo.Lines );
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.MenuItem4Click(Sender: TObject);
begin

end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.MenuItem5Click(Sender: TObject);
var
     nIndex: Integer;
     //strFileName: String;
     //bSuccess: Boolean;
     //TempFile: TextFile;
     //Huy
     RuleIdentify: String;
     //StrTmp:String;
     FromIP,ToIP:string;
     FWRule: TPSMFWRule;
     Delim: Integer;

     //h:String;
begin
 //No rule is selected in IP Rule list, then try with Path List
          nIndex:= Path_List.ItemIndex;
          if(nIndex>=0) then
               begin
                    if Application.MessageBox('Delete the selected application rule?', 'PSM Firewall', MB_YESNO) = IDYES then begin
                        //delete from registry
                        RuleIdentify:= Path_List.Items.Item[nIndex].Caption;
                        FWRule.RemovePathRule(Pchar(RuleIdentify));
                        //delre from List
                        Path_List.Items.Delete(nIndex);
                        if(Mainform.sbFWOn.Enabled)then
                              ApplyFWStatus(1);
                    end;
               end
          else
           Application.MessageBox('Select the rule first!', 'Shareview', MB_OK);

end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.MenuItem7Click(Sender: TObject);
var
    FWRule :TPSMFWRule;
    RuleIdentify:string;
    nIndex:Integer;
    Delim:Integer;

    FromIP:string;
    ToIP:string;

    FromPort:string;
    ToPort:string;
    PortRange:string;

    SlectedItem:TListItem;
    Permision:String;

    PermissionValue:Integer;

    strmsg:string;
begin

                nIndex:=  Path_List.ItemIndex;
                if(nIndex>=0) then
                    begin
                         SlectedItem:=Path_List.Items.Item[nIndex];
                         RuleIdentify:= SlectedItem.Caption;
                         Permision:= SlectedItem.SubItems[0];

                         strmsg:='Application rule : '#13#10'program path =   '+RuleIdentify+' '#13#10;
                         strmsg:=strmsg+'Permission:   '+ Permision+''#13#10;
                         strmsg:=strmsg+'**********************'#13#10;
                         if(Permision='DENY') then
                           strmsg:=strmsg+'Change permission to (Allow)?'
                         else  strmsg:=strmsg+'Change permission to (Deny)?';

                        if Application.MessageBox(PChar(strmsg),'PSM Firewall', MB_YESNO) = IDYES then
                             begin
                                   if(Permision='DENY') then
                                         begin
                                             FWRule.ModifyPathrule(Pchar(RuleIdentify),1) ;
                                             SlectedItem.SubItems[0]:='ALLOW';
                                          end
                                   else
                                         begin
                                            FWRule.ModifyPathrule(Pchar(RuleIdentify),0) ;
                                            SlectedItem.SubItems[0]:='DENY' ;
                                          end;
                                    if(Mainform.sbFWOn.Enabled) then
                                             ApplyFWStatus(1);
                             end;
                    end
                else
                        begin
                              Application.MessageBox('No rule is selected', 'PSM Firewall', MB_OK);
                        end;


end;

//----------------------------------------------------------------------------------------------------------------------


procedure TMainForm.FormResize(Sender: TObject);
begin
   self.sbAbout.Left:=cpanel1.Width-self.sbabout.Width  - 3;
   self.sbHelp.Left:=cpanel1.Width-self.sbabout.Width*2  - 3;
   Self.SpeedB6utton27.Left:=Image17.left+Image17.Width-2-SpeedB6utton27.Width;
   Self.SpeedButton28.Left:=Image17.left+Image17.Width-4-SpeedB6utton27.Width*2;
   if height < NormalSizeHeight then height := NormalSizeHeight;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.TrapMSG(var MSGX: TMessage);
var
  ListItem: TListItem;
begin
  case MSGX.Msg of
    WM_USER://New log arrived
      begin
        if ListView_FWLog.Items.Count>500 then

        ListView_FWLog.Items.BeginUpdate;
        ListItem:=ListView_FWLog.Items.Add;
        ListItem.ImageIndex:=6;


        //display log information
        with Logs[MSGX.WParam] do
        begin
          //if(not NameFromIP(mIP,mHostName)) then mHostName:= mIP;
          if(logPaths.IndexOf(mPath)<0) then //This Path is not added
          begin
              ListItem.ImageIndex:=logImages.AddIcon(Form_FWRule.GetICON(mPath));
              logPaths.Add(LowerCase(mPath));
          end
          else //path is existing
          begin
               ListItem.ImageIndex:=logPaths.IndexOf(LowerCase(mPath));
          end;
         
          ListItem.Caption:=mTime;
          ListItem.SubItems.Add(mDirection);
          //if  mPermit=0 then  strTmp:='DENY'
          //else  strTmp:='ALLOW';
          ListItem.SubItems.Add(mPermit);
          ListItem.SubItems.Add(mIP);

          ListItem.SubItems.Add(mHostName);


          ListItem.SubItems.Add(mPort);

          ListItem.SubItems.Add(mPath);


          ListItem.SubItems.Add(mToltalRec);
          ListItem.SubItems.Add(mToltalSen);
          ListItem.SubItems.Add(mTotalRecSen);
          ListItem.SubItems.Add(mSockNo);
        end;
        ListView_FWLog.Items.EndUpdate;
        if((ListView_FWLog.Selected=Nil)) then
          ListItem.MakeVisible(TRue);
      end;

    WM_USER+1://Reserved
    else WndProc(MSGX);
  end;
end;

//----------------------------------------------------------------------------------------------------------------------


procedure TMainForm.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  image1.OnMouseMove:=Image1MouseMove;
  _x:=x;
  _y:=y;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
    left:=x-_x+left;
    top:=y-_y+top;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  image1.OnMouseMove:=nil;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.Image17MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  image17.OnMouseMove:=Image17MouseMove;
  _x:=x;
  _y:=y;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.Image17MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
    left:=x-_x+left;
    top:=y-_y+top;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.Image17MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  image17.OnMouseMove:=nil;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.SpeedButton28Click(Sender: TObject);
begin
   if fs=fsMaximized then fs:=fsNormal else fs:=fsMaximized;

   if fs=fsMaximized then
     begin
       self.Left:=screen.WorkAreaRect.Left;
       self.Top:=screen.WorkAreaRect.Top;
       self.Width:=screen.WorkAreaRect.Right+screen.WorkAreaRect.Left;
       self.Height:=screen.WorkAreaRect.Bottom+screen.WorkAreaRect.Top;
     end;

   if fs=fsNormal then
     begin
       self.Width:=NormalSizeWidth;
       self.Height:=NormalSizeHeight;
       self.Left:=(screen.WorkAreaWidth-self.Width) div 2;
       self.Top:=(screen.WorkAreaHeight-self.Height) div 2;
     end;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.tvmainMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var NodeUnderMouse:integer;
begin
  try
    NodeUnderMouse:=tvmain.GetNodeAt(X,Y).AbsoluteIndex;
  except
   on EAccessViolation do NodeUnderMouse:=0;
  end;
  openpage(NodeUnderMouse);
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.Path_ListEnter(Sender: TObject);
begin

      ChosenRuleType:=PATH_RULE_TYPE;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.ListView_FWRuleEnter(Sender: TObject);
begin
  ChosenRuleType:=IP_RULE_TYPE;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.SpeedB6utton27Click(Sender: TObject);
begin
  close;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.Report( TTL: integer; ResponseTime: integer; Status: TReplyStatus;
                         info: string );
var
 HostName : string;
begin
  Application.ProcessMessages;
  if cbResolveHosts.Checked
  and (Status.FromIpAddress <> NULL_IP ) then
   try
      StatusBar.SimpleText := ' rDNS lookup for ' + Status.FromIpAddress+ ' ...';
      HostName := gStack.WSGetHostByAddr( Status.FromIpAddress );
   except
      HostName := Status.FromIpAddress+ ' [no rDNS]';
   end
  else
    HostName := '...';

  with Status do
  begin
   case Status.ReplyStatusType of
     rsECHO             : reLog.SelAttributes.Color := clGREEN;
     rsTIMEOUT,
     rsERROR,
     rsERRORUNREACHABLE : reLog.SelAttributes.Color := clRED
     else
      reLog.SelAttributes.Color := clNAVY;
   end;
   reLog.Lines.Add( Format( '%-4d %-45s %-18s %4dms  %-4d %s',
                               [TTL, HostName, FromIPAddress,
                                ResponseTime, Status.TimeToLive, Info]) );
  end;
  Application.ProcessMessages;

end;


//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.PingFirst;
var
 OldMode : DWORD;
begin
 reLog.Clear;
 Application.ProcessMessages;
 CurrentTTL := 1;
 FHostName := edtHost.Text;
 ICMP.ReceiveTimeout := ICMP_TIMEOUT;
 ICMP.TTL  := CurrentTTL;

 OldMode := SetErrorMode( SEM_FAILCRITICALERRORS ); // trap DNS-errors!
 try
  StatusBar.SimpleText := 'looking up destination IP of ' +  FHostName +' ...' ;
  reLog.Refresh;
  FDestIP    := GStack.WSGetHostByName( FHostName); // lookup host IP with DNS
  edtIP.Text := FDestIP;
 except
  edtIP.Text := '?.?.?.?';
  StatusBar.SimpleText :='  cannot resolve IP-address of host "' + edtHost.Text +'"';
  MessageBeep(0);  // Euh Aah...
  EXIT;
 end;
 SetErrorMode( OldMode );

 ICMP.Host := FDestIP;
 PingStart := GetTickCount;

 if not FStop then
 begin
   ICMP.Ping;
   Processresponse(ICMP.ReplyStatus);
 end;

end;


//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.PingNext;
var
  OldMode: DWORD;
begin
 if FStop then
 begin
    reLog.Lines.Add('** INTERRUPTED **');
    EXIT;
 end;
 inc(CurrentTTL);
 if CurrentTTL < ICMP_MAX_HOPS then
 begin
   ICMP.Host := FDestIP ;
   ICMP.TTL  := CurrentTTL;
   ICMP.ReceiveTimeout := ICMP_TIMEOUT;
   PingStart := GetTickCount;
   StatusBar.SimpleText := ' ping ' + FDestIP + ' ...';
   OldMode := SetErrorMode( SEM_FAILCRITICALERRORS );
   try
     ICMP.Ping;
   except
     reLog.Lines.Add('** ERROR **');
   end;
   SetErrorMode( OldMode );
   Processresponse(ICMP.ReplyStatus);
 end
 else
   StatusBar.SimpleText :=  'MAX TTL EXCEEDED.';
end;


//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.ProcessResponse( Status: TReplyStatus );
begin

   StatusBar.SimpleText := Status.FromIpAddress + ' responded';
   case Status.ReplyStatusType of

   //------
   rsECHO :
    begin     // target host has responded
      Report( CurrentTTL, GetTickCount-PingStart, Status, 'DONE!' );  // done!
      StatusBar.SimpleText := 'done.';
    end;

   //------
   rsErrorTTLExceeded:
     begin  // Time-To-Live exceeded for an ICMP response.
        Report( CurrentTTL, GetTickCount-PingStart, Status, 'OK' );
        PingNext;
     end;

   //-------
   rsTimeOut :
     begin // - Timeout occurred before a response was received.
        Report( CurrentTTL, GetTickCount-PingStart, Status, 'TIMEOUT' );
        PingNext;
     end;

   //-------
   rsErrorUnreachable:
     begin // - Destination unreachable
       Report( CurrentTTL, GetTickCount-PingStart, Status, 'DEST_UNREACH' );
       StatusBar.SimpleText := 'destination unreachable!';
     end;

   //------
   rsError:
     begin // - An error has occurred.
       Report( CurrentTTL, GetTickCount-PingStart, Status, 'ERROR' );
       PingNext;
     end;
   end   // case
end;


//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.sbTraceClick(Sender: TObject);
begin
  FStop := false;
  PingFirst;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.sbStopClick(Sender: TObject);
begin
 FStop := true;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TMainForm.sbRunPingClick(Sender: TObject);
var x:integer;
    ping1:TPingThread;
    PingThreads:array [1..255] of TPingThread;
    r,e:integer;
begin
  Timer2.Enabled:=false;
  If cbLowSpeed.Checked then MaxPingStep:=6 else MaxPingStep:=1;
  showwait;

  if not cbIP3range.Checked then
    begin
      PingResults[PingStep][1].host:='';
      ping1:=TPingThread.Create(ip4_1.text+'.'+ip4_2.text+'.'+ip4_3.text+'.'+ip4_4.text,1,r,e);

//      WinPing();
    end
    else
    begin
      if ip4_4.Value<ip5_4.Value then
      for x:=ip4_4.Value to ip5_4.Value do
        begin
           PingResults[PingStep][x].host:='';
           PingThreads[x]:=TPingThread.Create(ip4_1.text+'.'+ip4_2.text+'.'+ip4_3.text+'.'+inttostr(x),x,r,e);
           Application.ProcessMessages;
        end else begin closewait; showmessage('IP range input error'); end;
    end;

    timer1.Enabled:=true;
end;


// ---------------------------------------------------------------------------------------------------------

constructor TPingThread.Create(Host: string; index:integer; var result, Error: integer);
begin
    FHost := Host;
    FResult := Result;
    FError := Error;
    fIndex := index;
  FreeOnTerminate := True;
  inherited Create(False);
end;


// ---------------------------------------------------------------------------------------------------------

procedure TPingThread.Execute;
label beg,ext;

var x:integer;
    hostname:string;
 hIP : THandle;
    pingBuffer : array [0..31] of Char;
    pIpe : ^icmp_echo_reply;
    pHostEn : PHostEnt;
    wVersionRequested : WORD;
    lwsaData : WSAData;
    error : DWORD;
    destAddress : In_Addr;
begin
 // Blocksize:=edPingSize.Value;
  hostname:=fhost;
    // Создаем handle
       hIP := IcmpCreateFile();
       GetMem( pIpe, sizeof(icmp_echo_reply) + sizeof(pingBuffer));
       pIpe.Data := @pingBuffer;
       pIpe.DataSize := sizeof(pingBuffer);
       wVersionRequested := MakeWord(1,1);
       error := WSAStartup(wVersionRequested,lwsaData);
       if (error <> 0) then
       begin
            fresult:=0;
            ferror:=error;
            goto Ext;
       end;
       pHostEn := gethostbyname(pansichar(hostname));
       error := GetLastError();
       if (error <> 0) then
       begin
            fresult:=0;
            ferror:=error;
            goto Ext;
       end;

    destAddress := PInAddr(pHostEn^.h_addr_list^)^;

      // Посылаем ping-пакет

    IcmpSendEcho(hIP,
                    destAddress.S_addr,
                    @pingBuffer,
                    sizeof(pingBuffer),
                    Nil,
                    pIpe,
                    sizeof(icmp_echo_reply) + sizeof(pingBuffer),
                    5000);


    error := GetLastError();
       if (error <> 0) then
       begin
            fresult:=0;
            ferror:=error;
            goto Ext;
       end;

     // Смотрим некоторые из вернувшихся данных
    fresult:=pIpe.RTTime;

    IcmpCloseHandle(hIP);
       WSACleanup();
       FreeMem(pIpe);

    ext:
    PingResults[Pingstep][findex].host:=fhost;
    PingResults[Pingstep][findex].hostname:='';
    if MainForm.cbCheckHost.Checked then
       if ferror=0 then
          PingResults[Pingstep][findex].hostname:=GetHostByIP(fhost);
    PingResults[Pingstep][findex].time:=fresult;
    PingResults[Pingstep][findex].error:=ferror;

   // fomain.mmPing.lines.add('host = ' + fhost+'  result = '+inttostr(fresult)+' error = '+inttostr(ferror));

end;


// ---------------------------------------------------------------------------------------------------------

procedure TMainForm.IP4_1Change(Sender: TObject);
begin

     IP5_1.Value:=IP4_1.Value;
     IP5_2.Value:=IP4_2.Value;
     IP5_3.Value:=IP4_3.Value;
end;

// ---------------------------------------------------------------------------------------------------------

procedure TMainForm.Timer1Timer(Sender: TObject);

var x:integer;
    b:boolean;
begin
  if not cbIP3range.Checked then
    begin
      if PingResults[PingStep][1].host<>'' then BuildHTMLResult(1,1);

//      WinPing();
    end
    else
    begin
      if ip4_4.Value<ip5_4.Value then
      begin
        b:=false;
        for x:=ip4_4.Value to ip5_4.Value do if PingResults[PingStep][x].host='' then begin b:=true;break;end;
        if not b then
         begin
          if pingstep<MaxPingStep then
            begin
              inc(pingstep);
              sbRunPingClick(self);
            end else
            begin
              PingStep:=1;
              BuildHTMLResult(ip4_4.Value,ip5_4.Value);
            end;
         end;
      end;
    end;
end;


// ---------------------------------------------------------------------------------------------------------

procedure TMainForm.BuildHTMLResult(p1,p2:integer);
var  F: TextFile;
  i,x,y,z,x2:integer;
begin
   closewait;
   timer1.Enabled:=false;
   mmTemp.Lines.Clear;
   PingStep:=1;   if MaxPingStep>1 then
     begin
   x:=p1;
   while (x<=p2) do
     begin
       if pingresults[PingStep][1].error>0 then
         begin
            for x2:=2 to MaxPingStep do if pingresults[PingStep][x2].error=0 then
              begin
                pingresults[PingStep][1].error:=0;
                pingresults[PingStep][1].time:=pingresults[PingStep][x2].time;
                pingresults[PingStep][1].hostname:=pingresults[PingStep][x2].hostname;
              end;
         end;
       inc(x)
     end;
     end;

   mmTemp.lines.add('<HTML><HEAD> ');
   mmTemp.lines.add('<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=WINDOWS-1251">');
   mmTemp.lines.add('<TITLE>Title</TITLE></HEAD>');
   mmTemp.lines.add('<body bgcolor="#FFFFFF"> <FONT face="Arial" size=4> Ping results ' +ip4_1.text+'.'+ip4_2.text+'.'+ip4_3.text+'.'+ip4_4.text+' - ' + ip5_1.text+'.'+ip5_2.text+'.'+ip5_3.text+'.'+ip5_4.text + '.<br> Date '+datetimetostr(now)+'</font><BR><BR>');
   mmTemp.lines.add('<table width="640" border="0" cellpadding="0" cellspacing="1"> ');
   x:=0;
   for y:=0 to 7 do
   begin
    mmTemp.lines.add('<tr width="640">');
//    z:=y*32+x; if z=0 then mmTemp.lines.add('<td width="20"></td>');
    for x:=0 to 31 do
     begin
       z:=y*32+x;
       if (z<=p2)and(z>=p1) then
       begin
       if pingresults[PingStep][z].error=0 then
         begin
           mmTemp.lines.add('<td  style="background-color=#bbbbee;font-weight: bold;" width="20">');
           mmTemp.lines.add('<a style="font:11px Helvetica, Verdana, Arial, sans-serif; text-decoration:underline;color:#000000; text-decoration: none" href="'+ip4_1.text+'.'+ip4_2.text+'.'+ip4_3.text+'.'+inttostr (z)+'">.'+inttostr (z) +'</a><td>' );
         end;
       if pingresults[PingStep][z].error>0 then
         begin
           mmTemp.lines.add('<td  style="background-color=#eeeeee;font-weight: bold;" width="20">');
           mmTemp.lines.add('<a style="font:11px Helvetica, Verdana, Arial, sans-serif; text-decoration:underline;color:#000000; text-decoration: none" href="'+ip4_1.text+'.'+ip4_2.text+'.'+ip4_3.text+'.'+inttostr (z)+'">.'+inttostr (z) +'</a><td>' );
         end;
       end;
     end;
    mmTemp.lines.add('</tr>');
   end;
   mmTemp.lines.add('</table><br>');

   mmTemp.lines.add('<table width="720" border="0" cellpadding="0" cellspacing="1"> ');
   mmTemp.lines.add('<tr style="font:14px Helvetica, Verdana, Arial, sans-serif; halign=center;background-color=#aaffaa;font-weight: bold;">');
   mmTemp.lines.add('   <td width="150"> IP <td>' );
   mmTemp.lines.add('    <td width="20">Time<td>' );
   mmTemp.lines.add('     <td width="50">Response<td>' );
   mmTemp.lines.add('    <td width="470">Hostname </td></tr>' );

   x:=p1;
   while (x<=p2) do
     begin
       if pingresults[PingStep][x].error=0 then
         begin
           mmTemp.lines.add('<tr style="font:14px Helvetica, Verdana, Arial, sans-serif;background-color=#bbbbee;font-weight: bold;"><td width="150"> '+ pingresults[PingStep][x].host + ' <td>' );
           mmTemp.lines.add('    <td width="20">'+inttostr (pingresults[PingStep][x].time) +'<td>' );
           mmTemp.lines.add('    <td width="50">');
           for x2:=2 to MaxPingStep do
             begin
               if pingresults[x2][x].error=0 then mmTemp.lines.add('!');
               if pingresults[x2][x].error>0 then mmTemp.lines.add('.');
             end;
           mmTemp.lines.add('    <td>' );
           mmTemp.lines.add('    <td width="470">'+ pingresults[PingStep][x].hostname + ' </td></tr>' );
         end;
       if pingresults[PingStep][x].error>0 then
         begin
           x2:=x;
           if pingresults[PingStep][x+1].error>0 then
            begin
              while pingresults[PingStep][x+1].error>0 do inc(x);
              mmTemp.lines.add('<tr style="font:14px Helvetica, Verdana, Arial, sans-serif;background-color=#eeeeee;"> <td width="150"> '+ pingresults[PingStep][x2].host +'-'+ inttostr(x)+ ' <td>' );
              mmTemp.lines.add('    <td width="20"><td>' );
              mmTemp.lines.add('    <td width="50">.....<td>' );
              mmTemp.lines.add('    <td width="470"> Host not response </td></tr>' );
            end
            else
            begin
              mmTemp.lines.add('<tr style="font:14px Helvetica, Verdana, Arial, sans-serif;background-color=#eeeeee;"> <td width="150"> '+ pingresults[PingStep][x].host + ' <td>' );
              mmTemp.lines.add('    <td width="20"><td>' );
              mmTemp.lines.add('    <td width="50">.....<td>' );
              mmTemp.lines.add('    <td width="470"> Host not response </td></tr>' );
            end;
         end;
       inc(x)
     end;

   mmTemp.lines.add('</table></font></body></html>');
  mmTemp.Lines.SaveToFile(apl_path + '\ping.htm');

  self.WebBrowser2.Navigate(apl_path + '\ping.htm');
//  self.WebBrowser1.OnBeforeNavigate2:=WebBrowser1BeforeNavigate2;

end;

// ---------------------------------------------------------------------------------------------------------


procedure TMainForm.cbIP3rangeClick(Sender: TObject);
begin
 {  IP2_1.Enabled:=cbIP1range.Checked;
  IP2_2.Enabled:=cbIP1range.Checked;
  IP2_3.Enabled:=cbIP1range.Checked; }
  IP5_4.Enabled:=cbIP3range.Checked;

  lbIP_to1.Enabled:=cbIP1range.Checked;
{  lbdot1.Enabled:=cbIP1range.Checked;
  lbdot2.Enabled:=cbIP1range.Checked;}
  lbdot3.Enabled:=cbIP3range.Checked;


  if cbIP3range.Checked then
   begin
     IP5_1.Value:=IP4_1.Value;
     IP5_2.Value:=IP4_2.Value;
     IP5_3.Value:=IP4_3.Value;
     IP5_4.Value:=255;
   end;
end;

// ---------------------------------------------------------------------------------------------------------

procedure TMainForm.raceroute1Click(Sender: TObject);
begin
  RxTrayIcon1DblClick(self);
  openpage(6)
end;

// ---------------------------------------------------------------------------------------------------------

procedure TMainForm.IPScan1Click(Sender: TObject);
begin
 RxTrayIcon1DblClick(self);
 openpage(7)
end;

// ---------------------------------------------------------------------------------------------------------

procedure TMainForm.SpeedB3utton30Click(Sender: TObject);
begin
 btnGetSharesClick(self);
end;

// ---------------------------------------------------------------------------------------------------------

procedure TMainForm.SpeedButton31Click(Sender: TObject);
var i:integer;
    ShareName:string;
begin
  if self.lbxShares.Items.Count = 0 then Exit;
  if self.lbxShares.SelCount <1 then Exit;
  for i:= 0 to self.lbxShares.Items.Count -1 do
    if self.lbxShares.Items[i].Selected then Break;  //Ищем выбранный элемент
  if not self.lbxShares.Items[i].Selected then Exit; //Если не найден уходим
  ShareName := self.lbxShares.Items[i].Caption;



  if self.lbxShares.Items[i].ImageIndex=31 then
    begin
      CloseShare(ShareName);
    end;

    try
      MainForm.aqSQL.SQL.Clear;
      MainForm.aqSQL.SQL.Add('delete from shares where shi2_netname='+#39+ShareName+#39);
      MainForm.aqSQL.ExecSQL;
    except
      on EOleException do
    end;

    btnGetSharesClick(self);
end;

// ---------------------------------------------------------------------------------------------------------

procedure TMainForm.CloseShare(s:string);
var
  OS:Boolean;
  FLibHandle : THandle;
  NameNT:PWChar;
  i:Integer;
  ShareName: String;
begin
  if not mainform.IsNT(OS) then Close; //Определяем тип системы
  begin
  ShareName := s;

  if OS then begin //Код для NT
    FLibHandle := LoadLibrary('NETAPI32.DLL');
    if FLibHandle = 0 then Exit;
    @NetShareDelNT := GetProcAddress(FLibHandle,'NetShareDel');
    if not Assigned(NetShareDelNT) then //Проверка
    begin
      FreeLibrary(FLibHandle);
      Exit;
    end;
    i:= SizeOf(WideChar)*256;
    GetMem(NameNT,i);  //Выделяем память под переменную
    StringToWideChar(ShareName,NameNT,i); //Преобразуем в PWideChar
    NetShareDelNT(nil,NameNT,0);   //Удаляем ресурс
    FreeMem(NameNT);  //Освобождаем память
  end;
  FreeLibrary(FLibHandle);

    // метим как отрубленный ресурс
    try
      aqSQL2.SQL.Clear;
      aqSQL2.SQL.Add('update Shares set status='+#39+'off'+#39+' where shi2_netname='+#39+ShareName+#39);
      aqSQL2.ExecSQL;
    except
      on EOleException do
    end;
  end;
 end;

// ---------------------------------------------------------------------------------------------------------

procedure TMainForm.BmBtnPortDefaultClick(Sender: TObject);
var
     i, nPortCount: Integer;
     PortNumber:Integer;
     currTh:Integer;
     ListItem: TListItem;
begin
      nPortCount:=0;
      ListView_PortTemp.Width:= 0;
      ListView_PortTemp.Height:= 0;
      ListView_PortTemp.Visible:= True;

      for i:=0 to ListView_PortTemp.Items.Count-1 do
               if ListView_PortTemp.Items.Item[i].SubItems.Strings[1] = 'Default' then begin
                    inc(nPortCount);
               end;
      ProgressBar_PortScan.Min:=0;
      ProgressBar_PortScan.Max:=100;
      ProgressBar_PortScan.Position:=0;
      bPortScanning:= True;

      ListView_Port.Items.BeginUpdate;
      ListView_Port.Items.Clear;

      currTh:=0;
      for i:=0 to ListView_PortTemp.Items.Count-1 do begin
               if ListView_PortTemp.Items.Item[i].SubItems.Strings[1] = 'Default' then
               begin

                    ProgressBar_PortScan.Position := Round(100*currTh/nPortCount);
                    PortNumber:= StrToInt(ListView_PortTemp.Items.Item[i].SubItems.Strings[0]);

                    try
                         // Trying to open serversocket
                         ServerSocket.Port := PortNumber;
                         ServerSocket.Open();
                         ServerSocket.Close();
                         ListItem:= ListView_Port.Items.Add;
                         ListItem.ImageIndex:=32;
                         ListItem.Caption:= ListView_PortTemp.Items.Item[i].Caption;
                         ListItem.SubItems.Add(ListView_PortTemp.Items.Item[i].SubItems.Strings[0]);
                         ListItem.SubItems.Add('Close');
                    except
                         ListItem:= ListView_Port.Items.Add;
                         ListItem.ImageIndex:=31;
                         ListItem.Caption:= ListView_PortTemp.Items.Item[i].Caption;
                         ListItem.SubItems.Add(ListView_PortTemp.Items.Item[i].SubItems.Strings[0]);
                         ListItem.SubItems.Add(' Open ');
                    end; // try/except

                    inc(currTh);
               end;
          end;
      bPortScanning:= False;
      ListView_Port.Items.EndUpdate;
      ListView_PortTemp.Visible:= False;
      ProgressBar_PortScan.Position :=0;
      ListView_PortTempAll.Items:=ListView_Port.Items;
end;

// ---------------------------------------------------------------------------------------------------------

procedure TMainForm.BmBtnPortBackDoorClick(Sender: TObject);
var
     i, nPortCount: Integer;
     PortNumber:Integer;
     currTh:Integer;
     ListItem: TListItem;
begin
     //Count the number of backdoor port
      nPortCount:=0;
      ListView_PortTemp.Width:= 0;
      ListView_PortTemp.Height:= 0;
      ListView_PortTemp.Visible:= True;

      for i:=0 to ListView_PortTemp.Items.Count-1 do
               if ListView_PortTemp.Items.Item[i].SubItems.Strings[1] = 'Backdoor' then begin
                    inc(nPortCount);
               end;
      ProgressBar_PortScan.Min:=0;
      ProgressBar_PortScan.Max:=100;
      ProgressBar_PortScan.Position:=0;
      bPortScanning:= True;

      ListView_Port.Items.BeginUpdate;
      ListView_Port.Items.Clear;

      currTh:=0;
      for i:=0 to ListView_PortTemp.Items.Count-1 do begin
               if ListView_PortTemp.Items.Item[i].SubItems.Strings[1] = 'Backdoor' then
               begin

                    ProgressBar_PortScan.Position := Round(100*currTh/nPortCount);
                    PortNumber:= StrToInt(ListView_PortTemp.Items.Item[i].SubItems.Strings[0]);

                    try
                         // Trying to open serversocket
                         ServerSocket.Port := PortNumber;
                         ServerSocket.Open();
                         ServerSocket.Close();

                         ListItem:= ListView_Port.Items.Add;
                         ListItem.ImageIndex:=32;
                         ListItem.Caption:= ListView_PortTemp.Items.Item[i].Caption;
                         ListItem.SubItems.Add(ListView_PortTemp.Items.Item[i].SubItems.Strings[0]);
                         ListItem.SubItems.Add('Close');
                    except
                         ListItem:= ListView_Port.Items.Add;

                         ListItem.ImageIndex:=31;
                         ListItem.Caption:= ListView_PortTemp.Items.Item[i].Caption;
                         ListItem.SubItems.Add(ListView_PortTemp.Items.Item[i].SubItems.Strings[0]);
                         ListItem.SubItems.Add(' Open ');
                    end; // try/except

                    inc(currTh);
               end;
          end;
      bPortScanning:= False;
      ListView_Port.Items.EndUpdate;
      ListView_PortTemp.Visible:= False;
      ProgressBar_PortScan.Position :=0;
      ListView_PortTempAll.Items:=ListView_Port.Items;

end;

// ---------------------------------------------------------------------------------------------------------

procedure TMainForm.BmBtnPortAllClick(Sender: TObject);

var
     i, nPortCount: Integer;
     PortNumber:Integer;
     currTh:Integer;
     ListItem: TListItem;
begin
   If MessageBox(0,'You want to scan all ports? That can take up to 10 minutes.','Shareview',MB_ICONINFORMATION or MB_YESNO)=IDYES then
   begin

       nPortCount:=0;
      ListView_PortTemp.Width:= 0;
      ListView_PortTemp.Height:= 0;
      ListView_PortTemp.Visible:= True;


      ProgressBar_PortScan.Min:=0;
      ProgressBar_PortScan.Max:=100;
      ProgressBar_PortScan.Position:=0;
      bPortScanning:= True;

      ListView_Port.Items.BeginUpdate;
      ListView_Port.Items.Clear;

      currTh:=0;
      for i:=1 to 65535 do
         begin
               //if ListView_PortTemp.Items.Item[i].SubItems.Strings[1] = 'Backdoor' then


                    ProgressBar_PortScan.Position := Round(100*i/65535);
                    PortNumber:= i;

                         // Trying to open serversocket
                    try
                           ServerSocket.Port := PortNumber;
                           ServerSocket.Open();
                           ServerSocket.Close();
                           ListItem:= ListView_Port.Items.Add;
                           ListItem.ImageIndex:=32;
                           ListItem.Caption:= inttostr(i);
                           ListItem.SubItems.Add(inttostr(i));
                           ListItem.SubItems.Add('Close');
                    except
                           ListItem:= ListView_Port.Items.Add;
                           ListItem.ImageIndex:=31;
                           ListItem.Caption:= inttostr(i);
                           ListItem.SubItems.Add(inttostr(i));
                           ListItem.SubItems.Add(' Open ');
                    end;//Try

               //end;
               if i mod 10 = 0 then application.ProcessMessages;
          end;
      bPortScanning:= False;
      ListView_Port.Items.EndUpdate;
      ListView_PortTemp.Visible:= False;
      ProgressBar_PortScan.Position :=0;
   end;
      ListView_PortTempAll.Items:=ListView_Port.Items;
end;

// ---------------------------------------------------------------------------------------------------------

procedure TMainForm.SpeedButton42Click(Sender: TObject);
begin
  self.SpeedButton42.PopupMenu.Popup(mouse.CursorPos.X,mouse.CursorPos.y);
end;

// ---------------------------------------------------------------------------------------------------------

procedure TMainForm.Showall1Click(Sender: TObject);
begin
  ListView_Port.Items:=ListView_PortTempAll.Items;
end;

// ---------------------------------------------------------------------------------------------------------

procedure TMainForm.Showclosedport1Click(Sender: TObject);

var
     i, nPortCount: Integer;
     PortNumber:Integer;
     currTh:Integer;
     ListItem: TListItem;
begin
      ListView_Port.Items.BeginUpdate;
      ListView_Port.Items.Clear;
      for i:=0 to ListView_PortTempAll.Items.Count-1 do begin
               if ListView_PortTempAll.Items.Item[i].SubItems.Strings[1] = 'Close' then
               begin


                         ListItem:= ListView_Port.Items.Add;
                         ListItem.ImageIndex:=32;
                         ListItem.Caption:= ListView_PortTempAll.Items.Item[i].Caption;
                         ListItem.SubItems.Add(ListView_PortTempAll.Items.Item[i].SubItems.Strings[0]);
                         ListItem.SubItems.Add('Close');
               end;
          end;
      ListView_Port.Items.EndUpdate;

end;

// ---------------------------------------------------------------------------------------------------------

procedure TMainForm.Showopened1Click(Sender: TObject);
var
     i, nPortCount: Integer;
     PortNumber:Integer;
     currTh:Integer;
     ListItem: TListItem;
begin
      ListView_Port.Items.BeginUpdate;
      ListView_Port.Items.Clear;
      for i:=0 to ListView_PortTempAll.Items.Count-1 do begin
               if ListView_PortTempAll.Items.Item[i].SubItems.Strings[1] = ' Open ' then
               begin


                         ListItem:= ListView_Port.Items.Add;
                         ListItem.ImageIndex:=31;
                         ListItem.Caption:= ListView_PortTempAll.Items.Item[i].Caption;
                         ListItem.SubItems.Add(ListView_PortTempAll.Items.Item[i].SubItems.Strings[0]);
                         ListItem.SubItems.Add(' Open ');
               end;
          end;
      ListView_Port.Items.EndUpdate;
end;

// ---------------------------------------------------------------------------------------------------------

procedure TMainForm.SpeedButto0n7Click(Sender: TObject);
begin
  Tag := Tag + 1;
  if (Tag mod 2) = 1 then
  begin
    tvNetwork.Items.Clear;
    StatusBar1.Panels[1].Text := STR_STARTED;
    SpeedButto0n7.Caption := STR_STOP;
    Thread := TDemoThread.Create(False);
  end
  else
  begin
    StatusBar1.Panels[1].Text := STR_END;
    SpeedButto0n7.Enabled := False;
    Thread.Terminate;
  end;
end;

// ---------------------------------------------------------------------------------------------------------

procedure TMainForm.tvNetworkClick(Sender: TObject);
begin
  if Assigned(tvNetwork.Selected) then
    StatusBar1.Panels[0].Text := '   ' + tvNetwork.Selected.Text
  else
    StatusBar1.Panels[0].Text := STR_FIELD;
end;

// ---------------------------------------------------------------------------------------------------------

procedure TMainForm.tvNetworkDblClick(Sender: TObject);

var
  Str: String;
begin
  if Assigned(tvNetwork.Selected) then
  begin
    Str := tvNetwork.Selected.Text;
    if Copy(Str, 1, 2) <> '\\' then Exit;
    if Pos(' IP:', Str) <> 0 then
      ShellExecute(Handle, 'explore', PChar(Copy(Str, 1, Pos(' IP:', Str))), nil, nil, SW_SHOW)
    else
      ShellExecute(Handle, 'explore', PChar(Str), nil, nil, SW_SHOW);
  end;
end;

end.


