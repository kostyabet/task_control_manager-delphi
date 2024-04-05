Unit NewTaskUnit;

Interface

Uses
    Winapi.Windows,
    System.SysUtils,
    Vcl.Forms,
    Vcl.ExtCtrls,
    Vcl.StdCtrls,
    Vcl.ComCtrls,
    ButtonFrame,
    TaskUnit,
    Vcl.Controls,
    Vcl.Mask,
    System.Classes;

Type
    TNewTaskForm = Class(TForm)
        HeadlineLabel: TLabel;
        BackgroundPBox: TPaintBox;
        TitleLEdit: TLabeledEdit;
        TitleLabel: TLabel;
        TitleLenLabel: TLabel;
        DateLabel: TLabel;
        DateTPicker: TDateTimePicker;
        DateMarkLabel: TLabel;
        AboutTaskLabel: TLabel;
        AboutTaskMemo: TMemo;
        AboutTaskLenLabel: TLabel;
        SubTaskLabel: TLabel;
        SubTitleLEdit: TLabeledEdit;
        SubTitleLenLabel: TLabel;
        ComplexityLabel: TLabel;
        ComplexityCBox: TComboBox;
        AddSubTaskFrame: TFrame1;
        SubTasksListFrame: TFrame1;
        ApplyFrame: TFrame1;
        Procedure FormCreate(Sender: TObject);
        Procedure BackgroundPBoxPaint(Sender: TObject);
        Procedure SubTitleLEditChange(Sender: TObject);
        Procedure TitleLEditChange(Sender: TObject);
        Procedure AboutTaskMemoChange(Sender: TObject);
        Procedure AddSubTaskFrameClick(Sender: TObject);
        Procedure SubTasksListFrameClick(Sender: TObject);
        Procedure ApplyFrameClick(Sender: TObject);
    Private
        Function CheckData(TitleLEditText: String): Boolean;
    Public
        Procedure ChangeEditShortText(Var Title: TLabel; Text: String; MaxLength, Left, Top, Width: Integer);
    End;

Var
    NewTaskForm: TNewTaskForm;
    NewTask: TTask;

Implementation

{$R *.dfm}

Uses
    ViewControllerUnit,
    TasksListScreenUnit,
    ViewSubTasksUnit,
    ColorsUnit;

{ вывод пользователю информации по вводу }
Procedure TNewTaskForm.ChangeEditShortText(Var Title: TLabel; Text: String; MaxLength, Left, Top, Width: Integer);
Begin
    Title.Caption := IntToStr(Length(Text)) + '/' + IntToStr(MaxLength);
    Title.Left := Width + Left - Title.Width;
    Title.Top := Top - Title.Height - 1;
    If (Length(Text) = MaxLength) Then
        Title.Font.Color := ClMyRed
    Else
        Title.Font.Color := ClText;
End;

{ проверка на ввод }
Function TNewTaskForm.CheckData(TitleLEditText: String): Boolean;
Begin
    CheckData := (Trim(TitleLEditText) <> '');
End;

{ контроль ввода о задаче }
Procedure TNewTaskForm.AboutTaskMemoChange(Sender: TObject);
Begin
    ChangeEditShortText(AboutTaskLenLabel, AboutTaskMemo.Text, AboutTaskMemo.MaxLength, AboutTaskMemo.Left, AboutTaskMemo.Top,
        AboutTaskMemo.Width);
End;

