unit uShared;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, main, Buttons, jpeg, Menus, ComCtrls,  ShlObj, comobj,
  DB, ADODB ;

{admin$ 
My Documents 
print$ 
ipc$ 
Shared Docs 
Any default shares named a$ through z$  }

type
  TfoShared = class(TForm)
    Panel11: TPanel;
    Image3: TImage;
    lbFormCaption: TLabel;
    CPanel1: TPanel;
    sbSave: TSpeedButton;
    sbClose: TSpeedButton;
    ppSharedFolders: TPopupMenu;
    Unshareresource1: TMenuItem;
    lbxShares: TListView;
    aqSQL2: TADOQuery;
    aqList: TADOQuery;
    Openresource1: TMenuItem;
    Addresource1: TMenuItem;
    N1: TMenuItem;
    Closeall1: TMenuItem;
    Openall1: TMenuItem;
    N2: TMenuItem;
    Refresh1: TMenuItem;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    Delete1: TMenuItem;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    procedure CloseShare(s:string);
    procedure FormCreate(Sender: TObject);
    procedure btnCloseSharesClick(Sender: TObject);
    procedure btnGetSharesClick(Sender: TObject);
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
    procedure sbCloseClick(Sender: TObject);
    procedure Refresh1Click(Sender: TObject);
    procedure Addresource1Click(Sender: TObject);
    procedure Openresource1Click(Sender: TObject);
    procedure Delete1Click(Sender: TObject);
    procedure Closeall1Click(Sender: TObject);
    procedure Openall1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  foShared: TfoShared;

implementation

uses uDialog;

{$R *.dfm}

//----------------------------------------------------------------------------------------------------------------------

procedure tfoShared.CloseShare(s:string);
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

//----------------------------------------------------------------------------------------------------------------------

procedure TfoShared.btnGetSharesClick(Sender: TObject);
var
  i:Integer;
  FLibHandle : THandle;
  ShareNT : PShareInfo2Array;     //<= Перемеменные
  entriesread,totalentries:DWORD; //<= для Windows NT
  OS: Boolean;
begin
  foShared.lbxShares.Items.Clear;
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
     with foShared.lbxShares.Items.Add do
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


  foShared.lbxShares.Items.Clear;
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
     with foShared.lbxShares.Items.Add do
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
       with foShared.lbxShares.Items.Add do
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


//----------------------------------------------------------------------------------------------------------------------

procedure TfoShared.FormCreate(Sender: TObject);
begin
  Self.DoubleBuffered:=true;
  self.btnGetSharesClick(self);
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TfoShared.btnCloseSharesClick(Sender: TObject);
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

procedure TfoShared.dxButton1Click(Sender: TObject);
begin
  close;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TfoShared.Image3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  image3.OnMouseMove:=Image3MouseMove;
  self.AlphaBlendValue:=trunc(255/100*strtofloatdef(mainform.draga,0));
  _x:=x;
  _y:=y;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TfoShared.Image3MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
    left:=x-_x+left;
    top:=y-_y+top;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TfoShared.Image3MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  image3.OnMouseMove:=nil;
  self.AlphaBlendValue:=255;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TfoShared.lbFormCaptionMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  lbFormCaption.OnMouseMove:=lbFormCaptionMouseMove;
  self.AlphaBlendValue:=trunc(255/100*strtofloatdef(mainform.draga,0));
  _x:=x;
  _y:=y;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TfoShared.lbFormCaptionMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
    left:=x-_x+left;
    top:=y-_y+top;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TfoShared.lbFormCaptionMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   lbFormCaption.OnMouseMove:=nil;
  self.AlphaBlendValue:=255;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TfoShared.SpeedButton3Click(Sender: TObject);
begin
  close;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TfoShared.sbCloseClick(Sender: TObject);
begin
close;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TfoShared.Refresh1Click(Sender: TObject);
begin
 btnGetSharesClick(self);

end;

//----------------------------------------------------------------------------------------------------------------------

procedure TfoShared.Addresource1Click(Sender: TObject);
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

procedure TfoShared.Openresource1Click(Sender: TObject);
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

procedure TfoShared.Delete1Click(Sender: TObject);
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

//----------------------------------------------------------------------------------------------------------------------

procedure TfoShared.Closeall1Click(Sender: TObject);
var i:integer;
    ShareName:string;
begin

  if self.lbxShares.Items.Count = 0 then Exit;
  for i:= 0 to self.lbxShares.Items.Count -1 do
    begin
      ShareName := self.lbxShares.Items[i].Caption;
      if self.lbxShares.Items[i].ImageIndex=31 then CloseShare(ShareName);
    end;


    btnGetSharesClick(self);

end;

//----------------------------------------------------------------------------------------------------------------------

procedure TfoShared.Openall1Click(Sender: TObject);
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
end;

//----------------------------------------------------------------------------------------------------------------------


end.



