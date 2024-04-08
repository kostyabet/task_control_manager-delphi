Unit TaskFrame;

Interface

Uses
    Winapi.Windows,
    Vcl.Forms,
    ButtonFrame,
    Vcl.VirtualImage,
    Vcl.StdCtrls,
    Vcl.Controls,
    System.Classes;

Type
    TTaskOutputFrame = Class(TFrame)
        BackGroundVImage: TVirtualImage;
        ApplyButtonFrame: TFrame1;
        ExpVImage: TVirtualImage;
        XPLabel: TLabel;
        HpLabel: TLabel;
        HpVImage: TVirtualImage;
        MoneyVImage: TVirtualImage;
        MoneyLabel: TLabel;
        ComplexityVImage: TVirtualImage;
        SubTasksLabel: TLabel;
        SubTasksResLabel: TLabel;
        ChangeSubTasksFrame: TFrame1;
        TaskLabel: TLabel;
        DeadLineLabel: TLabel;
        AboutLabel: TLabel;
        Procedure ChangeSubTasksFrameClick(Sender: TObject);
        Procedure CustomDblClick(Sender: TObject);
        Procedure ApplyButtonClick(Sender: TObject);
    Private
        Function GetCurentObjectIndex(Sender: TObject): Integer;
    Public
        { Public declarations }
    End;

Implementation

{$R *.dfm}

Uses
    ViewSubTasksUnit,
    TasksLinkedListUnit,
    TasksListScreenUnit,
    NewTaskUnit,
    TaskUnit,
    UserUnit;

{ поиск нажатой задачи }
Function TTaskOutputFrame.GetCurentObjectIndex(Sender: TObject): Integer;
Var
    I, Index: Integer;
Begin
    Index := -1;
    For I := 0 To High(FArrayOfBlocks) Do
        If (Sender = FArrayOfBlocks[I].ChangeSubTasksFrame.ButtonText) Or
            (Sender = FArrayOfBlocks[I].ChangeSubTasksFrame.BackGroundVirtmage) Or (Sender = FArrayOfBlocks[I].TaskLabel) Or
            (Sender = FArrayOfBlocks[I].DeadLineLabel) Or (Sender = FArrayOfBlocks[I].AboutLabel) Or
            (Sender = FArrayOfBlocks[I].ComplexityVImage) Or (Sender = FArrayOfBlocks[I].BackGroundVImage) Or
            (Sender = FArrayOfBlocks[I].ApplyButtonFrame.ButtonText) Or
            (Sender = FArrayOfBlocks[I].ApplyButtonFrame.BackGroundVirtmage) Then
            Index := I;
    GetCurentObjectIndex := Index;
End;

{ изменение задачи }
Procedure TTaskOutputFrame.CustomDblClick(Sender: TObject);
Var
    Complexity: TComplexity;
    Index, Position: Integer;
Begin
    Index := GetCurentObjectIndex(Sender);
    NewTask := TasksList.SearchCurentTask(Index).Data;
    Application.CreateForm(TNewTaskForm, NewTaskForm);
    NewTaskForm.TitleLEdit.Text := NewTask.FTaskData.Title;
    NewTaskForm.DateTPicker.Date := NewTask.FTaskData.Date;
    NewTaskForm.AboutTaskMemo.Text := NewTask.FTaskData.About;
    NewTaskForm.ComplexityCBox.ItemIndex := TasksList.GetComplexityItemValue(TasksList.SearchCurentTask(Index)) - 9;
    NewTaskForm.ShowModal;
    If (ChoosenOpenButton = Info) Then
    Begin
        Position := TaskListForm.TasksListSclBox.VertScrollBar.Position;
        TaskListForm.TasksListSclBox.VertScrollBar.Position := 0;
        Complexity := TasksList.SearchCurentTask(Index).Data.ComplexityDeterminant(NewTaskForm.ComplexityCBox.ItemIndex);
        TasksList.SearchCurentTask(Index).Data.InputMainData(NewTaskForm.TitleLEdit.Text, NewTaskForm.DateTPicker.Date,
            NewTaskForm.AboutTaskMemo.Text, Complexity);
        TasksList.InputInfoInOutputTask(FArrayOfBlocks[Index], Index);
        ChoosenOpenButton := Nothing;
        TaskListForm.TasksListSclBox.VertScrollBar.Position := Position;
    End;
End;

{ обработка завершения задачи }
Procedure TTaskOutputFrame.ApplyButtonClick(Sender: TObject);
Var
    ResultKey, Index, Position: Integer;
    CurentTask: TListOfTasks.PTasks;
    IsFreeTaskExist: Boolean;
Begin
    { уточнение у пользователя о его намерениях }
    ResultKey := Application.Messagebox('Вы уверенны, что хотите завершить задачу?', 'Сохранение',
        MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2);
    { выполнится в случае, если пользователь не отказывается }
    If (ResultKey = ID_YES) Then
    Begin
        { запоминаем текущую позицию ScrollBox пользователя }
        Position := TaskListForm.TasksListSclBox.VertScrollBar.Position;
        { выставляем ScrollBox.Position в начальное положение }
        TaskListForm.TasksListSclBox.VertScrollBar.Position := 0;
        { получаем индекс выбранной задачи }
        Index := GetCurentObjectIndex(Sender);
        { получаем текущую задачу через полученый ранее индекс }
        CurentTask := TasksList.SearchCurentTask(Index);
        { проверка на существование бонуса FreeTask }
        IsFreeTaskExist := User.FreeTaskUsed;
        { запускаем код отвечающий за выполнение задачи }
        User.ApplyTask(User.GetTaskXP(CurentTask.Data), User.GetTaskHP(CurentTask.Data), User.GetTaskMoney(CurentTask.Data));
        { обнавляем основную информацию пользователя }
        TaskListForm.UpDateUserInfo;
        { удаляем задачу из двунаправленного списка }
        TasksList.RemoveCurentTask(Index - 1);
        { удаляем задачу из массива отображённых пользователю задач }
        TaskListForm.RemoveCompleteTask(Index);
        { проверяем был ли использован бонус FreeTask }
        If IsFreeTaskExist And Not User.FreeTaskUsed Then
            TaskListForm.FreeTaskVImage.Visible := False; //если да, скрываем его
        { скрываем все возможно использованные ticket-бонусы }
        TaskListForm.ShowHPBustVImage.Visible := False;
        TaskListForm.ShowXPBustVImage.Visible := False;
        TaskListForm.ShowCoinsBustVImage.Visible := False;
        { частная проверка на бонус totem }
        If User.IsTotemUsed Then
            User.UseBust(TUser.TBusts.Tothem, TaskListForm.TotemFrame.CountLabel); //если был использован - фиксируем
        User.IsTotemUsed := False; //возвращаем статус totem-а в стандарт
        { возвращаем ScrollBox в пользовательское состояние }
        TaskListForm.TasksListSclBox.VertScrollBar.Position := Position;
    End;
End;

{ обработка нажатия на подзадачи }
Procedure TTaskOutputFrame.ChangeSubTasksFrameClick(Sender: TObject);
Var
    Index: Integer;
Begin
    Index := GetCurentObjectIndex(Sender);
    NewTask := TasksList.SearchCurentTask(Index).Data;
    Application.CreateForm(TSubTasksForm, SubTasksForm);
    SubTasksForm.ShowModal;
    TasksList.InputInfoInOutputTask(FArrayOfBlocks[Index], Index);
End;

End.
