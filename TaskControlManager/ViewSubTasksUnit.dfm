object SubTasksForm: TSubTasksForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1055#1086#1076#1079#1072#1076#1072#1095#1080
  ClientHeight = 299
  ClientWidth = 523
  Color = clBtnFace
  Constraints.MaxHeight = 346
  Constraints.MaxWidth = 541
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  ShowHint = True
  OnCreate = FormCreate
  TextHeight = 15
  object MainLabel: TLabel
    Left = 174
    Top = 10
    Width = 186
    Height = 25
    Hint = #1047#1076#1077#1089#1100' '#1088#1072#1089#1087#1086#1083#1086#1078#1077#1085' '#1074#1077#1089#1100' '#1089#1087#1080#1089#1086#1082' '#1087#1086#1076#1079#1072#1076#1072#1095' '#1076#1072#1085#1085#1086#1081' '#1079#1072#1076#1072#1095#1080'.'
    Caption = #1057#1055#1048#1057#1054#1050' '#1055#1054#1047#1044#1040#1044#1040#1063
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
  end
  object SubTasksSclBox: TScrollBox
    Left = 10
    Top = 48
    Width = 510
    Height = 249
    HorzScrollBar.Visible = False
    VertScrollBar.Tracking = True
    TabOrder = 0
    OnMouseWheel = SubTasksSclBoxMouseWheel
    object SubTasksPBox: TPaintBox
      Left = 0
      Top = 0
      Width = 489
      Height = 246
      OnPaint = SubTasksPBoxPaint
    end
  end
end
