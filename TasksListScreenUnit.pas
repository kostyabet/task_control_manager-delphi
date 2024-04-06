Unit TasksListScreenUnit;

Interface

Uses
    Winapi.Windows,
    System.SysUtils,
    System.Classes,
    Vcl.Forms,
    Vcl.ExtCtrls,
    Vcl.StdCtrls,
    Vcl.VirtualImage,
    Vcl.ImageCollection,
    ButtonFrame,
    TasksLinkedListUnit,
    TaskFrame,
    TaskUnit,
    UserUnit,
    BustOutputFrame,
    Vcl.BaseImageCollection,
    Vcl.Controls;

Type
    TTaskListForm = Class(TForm)
        BinusesPBox: TPaintBox;
        TasksListPaintBox: TPaintBox;
        MenuBackGround: TPaintBox;
        CoinsLabel: TLabel;
        LvlInfoLabel: TLabel;
        LvlLabel: TLabel;
        XPBox: TPaintBox;
        HPPBox: TPaintBox;
        StoreButtonFrame: TFrame1;
        AddTaskFrame: TFrame1;
        InstractionFrame: TFrame1;
        TasksListSclBox: TScrollBox;
        BackgroundImgCollection: TImageCollection;
        HPFrame: TBustFrame;
        CoinsFrame: TBustFrame;
        XPFrame: TBustFrame;
        TotemFrame: TBustFrame;
        HPBustFrame: TBustFrame;
        FreeTaskFrame: TBustFrame;
        XPBustFrame: TBustFrame;
        SecretBoxFrame: TBustFrame;
        XPicoVImage: TVirtualImage;
        HPicoVImage: TVirtualImage;
        ShowHPBustVImage: TVirtualImage;
        ShowXPBustVImage: TVirtualImage;
        ShowCoinsBustVImage: TVirtualImage;
        FreeTaskVImage: TVirtualImage;
        UsedBonusPanel: TPanel;
        CheckTaskTimer: TTimer;
        CoinsVImage: TVirtualImage;
        IconsImgCollection: TImageCollection;
        Procedure FormCreate(Sender: TObject);
        Procedure BonusesPBoxPaint(Sender: TObject);
        Procedure TasksListPaintBoxPaint(Sender: TObject);
        Procedure MenuBackGroundPaint(Sender: TObject);
        Procedure HPPBoxPaint(Sender: TObject);
        Procedure XPBoxPaint(Sender: TObject);
        Procedure StoreButtonFrameClick(Sender: TObject);
        Procedure NewTaskAddClick(Sender: TObject);
        Procedure InstractionInfoClick(Sender: TObject);
        Procedure AddNewBlockInBlocksArr;
        Procedure TasksListSclBoxMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
            Var Handled: Boolean);
        Procedure FormDestroy(Sender: TObject);
        Procedure CheckTaskTime(Sender: TObject);
        Procedure FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
        Function FormHelp(Command: Word; Data: NativeInt; Var CallHelp: Boolean): Boolean;
    Private

    Public
        Procedure UpDateUserInfo;
        Function UseBustIndex(Sender: TObject): TUser.TBusts;
        Procedure ErrorExit(ErrorStr, Caption: String);
        Procedure RemoveCompleteTask(Index: Integer);
        Procedure ChangeBustsCounter(CountLabel: TLabel; TypeOfBust: TUser.TBusts);
        Function GetBustLabel(TypeOfBust: TUser.TBusts): TLabel;
    End;

Type
    TArrayOfBlocks = Array Of TTaskOutputFrame;
    TChoosenOpenButton = (Info, Nothing);

Var
    TaskListForm: TTaskListForm;
    TasksList: TListOfTasks;
    ChoosenOpenButton: TChoosenOpenButton = Nothing;
    FArrayOfBlocks: TArrayOfBlocks;
    User: TUser;

Implementation

{$R *.dfm}

Uses
    NewTaskUnit,
    StoreUnit,
    SettingsUnit,
    InstractionUnit,
    ProfileUnit,
    ColorsUnit,
    LoadingScreenUnit;

