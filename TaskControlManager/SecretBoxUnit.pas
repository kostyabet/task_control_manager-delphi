Unit SecretBoxUnit;

Interface

Uses
    System.SysUtils,
    Vcl.Forms,
    ButtonFrame,
    Vcl.StdCtrls,
    Vcl.VirtualImage,
    UserUnit,
    TasksListScreenUnit,
    DateUtils,
    Vcl.Controls,
    System.Classes;

Type
    TSecreteBoxForm = Class(TForm)
        RandomBustImage: TVirtualImage;
        TitleLabel: TLabel;
        OpenButtonFrame: TFrame1;
        Procedure FormCreate(Sender: TObject);
        Procedure SearchRandomBust(Sender: TObject);
    Private
        Function CustomRandom: TUser.TBusts;
        Function SearchPrice(): Integer;
        Procedure TreatmentCosts(MiddlePrice: Integer);
    Public
        { Public declarations }
    End;

Type
    TItems = Array [Low(TUser.TBusts) .. High(TUser.TBusts)] Of TUser.TBusts;

Var
    SecreteBoxForm: TSecreteBoxForm;
    Costs: TUser.TBustsCost;
    BustsLabels: TUser.TArrOfLabel;
    Items: TItems = (TUser.TBusts.HP, TUser.TBusts.XP, TUser.TBusts.HPBust, TUser.TBusts.XPBust, TUser.TBusts.CoinsBust,
        TUser.TBusts.Tothem, TUser.TBusts.FreeTask, TUser.TBusts.SecretBox);
    TotalPrice: Integer;

Implementation

{$R *.dfm}

Uses
    ColorsUnit;

{ алгоритм поиска случайного значения: "случайный алгоритм" }
Function TSecreteBoxForm.CustomRandom: TUser.TBusts;
Var
    RandomValue: Integer;
    RandomIndex: TUser.TBusts;
Begin
    RandomValue := Random(TotalPrice) + 1;
    RandomIndex := TUser.TBusts.HP;

    While (RandomValue > Costs[RandomIndex]) And (RandomIndex < TUser.TBusts.SecretBox) Do
    Begin
        RandomValue := RandomValue - Costs[RandomIndex];
        Inc(RandomIndex);
    End;

    Result := RandomIndex;
End;

{ высчитывание цены бонусов }
Function TSecreteBoxForm.SearchPrice(): Integer;
Var
    Price: Integer;
    I: TUser.TBusts;
Begin
    Price := 0;
    For I := Low(TUser.TBusts) To High(TUser.TBusts) Do
        Price := Price + Costs[I];
    SearchPrice := Price;
End;

{ подготовка данных к "случайному алгоритму" }
Procedure TSecreteBoxForm.TreatmentCosts(MiddlePrice: Integer);
Var
    I: TUser.TBusts;
Begin
    For I := Low(TUser.TBusts) To High(TUser.TBusts) Do
    Begin
        If (Costs[I] > MiddlePrice) Then
            Costs[I] := Costs[I] - (Costs[I] - MiddlePrice) * 2
        Else
            Costs[I] := Costs[I] + (MiddlePrice - Costs[I]) * 2;
    End;
End;

{ инициализация данных }
Procedure TSecreteBoxForm.FormCreate(Sender: TObject);
Var
    MiddlePrice: Integer;
Begin
    BustsLabels := User.ArrOfLabel;
    SecreteBoxForm.Color := ClFont;
    Costs := User.GetBustsCost();
    MiddlePrice := SearchPrice Div Ord(TUser.TBusts.FreeTask);
    TreatmentCosts(MiddlePrice);
    TotalPrice := SearchPrice;
End;

{ поиск случайного бонуса }
Procedure TSecreteBoxForm.SearchRandomBust(Sender: TObject);
Var
    RandomBust: TUser.TBusts;
    TempBought: Tuser.TBustBought;
Begin
    RandomBust := CustomRandom();
    RandomBustImage.ImageIndex := Ord(RandomBust);
    User.BuyBust(RandomBust, BustsLabels[Ord(RandomBust)]);
    User.FCoins := User.FCoins - User.FBustsCost[RandomBust];
    Dec(User.FBustsBuyCount);
    TempBought := User.BustBought;
    Dec(TempBought[TUser.TBusts.SecretBox]);
    User.BustBought := TempBought;
    TaskListForm.ChangeBustsCounter(BustsLabels[Ord(TUser.TBusts.SecretBox)], TUser.TBusts.SecretBox);
    OpenButtonFrame.ButtonText.Enabled := False;
    OpenButtonFrame.BackGroundVirtmage.Enabled := False;
End;

End.
