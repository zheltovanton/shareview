unit uWait;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, jpeg, Buttons, Animate, GIFCtrl;

type
  TfoWait = class(TForm)
    RxGIFAnimator1: TRxGIFAnimator;
    Label1: TLabel;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  foWait: TfoWait;
  d1,d2:tdatetime;
implementation

uses Main;


{$R *.DFM}

type

  TTimeThread = class(TThread)
  private
  protected
    procedure Execute; override;
  public
    constructor Create();
  end;

var t:TTimeThread;

// ---------------------------------------------------------------------------------------------------------

constructor TTimeThread.Create();
begin
  FreeOnTerminate := True;
  inherited Create(False);
end;


// ---------------------------------------------------------------------------------------------------------

procedure TTimeThread.Execute;
begin
 repeat
  d2:=now;
  fowait.label1.caption:=FormatDateTime('ss:zz',d2-d1);
  sleep(100);
 until 1=0;

end;

// ---------------------------------------------------------------------------------------------------------

procedure TfoWait.FormCreate(Sender: TObject);
begin

 d1:=now;
 t:=TTimeThread.Create;

end;

// ---------------------------------------------------------------------------------------------------------

procedure TfoWait.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_ESCAPE then
    begin

    end;
end;

// ---------------------------------------------------------------------------------------------------------

procedure TfoWait.FormShow(Sender: TObject);
begin
 d1:=now;
end;

procedure TfoWait.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  t.DoTerminate;
end;

end.
