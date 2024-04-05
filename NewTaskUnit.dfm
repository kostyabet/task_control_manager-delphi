object NewTaskForm: TNewTaskForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1085#1086#1074#1086#1081' '#1079#1072#1076#1072#1095#1080
  ClientHeight = 365
  ClientWidth = 773
  Color = clBtnFace
  Constraints.MaxHeight = 412
  Constraints.MaxWidth = 789
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
  object HeadlineLabel: TLabel
    Left = 250
    Top = 12
    Width = 281
    Height = 25
    Caption = #1044#1054#1041#1040#1042#1051#1045#1053#1048#1045' '#1053#1054#1042#1054#1049' '#1047#1040#1044#1040#1063#1048
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object BackgroundPBox: TPaintBox
    Left = 18
    Top = 50
    Width = 732
    Height = 302
    Constraints.MaxHeight = 302
    Constraints.MaxWidth = 732
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    OnPaint = BackgroundPBoxPaint
  end
  object TitleLabel: TLabel
    Left = 56
    Top = 77
    Width = 144
    Height = 17
    Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1079#1072#1076#1072#1095#1080
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object TitleLenLabel: TLabel
    Left = 342
    Top = 81
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
  object DateLabel: TLabel
    Left = 402
    Top = 77
    Width = 116
    Height = 17
    Caption = #1057#1088#1086#1082' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object DateMarkLabel: TLabel
    Left = 687
    Top = 81
    Width = 19
    Height = 12
    Caption = 'date'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -10
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object AboutTaskLabel: TLabel
    Left = 56
    Top = 140
    Width = 143
    Height = 17
    Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1079#1072#1076#1072#1095#1077
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object AboutTaskLenLabel: TLabel
    Left = 678
    Top = 144
    Width = 24
    Height = 12
    Caption = '0/200'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -10
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object SubTaskLabel: TLabel
    Left = 56
    Top = 230
    Width = 70
    Height = 17
    Caption = #1055#1086#1076#1079#1072#1076#1072#1095#1080
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object SubTitleLenLabel: TLabel
    Left = 342
    Top = 234
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
  object ComplexityLabel: TLabel
    Left = 56
    Top = 293
    Width = 74
    Height = 17
    Caption = #1057#1083#1086#1078#1085#1086#1089#1090#1100':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object TitleLEdit: TLabeledEdit
    Left = 56
    Top = 96
    Width = 307
    Height = 23
    EditLabel.Width = 48
    EditLabel.Height = 15
    EditLabel.Caption = 'TitleLEdit'
    MaxLength = 25
    TabOrder = 0
    Text = ''
    TextHint = #1047#1072#1076#1072#1095#1072
    OnChange = TitleLEditChange
  end
  object DateTPicker: TDateTimePicker
    Left = 402
    Top = 96
    Width = 306
    Height = 21
    CalColors.BackColor = clScrollBar
    CalColors.TitleTextColor = clMedGray
    CalColors.MonthBackColor = clMedGray
    Date = 45376.000000000000000000
    Time = 0.923285231481713700
    Color = clWindowFrame
    TabOrder = 1
    Touch.ParentTabletOptions = False
    Touch.TabletOptions = [toPressAndHold]
  end
  object AboutTaskMemo: TMemo
    Left = 56
    Top = 159
    Width = 652
    Height = 58
    MaxLength = 200
    TabOrder = 2
    OnChange = AboutTaskMemoChange
  end
  object SubTitleLEdit: TLabeledEdit
    Left = 54
    Top = 249
    Width = 307
    Height = 23
    EditLabel.Width = 67
    EditLabel.Height = 15
    EditLabel.Caption = 'LabeledEdit1'
    MaxLength = 25
    TabOrder = 3
    Text = ''
    TextHint = #1047#1072#1076#1072#1095#1072
    OnChange = SubTitleLEditChange
  end
  object ComplexityCBox: TComboBox
    Left = 136
    Top = 292
    Width = 131
    Height = 23
    Style = csDropDownList
    Color = clWindowFrame
    ExtendedUI = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ImeMode = imDisable
    ItemIndex = 0
    ParentFont = False
    TabOrder = 4
    Text = #1051#1077#1075#1082#1086
    Items.Strings = (
      #1051#1077#1075#1082#1086
      #1057#1088#1077#1076#1085#1077
      #1058#1103#1078#1077#1083#1086)
  end
  inline AddSubTaskFrame: TFrame1
    Left = 372
    Top = 249
    Width = 100
    Height = 21
    Enabled = False
    TabOrder = 5
    OnClick = AddSubTaskFrameClick
    ExplicitLeft = 372
    ExplicitTop = 249
    ExplicitWidth = 100
    ExplicitHeight = 21
    inherited BackGroundVirtmage: TVirtualImage
      Width = 100
      Height = 21
      Enabled = False
      Proportional = False
      OnClick = AddSubTaskFrameClick
      ExplicitWidth = 100
      ExplicitHeight = 21
    end
    inherited ButtonText: TLabel
      Left = 17
      Top = 2
      Width = 65
      Caption = #1044#1054#1041#1040#1042#1048#1058#1068
      Enabled = False
      Font.Color = clDefault
      OnClick = AddSubTaskFrameClick
      ExplicitLeft = 17
      ExplicitTop = 2
      ExplicitWidth = 65
    end
  end
  inline SubTasksListFrame: TFrame1
    Left = 484
    Top = 249
    Width = 224
    Height = 21
    TabOrder = 6
    ExplicitLeft = 484
    ExplicitTop = 249
    ExplicitWidth = 224
    ExplicitHeight = 21
    inherited BackGroundVirtmage: TVirtualImage
      Width = 224
      Height = 21
      Proportional = False
      OnClick = SubTasksListFrameClick
      ExplicitWidth = 224
      ExplicitHeight = 21
    end
    inherited ButtonText: TLabel
      Left = 7
      Top = 2
      Width = 208
      Caption = #1055#1056#1054#1057#1052#1054#1058#1056#1045#1058#1068' '#1057#1055#1048#1057#1054#1050' '#1055#1054#1044#1047#1040#1044#1040#1063
      OnClick = SubTasksListFrameClick
      ExplicitLeft = 7
      ExplicitTop = 2
      ExplicitWidth = 208
    end
  end
  inline ApplyFrame: TFrame1
    Left = 273
    Top = 294
    Width = 435
    Height = 21
    Enabled = False
    TabOrder = 7
    OnClick = ApplyFrameClick
    ExplicitLeft = 273
    ExplicitTop = 294
    ExplicitWidth = 435
    ExplicitHeight = 21
    inherited BackGroundVirtmage: TVirtualImage
      Width = 435
      Height = 21
      Enabled = False
      Proportional = False
      OnClick = ApplyFrameClick
      ExplicitWidth = 435
      ExplicitHeight = 21
    end
    inherited ButtonText: TLabel
      Left = 135
      Top = 2
      Width = 163
      Caption = #1055#1054#1044#1058#1042#1045#1056#1044#1048#1058#1068' '#1048#1047#1052#1045#1053#1045#1053#1048#1071
      Enabled = False
      Font.Color = clDefault
      OnClick = ApplyFrameClick
      ExplicitLeft = 135
      ExplicitTop = 2
      ExplicitWidth = 163
    end
  end
end
