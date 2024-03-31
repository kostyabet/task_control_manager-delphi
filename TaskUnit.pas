Unit TaskUnit;

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
    Vcl.StdCtrls,
    Vcl.Mask,
    Vcl.ComCtrls,
    Vcl.VirtualImage,
    Vcl.BaseImageCollection,
    Vcl.ImageCollection,
    System.ImageList,
    Vcl.ImgList,
    Vcl.VirtualImageList,
    ButtonFrame;

Type
    TButtonTypes = (Apply, Change, Return, Remove);
    TButtonsTypeArr = Array Of Array Of TButtonTypes;
    TSubTaskLabels = Array Of TLabel;
    TFramesArray = Array Of Array Of TFrame1;
    TNumbersArray = Array Of TLabel;
    TComplexity = (Easy, Medium, Hard);

    TTask = Class
    Type
        PSubTasks = ^TSubTasks;

        TSubTasks = Record
            Title: String;
            Status: Boolean;
            Next: PSubTasks;
        End;

        TTaskData = Record
            Title: String;
            Date: TDate;
            About: String;
            SubTasks: PSubTasks;
            Complexity: TComplexity;
            Status: Boolean;
        End;

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
        Function GetSubTasksInfo(Task: TTask): String;
        Function GetAbout(Task: TTask): String;
        Function GetDate(Task: TTask): TDate;
        Function GetComplexity(Task: TTask): TComplexity;
        Function GetTitle(Task: TTask): String;
        Procedure ChangeSubTaskData(Title: String; Index: Integer);
        Procedure RemoveSubTask(Index: Integer);
        Procedure ChangeRemoveOnClick(Sender: TObject);
        Procedure ApplyReturnOnClick(Sender: TObject);
        Procedure OutputText(Left, Top, Width, Height: Integer);
        Procedure ClearArray();
        Constructor Create;
        Destructor Destroy;
        Property SubTasksCounter: Integer Read FSubTasksCounter Write FSubTasksCounter;
        Procedure InputMainData(Title: String; Date: TDate; About: String; Complexity: TComplexity);
        Procedure InputNewSubTask(Title: String);
        Function ComplexityDeterminant(Index: Integer): TComplexity;
        Procedure DrawSubTasks(Canvas: TCanvas; Var PaintBox: TPaintBox; Left, Top, Width, Height: Integer);
        Procedure EndTask(ChoosenButton: Integer);
        Procedure ReturnTask(ChoosenButton: Integer);
    End;

Implementation

Uses
    ViewSubTasksUnit,
    ChangeDataUnit,
    NewTaskUnit;

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
    GetSubTasksInfo := IntToStr(CompleteCounter) + '/' + IntToStr(FSubTasksCounter);
End;

Function TTask.GetAbout(Task: TTask): String;
Var
    ResStr: String;
Begin
    ResStr := Task.FTaskData.About;

    If Length(ResStr) > 15 Then
        ResStr := Copy(ResStr, 0, 15) + '...';
    GetAbout := ResStr;
End;

Function TTask.GetDate(Task: TTask): TDate;
Begin
    GetDate := Task.FTaskData.Date;
End;

Function TTask.GetTitle(Task: TTask): String;
Begin
    GetTitle := Task.FTaskData.Title;
End;

Function TTask.GetComplexity(Task: TTask): TComplexity;
Begin
    GetComplexity := Task.FTaskData.Complexity;
End;

Constructor TTask.Create;
Var
    CurrentDate: TDate;
Begin
    CurrentDate := Date;
    FTaskData.Title := '';
    FTaskData.Date := CurrentDate;
    FTaskData.About := '';
    FTaskData.SubTasks := Nil;
    FTaskData.Complexity := Easy;
    New(FHeadSubTask);
    FHeadSubTask.Title := 'Create New Task';
    FHeadSubTask.Next := Nil;
    FTailSubTask := FHeadSubTask;
    FSubTasksCounter := 0;
End;

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
                    OutputText(LeftBorder, TopBorder, WidthBorder, HeightBorder);
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

