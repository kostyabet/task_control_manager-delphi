object Frame1: TFrame1
  Left = 0
  Top = 0
  Width = 76
  Height = 18
  TabOrder = 0
  object BackGroundVirtmage: TVirtualImage
    Left = 0
    Top = 0
    Width = 76
    Height = 18
    Cursor = crHandPoint
    ImageCollection = TaskListForm.BackgroundImgCollection
    ImageWidth = 0
    ImageHeight = 0
    ImageIndex = 3
    ImageName = 'OFFBYE'
    OnMouseEnter = MouseEnter
    OnMouseLeave = MouseLeave
  end
  object ButtonText: TLabel
    Left = 27
    Top = 1
    Width = 21
    Height = 15
    Cursor = crHandPoint
    Caption = '100'
    Color = clMenuHighlight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNone
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    OnMouseEnter = MouseEnter
    OnMouseLeave = MouseLeave
  end
end
