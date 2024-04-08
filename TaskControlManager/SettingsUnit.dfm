object SettingsForm: TSettingsForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
  ClientHeight = 111
  ClientWidth = 273
  Color = clBtnFace
  Constraints.MaxHeight = 149
  Constraints.MaxWidth = 285
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
  object BackgroundPBox: TPaintBox
    Left = 10
    Top = 10
    Width = 253
    Height = 87
    OnPaint = BackgroundPBoxPaint
  end
  object ThemeLabel: TLabel
    Left = 24
    Top = 20
    Width = 97
    Height = 15
    Caption = #1062#1074#1077#1090#1086#1074#1072#1103' '#1089#1093#1077#1084#1072':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ThemeCBox: TComboBox
    Left = 127
    Top = 17
    Width = 120
    Height = 23
    Style = csDropDownList
    Color = clScrollBar
    TabOrder = 0
    OnChange = ThemeCBoxChange
    Items.Strings = (
      #1089#1074#1077#1090#1083#1072#1103)
  end
end
