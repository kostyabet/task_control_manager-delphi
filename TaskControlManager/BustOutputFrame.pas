Unit BustOutputFrame;

Interface

Uses
    Winapi.Windows,
    Vcl.Forms,
    Vcl.VirtualImage,
    ButtonFrame,
    Vcl.StdCtrls,
    System.Classes,
    Vcl.Controls;

Type
    TBustFrame = Class(TFrame)
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

Uses
    UserUnit,
    TasksListScreenUnit;

{ попытка применения бонуса }
Procedure TBustFrame.BustClick(Sender: TObject);
Var
    TypeOfBust: TUser.TBusts;
    ResultKey: Integer;
    BustCountLabel: TLabel;
Begin
    { получение выбранного объекта }
    TypeOfBust := TaskListForm.UseBustIndex(Sender);
    BustCountLabel := TaskListForm.GetBustLabel(TypeOfBust);
    { проверка на наличие бонуса }
    If (User.BustBought[TypeOfBust] = 0) Then
        Application.Messagebox('У вас нет данного бонуса.'#13#10'Приобретите желаемый бонус в магазине.', 'Ошибка', MB_OK + MB_ICONQUESTION)
    Else
        { отделения особого типа бонусов }
        If (TypeOfBust = TUser.TBusts.Tothem) Then
            Application.Messagebox('Данный бонус применяется автоматически'#13#10'при выполнении просроченой задачи.', 'Подсказка',
                MB_OK + MB_ICONQUESTION)
        Else
        { уточняющий момент }
        Begin
            If TypeOfBust <> TUser.TBusts.SecretBox Then
                ResultKey := Application.Messagebox('Хотите применить данный бонус?', 'Применение бонуса',
                    MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2)
            Else
                ResultKey := ID_YES;
            If (Resultkey = ID_YES) Then
                User.UseBust(TypeOfBust, BustCountLabel);
        End;
End;

{ оброботчик события при попадании мыши на объект }
Procedure TBustFrame.MouseEnter(Sender: TObject);
Begin
    BackgroundVImage.ImageIndex := BackgroundVImage.ImageIndex + 1;
End;

{ оброботчик события при выходе мыши с объект }
Procedure TBustFrame.MouseLeave(Sender: TObject);
Begin
    BackgroundVImage.ImageIndex := BackgroundVImage.ImageIndex - 1;
End;

End.
