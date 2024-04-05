Unit ColorsUnit;

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
    UserUnit;

Const
    ColorsCount = 7;

Type
    TArrOfColor = Array [0 .. ColorsCount - 1] Of TColor;

Var
    ClText: TColor;
    ClMyRed: TColor;
    ClFont: TColor;
    ClBackgroundBrush: Tcolor;
    ClTasksBackGround: TColor;
    ClBackgroundPen: TColor;
    ClXP: TColor;
    White: TArrOfColor;

Procedure InitializationColor();

Implementation

{ присваивание выбранного цвета }
Procedure InitializationColor();
Begin
    ClText := White[0];
    ClMyRed := White[1];
    ClFont := White[2];
    ClBackgroundBrush := White[3];
    ClTasksBackGround := White[4];
    ClBackgroundPen := White[5];
    ClXP := White[6];
End;

Initialization

{ инифицализация цветов }
White[0] := Rgb(38, 43, 50);
White[1] := Rgb(186, 55, 71);
White[2] := Rgb(202, 205, 221);
White[3] := Rgb(169, 174, 187);
White[4] := Rgb(130, 138, 157);
White[5] := Rgb(179, 188, 206);
White[6] := RGB(26, 155, 85);

End.
