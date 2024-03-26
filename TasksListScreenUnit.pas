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
    Vcl.VirtualImageList;

Type
    TTaskListForm = Class(TForm)
        PaintBox2: TPaintBox;
        PaintBox4: TPaintBox;
        MenuBackGround: TPaintBox;
        ImageCollection: TImageCollection;
        AddTask: TVirtualImage;
        Store: TVirtualImage;
        Profile: TVirtualImage;
        Refferencess: TVirtualImage;
        Settings: TVirtualImage;
        Image1: TImage;
        Image2: TImage;
        Label1: TLabel;
        Label2: TLabel;
        Label3: TLabel;
        Label4: TLabel;
        Label5: TLabel;
        Label6: TLabel;
        HPPBox: TPaintBox;
        EXPPBox: TPaintBox;
        PaintBox1: TPaintBox;
        Procedure FormCreate(Sender: TObject);
        Procedure PaintBox2Paint(Sender: TObject);
        Procedure PaintBox4Paint(Sender: TObject);
        Procedure MenuBackGroundPaint(Sender: TObject);
        Procedure AddTaskMouseLeave(Sender: TObject);
        Procedure AddTaskMouseEnter(Sender: TObject);
        Procedure StoreMouseEnter(Sender: TObject);
        Procedure StoreMouseLeave(Sender: TObject);
        Procedure ProfileMouseLeave(Sender: TObject);
        Procedure ProfileMouseEnter(Sender: TObject);
        Procedure RefferencessMouseLeave(Sender: TObject);
        Procedure RefferencessMouseEnter(Sender: TObject);
        Procedure SettingsMouseEnter(Sender: TObject);
        Procedure SettingsMouseLeave(Sender: TObject);
        Procedure ExpPBoxPaint(Sender: TObject);
        Procedure HPPBoxPaint(Sender: TObject);
        Procedure AddTaskClick(Sender: TObject);
    procedure StoreClick(Sender: TObject);
    procedure SettingsClick(Sender: TObject);
    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Var
    TaskListForm: TTaskListForm;

Implementation

{$R *.dfm}

Uses
    NewTaskUnit, StoreUnit, SettingsUnit;

Procedure TTaskListForm.FormCreate(Sender: TObject);
Begin
    TaskListForm.Color := RGB(202, 205, 221);
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

    HPPBox.Canvas.Brush.Color := RGB(26, 155, 85);
    HPPBox.Canvas.Pen.Color := RGB(26, 155, 85);
    HPPBox.Canvas.Pen.Width := 2;
    Radius := 10;
    Rect := HPPBox.ClientRect;
    HPPBox.Canvas.RoundRect(Rect.Left, Rect.Top, Rect.Right Div 2, Rect.Bottom, Radius, Radius);

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

    //TaskListForm.Canvas.Draw(PaintBox2.Left, PaintBox2.Top, BitMap);
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

Procedure TTaskListForm.PaintBox4Paint(Sender: TObject);
Var
    BitMap: TBitmap;
    Rect: TRect;
    Radius: Integer;
Begin
    BitMap := TBitmap.Create();
    Rect := PaintBox4.ClientRect;
    BitMap.Height := PaintBox4.Height;
    BitMap.Width := PaintBox4.Width;
    Radius := 30;
    PaintBox4.Canvas.Brush.Color := Rgb(130, 138, 157);
    PaintBox4.Canvas.Pen.Color := Rgb(179, 186, 200);
    PaintBox4.Canvas.Pen.Width := 10;
    PaintBox4.Canvas.RoundRect(Rect.Left, Rect.Top, Rect.Right, Rect.Bottom, Radius, Radius);
    BitMap.Free();
End;

Procedure TTaskListForm.AddTaskClick(Sender: TObject);
Begin
    Application.CreateForm(TNewTaskForm, NewTaskForm);
    NewTaskForm.ShowModal;
End;

Procedure TTaskListForm.AddTaskMouseEnter(Sender: TObject);
Begin
    AddTask.ImageIndex := 1;
End;

Procedure TTaskListForm.AddTaskMouseLeave(Sender: TObject);
Begin
    AddTask.ImageIndex := 0;
End;

Procedure TTaskListForm.ExpPBoxPaint(Sender: TObject);
Var
    BitMap: TBitmap;
    Rect: TRect;
    Radius: Integer;
Begin
    BitMap := TBitmap.Create();
    BitMap.Height := ExpPBox.Height;
    BitMap.Width := ExpPBox.Width;

    ExpPBox.Canvas.Brush.Color := RGB(179, 186, 200);
    ExpPBox.Canvas.Pen.Color := RGB(179, 186, 200);
    ExpPBox.Canvas.Pen.Width := 2;
    Radius := 10;
    Rect := ExpPBox.ClientRect;
    ExpPBox.Canvas.RoundRect(Rect.Left, Rect.Top, Rect.Right, Rect.Bottom, Radius, Radius);

    ExpPBox.Canvas.Brush.Color := RGB(186, 55, 71);
    ExpPBox.Canvas.Pen.Color := RGB(186, 55, 71);
    ExpPBox.Canvas.RoundRect(Rect.Left, Rect.Top, Rect.Right Div 2, Rect.Bottom, Radius, Radius);

    BitMap.Free();
End;

procedure TTaskListForm.StoreClick(Sender: TObject);
begin
    StoreForm.ShowModal;
end;

Procedure TTaskListForm.StoreMouseEnter(Sender: TObject);
Begin
    Store.ImageIndex := 3;
End;

Procedure TTaskListForm.StoreMouseLeave(Sender: TObject);
Begin
    Store.ImageIndex := 2;
End;

Procedure TTaskListForm.ProfileMouseEnter(Sender: TObject);
Begin
    Profile.ImageIndex := 5;
End;

Procedure TTaskListForm.ProfileMouseLeave(Sender: TObject);
Begin
    Profile.ImageIndex := 4;
End;

Procedure TTaskListForm.RefferencessMouseEnter(Sender: TObject);
Begin
    Refferencess.ImageIndex := 7;
End;

Procedure TTaskListForm.RefferencessMouseLeave(Sender: TObject);
Begin
    Refferencess.ImageIndex := 6;
End;

procedure TTaskListForm.SettingsClick(Sender: TObject);
begin
    Form1.ShowModal;
end;

Procedure TTaskListForm.SettingsMouseEnter(Sender: TObject);
Begin
    Settings.ImageIndex := 9;
End;

Procedure TTaskListForm.SettingsMouseLeave(Sender: TObject);
Begin
    Settings.ImageIndex := 8;
End;

End.
