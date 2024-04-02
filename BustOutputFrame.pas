Unit BustOutputFrame;

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
    ButtonFrame,
    Vcl.StdCtrls;

Type
    TBustFrame = Class(TFrame)
        ImageCollection: TImageCollection;
        BackGroundVImage: TVirtualImage;
        BustVImage: TVirtualImage;
        CountLabel: TLabel;
        Procedure MouseLeave(Sender: TObject);
        Procedure MouseEnter(Sender: TObject);
        Procedure BustClick(Sender: TObject);
    Private
    Public
        { Public declarations }
    End;

Implementation

{$R *.dfm}

uses UserUnit, TasksListScreenUnit;

Procedure TBustFrame.BustClick(Sender: TObject);
Var
    TypeOfBust: TUser.TBusts;
    ResultKey: Integer;
    BustCountLabel: TLabel;
Begin
    TypeOfBust := TaskListForm.UseBustIndex(Sender);
    BustCountLabel := TaskListForm.GetBustLabel(TypeOfBust);
    If (User.BustBought[TypeOfBust] = 0) Then
        Application.Messagebox('У вас нет данного бонуса.'#13#10'Приобретите желаемый бонус в магазине.', 'Ошибка', MB_OK + MB_ICONQUESTION)
    Else if (TypeOfBust = TUser.TBusts.Tothem) then
        Application.Messagebox('Данный бонус применяется автоматически'#13#10'при выполнении просроченой задачи.', 'Подсказка', MB_OK + MB_ICONQUESTION)
    Else
    Begin
        If TypeOfBust <> TUser.TBusts.SecretBox Then
            ResultKey := Application.Messagebox('Хотите применить данный бонус?', 'Применение бонуса', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2)
        else
            ResultKey := ID_YES;
        If (Resultkey = ID_YES) Then
            User.UseBust(TypeOfBust, BustCountLabel);
    End;
End;

Procedure TBustFrame.MouseEnter(Sender: TObject);
Begin
    BackgroundVImage.ImageIndex := 9;
End;

Procedure TBustFrame.MouseLeave(Sender: TObject);
Begin
    BackgroundVImage.ImageIndex := 0;
End;

End.
