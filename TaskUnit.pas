Unit TaskUnit;

Interface

Uses
    System.Math,
    Winapi.Windows,
    System.SysUtils,
    System.Classes,
    Vcl.Graphics,
    Vcl.Forms,
    Vcl.ExtCtrls,
    Vcl.StdCtrls,
    ButtonFrame;

Const
    TitleLen = 20;
    AboutLen = 200;
    SubTasksLimit: Integer = 15;

Type
    TButtonTypes = (Apply, Change, Return, Remove);
    TButtonsTypeArr = Array Of Array Of TButtonTypes;
    TSubTaskLabels = Array Of TLabel;
    TFramesArray = Array Of Array Of TFrame1;
    TNumbersArray = Array Of TLabel;
    TComplexity = (Easy, Medium, Hard);
    TTitleString = Array [1 .. TitleLen] Of WideChar;
    TAboutString = Array [1 .. AboutLen] Of WideChar;

    TTask = Class
    Type
        PSubTasks = ^TSubTasks;

        TSubTasks = Record
            Title: TTitleString;
            Status: Boolean;
            Next: PSubTasks;
        End;

        TTaskData = Record
            Title: TTitleString;
            Date: TDate;
            About: TAboutString;
            SubTasks: PSubTasks;
            Complexity: TComplexity;
        End;

    Const
        NULL_POINT: Char = #0;

    Var
        FFramesArray: TFramesArray;
        FButtonsTypeArr: TButtonsTypeArr;
        FSubTaskLabels: TSubTaskLabels;
        FNumbersArray: TNumbersArray;
        FTaskData: TTaskData;
        FHeadSubTask: PSubTasks;
        FTailSubTask: PSubTasks;
        FSubTasksCounter: Integer;
    Private
        Function SearchClickedObject(ButtonType: Integer; Sender: TObject): Integer;
        Procedure InputSubTaskNumber(Index, Counter, Left, Top, Height: Integer);
        Procedure InputSubTaskTitle(Title: String; Status: Boolean; Index, Left, Top, Height: Integer);
        Procedure InputSubTaskButtons(Status: Boolean; Counter: Integer; Index, Left, Top: Integer);
        Function SearchSubTask(Index: Integer): PSubTasks;
        Procedure ChangeButtons(Status: Boolean; Index: Integer);
    Public
        Function StrToWideCharForAbout(SourceString: String): TAboutString;
        Function StrToWideCharForTitle(SourceString: String): TTitleString;
        Function WideCharToStr(SourceWideChar: TTitleString): String; Overload;
        Function WideCharToStr(SourceWideChar: TAboutString): String; Overload;
        Function GetSubTasksInfo(Task: TTask): String;
        Function GetAbout(Task: TTask): String;
        Function GetDate(Task: TTask): TDate;
        Function GetComplexity(Task: TTask): TComplexity;
        Function GetTitle(Task: TTask): String;
        Procedure ChangeSubTaskData(Title: String; Index: Integer);
        Procedure RemoveSubTask(Index: Integer);
        Procedure ChangeRemoveOnClick(Sender: TObject);
        Procedure ApplyReturnOnClick(Sender: TObject);
        Procedure OutputSubTask(Left, Top, Width, Height: Integer);
        Procedure ClearArray();
        Constructor Create;
        Destructor CustomDestroy;
        Property SubTasksCounter: Integer Read FSubTasksCounter Write FSubTasksCounter;
        Procedure InputMainData(Title: String; Date: TDate; About: String; Complexity: TComplexity);
        Procedure InputNewSubTask(Title: String; Status: Boolean);
        Function ComplexityDeterminant(Index: Integer): TComplexity;
        Procedure DrawSubTasks(Canvas: TCanvas; Var PaintBox: TPaintBox; Left, Top, Width, Height: Integer);
        Procedure EndTask(ChoosenButton: Integer);
        Procedure ReturnTask(ChoosenButton: Integer);
    End;

Implementation

Uses
    ViewSubTasksUnit,
    ChangeDataUnit,
    NewTaskUnit,
    ColorsUnit;

{ перевод из Wide Char в String }
Function TTask.WideCharToStr(SourceWideChar: TAboutString): String;
Var
    ResStr: String;
    I: Integer;
Begin
    ResStr := '';
    For I := Low(SourceWideChar) To High(SourceWideChar) Do
    Begin
        If SourceWideChar[I] <> NULL_POINT Then
            ResStr := ResStr + String(SourceWideChar[I]);
    End;

    WideCharToStr := ResStr;
