Unit NewTaskUnit;

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
    Vcl.StdCtrls,
    Vcl.Mask,
    Vcl.ComCtrls,
    Vcl.VirtualImage,
    Vcl.BaseImageCollection,
    Vcl.ImageCollection,
    System.ImageList,
    Vcl.ImgList,
    Vcl.VirtualImageList,
    ButtonFrame;

Type
    TNewTaskForm = Class(TForm)
        Label1: TLabel;
        PaintBox1: TPaintBox;
        LabeledEdit1: TLabeledEdit;
        Label2: TLabel;
        Label3: TLabel;
        Label4: TLabel;
        DateTimePicker1: TDateTimePicker;
        Label5: TLabel;
        Label6: TLabel;
        Memo1: TMemo;
        Label7: TLabel;
        Label8: TLabel;
        LabeledEdit2: TLabeledEdit;
        Label9: TLabel;
        Label10: TLabel;
        ComboBox1: TComboBox;
        ImageCollection: TImageCollection;
        VirtualImageList1: TVirtualImageList;
        VirtualImage1: TVirtualImage;
        VirtualImage2: TVirtualImage;
        VirtualImage3: TVirtualImage;
        Procedure FormCreate(Sender: TObject);
        Procedure PaintBox1Paint(Sender: TObject);
        Procedure VirtualImage1MouseEnter(Sender: TObject);
        Procedure VirtualImage1MouseLeave(Sender: TObject);
        Procedure VirtualImage2MouseEnter(Sender: TObject);
        Procedure VirtualImage2MouseLeave(Sender: TObject);
        Procedure VirtualImage3MouseEnter(Sender: TObject);
        Procedure VirtualImage3MouseLeave(Sender: TObject);
    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Var
    NewTaskForm: TNewTaskForm;

Implementation

{$R *.dfm}

Procedure TNewTaskForm.FormCreate(Sender: TObject);
Begin
    DateTimePicker1.Color := Rgb(202, 205, 221);
    LabeledEdit1.Color := Rgb(202, 205, 221);
    LabeledEdit2.Color := Rgb(202, 205, 221);
    NewTaskForm.Color := Rgb(202, 205, 221);
    ComboBox1.Color := RGB(202, 205, 221);
    Memo1.Color := Rgb(202, 205, 221);

    LabeledEdit1.EditLabel.Caption := '';
    LabeledEdit2.EditLabel.Caption := '';

    DateTimePicker1.Font.Color := Rgb(38, 43, 50);
    LabeledEdit1.Font.Color := RGB(38, 43, 50);
    LabeledEdit2.Font.Color := RGB(38, 43, 50);
    ComboBox1.Font.Color := RGB(38, 43, 50);
    Label10.Font.Color := RGB(38, 43, 50);
    Label1.Font.Color := RGB(38, 43, 50);
    Label2.Font.Color := RGB(38, 43, 50);
    Label3.Font.Color := RGB(38, 43, 50);
    Label4.Font.Color := RGB(38, 43, 50);
    Label5.Font.Color := RGB(38, 43, 50);
    Label6.Font.Color := RGB(38, 43, 50);
    Label7.Font.Color := RGB(38, 43, 50);
    Label8.Font.Color := RGB(38, 43, 50);
    Label9.Font.Color := RGB(38, 43, 50);
    Memo1.Font.Color := RGB(38, 43, 50);
End;

Procedure TNewTaskForm.PaintBox1Paint(Sender: TObject);
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

Procedure TNewTaskForm.VirtualImage1MouseEnter(Sender: TObject);
Begin
    VirtualImage1.ImageIndex := 1;
End;

Procedure TNewTaskForm.VirtualImage1MouseLeave(Sender: TObject);
Begin
    VirtualImage1.ImageIndex := 0;
End;

Procedure TNewTaskForm.VirtualImage2MouseEnter(Sender: TObject);
Begin
    VirtualImage2.ImageIndex := 3;
End;

Procedure TNewTaskForm.VirtualImage2MouseLeave(Sender: TObject);
Begin
    VirtualImage2.ImageIndex := 2;
End;

Procedure TNewTaskForm.VirtualImage3MouseEnter(Sender: TObject);
Begin
    VirtualImage3.ImageIndex := 5;
End;

Procedure TNewTaskForm.VirtualImage3MouseLeave(Sender: TObject);
Begin
    VirtualImage3.ImageIndex := 4;
End;

End.
