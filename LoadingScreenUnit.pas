Unit LoadingScreenUnit;

Interface

Uses
    Winapi.Windows,
    Vcl.Forms,
    Vcl.ExtCtrls,
    Vcl.Imaging.Jpeg,
    System.Classes,
    Vcl.Controls,
    Vcl.Graphics;

Type
    TLoadingScreen = Class(TForm)
        EndLoadingScreen: TTimer;
        AlphaBlendChanging: TTimer;
        LoadImage: TImage;
        Procedure EndLoadingScreenTimer(Sender: TObject);
        Procedure FormCreate(Sender: TObject);
        Procedure AlphaBlendChangingTimer(Sender: TObject);
    End;

Const
    SIRCLE_HEIGHT: Integer = 258;
    SIRCLE_WIDTH: Integer = 258;

Var
    LoadingScreen: TLoadingScreen;

Implementation

{$R *.dfm}

Procedure TLoadingScreen.FormCreate(Sender: TObject);
Const
    Radius: Integer = 45;
Var
    Rgn: HRGN;
    MyRect: TRect;
Begin
    { изменение вида формы }
    MyRect := Rect(0, 0, SIRCLE_HEIGHT, SIRCLE_WIDTH);
    Rgn := CreateRoundRectRgn(MyRect.Left, MyRect.Top, MyRect.Right, MyRect.Bottom, Radius, Radius);
    SetWindowRgn(Handle, Rgn, True);
    { запуск таймеров }
    EndLoadingScreen.Enabled := True;
    AlphaBlendChanging.Enabled := True;
End;

{ изменение AlphaBlend }
Procedure TLoadingScreen.AlphaBlendChangingTimer(Sender: TObject);
Const
    GROUGHT_ABV: Integer = 2;
    MAX_ALPHA_BLEND: Integer = 253;
Begin
    If LoadingScreen.AlphaBlendValue > MAX_ALPHA_BLEND Then
        AlphaBlendChanging.Enabled := False
    Else
        LoadingScreen.AlphaBlendValue := LoadingScreen.AlphaBlendValue + GROUGHT_ABV;
End;

{ таймер завершения }
Procedure TLoadingScreen.EndLoadingScreenTimer(Sender: TObject);
Begin
    EndLoadingScreen.Enabled := False;
End;

End.
