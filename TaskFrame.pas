Unit TaskFrame;

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
    ButtonFrame,
    Vcl.VirtualImage,
    Vcl.BaseImageCollection,
    Vcl.ImageCollection,
    Vcl.StdCtrls;

Type
    TTaskOutputFrame = Class(TFrame)
        ImageCollection: TImageCollection;
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
        Procedure DblClick(Sender: TObject);
        Procedure ApplyButtonClick(Sender: TObject);
    Private
        { Private declarations }
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
    TaskUnit;

Procedure TTaskOutputFrame.DblClick(Sender: TObject);
Var
    Complexity: TComplexity;
    I, Index: Integer;
Begin
    For I := 0 To High(FArrayOfBlocks) Do
        If (Sender = FArrayOfBlocks[I].TaskLabel) Or (Sender = FArrayOfBlocks[I].DeadLineLabel) Or (Sender = FArrayOfBlocks[I].AboutLabel)
            Or (Sender = FArrayOfBlocks[I].ComplexityVImage) Or (Sender = FArrayOfBlocks[I].BackGroundVImage) Then
            Index := I;
    NewTask := TasksList.SearchCurentTask(Index).Data;
    Application.CreateForm(TNewTaskForm, NewTaskForm);
    NewTaskForm.TitleLEdit.Text := NewTask.FTaskData.Title;
    NewTaskForm.DateTPicker.Date := NewTask.FTaskData.Date;
    NewTaskForm.AboutTaskMemo.Text := NewTask.FTaskData.About;
    NewTaskForm.ComplexityCBox.ItemIndex := TasksList.GetComplexityItemValue(TasksList.SearchCurentTask(Index)) - 4;
    NewTaskForm.ShowModal;
    If (ChoosenOpenButton = Info) Then
    Begin
        Complexity := TasksList.SearchCurentTask(Index).Data.ComplexityDeterminant(NewTaskForm.ComplexityCBox.ItemIndex);
        TasksList.SearchCurentTask(Index).Data.InputMainData(NewTaskForm.TitleLEdit.Text, NewTaskForm.DateTPicker.Date,
            NewTaskForm.AboutTaskMemo.Text, Complexity);
        TasksList.InputInfoInTask(FArrayOfBlocks[Index], Index);
        ChoosenOpenButton := Nothing;
    End;
End;

Procedure TTaskOutputFrame.ApplyButtonClick(Sender: TObject);
Var
    ResultKey: Integer;
    XP, HP, Money: Integer;
Begin
    ResultKey := Application.Messagebox('Вы уверенны, что хотите завершить задачу?', 'Сохранение',
        MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2);
    If (ResultKey = ID_YES) Then
    Begin
        XP := StrToInt(XPLabel.Caption);
        HP := StrToInt(HPLabel.Caption);
        Money := StrToInt(MoneyLabel.Caption);
        User.ApplyNewTask(XP, HP, Money);
        TaskListForm.UpDateUserInfo;
        //RemoveCurentTask();
    End;
End;

Procedure TTaskOutputFrame.ChangeSubTasksFrameClick(Sender: TObject);
Var
    I, Index: Integer;
Begin
    For I := 0 To High(FArrayOfBlocks) Do
        If (Sender = FArrayOfBlocks[I].ChangeSubTasksFrame.ButtonText) Or
            (Sender = FArrayOfBlocks[I].ChangeSubTasksFrame.BackGroundVirtmage) Then
            Index := I;
    NewTask := TasksList.SearchCurentTask(Index).Data;
    Application.CreateForm(TSubTasksForm, SubTasksForm);
    SubTasksForm.ShowModal;
    TasksList.InputInfoInTask(FArrayOfBlocks[Index], Index);
End;

End.
