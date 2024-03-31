object SubTasksForm: TSubTasksForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1055#1086#1076#1079#1072#1076#1072#1095#1080
  ClientHeight = 303
  ClientWidth = 529
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
  object MainLabel: TLabel
    Left = 174
    Top = 10
    Width = 186
    Height = 25
    Caption = #1057#1055#1048#1057#1054#1050' '#1055#1054#1047#1044#1040#1044#1040#1063
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
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
