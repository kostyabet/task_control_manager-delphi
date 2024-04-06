Unit StoreUnit;

Interface

Uses
    Winapi.Windows,
    System.SysUtils,
    Vcl.Forms,
    Vcl.StdCtrls,
    Vcl.ExtCtrls,
    Vcl.VirtualImage,
    ButtonFrame,
    UserUnit,
    Vcl.Controls,
    System.Classes;

Type
    TStoreForm = Class(TForm)
        TitleLabel: TLabel;
        StoreFontPBox: TPaintBox;
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
        CoinsImage: TVirtualImage;
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
    TasksListScreenUnit,
    ColorsUnit;

{ центрирование текста }
Procedure TStoreForm.MoveInCenter(Frame: TFrame1);
Begin
    Frame.ButtonText.Left := (Frame.Width - Frame.ButtonText.Width) Div 2;
End;

{ тзменние видимости кнопок }
Procedure TStoreForm.TreatmentButton(Frame: TFrame1; Status: Boolean);
Begin
    Frame.BackGroundVirtmage.Enabled := Status;
    Frame.ButtonText.Enabled := Status;
End;

{ проверка на возможность покупки }
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

{ обработка попытки купить бонус }
Procedure TStoreForm.ButtonFrameBuyClick(Sender: TObject);
Var
    ResultKey: Integer;
Begin
    ResultKey := Application.Messagebox('Вы уверены, что хотите купить бонус?', 'Покупка бонуса',
        MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2);
    If (ResultKey = ID_YES) Then
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
End;

{ заполнение цен бонусов }
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

{ инициализация данных формы }
Procedure TStoreForm.FormCreate(Sender: TObject);
Begin
    StoreForm.Color := ClFont;
    TitleLabel.Font.Color := ClText;
    CoinsLabel.Font.Color := ClText;
    CoinsLabel.Caption := IntToStr(User.Coins);
    TothemBust.Hint := 'Тотем. Возвращает все бонусы просроченой задачи в норму.'#13#10'Применяется автоматически при выполнении просроченой задачи.';
    FreeTaskBust.Hint := 'Бесплатная задача. Зануляет все бонусы просроченой задачи в норму.'#13#10'Применяется автоматически при выполнении просроченой задачи.';
    SecretBox.Hint := 'Секретный сундучок. Вы получите рандомный бонус из 8-ми.'#13#10'Шанс скоррестирован относительно цен.';
    CheckEnabled;
    InputCostInCell(User.GetBustsCost());
End;

{ отрисовка фона магазина }
Procedure TStoreForm.StoreFontPBoxPaint(Sender: TObject);
Const
    RADIUS: Integer = 30;
    PEN_WIDTH: Integer = 10;
Var
    Rect: TRect;
Begin
    Rect := StoreFontPBox.ClientRect;
    StoreFontPBox.Canvas.Brush.Color := ClBackgroundBrush;
    StoreFontPBox.Canvas.Pen.Color := ClBackgroundPen;
    StoreFontPBox.Canvas.Pen.Width := PEN_WIDTH;
    StoreFontPBox.Canvas.RoundRect(Rect.Left, Rect.Top, Rect.Right, Rect.Bottom, RADIUS, RADIUS);
End;

End.