Procedure TTask.ChangeSubTaskData(Title: String; Index: Integer);
Var
    BufSubTask: PSubTasks;
Begin
    BufSubTask := SearchSubTask(Index);
    FSubTaskLabels[Index].Caption := Title;
    BufSubTask.Title := Title;
End;

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

Procedure TTask.InputMainData(Title: String; Date: TDate; About: String; Complexity: TComplexity);
Begin
    FTaskData.Title := Title;
    FTaskData.Date := Date;
    FTaskData.About := About;
    FTaskData.SubTasks := FHeadSubTask;
    FTaskData.Complexity := Complexity;
    FTaskData.Status := False;
End;

Procedure TTask.InputNewSubTask(Title: String);
Var
    NewSubTask: PSubTasks;
Begin
    New(NewSubTask);
    NewSubTask.Title := Title;
    NewSubTask.Status := False;
    NewSubTask.Next := Nil;
    FTailSubTask.Next := NewSubTask;
    FTailSubTask := NewSubTask;
    Inc(FSubTasksCounter);
End;

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

Destructor TTask.Destroy;
Var
    I: Integer;
Begin
    Dispose(FHeadSubTask);
    FHeadSubTask := Nil;
    Dispose(FTailSubTask);
    FTailSubTask := Nil;
    ClearArray;
End;

Procedure TTask.InputSubTaskNumber(Index, Counter, Left, Top, Height: Integer);
Var
    Number: TLabel;
Begin
    Number := TLabel.Create(SubTasksForm.SubTasksSclBox);
    Number.Parent := SubTasksForm.SubTasksSclBox;
    Number.Left := Left + 10;
    Number.Font.Size := 7;
    Number.Top := Top + Height Div 2 - Number.Height Div 2;
    Number.Font.Color := RGB(38, 43, 50);
    Number.Caption := IntToStr(Counter);
    Number.Visible := True;
    FNumbersArray[Index] := Number;
End;

Procedure TTask.InputSubTaskTitle(Title: String; Status: Boolean; Index, Left, Top, Height: Integer);
Var
    TitleLabel: TLabel;
Begin
    TitleLabel := TLabel.Create(SubTasksForm.SubTasksSclBox);
    TitleLabel.Parent := SubTasksForm.SubTasksSclBox;
    TitleLabel.Left := Left + 35;
    TitleLabel.Top := Top + Height Div 2 - TitleLabel.Height Div 2;
    TitleLabel.Font.Style := [FsBold];
    TitleLabel.Font.Color := RGB(38, 43, 50);
    TitleLabel.Caption := Title;
    TitleLabel.Visible := True;

    FSubTaskLabels[Index] := TitleLabel;
End;

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

Procedure TTask.InputSubTaskButtons(Status: Boolean; Counter: Integer; Index, Left, Top: Integer);
Begin

    FFramesArray[Index][0] := TFrame1.Create(SubTasksForm.SubTasksSclBox);
    FFramesArray[Index][0].Name := 'Frame' + IntToStr(Counter + 1);
    FFramesArray[Index][0].Parent := SubTasksForm.SubTasksSclBox;
    FFramesArray[Index][0].Width := 120;
    FFramesArray[Index][0].Height := 23;
    FFramesArray[Index][0].Left := Left - FFramesArray[Index][0].Width;
    FFramesArray[Index][0].Top := Top;
    FFramesArray[Index][0].Visible := True;
    FFramesArray[Index][0].ButtonText.Font.Color := Rgb(38, 43, 50);
    FFramesArray[Index][0].BackGroundVirtmage.Proportional := False;
    FFramesArray[Index][0].BackGroundVirtmage.Width := 120;
    FFramesArray[Index][0].BackGroundVirtmage.OnClick := ApplyReturnOnClick;
    FFramesArray[Index][0].ButtonText.OnClick := ApplyReturnOnClick;

    FFramesArray[Index][1] := TFrame1.Create(SubTasksForm.SubTasksSclBox);
    FFramesArray[Index][1].Name := 'Frame' + IntToStr(Counter + 2);
    FFramesArray[Index][1].Parent := SubTasksForm.SubTasksSclBox;
    FFramesArray[Index][1].Width := 120;
    FFramesArray[Index][1].Height := 23;
    FFramesArray[Index][1].Left := Left - FFramesArray[Index][1].Width;
    FFramesArray[Index][1].Top := Top + 24;
    FFramesArray[Index][1].Visible := True;
    FFramesArray[Index][1].ButtonText.Font.Color := Rgb(38, 43, 50);
    FFramesArray[Index][1].BackGroundVirtmage.Proportional := False;
    FFramesArray[Index][1].BackGroundVirtmage.Width := 120;
    FFramesArray[Index][1].BackGroundVirtmage.OnClick := ChangeRemoveOnClick;
    FFramesArray[Index][1].ButtonText.OnClick := ChangeRemoveOnClick;

    ChangeButtons(Status, Index);
