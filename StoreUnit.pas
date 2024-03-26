Unit StoreUnit;

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
    Vcl.VirtualImage,
    Vcl.BaseImageCollection,
    Vcl.ImageCollection,
    ButtonFrame, Vcl.Imaging.pngimage;

Type
    TStoreForm = Class(TForm)
        Label1: TLabel;
        PaintBox1: TPaintBox;
        ImageCollection1: TImageCollection;
        VirtualImage1: TVirtualImage;
        VirtualImage2: TVirtualImage;
        VirtualImage3: TVirtualImage;
        VirtualImage4: TVirtualImage;
        VirtualImage5: TVirtualImage;
        VirtualImage6: TVirtualImage;
        VirtualImage7: TVirtualImage;
        VirtualImage8: TVirtualImage;
        VirtualImage17: TVirtualImage;
        VirtualImage18: TVirtualImage;
        VirtualImage19: TVirtualImage;
        VirtualImage20: TVirtualImage;
        VirtualImage21: TVirtualImage;
        VirtualImage22: TVirtualImage;
        VirtualImage23: TVirtualImage;
        VirtualImage24: TVirtualImage;
        Frame11: TFrame1;
        Frame12: TFrame1;
        Frame13: TFrame1;
        Frame14: TFrame1;
        Frame15: TFrame1;
        Frame16: TFrame1;
        Frame17: TFrame1;
        Frame18: TFrame1;
    Label2: TLabel;
    Image2: TImage;
        Procedure FormCreate(Sender: TObject);
        Procedure PaintBox1Paint(Sender: TObject);
        Procedure VirtualImage9MouseEnter(Sender: TObject);
        Procedure VirtualImage9MouseLeave(Sender: TObject);
    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Var
    StoreForm: TStoreForm;

Implementation

{$R *.dfm}

Procedure TStoreForm.FormCreate(Sender: TObject);
Begin
    StoreForm.Color := Rgb(202, 205, 221);
    Label1.Font.Color := RGB(38, 43, 50);
    //Label2.Font.Color := RGB(38, 43, 50);
End;

Procedure TStoreForm.PaintBox1Paint(Sender: TObject);
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

Procedure TStoreForm.VirtualImage9MouseEnter(Sender: TObject);
Begin
    //VirtualImage9.ImageIndex := 1;
End;

Procedure TStoreForm.VirtualImage9MouseLeave(Sender: TObject);
Begin
    //VirtualImage9.ImageIndex := 0;
End;

End.
