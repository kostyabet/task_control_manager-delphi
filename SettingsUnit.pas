Unit SettingsUnit;

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
    Vcl.WinXCtrls;

Type
    TForm1 = Class(TForm)
        PaintBox1: TPaintBox;
        ToggleSwitch1: TToggleSwitch;
        Procedure FormCreate(Sender: TObject);
        Procedure PaintBox1Paint(Sender: TObject);
    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Var
    Form1: TForm1;

Implementation

{$R *.dfm}

Procedure TForm1.FormCreate(Sender: TObject);
Begin
    Form1.Color := Rgb(202, 205, 221);
    ToggleSwitch1.FrameColor := Rgb(202, 205, 221);
    ToggleSwitch1.ThumbColor := Rgb(38, 43, 50);
    ToggleSwitch1.Font.Color := Rgb(38, 43, 50);
End;

Procedure TForm1.PaintBox1Paint(Sender: TObject);
Var
    BitMap: TBitmap;
    Rect: TRect;
    Radius: Integer;
Begin
    BitMap := TBitmap.Create();
    Rect := PaintBox1.ClientRect;
    BitMap.Height := PaintBox1.Height;
    BitMap.Width := PaintBox1.Width;
    Radius := 30;
    PaintBox1.Canvas.Brush.Color := Rgb(169, 174, 187);
    PaintBox1.Canvas.Pen.Color := Rgb(179, 188, 206);
    PaintBox1.Canvas.Pen.Width := 10;
    PaintBox1.Canvas.RoundRect(Rect.Left, Rect.Top, Rect.Right, Rect.Bottom, Radius, Radius);
    BitMap.Free();
End;

End.