End;

{ перевод из String в Wide Char }
Function TTask.WideCharToStr(SourceWideChar: TTitleString): String;
Var
    ResStr: String;
    I: Integer;
Begin
    ResStr := '';
    For I := Low(SourceWideChar) To High(SourceWideChar) Do
    Begin
        If SourceWideChar[I] <> NULL_POINT Then
            ResStr := ResStr + String(SourceWideChar[I]);
    End;

    WideCharToStr := ResStr;
End;

{ перевод из Wide Char в String для Title }
Function TTask.StrToWideCharForTitle(SourceString: String): TTitleString;
Var
    DestArray: TTitleString;
    NumCharsToCopy, I: Integer;
Begin
    NumCharsToCopy := Min(Length(SourceString), SizeOf(DestArray) Div SizeOf(WideChar) - 1);

    For I := 1 To NumCharsToCopy Do
        DestArray[I] := WideChar(SourceString[I]);
    For I := NumCharsToCopy + 1 To High(DestArray) Do
        DestArray[I] := WideChar(NULL_POINT);

    StrToWideCharForTitle := DestArray;
End;

{ перевод из Wide Char в String для About }
Function TTask.StrToWideCharForAbout(SourceString: String): TAboutString;
Var
    DestArray: TAboutString;
    NumCharsToCopy, I: Integer;
Begin
    NumCharsToCopy := Min(Length(SourceString), SizeOf(DestArray) Div SizeOf(WideChar) - 1);

    For I := 1 To NumCharsToCopy Do
        DestArray[I] := WideChar(SourceString[I]);
    For I := NumCharsToCopy + 1 To High(DestArray) Do
        DestArray[I] := WideChar(NULL_POINT);

    StrToWideCharForAbout := DestArray;
End;

{ получение информации о подзадаче }
Function TTask.GetSubTasksInfo(Task: TTask): String;
Var
    I, CompleteCounter: Integer;
    BufferHead: PSubTasks;
Begin
    CompleteCounter := 0;
    BufferHead := FHeadSubTask.Next;
    For I := 1 To FSubTasksCounter Do
    Begin
        CompleteCounter := CompleteCounter + Ord((BufferHead.Status));
        BufferHead := BufferHead.Next;
    End;
    { выполнено / всего }
    GetSubTasksInfo := IntToStr(CompleteCounter) + '/' + IntToStr(FSubTasksCounter);
End;

{ получение краткой информации о задаче }
Function TTask.GetAbout(Task: TTask): String;
Const
    DefaultLen: Integer = 15;
Var
    ResStr: String;
Begin
    ResStr := Task.FTaskData.About;

    If Length(ResStr) > DefaultLen Then
        ResStr := Copy(ResStr, 0, DefaultLen) + '...';
    GetAbout := ResStr;
End;

{ получение даты задачи }
Function TTask.GetDate(Task: TTask): TDate;
Begin
    GetDate := Task.FTaskData.Date;
End;

{ получение названия задачи }
Function TTask.GetTitle(Task: TTask): String;
Begin
    GetTitle := Task.FTaskData.Title;
End;

{ получение сложности задачи }
Function TTask.GetComplexity(Task: TTask): TComplexity;
Begin
    GetComplexity := Task.FTaskData.Complexity;
End;

{ инициализация }
Constructor TTask.Create;
Var
    CurrentDate: TDate;
Begin
    CurrentDate := Date;
    FTaskData.Title := StrToWideCharForTitle('');
    FTaskData.Date := CurrentDate;
    FTaskData.About := StrToWideCharForAbout('');
    FTaskData.SubTasks := Nil;
    FTaskData.Complexity := Easy;
    New(FHeadSubTask);
    FHeadSubTask.Title := StrToWideCharForTitle('Create New Task');
    FHeadSubTask.Next := Nil;
    FTailSubTask := FHeadSubTask;
    FSubTasksCounter := 0;
End;

{ поиск объекта }
Function TTask.SearchClickedObject(ButtonType: Integer; Sender: TObject): Integer;
Var
    I: Integer;
Begin
    SearchClickedObject := -1;
    For I := Low(FFramesArray) To High(FFramesArray) Do
    Begin
        If (Sender = FFramesArray[I][ButtonType].ButtonText) Or (Sender = FFramesArray[I][ButtonType].BackGroundVirtmage) Then
            SearchClickedObject := I;
    End;
End;

{ очистка массивов }
Procedure TTask.ClearArray();
Var
    I: Integer;
