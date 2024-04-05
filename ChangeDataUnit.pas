Unit ChangeDataUnit;

Interface

Uses
    Vcl.Forms,
    Vcl.StdCtrls,
    Vcl.ExtCtrls,
    ButtonFrame,
    Vcl.Controls,
    Vcl.Mask,
    System.Classes;

Type
    TChangeDataForm = Class(TForm)
        SubTitleLEdit: TLabeledEdit;
        SubTaskLabel: TLabel;
        SubTitleLenLabel: TLabel;
        ApplyButtonFrame: TFrame1;
        Procedure FormCreate(Sender: TObject);
        Procedure SubTitleLEditChange(Sender: TObject);
        Procedure ApplyButtonFrameClick(Sender: TObject);
    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Var
    ChangeDataForm: TChangeDataForm;
    Changes: Boolean = False;

Implementation

{$R *.dfm}

Uses
    ViewControllerUnit,
    NewTaskUnit,
    UserUnit,
    ColorsUnit;

{ подтверждение изменений }
Procedure TChangeDataForm.ApplyButtonFrameClick(Sender: TObject);
Begin
    Changes := True;
    ChangeDataForm.Close;
End;

{ стартовые настройки формы }
Procedure TChangeDataForm.FormCreate(Sender: TObject);
Begin
    { настройка цветов }
    ChangeDataForm.Color := ClFont;
    SubTaskLabel.Font.Color := ClText;
    SubTitleLenLabel.Font.Color := ClText;
    SubTitleLEdit.Font.Color := ClText;
    { "зануление" надписи у TLabeledEdit }
    SubTitleLEdit.EditLabel.Caption := '';
End;

{ контроль ввода }
Procedure TChangeDataForm.SubTitleLEditChange(Sender: TObject);
Begin
    NewTaskForm.ChangeEditShortText(SubTitleLenLabel, SubTitleLEdit.Text, SubTitleLEdit.MaxLength, SubTitleLEdit.Left, SubTitleLEdit.Top,
        SubTitleLEdit.Width);
End;

End.