{ информация о количестве бонуса }
Procedure TTaskListForm.ChangeBustsCounter(CountLabel: TLabel; TypeOfBust: TUser.TBusts);
Var
    LeftBorder: Integer;
Begin
    LeftBorder := CountLabel.Left + CountLabel.Width;
    CountLabel.Caption := 'x' + IntToStr(User.FBustBought[TypeOfBust]);
    CountLabel.Left := LeftBorder - CountLabel.Width;
End;

{ проверка задачи на время }
Procedure TTaskListForm.CheckTaskTime(Sender: TObject);
Var
    CurentTask: TListOfTasks.PTasks;
    I: Integer;
    CurentDate: TDate;
Begin
    For I := Low(FArrayOfBlocks) To High(FArrayOfBlocks) Do
    Begin
        CurentTask := TasksList.SearchCurentTask(I);
        CurentDate := Date + EncodeTime(0, 0, 0, 0);
        If (CurentTask.Data.FTaskData.Date < CurentDate) Then
        Begin
            FArrayOfBlocks[I].XPLabel.Caption := IntToStr(StrToInt(FArrayOfBlocks[I].XPLabel.Caption));
            FArrayOfBlocks[I].HpLabel.Caption := IntToStr(StrToInt(FArrayOfBlocks[I].HPLabel.Caption));
            FArrayOfBlocks[I].MoneyLabel.Caption := IntToStr(StrToInt(FArrayOfBlocks[I].MoneyLabel.Caption));
        End;
    End;
End;

{ получение label-а }
Function TTaskListForm.GetBustLabel(TypeOfBust: TUser.TBusts): TLabel;
Begin
    Case TypeOfBust Of
        TUser.TBusts.HP:
            GetBustLabel := HPFrame.CountLabel;
        TUser.TBusts.XP:
            GetBustLabel := XPFrame.CountLabel;
        TUser.TBusts.HPBust:
            GetBustLabel := HPBustFrame.CountLabel;
        TUser.TBusts.XPBust:
            GetBustLabel := XPBustFrame.CountLabel;
        TUser.TBusts.CoinsBust:
            GetBustLabel := CoinsFrame.CountLabel;
        TUser.TBusts.Tothem:
            GetBustLabel := TotemFrame.CountLabel;
        TUser.TBusts.FreeTask:
            GetBustLabel := FreeTaskFrame.CountLabel;
    Else
        GetBustLabel := SecretBoxFrame.CountLabel;
    End;
End;

{ удаление выполненой задачи }
Procedure TTaskListForm.RemoveCompleteTask(Index: Integer);
Const
    DefMargin: Integer = 8;
Var
    TempArr: TArrayOfBlocks;
    I: Integer;
Begin
    SetLength(TempArr, Length(FArrayOfBlocks) - 1);
    For I := Low(FArrayOfBlocks) To High(FArrayOfBlocks) Do
        If (I <> Index) Then
        Begin
            FArrayOfBlocks[I].Name := 'Frame' + IntToStr(I - Ord(I > Index));
            TempArr[I - Ord(I > Index)] := FArrayOfBlocks[I];
            TempArr[I - Ord(I > Index)].Top := DefMargin + (I - Ord(I > Index)) * (DefMargin + TempArr[I - Ord(I > Index)].Height);
        End
        Else
            FArrayOfBlocks[I].Destroy;

    FArrayOfBlocks := Copy(TempArr);
End;

{ обновление информации о пользователе }
Procedure TTaskListForm.UpDateUserInfo();
Var
    LeftBorder: Integer;
Begin
    XPBoxPaint(TaskListForm.XPBox);
    XPBox.Hint := 'Опыт: ' + IntToStr(User.XP) + '/' + IntToStr(User.MaxXP);
    HPPBoxPaint(TaskListForm.HPPBox);
    HPPBox.Hint := 'доровье: ' + IntToStr(User.HP) + '/' + IntToStr(User.MaxHP);
    LeftBorder := LvlLabel.Left + LvlLabel.Width;
    LvlLabel.Caption := IntToStr(User.CurentLvl);
    LvlLabel.Left := LeftBorder - LvlLabel.Width;
    CoinsLabel.Caption := IntToStr(User.Coins);
