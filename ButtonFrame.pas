Unit ButtonFrame;

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
    Vcl.VirtualImage,
    Vcl.BaseImageCollection,
    Vcl.ImageCollection,
    Vcl.StdCtrls;

Type
    TFrame1 = Class(TFrame)
        ImageCollection1: TImageCollection;
        VirtualImage1: TVirtualImage;
        Label1: TLabel;
        Procedure VirtualImage1MouseLeave(Sender: TObject);
        Procedure VirtualImage1MouseEnter(Sender: TObject);
        Procedure Label1MouseEnter(Sender: TObject);
        Procedure Label1MouseLeave(Sender: TObject);
    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Implementation

{$R *.dfm}

Procedure TFrame1.Label1MouseEnter(Sender: TObject);
Begin
    VirtualImage1.ImageIndex := 1;
End;

Procedure TFrame1.Label1MouseLeave(Sender: TObject);
Begin
    VirtualImage1.ImageIndex := 0;
End;

Procedure TFrame1.VirtualImage1MouseEnter(Sender: TObject);
Begin
    VirtualImage1.ImageIndex := 1;
End;

Procedure TFrame1.VirtualImage1MouseLeave(Sender: TObject);
Begin
    VirtualImage1.ImageIndex := 0;
End;

End.
