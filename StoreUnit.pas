Unit StoreUnit;

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
    Vcl.ExtCtrls,
    Vcl.VirtualImage,
    Vcl.BaseImageCollection,
    Vcl.ImageCollection,
    ButtonFrame,
    Vcl.Imaging.Pngimage,
    UserUnit;

Type
    TStoreForm = Class(TForm)
        TitleLabel: TLabel;
        StoreFontPBox: TPaintBox;
        ImageCollection: TImageCollection;
        BackGroundHP: TVirtualImage;
        BackGroundTothem: TVirtualImage;
        BackGroundHPBust: TVirtualImage;
        BackGroundXPbust: TVirtualImage;
        BackGoundCoins: TVirtualImage;
        BackGroundSecretBox: TVirtualImage;
        BackGroundFreeTask: TVirtualImage;
        BackGroundEXP: TVirtualImage;
        FreeHP: TVirtualImage;
        FreeXP: TVirtualImage;
        FreeHPBust: TVirtualImage;
        FreeXPBust: TVirtualImage;
        CoinsBust: TVirtualImage;
        FreeTaskBust: TVirtualImage;
        TothemBust: TVirtualImage;
        SecretBox: TVirtualImage;
        HPBustFrame: TFrame1;
        HPFrame: TFrame1;
        XPFrame: TFrame1;
        XPBustFrame: TFrame1;
        SecretBoxFrame: TFrame1;
        FreeTaskBustFrame: TFrame1;
        TothemBustFrame: TFrame1;
        CoinsBustFrame: TFrame1;
        CoinsLabel: TLabel;
        CoinsImage: TImage;
        Procedure FormCreate(Sender: TObject);
        Procedure StoreFontPBoxPaint(Sender: TObject);
        Procedure ButtonFrameBuyClick(Sender: TObject);
    Private
        Procedure MoveInCenter(Frame: TFrame1);
        Procedure InputCostInCell(Costs: TUser.TBustsCost);
        Procedure TreatmentButton(Frame: TFrame1; Status: Boolean);
        Procedure CheckEnabled();
    Public
        { Public declarations }
    End;

Var
    StoreForm: TStoreForm;

Implementation

{$R *.dfm}

Uses
    TasksListScreenUnit;

Procedure TStoreForm.MoveInCenter(Frame: TFrame1);
Begin
    Frame.ButtonText.Left := (Frame.Width - Frame.ButtonText.Width) Div 2;
End;

Procedure TStoreForm.TreatmentButton(Frame: TFrame1; Status: Boolean);
Begin
    Frame.BackGroundVirtmage.Enabled := Status;
    Frame.ButtonText.Enabled := Status;
End;

Procedure TStoreForm.CheckEnabled();
Var
    Costs: TUser.TBustsCost;
Begin
    Costs := User.GetBustsCost();
    TreatmentButton(HPFrame, User.IsCanBuy(Costs[TUser.TBusts.HP]));
    TreatmentButton(XPFrame, User.IsCanBuy(Costs[TUser.TBusts.XP]));
    TreatmentButton(HPBustFrame, User.IsCanBuy(Costs[TUser.TBusts.HPBust]));
    TreatmentButton(XPBustFrame, User.IsCanBuy(Costs[TUser.TBusts.XPBust]));
    TreatmentButton(CoinsBustFrame, User.IsCanBuy(Costs[TUser.TBusts.CoinsBust]));
    TreatmentButton(TothemBustFrame, User.IsCanBuy(Costs[TUser.TBusts.Tothem]));
    TreatmentButton(FreeTaskBustFrame, User.IsCanBuy(Costs[TUser.TBusts.FreeTask]));
    TreatmentButton(SecretBoxFrame, User.IsCanBuy(Costs[TUser.TBusts.SecretBox]));
End;

