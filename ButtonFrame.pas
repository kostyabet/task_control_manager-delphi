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
        ImageCollection: TImageCollection;
        BackGroundVirtmage: TVirtualImage;
        ButtonText: TLabel;
        Procedure MouseLeave(Sender: TObject);
        Procedure MouseEnter(Sender: TObject);
    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Implementation

{$R *.dfm}

Procedure TFrame1.MouseLeave(Sender: TObject);
Begin
    BackGroundVirtmage.ImageIndex := 0;
End;

Procedure TFrame1.MouseEnter(Sender: TObject);
Begin
    BackGroundVirtmage.ImageIndex := 1;
End;

End.
