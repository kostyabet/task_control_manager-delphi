Unit AboutEditorUnit;

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
    Vcl.VirtualImage;

Type
    TAboutEditorForm = Class(TForm)
        IcoVImage: TVirtualImage;
        TCMLabel: TLabel;
        AboutCompLabel: TLabel;
        EditorLabel: TLabel;
        GroupLabel: TLabel;
        Procedure FormCreate(Sender: TObject);
    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Var
    AboutEditorForm: TAboutEditorForm;

Implementation

{$R *.dfm}

Uses
    TasksListScreenUnit,
    ColorsUnit;

Procedure TAboutEditorForm.FormCreate(Sender: TObject);
Begin
    AboutEditorForm.Color := ClFont;
End;

End.