End;

Procedure TTask.OutputText(Left, Top, Width, Height: Integer);
Var
    Counter, SubCounter, I, ScrollPos: Integer;
    BufHeadSubTasks: PSubTasks;
Begin
    ScrollPos := SubTasksForm.SubTasksSclBox.VertScrollBar.Position;
    SubTasksForm.SubTasksSclBox.VertScrollBar.Position := 0;
    BufHeadSubTasks := FHeadSubTask.Next;
    SubCounter := 1;
    Counter := 0;
    SetLength(FFramesArray, FSubTasksCounter, 2);
    SetLength(FButtonsTypeArr, FSubTasksCounter, 2);
    SetLength(FSubTaskLabels, FSubTasksCounter);
    SetLength(FNumbersArray, FSubTasksCounter);
    For I := 1 To FSubTasksCounter Do
    Begin
        InputSubTaskNumber(Counter, Counter + 1, Left, Top + Counter * (Height + Top), Height);
        InputSubTaskTitle(BufHeadSubTasks.Title, BufHeadSubTasks.Status, Counter, Left, Top + Counter * (Height + Top), Height);
        InputSubTaskButtons(BufHeadSubTasks.Status, SubCounter, Counter, Width - Left, 2 + Top + Counter * (Height + Top));

        Inc(SubCounter, 2);
        Inc(Counter);
        BufHeadSubTasks := BufHeadSubTasks.Next;
    End;
    SubTasksForm.SubTasksSclBox.VertScrollBar.Position := ScrollPos;
End;

Procedure TTask.DrawSubTasks(Canvas: TCanvas; Var PaintBox: TPaintBox; Left, Top, Width, Height: Integer);
Var
    BufHeadSubTasks: PSubTasks;
    Radius, Counter: Integer;
    NewRect: TRect;
    I: Integer;
Begin
    BufHeadSubTasks := FHeadSubTask.Next;
    Counter := 0;
    NewRect := Rect(Left, Top, Width - Left, Top + Height);
    Canvas.Brush.Color := Rgb(130, 138, 157);
    Canvas.Pen.Color := Rgb(130, 138, 157);
    Radius := 5;
    Canvas.Brush.Style := BsSolid;
    Canvas.Pen.Width := 0;
    For I := 1 To FSubTasksCounter Do
    Begin
        Canvas.RoundRect(NewRect.Left, NewRect.Top + Counter * (Height + NewRect.Top), NewRect.Right,
            NewRect.Bottom + Counter * (Height + NewRect.Top), Radius, Radius);
        Inc(Counter);
        BufHeadSubTasks := BufHeadSubTasks.Next;
    End;
End;

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

Procedure TTask.EndTask(ChoosenButton: Integer);
Var
    BufSubTasks: PSubTasks;
Begin
    BufSubTasks := SearchSubTask(ChoosenButton);
    BufSubTasks.Status := True;
    ChangeButtons(BufSubTasks.Status, ChoosenButton);
End;

Procedure TTask.ReturnTask(ChoosenButton: Integer);
Var
    BufSubTasks: PSubTasks;
Begin
    BufSubTasks := SearchSubTask(ChoosenButton);
    BufSubTasks.Status := False;
    ChangeButtons(BufSubTasks.Status, ChoosenButton);
End;

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