{ инифиализация данных }
Procedure TNewTaskForm.FormCreate(Sender: TObject);
Begin
    { выставление стандартной настройки deadline-а }
    DateTPicker.Date := Now;
    { изменение фонового цвета полей ввода }
    DateTPicker.Color := ClFont;
    TitleLEdit.Color := ClFont;
    SubTitleLEdit.Color := ClFont;
    NewTaskForm.Color := ClFont;
    ComplexityCBox.Color := ClFont;
    AboutTaskMemo.Color := ClFont;
    { очищение надписи над TLabeledEdit }
    TitleLEdit.EditLabel.Caption := '';
    SubTitleLEdit.EditLabel.Caption := '';
    { изменение фона текста }
    DateTPicker.Font.Color := ClText;
    TitleLEdit.Font.Color := ClText;
    SubTitleLEdit.Font.Color := ClText;
    ComplexityCBox.Font.Color := ClText;
    ComplexityLabel.Font.Color := ClText;
    HeadlineLabel.Font.Color := ClText;
    TitleLabel.Font.Color := ClText;
    TitleLenLabel.Font.Color := ClText;
    DateLabel.Font.Color := ClText;
    DateMarkLabel.Font.Color := ClText;
    AboutTaskLabel.Font.Color := ClText;
    AboutTaskLenLabel.Font.Color := ClText;
    SubTaskLabel.Font.Color := ClText;
    SubTitleLenLabel.Font.Color := ClText;
    AboutTaskMemo.Font.Color := ClText;
    { контроль изменений в полях ввода }
    ChangeEditShortText(TitleLenLabel, TitleLEdit.Text, TitleLEdit.MaxLength, TitleLEdit.Left, TitleLEdit.Top, TitleLEdit.Width);
    ChangeEditShortText(SubTitleLenLabel, SubTitleLEdit.Text, SubTitleLEdit.MaxLength, SubTitleLEdit.Left, SubTitleLEdit.Top,
        SubTitleLEdit.Width);
    ChangeEditShortText(AboutTaskLenLabel, AboutTaskMemo.Text, AboutTaskMemo.MaxLength, AboutTaskMemo.Left, AboutTaskMemo.Top,
        AboutTaskMemo.Width);
    SubTitleLEditChange(SubTitleLEdit);
End;

{ добавление подзадачи }
Procedure TNewTaskForm.AddSubTaskFrameClick(Sender: TObject);
Begin
    If (Newtask.SubTasksCounter = SubTasksLimit) Then
        TaskListForm.ErrorExit('Вы достигли лимита по подзадачам: ' + IntToStr(SubTasksLimit), 'Ошибка')
    Else
    Begin
        NewTask.InputNewSubTask(SubTitleLEdit.Text, False);
        SubTitleLEdit.Text := '';
    End;
End;

{ просмотр подзадач }
Procedure TNewTaskForm.SubTasksListFrameClick(Sender: TObject);
Begin
    Application.CreateForm(TSubTasksForm, SubTasksForm);
    SubTasksForm.ShowModal;
End;

{ добавление новой задачи и выход }
Procedure TNewTaskForm.ApplyFrameClick(Sender: TObject);
Begin
    ChoosenOpenButton := Info;
    NewTaskForm.Close;
End;

{ контроль ввода подзадачи }
Procedure TNewTaskForm.SubTitleLEditChange(Sender: TObject);
Begin
    ChangeEditShortText(SubTitleLenLabel, SubTitleLEdit.Text, SubTitleLEdit.MaxLength, SubTitleLEdit.Left, SubTitleLEdit.Top,
        SubTitleLEdit.Width);
    AddSubTaskFrame.ButtonText.Enabled := Not(Trim(SubTitleLEdit.Text) = '');
    AddSubTaskFrame.BackGroundVirtmage.Enabled := Not(Trim(SubTitleLEdit.Text) = '');
    AddSubTaskFrame.Enabled := Not(Trim(SubTitleLEdit.Text) = '');
End;

{ контроль ввода заголовка задачи }
Procedure TNewTaskForm.TitleLEditChange(Sender: TObject);
Begin
    ChangeEditShortText(TitleLenLabel, TitleLEdit.Text, TitleLEdit.MaxLength, TitleLEdit.Left, TitleLEdit.Top, TitleLEdit.Width);
    ApplyFrame.ButtonText.Enabled := CheckData(TitleLEdit.Text);
    ApplyFrame.BackGroundVirtmage.Enabled := CheckData(TitleLEdit.Text);
    ApplyFrame.Enabled := CheckData(TitleLEdit.Text);
End;

{ отрисовка фона }
Procedure TNewTaskForm.BackgroundPBoxPaint(Sender: TObject);
Const
    Radius: Integer = 30;
    PenWidth: Integer = 10;
Var
    Rect: TRect;
Begin
    Rect := BackgroundPBox.ClientRect;
    BackgroundPBox.Canvas.Brush.Color := ClBackgroundBrush;
    BackgroundPBox.Canvas.Pen.Color := ClBackgroundPen;
    BackgroundPBox.Canvas.Pen.Width := PenWidth;
    BackgroundPBox.Canvas.RoundRect(Rect.Left, Rect.Top, Rect.Right, Rect.Bottom, Radius, Radius)
End;

End.