End;

{ добавление нового блока задачи }
Procedure TTaskListForm.AddNewBlockInBlocksArr;
Var
    TempArrOfBlocks: TArrayOfBlocks;
    I, Position: Integer;
Begin
    Position := TasksListSclBox.VertScrollBar.Position;
    TasksListSclBox.VertScrollBar.Position := 0;
    SetLength(TempArrOfBlocks, Length(FArrayOfBlocks) + 1);
    For I := Low(FArrayOfBlocks) To High(FArrayOfBlocks) Do
        TempArrOfBlocks[I] := FArrayOfBlocks[I];
    TempArrOfBlocks[High(TempArrOfBlocks)] := TTaskOutputFrame.Create(TasksListPaintBox);
    TempArrOfBlocks[High(TempArrOfBlocks)].Name := 'Task' + IntToStr(High(TempArrOfBlocks));
    TempArrOfBlocks[High(TempArrOfBlocks)].Parent := TasksListSclBox;
    TasksList.InputInfoInTask(TempArrOfBlocks[High(TempArrOfBlocks)], High(TempArrOfBlocks));
    FArrayOfBlocks := TempArrOfBlocks;
    TasksListPaintBoxPaint(TasksListPaintBox);
    TasksListSclBox.VertScrollBar.Position := Position;
End;

{ исользование бонуса }
Function TTaskListForm.UseBustIndex(Sender: TObject): TUser.TBusts;
Begin
    UseBustIndex := TUser.TBusts.HP;
    If (Sender = HPFrame.BackGroundVImage) Or (Sender = HPFrame.CountLabel) Or (Sender = HPFrame.BustVImage) Then
        UseBustIndex := TUser.TBusts.HP;

    If (Sender = XPFrame.BackGroundVImage) Or (Sender = XPFrame.CountLabel) Or (Sender = XPFrame.BustVImage) Then
        UseBustIndex := TUser.TBusts.XP;

    If (Sender = HPBustFrame.BackGroundVImage) Or (Sender = HPBustFrame.CountLabel) Or (Sender = HPBustFrame.BustVImage) Then
        UseBustIndex := TUser.TBusts.HPBust;

    If (Sender = XPBustFrame.BackGroundVImage) Or (Sender = XPBustFrame.CountLabel) Or (Sender = XPBustFrame.BustVImage) Then
        UseBustIndex := TUser.TBusts.XPBust;

    If (Sender = CoinsFrame.BackGroundVImage) Or (Sender = CoinsFrame.CountLabel) Or (Sender = CoinsFrame.BustVImage) Then
        UseBustIndex := TUser.TBusts.CoinsBust;

    If (Sender = TotemFrame.BackGroundVImage) Or (Sender = TotemFrame.CountLabel) Or (Sender = TotemFrame.BustVImage) Then
        UseBustIndex := TUser.TBusts.Tothem;

    If (Sender = FreeTaskFrame.BackGroundVImage) Or (Sender = FreeTaskFrame.CountLabel) Or (Sender = FreeTaskFrame.BustVImage) Then
        UseBustIndex := TUser.TBusts.FreeTask;

    If (Sender = SecretBoxFrame.BackGroundVImage) Or (Sender = SecretBoxFrame.CountLabel) Or (Sender = SecretBoxFrame.BustVImage) Then
        UseBustIndex := TUser.TBusts.SecretBox;
End;

{ вывод информации об ошибке }
Procedure TTaskListForm.ErrorExit(ErrorStr, Caption: String);
Begin
    Application.Messagebox(PWideChar(ErrorStr), PWideChar(Caption), MB_OK + MB_ICONERROR + MB_DEFBUTTON2);
End;

{ инициализация данных }
Procedure TTaskListForm.FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
Var
    ResultKey: Integer;
