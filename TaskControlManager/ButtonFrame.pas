Unit ButtonFrame;

Interface

Uses
    Vcl.Forms,
    Vcl.VirtualImage,
    Vcl.StdCtrls,
    System.Classes,
    Vcl.Controls;

Type
    TFrame1 = Class(TFrame)
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

Uses
    TasksListScreenUnit;

{ уход курсора с объекта }
Procedure TFrame1.MouseLeave(Sender: TObject);
Begin
    BackGroundVirtmage.ImageIndex := BackGroundVirtmage.ImageIndex - 1;
End;

{ попадание курсора на объект }
Procedure TFrame1.MouseEnter(Sender: TObject);
Begin
    BackGroundVirtmage.ImageIndex := BackGroundVirtmage.ImageIndex + 1;
End;

End.
