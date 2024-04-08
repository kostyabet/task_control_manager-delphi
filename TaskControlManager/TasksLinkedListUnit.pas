Unit TasksLinkedListUnit;

Interface

Uses
    Winapi.Windows,
    System.SysUtils,
    System.Classes,
    Vcl.Graphics,
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
        Procedure InputInfoInOutputTask(Var ObjectTask: TTaskOutputFrame; Index: Integer);
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
    TasksListScreenUnit,
    ColorsUnit;

{ загрузка задач из файл }
Procedure TListOfTasks.LoadTasksFromFile;
Var
    NewTask: TTask;
    Counter, SubTaskCounter, I, J, EndJ, EndI: Integer;
Begin
    { создание объекта для считывания }
    TasksInfoFile := TIniFile.Create(ChangeFileExt(ParamStr(0), '.ini'));
    Try
        Try
            { счётчик задач }
            Counter := 0;
            { считываем количество задач }
            EndI := TasksInfoFile.ReadInteger('Tasks', 'TasksCounter', 0);
            For I := 1 To EndI Do
            Begin
                { считываем задачу }
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
                    { добавляем новую подзадачу }
                    NewTask.InputNewSubTask(TasksInfoFile.ReadString('SubTask' + IntToStr(Counter) + '.' + IntToStr(SubTaskCounter),
                        'Title', ''), TasksInfoFile.ReadBool('SubTask' + IntToStr(Counter) + '.' + IntToStr(SubTaskCounter),
                        'Status', False));
                    { увеличиваем счётчик подзадач }
                    Inc(SubTaskCounter);
                End;
                { Добавляем новую задачу }
                TasksList.AddTaskInList(NewTask);
                TaskListForm.OutputNewTaskFromArr;
                { увеличиваем счётчик задач }
                Inc(Counter);
            End;
        Except
            { вызывается при ошибке чтения }
            TaskListForm.ErrorExit('Ошибка при чтении данных из файла.', 'Чтение');
        End;
    Finally
        //освобождаем память которую занимал экземпляр класса работающий с файлом
        TasksInfoFile.Free;
    End;
End;

{ сохранение задач в файл }
Procedure TListOfTasks.SaveTasksInFile;
Var
    CurentTask: PTasks;
    CurentSubTask: TTask.PSubTasks;
    Counter, SubTaskCounter: Integer;
Begin
    { выставление начального значения }
    CurentTask := FHeadTasks.Next;
    { удаление предыдущего файла }
    DeleteFile(ChangeFileExt(ParamStr(0), '.ini'));
    { создаём новый файл копируя путь, где лежит исполняемый файл }
    TasksInfoFile := TIniFile.Create(ChangeFileExt(ParamStr(0), '.ini'));
    Try
        Try
            { счётчик задач }
            Counter := 0;
            { повторная очистка остаточных данных }
            TasksInfoFile.EraseSection('');
            { записывае количество всех задач }
            TasksInfoFile.WriteInteger('Tasks', 'TasksCounter', FTasksCounter);
            While (CurentTask <> Nil) Do
            Begin
                { записываем каждую задачу }
                TasksInfoFile.WriteString('Task' + IntToStr(Counter), 'Title', CurentTask.Data.FTaskData.Title);
                TasksInfoFile.WriteDate('Task' + IntToStr(Counter), 'Date', CurentTask.Data.FTaskData.Date);
                TasksInfoFile.WriteString('Task' + IntToStr(Counter), 'About', CurentTask.Data.FTaskData.About);
                TasksInfoFile.WriteInteger('Task' + IntToStr(Counter), 'Complexity', Ord(CurentTask.Data.FTaskData.Complexity));
                TasksInfoFile.WriteInteger('Task' + IntToStr(Counter), 'SubTasksCounter', Ord(CurentTask.Data.FSubTasksCounter));
                { записываем подзадачи данной задачи }
                CurentSubTask := CurentTask.Data.FHeadSubTask.Next;
                SubTaskCounter := 0; //счётчик подзадач
                While CurentSubTask <> Nil Do
                Begin
                    TasksInfoFile.WriteString('SubTask' + IntToStr(Counter) + '.' + IntToStr(SubTaskCounter), 'Title', CurentSubTask.Title);
                    TasksInfoFile.WriteBool('SubTask' + IntToStr(Counter) + '.' + IntToStr(SubTaskCounter), 'Status', CurentSubTask.Status);
                    { переходим к следующей подзадаче }
                    CurentSubTask := CurentSubTask.Next;
                    { увеличиваем счётчик подзадач }
                    Inc(SubTaskCounter);
                End;
                { переходим к следующей задаче }
                CurentTask := CurentTask.Next;
                { увеличиваем счётчик задач }
                Inc(Counter);
            End;
        Except
            { вызывается при ошибке записи }
            TaskListForm.ErrorExit('Ошибка при записи данных в файл.', 'Запись');
        End;
    Finally
        //освобождаем память которую занимал экземпляр класса работающий с файлом
        TasksInfoFile.Free;
    End;