Begin
    ResultKey := Application.Messagebox('Вы уверены, что хотите закрыть оконное приложение?', 'Выход',
        MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2);

    CanClose := ResultKey = ID_YES;
End;

Procedure TTaskListForm.FormCreate(Sender: TObject);
Begin
    User := TUser.Create;
    User.LoadUserDataFromFile;
    InitializationColor;
    TasksList := TListOfTasks.Create;
    TasksList.LoadTasksFromFile();
    UpDateUserInfo;
    TaskListForm.UpDateUserInfo;
    TaskListForm.Color := ClFont;
    TotemFrame.BustVImage.Hint :=
        'Тотем. Возвращает все бонусы просроченой задачи в норму.'#13#10'Применяется автоматически при выполнении просроченой задачи.';
    FreeTaskFrame.BustVImage.Hint :=
        'Бесплатная задача. Зануляет все бонусы просроченой задачи в норму.'#13#10'Применяется автоматически при выполнении просроченой задачи.';
    SecretBoxFrame.BustVImage.Hint :=
        'Секретный сундучок. Вы получите рандомный бонус из 8-ми.'#13#10'Шанс скоррестирован относительно цен.';
End;

{ очистка данных при закрытии }
Procedure TTaskListForm.FormDestroy(Sender: TObject);
Begin
    User.SaveUserDataInFile;
    TasksList.SaveTasksInFile;
    User.Destroy;
    TasksList.DestroyTaskList;
End;

Function TTaskListForm.FormHelp(Command: Word; Data: NativeInt; Var CallHelp: Boolean): Boolean;
Begin
    CallHelp := False;
    FormHelp := False;
End;

{ нажатие на кнопку магазина }
Procedure TTaskListForm.StoreButtonFrameClick(Sender: TObject);
Begin
    Application.CreateForm(TStoreForm, StoreForm);
    StoreForm.ShowModal;
End;

Procedure TTaskListForm.InstractionInfoClick(Sender: TObject);
Begin
    Application.CreateForm(TInstractionForm, InstractionForm);
    InstractionForm.ShowModal;
End;

{ доабвление новой задачи }
Procedure TTaskListForm.NewTaskAddClick(Sender: TObject);
Var
    Complexity: TComplexity;
Begin
    NewTask := TTask.Create;
    NewTaskForm.DateTPicker.Date := Now;
    NewTaskForm.ComplexityCBox.ItemIndex := 0;
    NewTaskForm.AboutTaskMemo.Text := '';
    NewTaskForm.TitleLEdit.Text := '';
    NewTaskForm.SubTitleLEdit.Text := '';
    NewTaskForm.ShowModal;
    If (ChoosenOpenButton = Info) Then
    Begin
        Complexity := NewTask.ComplexityDeterminant(NewTaskForm.ComplexityCBox.ItemIndex);
        NewTask.InputMainData(NewTaskForm.TitleLEdit.Text, NewTaskForm.DateTPicker.Date, NewTaskForm.AboutTaskMemo.Text, Complexity);
        TasksList.AddTaskInList(NewTask);
        TaskListForm.AddNewBlockInBlocksArr;
        ChoosenOpenButton := Nothing;
    End;
End;

{ отрисовка опыта }
Procedure TTaskListForm.XPBoxPaint(Sender: TObject);
Const
    Radius: Integer = 10;
    PenWidth: Integer = 1;
Var
    Rect: TRect;
Begin
    XPBox.Canvas.Brush.Color := ClBackgroundPen;
    XPBox.Canvas.Pen.Color := ClBackgroundPen;
    XPBox.Canvas.Pen.Width := PenWidth;
    Rect := XPBox.ClientRect;
    XPBox.Canvas.RoundRect(Rect.Left, Rect.Top, Rect.Right, Rect.Bottom, Radius, Radius);

    XPBox.Canvas.Brush.Color := ClXP;
    XPBox.Canvas.Pen.Color := ClXP;
    Rect := XPBox.ClientRect;
    XPBox.Canvas.RoundRect(Rect.Left, Rect.Top, Rect.Right * User.GetXpPersent Div High(TPercent), Rect.Bottom, Radius, Radius);
