Unit ViewSubTasksUnit;

Interface

Uses
    Winapi.Windows,
    Winapi.Messages,
    System.SysUtils,
    System.Variants,
    System.Classes,
    Vcl.Graphics,
    Vcl.Controls,
    Vcl.Forms,
    Vcl.Dialogs,
    Vcl.StdCtrls,
    Vcl.ExtCtrls,
    TasksLinkedListUnit,
    TaskUnit;

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
    LeftBorder: Integer = 25;
    TopBorder: Integer = 25;
    WidthBorder: Integer = 612;
    HeightBorder: Integer = 50;

Var
    SubTasksForm: TSubTasksForm;
    ArrayOfTasks: TArrayOfTasks;

Implementation

{$R *.dfm}

Uses
    TasksListScreenUnit,
    ViewControllerUnit,
    NewTaskUnit,
    ButtonFrame,
    ChangeDataUnit;

Procedure TSubTasksForm.FormCreate(Sender: TObject);
Begin
    MainLabel.Font.Color := Rgb(38, 43, 50);
    SubTasksForm.Color := Rgb(202, 205, 221);
    SubTasksSclBox.VertScrollBar.Color := Rgb(202, 205, 221);
    NewTask.OutputText(LeftBorder, TopBorder, WidthBorder, HeightBorder);
End;

Procedure TSubTasksForm.SubTasksPBoxPaint(Sender: TObject);
Var
    BitMap: TBitmap;
    RectM: TRect;
    Radius: Integer;
Begin
    BitMap := TBitmap.Create();

    If NewTask.SubTasksCounter > 3 Then
        SubTasksPBox.Height := NewTask.SubTasksCounter * (TopBorder + HeightBorder) + 20;

    RectM := SubTasksPBox.ClientRect;
    BitMap.Height := SubTasksPBox.Height;
    BitMap.Width := SubTasksPBox.Width;
    Radius := 30;
    BitMap.Canvas.Brush.Color := Rgb(169, 174, 187);
    BitMap.Canvas.Pen.Color := Rgb(179, 188, 206);
    BitMap.Canvas.Pen.Width := 10;
    BitMap.Canvas.RoundRect(RectM.Left, RectM.Top, RectM.Right, RectM.Bottom, Radius, Radius);

    NewTask.DrawSubTasks(BitMap.Canvas, SubTasksPBox, LeftBorder, TopBorder, WidthBorder, HeightBorder);

    SubTasksPBox.Canvas.Draw(0, 0, Bitmap);
    BitMap.Free();
End;

Procedure TSubTasksForm.SubTasksSclBoxMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
    Var Handled: Boolean);
Const
    ScrollSpeed = 10;
Var
    Delta: Integer;
Begin
    Delta := WheelDelta Div 60 * ScrollSpeed;
    SubTasksSclBox.VertScrollBar.Position := SubTasksSclBox.VertScrollBar.Position - Delta;
    Handled := True;
End;

End.
