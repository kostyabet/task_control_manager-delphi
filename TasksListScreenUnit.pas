Unit TasksListScreenUnit;

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
    Vcl.ExtCtrls,
    Vcl.Buttons,
    System.ImageList,
    Vcl.ImgList,
    Vcl.StdCtrls;

Type
    TTaskListForm = Class(TForm)
        PaintBox1: TPaintBox;
        PaintBox2: TPaintBox;
        PaintBox4: TPaintBox;
        PaintBox3: TPaintBox;
        SpeedButton6: TSpeedButton;
        SpeedButton7: TSpeedButton;
        SpeedButton8: TSpeedButton;
        SpeedButton9: TSpeedButton;
        SpeedButton10: TSpeedButton;
        ImageList1: TImageList;
        Procedure FormCreate(Sender: TObject);
        Procedure PaintBox2Paint(Sender: TObject);
        Procedure PaintBox4Paint(Sender: TObject);
        Procedure PaintBox3Paint(Sender: TObject);
    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Var
    TaskListForm: TTaskListForm;

Implementation

{$R *.dfm}

Procedure TTaskListForm.FormCreate(Sender: TObject);
Begin
    TaskListForm.Color := RGB(202, 205, 221);
End;

Procedure TTaskListForm.PaintBox2Paint(Sender: TObject);
Var
    BitMap: TBitmap;
    Rect: TRect;
    Radius: Integer;
Begin
    BitMap := TBitmap.Create();
    Rect := PaintBox2.ClientRect;
    BitMap.Height := PaintBox2.Height;
    BitMap.Width := PaintBox2.Width;
    Radius := 10;
    PaintBox2.Canvas.Brush.Color := RGB(179, 186, 200);
    PaintBox2.Canvas.Pen.Color := RGB(179, 186, 200);
    PaintBox2.Canvas.Pen.Width := 2;
    PaintBox2.Canvas.RoundRect(Rect.Left, Rect.Top, Rect.Right, Rect.Bottom, Radius, Radius);

    //TaskListForm.Canvas.Draw(PaintBox2.Left, PaintBox2.Top, BitMap);
    BitMap.Free();
End;

Procedure TTaskListForm.PaintBox3Paint(Sender: TObject);
Var
    BitMap: TBitmap;
Begin
    BitMap := TBitmap.Create();
    BitMap.Height := 10;
    BitMap.Width := 270;

    //DrawRoundedRect(BitMap.Canvas, 21, 31, 270, 10, 5);
    Canvas.Pen.Color := RGB(114, 122, 139);
    Canvas.Pen.Width := 6;
    Canvas.MoveTo(21, PaintBox3.Top + 41);
    Canvas.LineTo(133, PaintBox3.Top + 41);
    Canvas.MoveTo(179, PaintBox3.Top + 41);
    Canvas.LineTo(289, PaintBox3.Top + 41);

    Canvas.MoveTo(156, PaintBox3.Top + 8);
    Canvas.LineTo(156, PaintBox3.Top + 17);

    Canvas.MoveTo(156, PaintBox3.Top + 61);
    Canvas.LineTo(156, PaintBox3.Top + 72);
    //TaskListForm.Canvas.Draw(21, PaintBox3.Top + 35, BitMap);
    BitMap.Free();
End;

Procedure TTaskListForm.PaintBox4Paint(Sender: TObject);
Begin
    PaintBox4.Color := $A2ADC2;
End;

End.