End;

{ удаление задачи }
Procedure TListOfTasks.RemoveCurentTask(Index: Integer);
Var
    CurentTask: PTasks;
Begin
    { находим удаляемый узел }
    CurentTask := SearchCurentTask(Index).Next;
    { если текущий узел первый информационный }
    If CurentTask = FHeadTasks.Next Then
    Begin
        { если следующий узел не пустой }
        If (CurentTask.Next <> Nil) Then
            //распределяем ссылку следующего на предыдущий
            CurentTask.Next.Prev := FHeadTasks;
        { изменяем у Hed узла указатель на следующий }
        FHeadTasks.Next := CurentTask.Next;
    End;

    { если удаляемый узел хвостовой }
    If CurentTask = FTailTasks Then
    Begin
        { присвоить хвосту предыдущий от текущего элемент }
        FTailTasks := CurentTask.Prev;
        { занулить указатель предыдущего на следующий }
        CurentTask.Prev.Next := Nil;
    End
    { иначе }
    Else
    Begin
        { стандартное перераспределение указателей }
        CurentTask.Next.Prev := CurentTask.Prev;
        CurentTask.Prev.Next := CurentTask.Next;
    End;

    { очищаем память выделенную под узел }
    Dispose(CurentTask);
    { уменшаем счётчик задач на 1 }
    Dec(FTasksCounter);
End;

{ инициализация данных }
Constructor TListOfTasks.Create;
Begin
    New(FHeadTasks);
    FHeadTasks.Prev := Nil;
    FHeadTasks.Next := Nil;
    FHeadTasks.Data := Nil;
    FTailTasks := FHeadTasks;
    FTasksCounter := 0;
End;

{ поиск задачи }
Function TListOfTasks.SearchCurentTask(Index: Integer): PTasks;
Var
    ResultTask: PTasks;
    I: Integer;
Begin
    { начальная задача }
    ResultTask := FHeadTasks;
    { проходимся циклом, чтобы добраться до выбранной задачи }
    For I := 0 To Index Do
        ResultTask := ResultTask.Next; //переходим на следующий узел
    { инициализируем результат }
    SearchCurentTask := ResultTask;
End;

{ получение индекса сложности задачи }
Function TListOfTasks.GetComplexityItemValue(CurentTask: PTasks): Integer;
Const
    EazyIndex: Integer = 9;
    MediumIndex: Integer = 10;
    HardIndex: Integer = 11;
Var
    ComplexityValue: Integer;
Begin
    Case CurentTask.Data.GetComplexity(CurentTask.Data) Of
        Easy:
            ComplexityValue := EazyIndex;
        Medium:
            ComplexityValue := MediumIndex;
    Else
        ComplexityValue := HardIndex;
    End;
    GetComplexityItemValue := ComplexityValue;
End;

{ добавление информации в задачу }
Procedure TListOfTasks.InputInfoInOutputTask(Var ObjectTask: TTaskOutputFrame; Index: Integer);
Const
    MarginLeft: Integer = 10;
    MarginTop: Integer = 8;
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

    ObjectTask.Left := MarginLeft;
    ObjectTask.Top := MarginTop + Index * (MarginTop + ObjectTask.Height);
End;

{ отрисовка задач }
Procedure TListOfTasks.DrawTasks(Canvas: TCanvas; Left, Top, Width, Height: Integer);
Const
    Radius: Integer = 5;
    PenWidth: Integer = 0;
Var
    BufHeadTasks: PTasks;
    Counter: Integer;
    NewRect: TRect;
    I: Integer;
Begin
    BufHeadTasks := FHeadTasks.Next;
    Counter := 0;
    NewRect := Rect(Left, Top, Width - Left, Top + Height);
    Canvas.Brush.Color := ClTasksBackGround;
    Canvas.Pen.Color := ClTasksBackGround;
    Canvas.Pen.Width := PenWidth;
    For I := 1 To FTasksCounter Do
    Begin
        Canvas.RoundRect(NewRect.Left, NewRect.Top + Counter * (Height + NewRect.Top), NewRect.Right,
            NewRect.Bottom + Counter * (Height + NewRect.Top), Radius, Radius);
        Inc(Counter);
        BufHeadTasks := BufHeadTasks.Next;
    End;
End;

{ доабвление задачи }
Procedure TListOfTasks.AddTaskInList(Task: TTask);
Var
    NewTask: PTasks;
Begin
    { выделяем память под новую задачу }
    New(NewTask);
    { заполняем информацие новый узел списка }
    NewTask.Data := Task;
    NewTask.Next := Nil;
    NewTask.Prev := FTailTasks;
    { включение узла в список }
    FTailTasks.Next := NewTask;
    FTailTasks := NewTask;
    { увеличение счётчика задач }
    Inc(FTasksCounter);
End;

{ удаление задачи }
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