End;

{ фон бонусов }
Procedure TTaskListForm.BonusesPBoxPaint(Sender: TObject);
Const
    PEN_WIDTH: Integer = 2;
    RADIUS: Integer = 10;
Var
    Rect: TRect;
Begin
    BinusesPBox.Canvas.Brush.Color := ClBackgroundPen;
    BinusesPBox.Canvas.Pen.Color := ClBackgroundPen;
    BinusesPBox.Canvas.Pen.Width := PEN_WIDTH;
    Rect := BinusesPBox.ClientRect;
    BinusesPBox.Canvas.RoundRect(Rect.Left, Rect.Top, Rect.Right, Rect.Bottom, RADIUS, RADIUS);
End;

{ фон меню }
Procedure TTaskListForm.MenuBackGroundPaint(Sender: TObject);
Var
    Rect: TRect;
Begin
    MenuBackGround.Canvas.Brush.Color := ClBackgroundBrush;
    MenuBackGround.Canvas.Pen.Color := ClBackgroundBrush;
    Rect := MenuBackGround.ClientRect;
    MenuBackGround.Canvas.RoundRect(Rect.Left, Rect.Top, Rect.Right, Rect.Bottom, 0, 0);
End;

{ фон задач }
Procedure TTaskListForm.TasksListPaintBoxPaint(Sender: TObject);
Const
    VISIBLE_TASKS_COUNT: Integer = 6;
    BASIC_MARGIN: Integer = 8;
    RADIUS: Integer = 30;
    PEN_WIDTH: Integer = 10;
Var
    Rect: TRect;
Begin
    If (TasksList.FTasksCounter > VISIBLE_TASKS_COUNT) Then
        TasksListPaintBox.Height := BASIC_MARGIN + TasksList.FTasksCounter * (BASIC_MARGIN + FArrayOfBlocks[High(FArrayOfBlocks)].Height);

    TasksListPaintBox.Canvas.Brush.Color := ClTasksBackGround;
    TasksListPaintBox.Canvas.Pen.Color := ClBackgroundPen;
    TasksListPaintBox.Canvas.Pen.Width := PEN_WIDTH;
    Rect := TasksListPaintBox.ClientRect;
    TasksListPaintBox.Canvas.RoundRect(Rect.Left, Rect.Top, Rect.Right, Rect.Bottom, RADIUS, RADIUS);
End;

{ настройка scroll bar для мыши и touch pad }
Procedure TTaskListForm.TasksListSclBoxMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
    Var Handled: Boolean);
Const
    DegreeOfOffset: Integer = 60;
    ScrollSpeed = 10;
Var
    Delta: Integer;
Begin
    Delta := WheelDelta Div DegreeOfOffset * ScrollSpeed;
    TasksListSclBox.VertScrollBar.Position := TasksListSclBox.VertScrollBar.Position - Delta;
    Handled := True;
End;

{ вывод информации о здоровье }
Procedure TTaskListForm.HPPBoxPaint(Sender: TObject);
Const
    Radius: Integer = 10;
    PenWidth: Integer = 1;
Var
    Rect: TRect;
Begin
    HPPBox.Canvas.Brush.Color := ClBackgroundPen;
    HPPBox.Canvas.Pen.Color := ClBackgroundPen;
    HPPBox.Canvas.Pen.Width := PenWidth;
    Rect := HPPBox.ClientRect;
    HPPBox.Canvas.RoundRect(Rect.Left, Rect.Top, Rect.Right, Rect.Bottom, Radius, Radius);

    HPPBox.Canvas.Brush.Color := ClMyRed;
    HPPBox.Canvas.Pen.Color := ClMyRed;
    Rect := HPPBox.ClientRect;
    HPPBox.Canvas.RoundRect(Rect.Left, Rect.Top, Rect.Right * User.GetHpPersent Div High(TPercent), Rect.Bottom, Radius, Radius);
End;

End.
