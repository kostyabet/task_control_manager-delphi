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
    TaskUnit;

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

Procedure TTaskOutputFrame.DblClick(Sender: TObject);
Var
    Complexity: TComplexity;
    Index: Integer;
Begin
    Index := GetCurentObjectIndex(Sender);
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
    XP, HP, Money, Index: Integer;
Begin
    ResultKey := Application.Messagebox('Вы уверенны, что хотите завершить задачу?', 'Сохранение',
        MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2);
    If (ResultKey = ID_YES) Then
    Begin
        User.ApplyNewTask(StrToInt(XPLabel.Caption), StrToInt(HPLabel.Caption), StrToInt(MoneyLabel.Caption));
        TaskListForm.UpDateUserInfo;
        Index := GetCurentObjectIndex(Sender);
        TasksList.RemoveCurentTask(Index - 1);
        TaskListForm.RemoveCompleteTask(Index);
    End;
End;

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
