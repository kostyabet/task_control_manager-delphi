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
    UserUnit;

Type
    TArrayOfTasks = Array Of TTask;

    TListOfTasks = Class
    Type
        PTasks = ^TaskLinkedList;

        TaskLinkedList = Record
        Var
            Data: TTask;
            Prev: PTasks;
            Next: PTasks;
        End;

    Var
        FHeadTasks: PTasks;
        FTailTasks: PTasks;
        FTasksCounter: Integer;
    Public
        Function GetComplexityItemValue(CurentTask: PTasks): Integer;
        Property TasksCounter: Integer Read FTasksCounter Write FTasksCounter;
        Function SearchCurentTask(Index: Integer): PTasks;
        Procedure InputInfoInTask(Var ObjectTask: TTaskOutputFrame; Index: Integer);
        Constructor Create;
        Destructor Destroy;
        Procedure AddTaskInList(Task: TTask);
        Procedure DrawTasks(Canvas: TCanvas; Left, Top, Width, Height: Integer);
        Function ConvertToArray: TArrayOfTasks;
        Procedure CreateNewObject();
    End;

Implementation

Uses
    TasksListScreenUnit;

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
    Complexity: TComplexity;
Begin
    CurentTask := SearchCurentTask(Index);
    ObjectTask.ComplexityVImage.ImageIndex := GetComplexityItemValue(CurentTask);
    ObjectTask.TaskLabel.Caption := CurentTask.Data.GetTitle(CurentTask.Data);
    ObjectTask.DeadLineLabel.Caption := 'Сделать до: ' + DateToStr(CurentTask.Data.GetDate(CurentTask.Data));
    ObjectTask.AboutLabel.Caption := CurentTask.Data.GetAbout(CurentTask.Data);
    ObjectTask.SubTasksResLabel.Caption := CurentTask.Data.GetSubTasksInfo(CurentTask.Data);
    
    Complexity := CurentTask.Data.GetComplexity(CurentTask.Data);
    ObjectTask.XPLabel.Caption := IntToStr(User.GetTaskXP(Complexity));
    ObjectTask.HpLabel.Caption := IntToStr(User.GetTaskHP(Complexity));
    ObjectTask.MoneyLabel.Caption := IntToStr(User.GetTaskMoney(Complexity));

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

Procedure TListOfTasks.CreateNewObject();
Begin
    /// //////
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

Destructor TListOfTasks.Destroy;
Begin
    Dispose(FHeadTasks);
    FHeadTasks := Nil;
    Dispose(FTailTasks);
    FTailTasks := Nil;
End;

Function TListOfTasks.ConvertToArray: TArrayOfTasks;
Var
    ArrayOfTasks: TArrayOfTasks;
    BufHeadTasks: PTasks;
    Counter: Integer;
Begin
    Counter := 0;
    SetLength(ArrayOfTasks, FTasksCounter);
    BufHeadTasks := FHeadTasks;
    While BufHeadTasks = Nil Do
    Begin
        ArrayOfTasks[Counter] := BufHeadTasks.Data;
        BufHeadTasks := BufHeadTasks.Next;
    End;
    ConvertToArray := ArrayOfTasks;
End;

End.
