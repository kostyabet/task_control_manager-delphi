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
        TasksList.InputInfoInTask(FArrayOfBlocks[Index], Index);
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
    ResultKey := Application.Messagebox('Вы уверенны, что хотите завершить задачу?', 'Сохранение',
        MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2);
    If (ResultKey = ID_YES) Then
    Begin
        Position := TaskListForm.TasksListSclBox.VertScrollBar.Position;
        TaskListForm.TasksListSclBox.VertScrollBar.Position := 0;
        Index := GetCurentObjectIndex(Sender);
        CurentTask := TasksList.SearchCurentTask(Index);
        IsFreeTaskExist := User.FreeTaskUsed;
        User.ApplyNewTask(User.GetTaskXP(CurentTask.Data), User.GetTaskHP(CurentTask.Data), User.GetTaskMoney(CurentTask.Data));
        TaskListForm.UpDateUserInfo;
        TasksList.RemoveCurentTask(Index - 1);
        TaskListForm.RemoveCompleteTask(Index);
        If IsFreeTaskExist And Not User.FreeTaskUsed Then
            TaskListForm.FreeTaskVImage.Visible := False;
        TaskListForm.ShowHPBustVImage.Visible := False;
        TaskListForm.ShowXPBustVImage.Visible := False;
        TaskListForm.ShowCoinsBustVImage.Visible := False;
        If User.IsTotemUsed Then
            User.UseBust(TUser.TBusts.Tothem, TaskListForm.TotemFrame.CountLabel);
        User.IsTotemUsed := False;
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
    TasksList.InputInfoInTask(FArrayOfBlocks[Index], Index);
End;

End.
