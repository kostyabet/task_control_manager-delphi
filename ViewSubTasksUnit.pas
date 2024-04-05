Unit ViewSubTasksUnit;

Interface

Uses
    Winapi.Windows,
    System.Classes,
    Vcl.Graphics,
    Vcl.Forms,
    Vcl.StdCtrls,
    Vcl.ExtCtrls,
    NewTaskUnit,
    ColorsUnit,
    Vcl.Controls;

Type
    TSubTasksForm = Class(TForm)
        MainLabel: TLabel;
        SubTasksSclBox: TScrollBox;
        SubTasksPBox: TPaintBox;
        Procedure FormCreate(Sender: TObject);
        Procedure SubTasksPBoxPaint(Sender: TObject);
        Procedure SubTasksSclBoxMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
            Var Handled: Boolean);
    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Const
    LeftMargin: Integer = 25;
    TopMargin: Integer = 25;
    WidthLen: Integer = 612;
    HeightLen: Integer = 50;

Var
    SubTasksForm: TSubTasksForm;

Implementation

{$R *.dfm}

Procedure TSubTasksForm.FormCreate(Sender: TObject);
Begin
    { настройка пльзовательского стиля }
    MainLabel.Font.Color := ClText;
    SubTasksForm.Color := ClFont;
    SubTasksSclBox.VertScrollBar.Color := ClFont;
    NewTask.OutputSubTask(LeftMargin, TopMargin, WidthLen, HeightLen);
End;

Procedure TSubTasksForm.SubTasksPBoxPaint(Sender: TObject);
Const
    RADIUS: Integer = 30;
    PEN_WIDTH: Integer = 10;
    SUB_TASK_VISIBLE: Integer = 3;
    MARGIN: Integer = 20;
Var
    BitMap: TBitmap;
    RectM: TRect;
Begin
    BitMap := TBitmap.Create();

    { настройка области видимости }
    If NewTask.SubTasksCounter > SUB_TASK_VISIBLE Then
        SubTasksPBox.Height := NewTask.SubTasksCounter * (TopMargin + HeightLen) + MARGIN;

    RectM := SubTasksPBox.ClientRect;
    BitMap.Height := SubTasksPBox.Height;
    BitMap.Width := SubTasksPBox.Width;
    BitMap.Canvas.Brush.Color := ClBackgroundBrush;
    BitMap.Canvas.Pen.Color := ClBackgroundPen;
    BitMap.Canvas.Pen.Width := PEN_WIDTH;
    BitMap.Canvas.RoundRect(RectM.Left, RectM.Top, RectM.Right, RectM.Bottom, RADIUS, RADIUS);
    { отрисовка фона подзадач }
    NewTask.DrawSubTasks(BitMap.Canvas, SubTasksPBox, LeftMargin, TopMargin, WidthLen, HeightLen);

    SubTasksPBox.Canvas.Draw(0, 0, Bitmap);
    BitMap.Free();
End;

Procedure TSubTasksForm.SubTasksSclBoxMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
    Var Handled: Boolean);
Const
    SCROLL_SPEED = 10;
    DEGREE: Integer = 60;
Var
    Delta: Integer;
Begin
    { scroll bar для мыши и touch pad }
    Delta := WheelDelta Div DEGREE * SCROLL_SPEED;
    SubTasksSclBox.VertScrollBar.Position := SubTasksSclBox.VertScrollBar.Position - Delta;
    Handled := True;
End;

End.
