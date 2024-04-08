object AboutEditorForm: TAboutEditorForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1054' '#1088#1072#1079#1088#1072#1073#1086#1090#1095#1080#1082#1077
  ClientHeight = 166
  ClientWidth = 324
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
  object IcoVImage: TVirtualImage
    Left = 8
    Top = 56
    Width = 100
    Height = 100
    ImageCollection = TaskListForm.IconsImgCollection
    ImageWidth = 0
    ImageHeight = 0
    ImageIndex = 12
    ImageName = 'Group 2'
  end
  object TCMLabel: TLabel
    Left = 56
    Top = 8
    Width = 207
    Height = 28
    Caption = 'Task Control Manager'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object AboutCompLabel: TLabel
    Left = 228
    Top = 147
    Width = 92
    Height = 15
    Caption = 'KostyaBelBet, Inc.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsItalic]
    ParentFont = False
  end
  object EditorLabel: TLabel
    Left = 128
    Top = 64
    Width = 180
    Height = 15
    Caption = #1056#1072#1079#1088#1072#1073#1086#1090#1095#1080#1082': '#1041#1077#1090#1077#1085#1103' '#1050#1086#1085#1089#1090#1072#1085#1090#1080#1085
  end
  object GroupLabel: TLabel
    Left = 128
    Top = 85
    Width = 81
    Height = 15
    Caption = #1043#1088#1091#1087#1087#1072': 351005'
  end
end
