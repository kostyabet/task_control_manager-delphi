Unit UserUnit;

Interface

//из файла нам нужен:
//- текущий уровень;
//- кол-во опыта;
//- кол-во здоровья;
//- кол-во монет.

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
    Vcl.VirtualImageList,
    TaskUnit;

Type
    TPercent = 0 .. 100;

    TUser = Class
    Const
        StartXP: Integer = 50;
        StartHP: Integer = 25;

        EazyTaskXP: Integer = 10;
        EazyTaskHP: Integer = 3;
        EazyTaskMoney: Integer = 5;

        MediumTaskXP: Integer = 15;
        MediumTaskHP: Integer = 5;
        MediumTaskMoney: Integer = 7;

        HardTaskXP: Integer = 20;
        HardTaskHP: Integer = 7;
        HardTaskMoney: Integer = 10;

        EndTimeKoef: Double = 0.6;
        AwardIncrease: Double = 0.1;
        XPIncrease: Double = 1.1;
        HPIncrease: Double = 1.05;
        CostsIncrease: Double = 1.1;

        HPCost: Integer = 50;
        XPCost: Integer = 75;
        HPBustCost: Integer = 20;
        XPBustCost: Integer = 30;
        CoinsBustCost: Integer = 20;
        TothemBustCost: Integer = 100;
        FreeTaskBust: Integer = 80;
        SecretBox: Integer = 70;

    Type
        TBusts = (HP, XP, HPBust, XPBust, CoinsBust, Tothem, FreeTask, SecretBox);
        TBustsCost = Array [Low(TBusts) .. High(TBusts)] Of Integer;
        TBustBought = Array [Low(TBusts) .. TBusts.FreeTask] Of Integer;

    Var
        FCurentLvl: Integer;
        FXP: Integer;
        FNextLvlXP: Integer;
        FHP: Integer;
        FNextLvlHP: Integer;
        FCoins: Integer;
        FBustsCost: TBustsCost;
        FBustsBuyCount: Integer;
        FBustBought: TBustBought;
    Private
        Function CalculateAwards(Complexity: TComplexity; EasyVal, MediumVal, HardVal: Integer): Integer;

        Function FindCost(StartVal: Integer): Integer;
    Public
        Function GetTaskMoney(Complexity: TComplexity): Integer;
        Function GetTaskXP(Complexity: TComplexity): Integer;
        Function GetTaskHP(Complexity: TComplexity): Integer;

        Function GetHpPersent(): TPercent;
        Function GetXpPersent(): TPercent;
        Function GetBustsCost(): TBustsCost;

        Procedure ApplyNewTask(XP_Val, HP_Val, Coins_Val: Integer);
        Procedure BuyBust(TypeOfBust: TBusts; CountLabel: TLabel);

        Function IsCanBuy(ItemCost: Integer): Boolean;

        Property CurentLvl: Integer Read FCurentLvl;
        Property Coins: Integer Read FCoins;
        Property HP: Integer Read FHP;
        Property XP: Integer Read FXP;
        Property MaxHP: Integer Read FNextLvlHP;
        Property MaxXP: Integer Read FNextLvlXP;
        Property BustBought: TBustBought Read FBustBought;
        Constructor Create;
    End;

Implementation

Uses
    TasksListScreenUnit;

Function TUser.IsCanBuy(ItemCost: Integer): Boolean;
Begin
    IsCanBuy := FCoins >= ItemCost;
End;

Constructor TUser.Create;
Begin
    FXP := 0;
    FNextLvlXP := StartXP;
    FHP := StartHP;
    FNextLvlHP := StartHP;
    FCoins := 0;
    FCurentLvl := 1;
    FBustsBuyCount := 0;
End;

Procedure TUser.BuyBust(TypeOfBust: TBusts; CountLabel: TLabel);
Var
    LeftBorder: Integer;
Begin
    Inc(FBustBought[TypeOfBust]);
    FCoins := FCoins - FBustsCost[TypeOfBust];
    Inc(FBustsBuyCount);
    LeftBorder := CountLabel.Left + CountLabel.Width;
    CountLabel.Caption := 'x' + IntToStr(FBustBought[TypeOfBust]);
    CountLabel.Left := LeftBorder - CountLabel.Width;
End;

Function TUser.FindCost(StartVal: Integer): Integer;
Var
    I: Integer;
    ResVal: Double;
Begin
    ResVal := StartVal;
    For I := 1 To FBustsBuyCount Do
        ResVal := ResVal * CostsIncrease;
    FindCost := Trunc(ResVal);
End;

Function TUser.GetBustsCost: TUser.TBustsCost;
Begin
    FBustsCost[TBusts.HP] := FindCost(HPCost);
    FBustsCost[TBusts.XP] := FindCost(XPCost);
    FBustsCost[TBusts.HPBust] := FindCost(HPBustCost);
    FBustsCost[TBusts.XPBust] := FindCost(XPBustCost);
    FBustsCost[TBusts.CoinsBust] := FindCost(CoinsBustCost);
    FBustsCost[TBusts.Tothem] := FindCost(TothemBustCost);
    FBustsCost[TBusts.FreeTask] := FindCost(FreeTaskBust);
    FBustsCost[TBusts.SecretBox] := FindCost(SecretBox);

    GetBustsCost := FBustsCost;
End;

Function TUser.CalculateAwards(Complexity: TComplexity; EasyVal, MediumVal, HardVal: Integer): Integer;
Var
    I: Integer;
    Coef: Real;
Begin
    Coef := 1;
    For I := 1 To FCurentLvl Do
        Coef := Coef + Coef * AwardIncrease;

    Case Complexity Of
        Easy:
            CalculateAwards := Trunc(EasyVal * Coef);
        Medium:
            CalculateAwards := Trunc(MediumVal * Coef);
    Else
        CalculateAwards := Trunc(HardVal * Coef);
    End;
End;

Function TUser.GetTaskMoney(Complexity: TComplexity): Integer;
Begin
    GetTaskMoney := CalculateAwards(Complexity, EazyTaskMoney, MediumTaskMoney, HardTaskMoney);
End;

Function TUser.GetTaskXP(Complexity: TComplexity): Integer;
Begin
    GetTaskXP := CalculateAwards(Complexity, EazyTaskXP, MediumTaskXP, HardTaskXP);
End;

Function TUser.GetTaskHP(Complexity: TComplexity): Integer;
Begin
    GetTaskHP := CalculateAwards(Complexity, EazyTaskHP, MediumTaskHP, HardTaskHP);
End;

Function TUser.GetHpPersent: TPercent;
Begin
    GetHpPersent := Trunc((FHP / FNextLvlHP) * 100);
End;

Function TUser.GetXpPersent: TPercent;
Begin
    GetXpPersent := Trunc((FXP / FNextLvlXP) * 100);
End;

Procedure TUser.ApplyNewTask(XP_Val, HP_Val, Coins_Val: Integer);
Var
    TempHp, TempXp: Integer;
Begin
    FCoins := FCoins + Coins_Val;

    TempXP := (FXP + XP_Val);
    If (TempXP > FNextLvlXP) Then
    Begin
        FXP := TempXp Mod FNextLvlXP;
        FNextLvlXP := Trunc(XPIncrease * FNextLvlXP);
        FNextLvlHP := Trunc(HPIncrease * FNextLvlHP);
        Inc(FCurentLvl);
    End
    Else
        FXP := TempXp;

    TempHp := FHP + HP_Val;
    If (TempHP > FNextLvlHP) Then
        FHP := FNextLvlHP;
End;

End.
