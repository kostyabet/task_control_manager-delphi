Unit ViewControllerUnit;

Interface

Uses
    TaskUnit,
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

Procedure ChangeEditShortText(Var Title: TLabel; LabeledEdit: TLabeledEdit); Overload;
Procedure ChangeEditShortText(Var Title: TLabel; Memo: TMemo); Overload;
Function CheckData(TitleLEditText, AboutTaskMemoText: String): Boolean;

Implementation

Procedure ChangeEditShortText(Var Title: TLabel; LabeledEdit: TLabeledEdit);
Begin
    Title.Caption := IntToStr(Length(LabeledEdit.Text)) + '/' + IntToStr(LabeledEdit.MaxLength);
    Title.Left := LabeledEdit.Width + LabeledEdit.Left - Title.Width;
    Title.Top := LabeledEdit.Top - Title.Height - 1;
    If (Length(LabeledEdit.Text) = LabeledEdit.MaxLength) Then
        Title.Font.Color := RGB(186, 55, 71)
    Else
        Title.Font.Color := RGB(38, 43, 50);
End;

Procedure ChangeEditShortText(Var Title: TLabel; Memo: TMemo);
Begin
    Title.Caption := IntToStr(Length(Memo.Text)) + '/' + IntToStr(Memo.MaxLength);
    Title.Left := Memo.Width + Memo.Left - Title.Width;
    Title.Top := Memo.Top - Title.Height - 1;
    If (Length(Memo.Text) = Memo.MaxLength) Then
        Title.Font.Color := RGB(186, 55, 71)
    Else
        Title.Font.Color := RGB(38, 43, 50);
End;

Function CheckData(TitleLEditText, AboutTaskMemoText: String): Boolean;
begin
    CheckData := (Trim(TitleLEditText) <> '') And (Trim(AboutTaskMemoText) <> '');
end;

End.
