Unit TasksListScreenUnit;

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
    ButtonFrame,
    TasksLinkedListUnit,
    TaskFrame,
    TaskUnit,
    UserUnit,
    BustOutputFrame;

Type
    TTaskListForm = Class(TForm)
        PaintBox2: TPaintBox;
        TasksListPaintBox: TPaintBox;
        MenuBackGround: TPaintBox;
        Image1: TImage;
        Image2: TImage;
        CoinsLabel: TLabel;
        Label2: TLabel;
        LvlLabel: TLabel;
        Label4: TLabel;
        XPLabel: TLabel;
        HPLabel: TLabel;
        XPBox: TPaintBox;
        HPPBox: TPaintBox;
        StoreButtonFrame: TFrame1;
        ProfileFrame: TFrame1;
        SettingsFrame: TFrame1;
        InstractionFrame: TFrame1;
        AddTaskFrame: TFrame1;
        TasksListSclBox: TScrollBox;
        ImageCollection: TImageCollection;
        HPFrame: TBustFrame;
    CoinsFrame: TBustFrame;
        XPFrame: TBustFrame;
        TotemFrame: TBustFrame;
        HPBustFrame: TBustFrame;
        FreeTaskFrame: TBustFrame;
        XPBustFrame: TBustFrame;
        SecretBoxFrame: TBustFrame;
        Procedure FormCreate(Sender: TObject);
        Procedure PaintBox2Paint(Sender: TObject);
        Procedure TasksListPaintBoxPaint(Sender: TObject);
        Procedure MenuBackGroundPaint(Sender: TObject);
        Procedure HPPBoxPaint(Sender: TObject);
        Procedure XPBoxPaint(Sender: TObject);
        Procedure StoreButtonFrameClick(Sender: TObject);
        Procedure Frame13Label1Click(Sender: TObject);
        Procedure Frame13VirtualImage1Click(Sender: TObject);
        Procedure Frame15VirtualImage1Click(Sender: TObject);
        Procedure Frame14Label1Click(Sender: TObject);
        Procedure Frame14VirtualImage1Click(Sender: TObject);
        Procedure Frame12VirtualImage1Click(Sender: TObject);
        Procedure Frame12Label1Click(Sender: TObject);
        Procedure AddNewBlockInBlocksArr;
        Procedure TasksListSclBoxMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
            Var Handled: Boolean);
        Procedure UpDateUserInfo();
    Private
        { Private declarations }
    Public
        Procedure RemoveCompleteTask(Index: Integer);
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
    ProfileUnit;

Procedure TTaskListForm.RemoveCompleteTask(Index: Integer);
Var
    TempArr: TArrayOfBlocks;
    I: Integer;
Begin
    SetLength(TempArr, Length(FArrayOfBlocks) - 1);
    For I := Low(FArrayOfBlocks) To High(FArrayOfBlocks) Do
        If (I <> Index) Then
        Begin
            TempArr[I - Ord(I > Index)] := FArrayOfBlocks[I];
            TempArr[I - Ord(I > Index)].Top := 8 + (I - Ord(I > Index)) * (8 + TempArr[I - Ord(I > Index)].Height);
        End
        Else
            FArrayOfBlocks[I].Destroy;

    FArrayOfBlocks := Copy(TempArr);
End;

Procedure TTaskListForm.UpDateUserInfo();
Begin
    XPBoxPaint(TaskListForm.XPBox);
    XPBox.Hint := IntToStr(User.XP) + '/' + IntToStr(User.MaxXP);
    HPPBoxPaint(TaskListForm.HPPBox);
    HPPBox.Hint := IntToStr(User.HP) + '/' + IntToStr(User.MaxHP);
    LvlLabel.Caption := IntToStr(User.CurentLvl);
    CoinsLabel.Caption := IntToStr(User.Coins);
End;

Procedure TTaskListForm.AddNewBlockInBlocksArr;
Var
    TempArrOfBlocks: TArrayOfBlocks;
    I, Position: Integer;
Begin
    Position := TasksListSclBox.VertScrollBar.Position;
    TasksListSclBox.VertScrollBar.Position := 0;
    SetLength(TempArrOfBlocks, TasksList.FTasksCounter);
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

Procedure TTaskListForm.FormCreate(Sender: TObject);
Begin
    TasksList := TListOfTasks.Create;
    User := TUser.Create;
    UpDateUserInfo;
    TaskListForm.Color := RGB(202, 205, 221);
End;

Procedure TTaskListForm.StoreButtonFrameClick(Sender: TObject);
Begin
    Application.CreateForm(TStoreForm, StoreForm);
    StoreForm.ShowModal;
End;

Procedure TTaskListForm.Frame12Label1Click(Sender: TObject);
Begin
    ProfileForm.ShowModal;
End;

Procedure TTaskListForm.Frame12VirtualImage1Click(Sender: TObject);
Begin
    ProfileForm.ShowModal;
End;

Procedure TTaskListForm.Frame13Label1Click(Sender: TObject);
Begin
    Form1.ShowModal;
End;

Procedure TTaskListForm.Frame13VirtualImage1Click(Sender: TObject);
Begin
    Form1.ShowModal;
End;

Procedure TTaskListForm.Frame14Label1Click(Sender: TObject);
Begin
    InstractionForm.ShowModal;
End;

Procedure TTaskListForm.Frame14VirtualImage1Click(Sender: TObject);
Begin
    InstractionForm.ShowModal;
End;

Procedure TTaskListForm.Frame15VirtualImage1Click(Sender: TObject);
Var
    Complexity: TComplexity;
