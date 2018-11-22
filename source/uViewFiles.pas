unit uViewFiles;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls,  Buttons, ComCtrls;

type
  TfoViewFiles = class(TForm)
    Panel1: TPanel;
    Splitter1: TSplitter;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    SpeedButton3: TSpeedButton;
    lvFiles: TListView;
    procedure SpeedButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  foViewFiles: TfoViewFiles;

implementation

{$R *.dfm}

procedure TfoViewFiles.SpeedButton2Click(Sender: TObject);
begin
  halt;
end;

end.
