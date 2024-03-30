Unit UserUnit;

Interface

//из файла нам нужен:
//- текущий уровень;
//- кол-во опыта;
//- кол-во здоровья;
//- кол-во монет.

Uses
    TaskUnit;

Type
    TPercent = 0 .. 100;

    TUser = Class
    Const
        StartXP: Integer = 100;
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

    Var
        FCurentLvl: Integer;
        FXP: Integer;
        FNextLvlXP: Integer;
        FHP: Integer;
        FNextLvlHP: Integer;
        FCoins: Integer;
    Private
        Function CalculateAwards(Complexity: TComplexity; EasyVal, MediumVal, HardVal: Integer): Integer;
    Public
        Function GetTaskMoney(Complexity: TComplexity): Integer;
        Function GetTaskXP(Complexity: TComplexity): Integer;
        Function GetTaskHP(Complexity: TComplexity): Integer;

        Function GetHpPersent(): TPercent;
        Function GetXpPersent(): TPercent;

        Procedure ApplyNewTask(XP_Val, HP_Val, Coins_Val: Integer);

        Property CurentLvl: Integer Read FCurentLvl;
        Property Coins: Integer Read FCoins;
        Property HP: Integer Read FHP;
        Property XP: Integer Read FXP;
        Property MaxHP: Integer Read FNextLvlHP;
        Property MaxXP: Integer Read FNextLvlXP;
        Constructor Create;
    End;

Implementation

Constructor TUser.Create;
Begin
    FXP := 0;
    FNextLvlXP := StartXP;
    FHP := StartHP;
    FNextLvlHP := StartHP;
    FCoins := 0;
    FCurentLvl := 1;
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
