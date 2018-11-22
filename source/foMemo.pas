unit foMemo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Memo1: TMemo;
    SpeedButton3: TSpeedButton;
    SpeedButton1: TSpeedButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.SpeedButton3Click(Sender: TObject);
begin
 close;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);

begin
  self.SaveDialog1.FileName:='';

  self.SaveDialog1.Execute;
  if self.SaveDialog1.FileName <>'' then
   begin
     self.Memo1.Lines.SaveToFile(self.SaveDialog1.FileName);
   end;

end;

end.