Begin
    For I := Low(FFramesArray) To High(FFramesArray) Do
    Begin
        FFramesArray[I][0].Destroy;
        FFramesArray[I][0] := Nil;
        FFramesArray[I][1].Destroy;
        FFramesArray[I][1] := Nil;
    End;

    For I := Low(FSubTaskLabels) To High(FSubTaskLabels) Do
    Begin
        FSubTaskLabels[I].Destroy;
        FSubTaskLabels[I] := Nil;
    End;

    For I := Low(FNumbersArray) To High(FNumbersArray) Do
    Begin
        FNumbersArray[I].Destroy;
        FNumbersArray[I] := Nil;
    End;
End;

{ нажатие кнопки удалить / изменить }
Procedure TTask.ChangeRemoveOnClick(Sender: TObject);
Var
    ResultKey: Integer;
    ChoosenButton: Integer;
Begin
    ChoosenButton := SearchClickedObject(1, Sender);
    Case FButtonsTypeArr[ChoosenButton][1] Of
        Remove:
            Begin
                ResultKey := Application.Messagebox('Вы уверенны, что хотите удалить?', 'Сохранение',
                    MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2);
                If (ResultKey = ID_YES) Then
                Begin
                    RemoveSubTask(ChoosenButton + 1);
                    ClearArray();
                    OutputSubTask(LeftMargin, TopMargin, WidthLen, HeightLen);
                    SubTasksForm.SubTasksPBoxPaint(SubTasksForm.SubTasksPBox);
                End;
            End;
        Change:
            Begin
                Application.CreateForm(TChangeDataForm, ChangeDataForm);
                ChangeDataForm.SubTitleLEdit.Text := FSubTaskLabels[ChoosenButton].Caption;
                ChangeDataForm.ShowModal;
                If Changes Then
                    ChangeSubTaskData(ChangeDataForm.SubTitleLEdit.Text, ChoosenButton);
            End;
    End;
End;

{ изменение подзадачи }
Procedure TTask.ChangeSubTaskData(Title: String; Index: Integer);
Var
    BufSubTask: PSubTasks;
Begin
    BufSubTask := SearchSubTask(Index);
    FSubTaskLabels[Index].Caption := Title;
    BufSubTask.Title := StrToWideCharForTitle(Title);
End;

{ нажатие кнопки вернуть / закрыть }
Procedure TTask.ApplyReturnOnClick(Sender: TObject);
Var
    ChoosenButton: Integer;
Begin
    ChoosenButton := SearchClickedObject(0, Sender);
    Case FButtonsTypeArr[ChoosenButton][0] Of
        Return:
            ReturnTask(ChoosenButton);
        Apply:
            EndTask(ChoosenButton);
    End;
End;

{ ввод основной информации }
Procedure TTask.InputMainData(Title: String; Date: TDate; About: String; Complexity: TComplexity);
Begin
    FTaskData.Title := StrToWideCharForTitle(Title);
    FTaskData.Date := Date;
    FTaskData.About := StrToWideCharForAbout(About);
    FTaskData.SubTasks := FHeadSubTask;
    FTaskData.Complexity := Complexity;
End;

{ добавление новой подзадачи }
Procedure TTask.InputNewSubTask(Title: String; Status: Boolean);
Var
    NewSubTask: PSubTasks;
Begin
    New(NewSubTask);
    NewSubTask.Title := StrToWideCharForTitle(Title);
    NewSubTask.Status := Status;
    NewSubTask.Next := Nil;
    FTailSubTask.Next := NewSubTask;
    FTailSubTask := NewSubTask;
    Inc(FSubTasksCounter);
End;

{ определитель сложности }
Function TTask.ComplexityDeterminant(Index: Integer): TComplexity;
Var
    ResComplexity: TComplexity;
Begin
    Case Index Of
        Ord(Easy):
            ResComplexity := TComplexity.Easy;
        Ord(Medium):
            ResComplexity := TComplexity.Medium;
    Else
        ResComplexity := TComplexity.Hard;
    End;
    ComplexityDeterminant := ResComplexity;
End;

{ очистка памяти }
Destructor TTask.CustomDestroy;
Begin
    FTailSubTask := FHeadSubTask;
    While FHeadSubTask <> Nil Do
    Begin
        FTailSubTask := FTailSubTask.Next;
        Dispose(FHeadSubTask);
        FHeadSubTask := FTailSubTask;
    End;
    ClearArray;
End;

