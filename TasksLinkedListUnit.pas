Unit TasksLinkedListUnit;

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
    Vcl.ExtCtrls,
    Vcl.Buttons,
    System.ImageList,
    Vcl.ImgList,
    Vcl.StdCtrls,
    Vcl.Imaging.Pngimage,
    Vcl.VirtualImage,
    Vcl.BaseImageCollection,
    Vcl.ImageCollection,
    Vcl.VirtualImageList,
    TaskUnit,
    TaskFrame,
    UserUnit,
    IniFiles;

Type
    TListOfTasks = Class
    Type
        PTasks = ^TaskLinkedList;

        TaskLinkedList = Record
        Var
            Data: TTask;
            Prev: PTasks;
            Next: PTasks;
        End;

    Const
        TasksInfoPath: String = 'tasksinfo';

    Var
        TasksInfoFile: TIniFile;
        FHeadTasks: PTasks;
        FTailTasks: PTasks;
        FTasksCounter: Integer;
    Public
        Function GetComplexityItemValue(CurentTask: PTasks): Integer;
        Property TasksCounter: Integer Read FTasksCounter Write FTasksCounter;
        Function SearchCurentTask(Index: Integer): PTasks;
        Procedure InputInfoInTask(Var ObjectTask: TTaskOutputFrame; Index: Integer);
        Constructor Create;
        Destructor DestroyTaskList;
        Procedure AddTaskInList(Task: TTask);
        Procedure DrawTasks(Canvas: TCanvas; Left, Top, Width, Height: Integer);
        Procedure RemoveCurentTask(Index: Integer);
        Procedure SaveTasksInFile;
        Procedure LoadTasksFromFile;
    End;

Implementation

Uses
    TasksListScreenUnit;

Procedure TListOfTasks.LoadTasksFromFile;
Var
    NewTask: TTask;
    Counter, SubTaskCounter, I, J, Complexity, EndJ, EndI: Integer;
Begin
    TasksInfoFile := TIniFile.Create(ChangeFileExt(ParamStr(0), '.ini'));
    Try
        Try
            Counter := 0;
            EndI := TasksInfoFile.ReadInteger('Tasks', 'TasksCounter', 0);
            For I := 1 To EndI Do
            Begin
                NewTask := TTask.Create;
                Newtask.FTaskData.Title := NewTask.StrToWideCharForTitle(TasksInfoFile.ReadString('Task' + IntToStr(Counter), 'Title', ''));
                Newtask.FTaskData.Date := TasksInfoFile.ReadDate('Task' + IntToStr(Counter), 'Date', Now);
                Newtask.FTaskData.About := NewTask.StrToWideCharForAbout(TasksInfoFile.ReadString('Task' + IntToStr(Counter), 'About',
                    Newtask.FTaskData.About));
                NewTask.FTaskData.Complexity := NewTask.ComplexityDeterminant(TasksInfoFile.ReadInteger('Task' + IntToStr(Counter),
                    'Complexity', 0));
                EndJ := TasksInfoFile.ReadInteger('Task' + IntToStr(Counter), 'SubTasksCounter', 0);
                SubTaskCounter := 0;
                For J := 1 To EndJ Do
                Begin
                    NewTask.InputNewSubTask(TasksInfoFile.ReadString('SubTask' + IntToStr(Counter) + '.' + IntToStr(SubTaskCounter),
                        'Title', ''), TasksInfoFile.ReadBool('SubTask' + IntToStr(Counter) + '.' + IntToStr(SubTaskCounter),
                        'Status', False));
                    Inc(SubTaskCounter);
                End;
                TasksList.AddTaskInList(NewTask);
                TaskListForm.AddNewBlockInBlocksArr;
                Inc(Counter);
            End;
        Except
            TaskListForm.ErrorExit('Ошибка при выгрузке данных в файл.');
        End;
    Finally
        TasksInfoFile.Free;
    End;
End;

Procedure TListOfTasks.SaveTasksInFile;
Var
    CurentTask: PTasks;
    CurentSubTask: TTask.PSubTasks;
    Counter, SubTaskCounter: Integer;
Begin
    CurentTask := FHeadTasks.Next;
    DeleteFile(ChangeFileExt(ParamStr(0), '.ini'));
    TasksInfoFile := TIniFile.Create(ChangeFileExt(ParamStr(0), '.ini'));
    Try
        Try
            Counter := 0;
            TasksInfoFile.EraseSection('');
            TasksInfoFile.EraseSection('');
            TasksInfoFile.EraseSection('');
            TasksInfoFile.WriteInteger('Tasks', 'TasksCounter', FTasksCounter);
            While (CurentTask <> Nil) Do
            Begin
                TasksInfoFile.WriteString('Task' + IntToStr(Counter), 'Title', CurentTask.Data.FTaskData.Title);
                TasksInfoFile.WriteDate('Task' + IntToStr(Counter), 'Date', CurentTask.Data.FTaskData.Date);
                TasksInfoFile.WriteString('Task' + IntToStr(Counter), 'About', CurentTask.Data.FTaskData.About);
                TasksInfoFile.WriteInteger('Task' + IntToStr(Counter), 'Complexity', Ord(CurentTask.Data.FTaskData.Complexity));
                TasksInfoFile.WriteInteger('Task' + IntToStr(Counter), 'SubTasksCounter', Ord(CurentTask.Data.FSubTasksCounter));
                CurentSubTask := CurentTask.Data.FHeadSubTask.Next;
                SubTaskCounter := 0;
                While CurentSubTask <> Nil Do
                Begin
                    TasksInfoFile.WriteString('SubTask' + IntToStr(Counter) + '.' + IntToStr(SubTaskCounter), 'Title', CurentSubTask.Title);
                    TasksInfoFile.WriteBool('SubTask' + IntToStr(Counter) + '.' + IntToStr(SubTaskCounter), 'Status', CurentSubTask.Status);
                    CurentSubTask := CurentSubTask.Next;
                    Inc(SubTaskCounter);
                End;
                CurentTask := CurentTask.Next;
                Inc(Counter);
            End;
        Except
            TaskListForm.ErrorExit('Ошибка при выгрузке данных в файл.');
        End;
    Finally
        TasksInfoFile.Free;
    End;
