object BustFrame: TBustFrame
  Left = 0
  Top = 0
  Width = 49
  Height = 96
  TabOrder = 0
  object BackGroundVImage: TVirtualImage
    Left = 0
    Top = 0
    Width = 49
    Height = 96
    Cursor = crHandPoint
    Align = alClient
    ImageCollection = TaskListForm.BackgroundImgCollection
    ImageWidth = 0
    ImageHeight = 0
    ImageIndex = 6
    ImageName = 'BUSTBACKGROUND'
    Proportional = False
    OnClick = BustClick
    OnMouseEnter = MouseEnter
    OnMouseLeave = MouseLeave
    ExplicitLeft = 3
    ExplicitTop = 3
    ExplicitWidth = 105
    ExplicitHeight = 105
  end
  object BustVImage: TVirtualImage
    Left = 5
    Top = 30
    Width = 39
    Height = 55
    Cursor = crHandPoint
    ImageWidth = 0
    ImageHeight = 0
    ImageIndex = -1
    OnClick = BustClick
    OnMouseEnter = MouseEnter
    OnMouseLeave = MouseLeave
  end
  object CountLabel: TLabel
    Left = 28
    Top = 6
    Width = 13
    Height = 17
    Cursor = crHandPoint
    Caption = 'x0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    OnClick = BustClick
    OnMouseEnter = MouseEnter
    OnMouseLeave = MouseLeave
  end
end
