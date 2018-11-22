unit uTraffic;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGridEh, Buttons, ExtCtrls, main,
  DBCtrlsEh, StdCtrls, Mask, jpeg, shellapi, ComCtrls;

type
  TfoTraffic = class(TForm)
    Panel11: TPanel;
    Image3: TImage;
    lbFormCaption: TLabel;
    lvTraffic: TListView;
    tmrTraffic: TTimer;
    Panel1: TPanel;
    Image1: TImage;
    Label2: TLabel;
    Splitter1: TSplitter;
    Panel2: TPanel;
    Panel8: TPanel;
    Image2: TImage;
    Label1: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    sbClose: TSpeedButton;
    sbMax: TSpeedButton;
    Panel3: TPanel;
    Label3: TLabel;
    lbConnection: TLabel;
    lbMac: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    lbSpeed: TLabel;
    Label7: TLabel;
    lbIn: TLabel;
    Label11: TLabel;
    lbOut: TLabel;
    lbErrorsin: TLabel;
    Label8: TLabel;
    lbErrorsout: TLabel;
    Label13: TLabel;
    Label6: TLabel;
    lbMtu: TLabel;
    lbPacketsin: TLabel;
    Label14: TLabel;
    Label12: TLabel;
    lbPacketsOut: TLabel;
    Label15: TLabel;
    lbDiscardsIn: TLabel;
    Label17: TLabel;
    lbDiscardsOut: TLabel;
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
    procedure tmrTrafficTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lvTrafficClick(Sender: TObject);
    procedure sbCloseClick(Sender: TObject);
    procedure sbMaxClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  foTraffic: TfoTraffic;


implementation


var

  fs:formstates;
  
//----------------------------------------------------------------------------------------------------------------------


var
  FLibHandle : THandle;
  Table: TMibIfTable;
  i : integer;
  Size   : integer;

{$R *.dfm}

//----------------------------------------------------------------------------------------------------------------------

procedure TfoTraffic.Image3MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   image3.OnMouseMove:=Image3MouseMove;
  self.AlphaBlendValue:=80;
  _x:=x;
  _y:=y;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TfoTraffic.Image3MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
    left:=x-_x+left;
    top:=y-_y+top;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TfoTraffic.Image3MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   image3.OnMouseMove:=nil;
  self.AlphaBlendValue:=255;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TfoTraffic.lbFormCaptionMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   lbFormCaption.OnMouseMove:=lbFormCaptionMouseMove;
  self.AlphaBlendValue:=80;
  _x:=x;
  _y:=y;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TfoTraffic.lbFormCaptionMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
    left:=x-_x+left;
    top:=y-_y+top;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TfoTraffic.lbFormCaptionMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  lbFormCaption.OnMouseMove:=nil;
  self.AlphaBlendValue:=255;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TfoTraffic.SpeedButton3Click(Sender: TObject);
begin
close;
end;

//----------------------------------------------------------------------------------------------------------------------

  // Вспомогательная функция, преобразующая МАС адрес к "нормальному" виду
  //Определяем специальный тип, чтобы можно было передать в функцию массив

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

procedure TfoTraffic.tmrTrafficTimer(Sender: TObject);
var sel_pos:integer;
begin

  sel_pos:=-1;

  for i:=0 to lvTraffic.Items.Count-1 do if lvTraffic.Items[i].Selected then sel_pos:=i;


  tmrTraffic.Enabled := false; //Приостанавливаем на всякий случай таймер
  lvTraffic.Items.BeginUpdate;
  lvTraffic.Items.Clear;  //Очищаем список
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
      with lvTraffic.Items.Add do begin //Выводим результаты
        Caption := String(Table.Table[i].bDescr); //Наименование интерфейса
        SubItems.Add(GetMAC(TMAC(Table.Table[i].bPhysAddr),
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
  lvTraffic.Items.EndUpdate;
  FreeLibrary(FLibHandle);
  tmrTraffic.Enabled := true; //Не забываем активировать таймер
  if sel_pos>-1 then lvTraffic.Items[sel_pos].Selected:=true;
  lvTrafficClick(self);

end;

//----------------------------------------------------------------------------------------------------------------------

procedure TfoTraffic.FormCreate(Sender: TObject);
begin
  foTraffic.DoubleBuffered:=true;
  tmrTrafficTimer(self);
  fs:=fsnormal;
  panel3.Color:=$00EEEEEE;
  self.sbClose.Left:=self.Width-self.sbClose.Width;
  self.sbMax.Left:=self.Width-self.sbClose.Width*2;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TfoTraffic.lvTrafficClick(Sender: TObject);
var i:integer;
begin
  for i:=0 to lvTraffic.Items.Count-1 do
   if lvTraffic.Items[i].Selected then
    begin
      lbConnection.Caption:=Table.Table[i].bDescr;

      lbMac.Caption:=GetMAC(TMAC(Table.Table[i].bPhysAddr), Table.Table[i].dwPhysAddrLen);
      lbSpeed.Caption:=Format('%g Mbit ', [Table.Table[i].dwSpeed / 1000000]);
      lbin.caption:=Format('%g bytes ', [Table.Table[i].dwInOctets / 1]);
      lbOut.caption:=Format('%g bytes ', [Table.Table[i].dwOutOctets / 1]);
      lbErrorsin.caption:=Format('%g ', [Table.Table[i].dwInErrors / 1]);
      lbErrorsout.caption:=Format('%g ', [Table.Table[i].dwOutErrors / 1]);

      lbmtu.caption:=Format('%g ', [Table.Table[i].dwMtu / 1]);
      lbPacketsin.caption:=Format('%g ', [Table.Table[i].dwInUcastPkts / 1]);
      lbPacketsOut.caption:=Format('%g ', [Table.Table[i].dwOutUcastPkts / 1]);

      lbDiscardsIn.caption:=Format('%g ', [Table.Table[i].dwInDiscards / 1]);
      lbDiscardsOut.caption:=Format('%g ', [Table.Table[i].dwOutDiscards / 1]);
 //     lbDiscardsOut.caption:=Table.Table[i].bDescr;
//      lbDiscardsOut.caption:=Format('%g ', [Table.Table[i].dwLastChange/ 1]);


    end;
end;

procedure TfoTraffic.sbCloseClick(Sender: TObject);
begin
  close;
end;

procedure TfoTraffic.sbMaxClick(Sender: TObject);
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

   self.sbClose.Left:=self.Width-self.sbClose.Width;
   self.sbMax.Left:=self.Width-self.sbClose.Width*2;
end;

end.
