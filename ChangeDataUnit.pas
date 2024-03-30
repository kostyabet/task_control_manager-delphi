Unit ChangeDataUnit;

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
    Vcl.StdCtrls,
    Vcl.Mask,
    Vcl.ExtCtrls,
    ButtonFrame;

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
    ViewControllerUnit;

Procedure TChangeDataForm.ApplyButtonFrameClick(Sender: TObject);
Begin
    Changes := True;
    ChangeDataForm.Close;
End;

Procedure TChangeDataForm.FormCreate(Sender: TObject);
Begin
    ChangeDataForm.Color := Rgb(202, 205, 221);
    SubTaskLabel.Font.Color := Rgb(38, 43, 50);
    SubTitleLenLabel.Font.Color := Rgb(38, 43, 50);
    SubTitleLEdit.Font.Color := Rgb(38, 43, 50);

    SubTitleLEdit.EditLabel.Caption := '';
End;

Procedure TChangeDataForm.SubTitleLEditChange(Sender: TObject);
Begin
    ChangeEditShortText(SubTitleLenLabel, SubTitleLEdit);
End;

End.