Begin
    NewTask := TTask.Create;
    Application.CreateForm(TNewTaskForm, NewTaskForm);
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

Procedure TTaskListForm.XPBoxPaint(Sender: TObject);
Var
    BitMap: TBitmap;
    Rect: TRect;
    Radius: Integer;
Begin
    BitMap := TBitmap.Create();
    BitMap.Height := XPBox.Height;
    BitMap.Width := XPBox.Width;

    XPBox.Canvas.Brush.Color := RGB(179, 186, 200);
    XPBox.Canvas.Pen.Color := RGB(179, 186, 200);
    XPBox.Canvas.Pen.Width := 2;
    Radius := 10;
    Rect := XPBox.ClientRect;
    XPBox.Canvas.RoundRect(Rect.Left, Rect.Top, Rect.Right, Rect.Bottom, Radius, Radius);

    XPBox.Canvas.Brush.Color := RGB(26, 155, 85);
    XPBox.Canvas.Pen.Color := RGB(26, 155, 85);
    XPBox.Canvas.Pen.Width := 2;
    Radius := 10;
    Rect := XPBox.ClientRect;
    XPBox.Canvas.RoundRect(Rect.Left, Rect.Top, Rect.Right * User.GetXpPersent Div 100, Rect.Bottom, Radius, Radius);

    BitMap.Free();
End;

Procedure TTaskListForm.PaintBox2Paint(Sender: TObject);
Var
    BitMap: TBitmap;
    Rect: TRect;
    Radius: Integer;
Begin
    BitMap := TBitmap.Create();
    Rect := PaintBox2.ClientRect;
    BitMap.Height := PaintBox2.Height;
    BitMap.Width := PaintBox2.Width;
    Radius := 10;
    PaintBox2.Canvas.Brush.Color := RGB(179, 186, 200);
    PaintBox2.Canvas.Pen.Color := RGB(179, 186, 200);
    PaintBox2.Canvas.Pen.Width := 2;
    PaintBox2.Canvas.RoundRect(Rect.Left, Rect.Top, Rect.Right, Rect.Bottom, Radius, Radius);
    BitMap.Free();
End;

Procedure TTaskListForm.MenuBackGroundPaint(Sender: TObject);
Var
    BitMap: TBitmap;
    Rect: TRect;
    Radius: Integer;
Begin
    BitMap := TBitmap.Create();
    BitMap.Height := MenuBackGround.Height;
    BitMap.Width := MenuBackGround.Width;

    MenuBackGround.Canvas.Brush.Color := RGB(179, 186, 200);
    MenuBackGround.Canvas.Pen.Color := RGB(179, 186, 200);
    MenuBackGround.Canvas.Pen.Width := 2;
    Radius := 5;
    Rect := MenuBackGround.ClientRect;
    MenuBackGround.Canvas.RoundRect(Rect.Left - 100, Rect.Top, Rect.Right, Rect.Bottom, Radius, Radius);
    BitMap.Free();
End;

Procedure TTaskListForm.TasksListPaintBoxPaint(Sender: TObject);
Var
    BitMap: TBitmap;
    Rect: TRect;
    Radius: Integer;
Begin
    If (TasksList.FTasksCounter > 6) Then
        TasksListPaintBox.Height := 8 + TasksList.FTasksCounter * (8 + FArrayOfBlocks[High(FArrayOfBlocks)].Height);

    BitMap := TBitmap.Create();
    Rect := TasksListPaintBox.ClientRect;
    BitMap.Height := TasksListPaintBox.Height;
    BitMap.Width := TasksListPaintBox.Width;
    Radius := 30;
    TasksListPaintBox.Canvas.Brush.Color := Rgb(130, 138, 157);
    TasksListPaintBox.Canvas.Pen.Color := Rgb(179, 186, 200);
    TasksListPaintBox.Canvas.Pen.Width := 10;
    TasksListPaintBox.Canvas.RoundRect(Rect.Left, Rect.Top, Rect.Right, Rect.Bottom, Radius, Radius);
    BitMap.Free();
End;

Procedure TTaskListForm.TasksListSclBoxMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
    Var Handled: Boolean);
Const
    ScrollSpeed = 10;
Var
    Delta: Integer;
Begin
    Delta := WheelDelta Div 60 * ScrollSpeed;
    TasksListSclBox.VertScrollBar.Position := TasksListSclBox.VertScrollBar.Position - Delta;
    Handled := True;
End;

Procedure TTaskListForm.HPPBoxPaint(Sender: TObject);
Var
    BitMap: TBitmap;
    Rect: TRect;
    Radius: Integer;
Begin
    BitMap := TBitmap.Create();
    BitMap.Height := HPPBox.Height;
    BitMap.Width := HPPBox.Width;

    HPPBox.Canvas.Brush.Color := RGB(179, 186, 200);
    HPPBox.Canvas.Pen.Color := RGB(179, 186, 200);
    HPPBox.Canvas.Pen.Width := 2;
    Radius := 10;
    Rect := HPPBox.ClientRect;
    HPPBox.Canvas.RoundRect(Rect.Left, Rect.Top, Rect.Right, Rect.Bottom, Radius, Radius);

    HPPBox.Canvas.Brush.Color := RGB(186, 55, 71);
    HPPBox.Canvas.Pen.Color := RGB(186, 55, 71);
    HPPBox.Canvas.RoundRect(Rect.Left, Rect.Top, Rect.Right * User.GetHpPersent Div 100, Rect.Bottom, Radius, Radius);

    BitMap.Free();
End;

End.