End;

Procedure TListOfTasks.RemoveCurentTask(Index: Integer);
Var
    CurentTask: PTasks;
Begin
    CurentTask := SearchCurentTask(Index).Next;
    If CurentTask = FHeadTasks.Next Then
    Begin
        If (CurentTask.Next <> Nil) Then
            CurentTask.Next.Prev := FHeadTasks;
        FHeadTasks.Next := CurentTask.Next;
    End;

    If CurentTask = FTailTasks Then
    Begin
        FTailTasks := CurentTask.Prev;
        CurentTask.Prev.Next := Nil;
    End
    Else
    Begin
        CurentTask.Next.Prev := CurentTask.Prev;
        CurentTask.Prev.Next := CurentTask.Next;
    End;

    Dec(FTasksCounter);
    Dispose(CurentTask);
    CurentTask := Nil;
End;

Constructor TListOfTasks.Create;
Begin
    New(FHeadTasks);
    FHeadTasks.Prev := Nil;
    FHeadTasks.Next := Nil;
    FHeadTasks.Data := Nil;
    FTailTasks := FHeadTasks;
    FTasksCounter := 0;
End;

Function TListOfTasks.SearchCurentTask(Index: Integer): PTasks;
Var
    ResultTask: PTasks;
    I: Integer;
Begin
    ResultTask := FHeadTasks;
    For I := 0 To Index Do
        ResultTask := ResultTask.Next;
    SearchCurentTask := ResultTask;
End;

Function TListOfTasks.GetComplexityItemValue(CurentTask: PTasks): Integer;
Var
    ComplexityValue: Integer;
Begin
    Case CurentTask.Data.GetComplexity(CurentTask.Data) Of
        Easy:
            ComplexityValue := 4;
        Medium:
            ComplexityValue := 5;
    Else
        ComplexityValue := 6;
    End;
    GetComplexityItemValue := ComplexityValue;
End;

Procedure TListOfTasks.InputInfoInTask(Var ObjectTask: TTaskOutputFrame; Index: Integer);
Var
    CurentTask: PTasks;
Begin
    CurentTask := SearchCurentTask(Index);
    ObjectTask.ComplexityVImage.ImageIndex := GetComplexityItemValue(CurentTask);
    ObjectTask.TaskLabel.Caption := CurentTask.Data.GetTitle(CurentTask.Data);
    ObjectTask.DeadLineLabel.Caption := 'Сделать до: ' + DateToStr(CurentTask.Data.GetDate(CurentTask.Data));
    ObjectTask.AboutLabel.Caption := CurentTask.Data.GetAbout(CurentTask.Data);
    ObjectTask.SubTasksResLabel.Caption := CurentTask.Data.GetSubTasksInfo(CurentTask.Data);

    ObjectTask.XPLabel.Caption := IntToStr(User.GetTaskXP(CurentTask.Data));
    ObjectTask.HpLabel.Caption := IntToStr(User.GetTaskHP(CurentTask.Data));
    ObjectTask.MoneyLabel.Caption := IntToStr(User.GetTaskMoney(CurentTask.Data));

    ObjectTask.Left := 10;
    ObjectTask.Top := 8 + Index * (8 + ObjectTask.Height);
End;

Procedure TListOfTasks.DrawTasks(Canvas: TCanvas; Left, Top, Width, Height: Integer);
Var
    BufHeadTasks: PTasks;
    Radius, Counter: Integer;
    NewRect: TRect;
    I: Integer;
Begin
    BufHeadTasks := FHeadTasks.Next;
    Counter := 0;
    NewRect := Rect(Left, Top, Width - Left, Top + Height);
    Canvas.Brush.Color := Rgb(130, 138, 157);
    Canvas.Pen.Color := Rgb(130, 138, 157);
    Radius := 5;
    Canvas.Brush.Style := BsSolid;
    Canvas.Pen.Width := 0;
    For I := 1 To FTasksCounter Do
    Begin
        Canvas.RoundRect(NewRect.Left, NewRect.Top + Counter * (Height + NewRect.Top), NewRect.Right,
            NewRect.Bottom + Counter * (Height + NewRect.Top), Radius, Radius);
        Inc(Counter);
        BufHeadTasks := BufHeadTasks.Next;
    End;
End;

Procedure TListOfTasks.AddTaskInList(Task: TTask);
Var
    NewTask: PTasks;
Begin
    New(NewTask);
    NewTask.Data := Task;
    NewTask.Next := Nil;
    NewTask.Prev := FTailTasks;
    FTailTasks.Next := NewTask;
    FTailTasks := NewTask;
    Inc(FTasksCounter);
End;

Destructor TListOfTasks.DestroyTaskList;
Begin
    FTailTasks := FHeadTasks;
    While (FHeadTasks <> Nil) Do
    Begin
        FTailTasks := FTailTasks.Next;
        Dispose(FHeadTasks);
        FHeadTasks := FTailTasks;
    End;
End;

End.
