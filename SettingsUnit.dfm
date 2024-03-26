object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
  ClientHeight = 91
  ClientWidth = 253
  Color = clBtnFace
  Constraints.MaxHeight = 129
  Constraints.MaxWidth = 265
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
  object PaintBox1: TPaintBox
    Left = 10
    Top = 10
    Width = 233
    Height = 71
    OnPaint = PaintBox1Paint
  end
  object ToggleSwitch1: TToggleSwitch
    Left = 136
    Top = 32
    Width = 88
    Height = 20
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    StateCaptions.CaptionOn = #1042#1082#1083'.'
    StateCaptions.CaptionOff = #1042#1099#1082#1083'.'
    TabOrder = 0
  end
end