Procedure TStoreForm.ButtonFrameBuyClick(Sender: TObject);
Begin
    If (Sender = HPFrame.ButtonText) Or (Sender = HPFrame.BackGroundVirtmage) Then
        User.BuyBust(TUser.TBusts.HP, TaskListForm.HPFrame.CountLabel);

    If (Sender = XPFrame.ButtonText) Or (Sender = XPFrame.BackGroundVirtmage) Then
        User.BuyBust(TUser.TBusts.XP, TaskListForm.XPFrame.CountLabel);

    If (Sender = HPBustFrame.ButtonText) Or (Sender = HPBustFrame.BackGroundVirtmage) Then
        User.BuyBust(TUser.TBusts.HPBust, TaskListForm.HPBustFrame.CountLabel);

    If (Sender = XPBustFrame.ButtonText) Or (Sender = XPBustFrame.BackGroundVirtmage) Then
        User.BuyBust(TUser.TBusts.XPBust, TaskListForm.XPBustFrame.CountLabel);

    If (Sender = CoinsBustFrame.ButtonText) Or (Sender = CoinsBustFrame.BackGroundVirtmage) Then
        User.BuyBust(TUser.TBusts.CoinsBust, TaskListForm.CoinsFrame.CountLabel);

    If (Sender = TothemBustFrame.ButtonText) Or (Sender = TothemBustFrame.BackGroundVirtmage) Then
        User.BuyBust(TUser.TBusts.Tothem, TaskListForm.TotemFrame.CountLabel);

    If (Sender = FreeTaskBustFrame.ButtonText) Or (Sender = FreeTaskBustFrame.BackGroundVirtmage) Then
        User.BuyBust(TUser.TBusts.FreeTask, TaskListForm.FreeTaskFrame.CountLabel);

    If (Sender = SecretBoxFrame.ButtonText) Or (Sender = SecretBoxFrame.BackGroundVirtmage) Then
        User.BuyBust(TUser.TBusts.SecretBox, TaskListForm.SecretBoxFrame.CountLabel);

    CoinsLabel.Caption := IntToStr(User.Coins);
    InputCostInCell(User.GetBustsCost());
    CheckEnabled;
    TaskListForm.UpDateUserInfo;
End;

Procedure TStoreForm.InputCostInCell(Costs: TUser.TBustsCost);
Begin
    HPFrame.ButtonText.Caption := IntToStr(Costs[TUser.TBusts.HP]);
    MoveInCenter(HPFrame);
    XPFrame.ButtonText.Caption := IntToStr(Costs[TUser.TBusts.XP]);
    MoveInCenter(XPFrame);
    HPBustFrame.ButtonText.Caption := IntToStr(Costs[TUser.TBusts.HPBust]);
    MoveInCenter(HPBustFrame);
    XPBustFrame.ButtonText.Caption := IntToStr(Costs[TUser.TBusts.XPBust]);
    MoveInCenter(XPBustFrame);
    CoinsBustFrame.ButtonText.Caption := IntToStr(Costs[TUser.TBusts.CoinsBust]);
    MoveInCenter(CoinsBustFrame);
    TothemBustFrame.ButtonText.Caption := IntToStr(Costs[TUser.TBusts.Tothem]);
    MoveInCenter(TothemBustFrame);
    FreeTaskBustFrame.ButtonText.Caption := IntToStr(Costs[TUser.TBusts.FreeTask]);
    MoveInCenter(FreeTaskBustFrame);
    SecretBoxFrame.ButtonText.Caption := IntToStr(Costs[TUser.TBusts.SecretBox]);
    MoveInCenter(SecretBoxFrame);
End;

Procedure TStoreForm.FormCreate(Sender: TObject);
Begin
    StoreForm.Color := Rgb(202, 205, 221);
    TitleLabel.Font.Color := RGB(38, 43, 50);
    CoinsLabel.Font.Color := RGB(38, 43, 50);
    CoinsLabel.Caption := IntToStr(User.Coins);
    CheckEnabled;
    InputCostInCell(User.GetBustsCost());
End;

Procedure TStoreForm.StoreFontPBoxPaint(Sender: TObject);
Var
    BitMap: TBitmap;
    Rect: TRect;
    Radius: Integer;
Begin
    BitMap := TBitmap.Create();
    Rect := StoreFontPBox.ClientRect;
    BitMap.Height := StoreFontPBox.Height;
    BitMap.Width := StoreFontPBox.Width;
    Radius := 30;
    StoreFontPBox.Canvas.Brush.Color := Rgb(169, 174, 187);
    StoreFontPBox.Canvas.Pen.Color := Rgb(179, 188, 206);
    StoreFontPBox.Canvas.Pen.Width := 10;
    StoreFontPBox.Canvas.RoundRect(Rect.Left, Rect.Top, Rect.Right, Rect.Bottom, Radius, Radius);
    BitMap.Free();
End;

End.