{ доавление номера подзадачи }
Procedure TTask.InputSubTaskNumber(Index, Counter, Left, Top, Height: Integer);
Const
    MarginLeft: Integer = 10;
    FontSize: Integer = 7;
Var
    Number: TLabel;
Begin
    Number := TLabel.Create(SubTasksForm.SubTasksSclBox);
    Number.Parent := SubTasksForm.SubTasksSclBox;
    Number.Left := Left + MarginLeft;
    Number.Font.Size := FontSize;
    Number.Top := Top + Height Div 2 - Number.Height Div 2;
    Number.Font.Color := ClText;
    Number.Caption := IntToStr(Counter);
    Number.Visible := True;
    FNumbersArray[Index] := Number;
End;

{ название подзадачи }
Procedure TTask.InputSubTaskTitle(Title: String; Status: Boolean; Index, Left, Top, Height: Integer);
Const
    MarginLeft: Integer = 35;
Var
    TitleLabel: TLabel;
Begin
    TitleLabel := TLabel.Create(SubTasksForm.SubTasksSclBox);
    TitleLabel.Parent := SubTasksForm.SubTasksSclBox;
    TitleLabel.Left := Left + MarginLeft;
    TitleLabel.Top := Top + Height Div 2 - TitleLabel.Height Div 2;
    TitleLabel.Font.Style := [FsBold];
    TitleLabel.Font.Color := ClText;
    TitleLabel.Caption := Title;
    TitleLabel.Visible := True;

    FSubTaskLabels[Index] := TitleLabel;
End;

{ изменение наименований кнопок }
Procedure TTask.ChangeButtons(Status: Boolean; Index: Integer);
Begin
    If Not Status Then
    Begin
        FFramesArray[Index][0].ButtonText.Caption := 'ЗАВЕРШИТЬ';
        FButtonsTypeArr[Index][0] := Apply;
        FFramesArray[Index][1].ButtonText.Caption := 'ИЗМЕНИТЬ';
        FButtonsTypeArr[Index][1] := Change;
    End
    Else
    Begin
        FFramesArray[Index][0].ButtonText.Caption := 'ВЕРНУТЬ';
        FButtonsTypeArr[Index][0] := Return;
        FFramesArray[Index][1].ButtonText.Caption := 'УДАЛИТЬ';
        FButtonsTypeArr[Index][1] := Remove;
    End;

    FFramesArray[Index][0].ButtonText.Left := (FFramesArray[Index][0].Width - FFramesArray[Index][0].ButtonText.Width) Div 2;
    FFramesArray[Index][1].ButtonText.Left := (FFramesArray[Index][1].Width - FFramesArray[Index][1].ButtonText.Width) Div 2;
End;

{ вывод кнопок для подзадачи }
Procedure TTask.InputSubTaskButtons(Status: Boolean; Counter: Integer; Index, Left, Top: Integer);
Const
    FirstButton: Integer = 1;
    SecondButton: Integer = 2;
    Width: Integer = 120;
    Heigh: Integer = 23;
    MarginTop: Integer = 24;
Var
    I: Integer;
Begin
    For I := FirstButton To SecondButton Do
    Begin
        FFramesArray[Index][I - 1] := TFrame1.Create(SubTasksForm.SubTasksSclBox);
        FFramesArray[Index][I - 1].Name := 'Frame' + IntToStr(Counter + I);
        FFramesArray[Index][I - 1].Parent := SubTasksForm.SubTasksSclBox;
        FFramesArray[Index][I - 1].Width := Width;
        FFramesArray[Index][I - 1].Height := Heigh;
        FFramesArray[Index][I - 1].Left := Left - FFramesArray[Index][I - 1].Width;
        FFramesArray[Index][I - 1].Top := Top + MarginTop * (I - 1);
        FFramesArray[Index][I - 1].Visible := True;
        FFramesArray[Index][I - 1].ButtonText.Font.Color := ClText;
        FFramesArray[Index][I - 1].BackGroundVirtmage.Proportional := False;
        FFramesArray[Index][I - 1].BackGroundVirtmage.Width := Width;
    End;

    { присваивание обработчиков событий }
    FFramesArray[Index][0].BackGroundVirtmage.OnClick := ApplyReturnOnClick;
    FFramesArray[Index][0].ButtonText.OnClick := ApplyReturnOnClick;
    FFramesArray[Index][1].BackGroundVirtmage.OnClick := ChangeRemoveOnClick;
    FFramesArray[Index][1].ButtonText.OnClick := ChangeRemoveOnClick;

    ChangeButtons(Status, Index);
