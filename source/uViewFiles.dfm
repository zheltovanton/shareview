object foViewFiles: TfoViewFiles
  Left = 191
  Top = 137
  Width = 482
  Height = 480
  Caption = 'foViewFiles'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 176
    Width = 474
    Height = 6
    Cursor = crVSplit
    Align = alTop
    Beveled = True
    Color = clInfoBk
    ParentColor = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 474
    Height = 176
    Align = alTop
    TabOrder = 1
    object Panel3: TPanel
      Left = 1
      Top = 1
      Width = 28
      Height = 174
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      object SpeedButton3: TSpeedButton
        Left = -1
        Top = 1
        Width = 29
        Height = 29
        Hint = #1047#1072#1082#1088#1099#1090#1100' '#1082#1086#1085#1077#1082#1090
        Flat = True
        Glyph.Data = {
          76060000424D7606000000000000360400002800000018000000180000000100
          08000000000040020000230B0000230B00000001000000010000006300000084
          0000087308004242420042CE6B0084848400085ABD0063BDE700399CF700FF00
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00090909030509
          0909090909090909090909090909090909090909090305090909090909090909
          0909090909090909090909090903050909090909090909090909090909090909
          0909090909090305090909090909090909090909090909090909090909090903
          0002020202090909090909090909090909090909090909090401010102020209
          0909090909090909090909090909090904010101010102020909090909090909
          0909090909090909040101010101010202090909090909090909090909090909
          0404010101010104030909090909090909090909090909090904010101010403
          0909090909090909090909090909090909040401010403090909090909090909
          0909090909090909090904040403090909090306090909090909090909090909
          0909090403090909090307060609090909090909090909090909090909090909
          0307080806060909090909090909090909090909090909030708080808060909
          0909090909090909090909090909030708080808080606090909090909090909
          0909090909090707080808080808060909090909090909090909090909090907
          0708080808080609090909090909090909090909090909090707070808080609
          0909090909090909090909090909090909090707070703050909090909090909
          0909090909090909090909090909090305090909090909090909090909090909
          0909090909090909030509090909090909090909090909090909090909090909
          0903090909090909090909090909090909090909090909090909}
      end
    end
    object lvFiles: TListView
      Left = 29
      Top = 1
      Width = 444
      Height = 174
      Align = alClient
      BevelOuter = bvNone
      BevelKind = bkFlat
      BorderStyle = bsNone
      Columns = <
        item
        end
        item
        end
        item
        end>
      ColumnClick = False
      FlatScrollBars = True
      RowSelect = True
      TabOrder = 1
      ViewStyle = vsReport
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 182
    Width = 474
    Height = 269
    Align = alClient
    TabOrder = 0
    object Panel4: TPanel
      Left = 1
      Top = 1
      Width = 28
      Height = 267
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
    end
  end
end