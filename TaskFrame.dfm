object TaskOutputFrame: TTaskOutputFrame
  Left = 0
  Top = 0
  Width = 604
  Height = 54
  TabOrder = 0
  object BackGroundVImage: TVirtualImage
    Left = 0
    Top = 0
    Width = 604
    Height = 54
    Hint = #1042#1072#1096#1072' '#1079#1072#1076#1072#1095#1072'. '#1044#1074#1086#1081#1085#1086#1077' '#1085#1072#1078#1072#1090#1080#1077' - '#1088#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077'.'
    Align = alClient
    ImageCollection = TaskListForm.BackgroundImgCollection
    ImageWidth = 0
    ImageHeight = 0
    ImageIndex = 2
    ImageName = 'TASK_FON'
    ParentShowHint = False
    ShowHint = True
    OnDblClick = CustomDblClick
    ExplicitTop = 4
  end
  object ExpVImage: TVirtualImage
    Left = 485
    Top = 33
    Width = 5
    Height = 13
    Hint = #1054#1087#1099#1090'.'
    ImageCollection = TaskListForm.IconsImgCollection
    ImageWidth = 0
    ImageHeight = 0
    ImageIndex = 1
    ImageName = 'EXPBUFF'
    ParentShowHint = False
    ShowHint = True
  end
  object XPLabel: TLabel
    Left = 491
    Top = 32
    Width = 24
    Height = 15
    Hint = #1058#1086', '#1089#1082#1086#1083#1100#1082#1086' '#1086#1087#1099#1090#1072' '#1074#1099' '#1087#1086#1083#1091#1095#1080#1090#1077'.'
    Caption = '8888'
    ParentShowHint = False
    ShowHint = True
  end
  object HpLabel: TLabel
    Left = 533
    Top = 33
    Width = 24
    Height = 15
    Hint = #1058#1086', '#1089#1082#1086#1083#1100#1082#1086' '#1079#1076#1086#1088#1086#1074#1100#1103' '#1074#1099' '#1087#1086#1083#1091#1095#1080#1090#1077'.'
    Caption = '8888'
    ParentShowHint = False
    ShowHint = True
  end
  object HpVImage: TVirtualImage
    Left = 523
    Top = 34
    Width = 9
    Height = 13
    Hint = #1047#1076#1086#1088#1086#1074#1100#1077'.'
    ImageCollection = TaskListForm.IconsImgCollection
    ImageWidth = 0
    ImageHeight = 0
    ImageIndex = 0
    ImageName = 'HEALTHBUFF'
    ParentShowHint = False
    ShowHint = True
  end
  object MoneyVImage: TVirtualImage
    Left = 559
    Top = 35
    Width = 11
    Height = 11
    Hint = #1052#1086#1085#1077#1090#1099'.'
    ImageCollection = TaskListForm.IconsImgCollection
    ImageWidth = 0
    ImageHeight = 0
    ImageIndex = 8
    ImageName = 'koin'
  end
  object MoneyLabel: TLabel
    Left = 571
    Top = 33
    Width = 24
    Height = 15
    Hint = #1058#1086', '#1089#1082#1086#1083#1100#1082#1086' '#1084#1086#1085#1077#1090#1086#1082' '#1074#1099' '#1087#1086#1083#1091#1095#1080#1090#1077'.'
    Caption = '8888'
    ParentShowHint = False
    ShowHint = True
  end
  object ComplexityVImage: TVirtualImage
    Left = 4
    Top = 4
    Width = 3
    Height = 46
    Hint = #1057#1083#1086#1078#1085#1086#1089#1090#1100' '#1079#1072#1076#1072#1095#1080'.'
    ImageCollection = TaskListForm.IconsImgCollection
    ImageWidth = 0
    ImageHeight = 0
    ImageIndex = 9
    ImageName = 'EazyComplexity'
    ParentShowHint = False
    ShowHint = True
    OnDblClick = CustomDblClick
  end
  object SubTasksLabel: TLabel
    Left = 269
    Top = 6
    Width = 76
    Height = 15
    Caption = #1055#1054#1044#1047#1040#1044#1040#1063#1048
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object SubTasksResLabel: TLabel
    Left = 351
    Top = 6
    Width = 17
    Height = 15
    Hint = #1087#1086#1076#1079#1072#1076#1072#1095' '#1074#1099#1087#1086#1083#1085#1077#1085#1086' / '#1087#1086#1076#1079#1072#1076#1072#1095' '#1074#1089#1077#1075#1086
    Caption = '0/0'
    ParentShowHint = False
    ShowHint = True
  end
  object TaskLabel: TLabel
    Left = 15
    Top = 3
    Width = 64
    Height = 15
    Hint = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1079#1072#1076#1072#1095#1080'.'
    Caption = #1053#1040#1047#1042#1040#1053#1048#1045
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    OnDblClick = CustomDblClick
  end
  object DeadLineLabel: TLabel
    Left = 15
    Top = 18
    Width = 63
    Height = 15
    Hint = #1057#1088#1086#1082' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103' '#1079#1072#1076#1072#1095#1080'.'
    Caption = #1057#1076#1077#1083#1072#1090#1100' '#1076#1086':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    OnDblClick = CustomDblClick
  end
  object AboutLabel: TLabel
    Left = 15
    Top = 32
    Width = 55
    Height = 15
    Hint = #1050#1088#1072#1090#1082#1086#1077' '#1086#1087#1080#1089#1072#1085#1080#1077' '#1079#1072#1076#1072#1095#1080'.'
    Caption = #1054#1087#1080#1089#1072#1085#1080#1077
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    OnDblClick = CustomDblClick
  end
  inline ApplyButtonFrame: TFrame1
    Left = 485
    Top = 9
    Width = 110
    Height = 20
    TabOrder = 0
    ExplicitLeft = 485
    ExplicitTop = 9
    ExplicitWidth = 110
    ExplicitHeight = 20
    inherited BackGroundVirtmage: TVirtualImage
      Width = 110
      Height = 20
      Hint = #1042#1099#1087#1086#1083#1085#1080#1090#1100' '#1079#1072#1076#1072#1095#1091'.'
      ParentShowHint = False
      Proportional = False
      ShowHint = True
      OnClick = ApplyButtonClick
      ExplicitWidth = 110
      ExplicitHeight = 20
    end
    inherited ButtonText: TLabel
      Left = 18
      Top = 2
      Width = 78
      Hint = #1042#1099#1087#1086#1083#1085#1080#1090#1100' '#1079#1072#1076#1072#1095#1091'.'
      Caption = #1042#1067#1055#1054#1051#1053#1048#1058#1068
      ParentShowHint = False
      ShowHint = True
      OnClick = ApplyButtonClick
      ExplicitLeft = 18
      ExplicitTop = 2
      ExplicitWidth = 78
    end
  end
  inline ChangeSubTasksFrame: TFrame1
    Left = 267
    Top = 25
    Width = 100
    Height = 20
    TabOrder = 1
    ExplicitLeft = 267
    ExplicitTop = 25
    ExplicitWidth = 100
    ExplicitHeight = 20
    inherited BackGroundVirtmage: TVirtualImage
      Width = 100
      Height = 20
      Hint = #1055#1088#1086#1089#1084#1086#1090#1088#1077#1090#1100' '#1087#1086#1076#1079#1072#1076#1072#1095#1080'.'
      ParentShowHint = False
      Proportional = False
      ShowHint = True
      OnClick = ChangeSubTasksFrameClick
      ExplicitWidth = 100
      ExplicitHeight = 20
    end
    inherited ButtonText: TLabel
      Left = 22
      Top = 2
      Width = 56
      Hint = #1055#1088#1086#1089#1084#1086#1090#1088#1077#1090#1100' '#1087#1086#1076#1079#1072#1076#1072#1095#1080'.'
      Caption = #1054#1058#1050#1056#1067#1058#1068
      ParentShowHint = False
      ShowHint = True
      OnClick = ChangeSubTasksFrameClick
      ExplicitLeft = 22
      ExplicitTop = 2
      ExplicitWidth = 56
    end
  end
end