End;

{ вывод подазадачи }
Procedure TTask.OutputSubTask(Left, Top, Width, Height: Integer);
Const
    ButtonCount: Integer = 2;
    StartMargin: Integer = 2;
Var
    Counter, SubCounter, I, ScrollPos: Integer;
    BufHeadSubTasks: PSubTasks;
Begin
    ScrollPos := SubTasksForm.SubTasksSclBox.VertScrollBar.Position;
    SubTasksForm.SubTasksSclBox.VertScrollBar.Position := 0;
    BufHeadSubTasks := FHeadSubTask.Next;
    SubCounter := 1;
    Counter := 0;
    SetLength(FFramesArray, FSubTasksCounter, ButtonCount);
    SetLength(FButtonsTypeArr, FSubTasksCounter, ButtonCount);
    SetLength(FSubTaskLabels, FSubTasksCounter);
    SetLength(FNumbersArray, FSubTasksCounter);
    For I := 1 To FSubTasksCounter Do
    Begin
        InputSubTaskNumber(Counter, Counter + 1, Left, Top + Counter * (Height + Top), Height);
        InputSubTaskTitle(BufHeadSubTasks.Title, BufHeadSubTasks.Status, Counter, Left, Top + Counter * (Height + Top), Height);
        InputSubTaskButtons(BufHeadSubTasks.Status, SubCounter, Counter, Width - Left, StartMargin + Top + Counter * (Height + Top));

        Inc(SubCounter, ButtonCount);
        Inc(Counter);
        BufHeadSubTasks := BufHeadSubTasks.Next;
    End;
    SubTasksForm.SubTasksSclBox.VertScrollBar.Position := ScrollPos;
End;

{ отприсовка подазадач }
Procedure TTask.DrawSubTasks(Canvas: TCanvas; Var PaintBox: TPaintBox; Left, Top, Width, Height: Integer);
Const
    Radius: Integer = 5;
Var
    BufHeadSubTasks: PSubTasks;
    Counter: Integer;
    NewRect: TRect;
    I: Integer;
Begin
    BufHeadSubTasks := FHeadSubTask.Next;
    Counter := 0;
    NewRect := Rect(Left, Top, Width - Left, Top + Height);
    Canvas.Brush.Color := ClTasksBackGround;
    Canvas.Pen.Color := ClTasksBackGround;
    For I := 1 To FSubTasksCounter Do
    Begin
        Canvas.RoundRect(NewRect.Left, NewRect.Top + Counter * (Height + NewRect.Top), NewRect.Right,
            NewRect.Bottom + Counter * (Height + NewRect.Top), Radius, Radius);
        Inc(Counter);
        BufHeadSubTasks := BufHeadSubTasks.Next;
    End;
End;

{ поиск подзадачи }
Function TTask.SearchSubTask(Index: Integer): PSubTasks;
Var
    ResultSubTask: PSubTasks;
    I: Integer;
Begin
    ResultSubTask := FHeadSubTask.Next;
    For I := 1 To Index Do
        ResultSubTask := ResultSubTask.Next;
    SearchSubTask := ResultSubTask;
End;

{ завершение задачи }
Procedure TTask.EndTask(ChoosenButton: Integer);
Var
    BufSubTasks: PSubTasks;
Begin
    BufSubTasks := SearchSubTask(ChoosenButton);
    BufSubTasks.Status := True;
    ChangeButtons(BufSubTasks.Status, ChoosenButton);
End;

{ возвращение задачи }
Procedure TTask.ReturnTask(ChoosenButton: Integer);
Var
    BufSubTasks: PSubTasks;
Begin
    BufSubTasks := SearchSubTask(ChoosenButton);
    BufSubTasks.Status := False;
    ChangeButtons(BufSubTasks.Status, ChoosenButton);
End;

{ удаление задачи }
Procedure TTask.RemoveSubTask(Index: Integer);
Var
    PrevSubTasks: PSubTasks;
    CurentSubTask: PSubTasks;
Begin
    CurentSubTask := SearchSubTask(Index - 1);
    If (CurentSubTask = FHeadSubTask.Next) Then
        PrevSubTasks := FHeadSubTask
    Else
        PrevSubTasks := SearchSubTask(Index - 2);
    PrevSubTasks.Next := CurentSubTask.Next;
    If (CurentSubTask = FTailSubTask) Then
        FTailSubTask := PrevSubTasks;
    Dispose(CurentSubTask);
    Dec(FSubTasksCounter);
End;

End.
