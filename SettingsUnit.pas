Unit SettingsUnit;

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
    Vcl.WinXCtrls,
    Vcl.StdCtrls;

Type
    TSettingsForm = Class(TForm)
        BackgroundPBox: TPaintBox;
        ThemeLabel: TLabel;
        ThemeCBox: TComboBox;
    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Var
    SettingsForm: TSettingsForm;

Implementation

{$R *.dfm}

End.
