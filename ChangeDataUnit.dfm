object ChangeDataForm: TChangeDataForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1048#1079#1084#1077#1085#1077#1085#1080#1077' '#1076#1072#1085#1085#1099#1093
  ClientHeight = 82
  ClientWidth = 326
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnClick = ApplyButtonFrameClick
  OnCreate = FormCreate
  TextHeight = 15
  object SubTaskLabel: TLabel
    Left = 10
    Top = 6
    Width = 123
    Height = 17
    Caption = #1048#1079#1084#1077#1085#1105#1085#1085#1099#1081' '#1090#1077#1082#1089#1090':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object SubTitleLenLabel: TLabel
    Left = 296
    Top = 10
    Width = 19
    Height = 12
    Caption = '0/25'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -10
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object SubTitleLEdit: TLabeledEdit
    Left = 8
    Top = 25
    Width = 307
    Height = 23
    EditLabel.Width = 67
    EditLabel.Height = 15
    EditLabel.Caption = 'LabeledEdit1'
    MaxLength = 25
    TabOrder = 0
    Text = ''
    TextHint = #1042#1072#1096' '#1090#1077#1082#1089#1090
    OnChange = SubTitleLEditChange
  end
  inline ApplyButtonFrame: TFrame1
    Left = 8
    Top = 56
    Width = 307
    Height = 18
    TabOrder = 1
    ExplicitLeft = 8
    ExplicitTop = 56
    ExplicitWidth = 307
    inherited BackGroundVirtmage: TVirtualImage
      Width = 307
      Proportional = False
      OnClick = ApplyButtonFrameClick
      ExplicitWidth = 307
    end
    inherited ButtonText: TLabel
      Left = 112
      Width = 86
      Caption = #1055#1054#1044#1058#1042#1045#1056#1044#1048#1058#1068
      OnClick = ApplyButtonFrameClick
      ExplicitLeft = 112
      ExplicitWidth = 86
    end
  end
end
