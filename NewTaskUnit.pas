Unit NewTaskUnit;

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
    ButtonFrame,
    TaskUnit;

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
        { Private declarations }
    Public
        { Public declarations }
    End;

Var
    NewTaskForm: TNewTaskForm;
    NewTask: TTask;

Implementation

{$R *.dfm}

Uses
    ViewControllerUnit,
    TasksListScreenUnit,
    ViewSubTasksUnit;

Procedure TNewTaskForm.AboutTaskMemoChange(Sender: TObject);
Begin
    ChangeEditShortText(AboutTaskLenLabel, AboutTaskMemo);
    ApplyFrame.ButtonText.Enabled := CheckData(TitleLEdit.Text, AboutTaskMemo.Text);
    ApplyFrame.BackGroundVirtmage.Enabled := CheckData(TitleLEdit.Text, AboutTaskMemo.Text);
    ApplyFrame.Enabled := CheckData(TitleLEdit.Text, AboutTaskMemo.Text);
End;

Procedure TNewTaskForm.FormCreate(Sender: TObject);
Begin
    DateTPicker.Date := Now;
    SubTitleLEditChange(SubTitleLEdit);

    DateTPicker.Color := Rgb(202, 205, 221);
    TitleLEdit.Color := Rgb(202, 205, 221);
    SubTitleLEdit.Color := Rgb(202, 205, 221);
    NewTaskForm.Color := Rgb(202, 205, 221);
    ComplexityCBox.Color := RGB(202, 205, 221);
    AboutTaskMemo.Color := Rgb(202, 205, 221);

    TitleLEdit.EditLabel.Caption := '';
    SubTitleLEdit.EditLabel.Caption := '';

    DateTPicker.Font.Color := Rgb(38, 43, 50);
    TitleLEdit.Font.Color := RGB(38, 43, 50);
    SubTitleLEdit.Font.Color := RGB(38, 43, 50);
    ComplexityCBox.Font.Color := RGB(38, 43, 50);
    ComplexityLabel.Font.Color := RGB(38, 43, 50);
    HeadlineLabel.Font.Color := RGB(38, 43, 50);
    TitleLabel.Font.Color := RGB(38, 43, 50);
    TitleLenLabel.Font.Color := RGB(38, 43, 50);
    DateLabel.Font.Color := RGB(38, 43, 50);
    DateMarkLabel.Font.Color := RGB(38, 43, 50);
    AboutTaskLabel.Font.Color := RGB(38, 43, 50);
    AboutTaskLenLabel.Font.Color := RGB(38, 43, 50);
    SubTaskLabel.Font.Color := RGB(38, 43, 50);
    SubTitleLenLabel.Font.Color := RGB(38, 43, 50);
    AboutTaskMemo.Font.Color := RGB(38, 43, 50);

    ChangeEditShortText(TitleLenLabel, TitleLEdit);
    ChangeEditShortText(SubTitleLenLabel, SubTitleLEdit);
    ChangeEditShortText(AboutTaskLenLabel, AboutTaskMemo);
End;

Procedure TNewTaskForm.AddSubTaskFrameClick(Sender: TObject);
Begin
    NewTask.InputNewSubTask(SubTitleLEdit.Text);
    SubTitleLEdit.Text := '';
End;

Procedure TNewTaskForm.SubTasksListFrameClick(Sender: TObject);
Begin
    Application.CreateForm(TSubTasksForm, SubTasksForm);
    SubTasksForm.ShowModal;
End;

Procedure TNewTaskForm.ApplyFrameClick(Sender: TObject);
Begin
    ChoosenOpenButton := Info;
    NewTaskForm.Close;
End;

Procedure TNewTaskForm.SubTitleLEditChange(Sender: TObject);
Begin
    ChangeEditShortText(SubTitleLenLabel, SubTitleLEdit);
    AddSubTaskFrame.ButtonText.Enabled := Not(Trim(SubTitleLEdit.Text) = '');
    AddSubTaskFrame.BackGroundVirtmage.Enabled := Not(Trim(SubTitleLEdit.Text) = '');
    AddSubTaskFrame.Enabled := Not(Trim(SubTitleLEdit.Text) = '');
End;

Procedure TNewTaskForm.TitleLEditChange(Sender: TObject);
Begin
    ChangeEditShortText(TitleLenLabel, TitleLEdit);
    ApplyFrame.ButtonText.Enabled := CheckData(TitleLEdit.Text, AboutTaskMemo.Text);
    ApplyFrame.BackGroundVirtmage.Enabled := CheckData(TitleLEdit.Text, AboutTaskMemo.Text);
    ApplyFrame.Enabled := CheckData(TitleLEdit.Text, AboutTaskMemo.Text);
End;

Procedure TNewTaskForm.BackgroundPBoxPaint(Sender: TObject);
Var
    BitMap: TBitmap;
    Rect: TRect;
    Radius: Integer;
Begin
    BitMap := TBitmap.Create();
    Rect := BackgroundPBox.ClientRect;
    BitMap.Height := BackgroundPBox.Height;
    BitMap.Width := BackgroundPBox.Width;
    Radius := 30;
    BackgroundPBox.Canvas.Brush.Color := Rgb(169, 174, 187);
    BackgroundPBox.Canvas.Pen.Color := Rgb(179, 188, 206);
    BackgroundPBox.Canvas.Pen.Width := 10;
    BackgroundPBox.Canvas.RoundRect(Rect.Left, Rect.Top, Rect.Right, Rect.Bottom, Radius, Radius);
    BitMap.Free();
End;

End.
