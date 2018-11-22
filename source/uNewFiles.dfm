object foNewFiles: TfoNewFiles
  Left = 286
  Top = 533
  AlphaBlend = True
  AlphaBlendValue = 180
  BorderStyle = bsNone
  Caption = 'foNewFiles'
  ClientHeight = 86
  ClientWidth = 410
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lvFiles_compare: TListView
    Left = 0
    Top = 0
    Width = 410
    Height = 86
    Align = alClient
    Columns = <
      item
        Caption = 'Num'
      end
      item
        Caption = 'Status'
      end
      item
        Caption = 'Path'
      end
      item
        Caption = 'User'
      end>
    ColumnClick = False
    FlatScrollBars = True
    GridLines = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
    OnClick = lvFiles_compareClick
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 3000
    OnTimer = Timer1Timer
    Left = 200
    Top = 20
  end
end
