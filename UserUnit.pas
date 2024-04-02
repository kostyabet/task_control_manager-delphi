Unit UserUnit;

Interface

{ .ini настойки приложения } //?????????.ini
//- музыка
//- тема
//- локализация

{ персональная информация } //userinfo.txt
//- текущий уровень;
//- кол-во здоровья;
//- кол-во опыта;
//- кол-во монет.
//- массив с кол-вом бонусов
//- информация о применённых бонусах

{ хранение задач } //tasks.txt
//- хранить все задачи

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

        HPBonus: Integer = 15;
        XPBonus: Integer = 20;
        CoinsBonus: Integer = 5;

    Type
        TBusts = (HP, XP, HPBust, XPBust, CoinsBust, Tothem, FreeTask, SecretBox);
        TBustsCost = Array [Low(TBusts) .. High(TBusts)] Of Integer;
        TBustBought = Array [Low(TBusts) .. High(TBusts)] Of Integer;

        TUserInfo = Record
            Lvl: Integer;
            XP: Integer;
            HP: Integer;
            Coins: Integer;
            BustBought: TBustBought;
            XPBust: Integer;
            HPBust: Integer;
            CoinsBust: Integer;
            FreeTaskUsed: Boolean;
            BustsBuyCount: Integer;
        End;

        TUserFile = File Of TUserInfo;

    Const
        UserinfoPath: String = 'userinfo.txt';

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
        FXPBust: Integer;
        FHPBust: Integer;
        FCoinsBust: Integer;
        FFreeTaskUsed: Boolean;
        FIsTotemUsed: Boolean;
        UserInfoFile: TUserFile;
    Private
        Function CalculateAwards(Task: TTask; EasyVal, MediumVal, HardVal: Integer): Integer;
        Function FindCost(StartVal: Integer): Integer;
        Function SearchCurentValOnLvl(Start: Integer; Increase: Double): Integer;
        Function GetUserInfo(): TUserInfo;
        Procedure InputDataInField(UserInfo: TUserInfo);
        Procedure UseHp;
        Procedure UseXP;
        Procedure UseHPBust;
        Procedure UseXPBust;
        Procedure UseCoinsBust;
        Procedure UseFreeTask;
    Public
        Function GetTaskMoney(Task: TTask): Integer;
        Function GetTaskXP(Task: TTask): Integer;
        Function GetTaskHP(Task: TTask): Integer;

        Function GetHpPersent(): TPercent;
        Function GetXpPersent(): TPercent;
        Function GetBustsCost(): TBustsCost;
        Procedure UseBust(TypeOfBust: TBusts; CountLabel: TLabel);

        Procedure ApplyNewTask(XP_Val, HP_Val, Coins_Val: Integer);
        Procedure BuyBust(TypeOfBust: TBusts; CountLabel: TLabel);
        Procedure SaveUserDataInFile;
        Procedure LoadUserDataFromFile;

        Function IsCanBuy(ItemCost: Integer): Boolean;

        Property CurentLvl: Integer Read FCurentLvl;
        Property Coins: Integer Read FCoins;
        Property HP: Integer Read FHP;
        Property XP: Integer Read FXP;
        Property MaxHP: Integer Read FNextLvlHP;
        Property MaxXP: Integer Read FNextLvlXP;
        Property BustBought: TBustBought Read FBustBought Write FBustBought;
        Property FreeTaskUsed: Boolean Read FFreeTaskUsed Write FFreeTaskUsed;
        Property IsTotemUsed: Boolean Read FIsTotemUsed Write FIsTotemUsed;
        Constructor Create;
    End;

Implementation

Uses
    TasksListScreenUnit,
    SecretBoxUnit;

Procedure TUser.UseHp();
Begin
    FHP := FHP + HPBonus;
    If FHP > FNextLvlHP Then
        FHP := FNextLvlHP;
End;

Procedure TUser.UseXP();
Begin
    FXP := FXP + XPBonus;

    If (FXP > FNextLvlXP) Then
    Begin
        FXP := FXP Mod FNextLvlXP;
        FNextLvlXP := Trunc(XPIncrease * FNextLvlXP);
        FNextLvlHP := Trunc(HPIncrease * FNextLvlHP);
        Inc(FCurentLvl);
    End;
End;

Procedure TUser.UseHPBust;
Var
    I: Integer;
    Coef: Real;
Begin
    Coef := 1;
    For I := 1 To FCurentLvl Do
        Coef := Coef + Coef * AwardIncrease;

    FHPBust := FHPBust + Trunc(HPBonus * Coef);
End;

Procedure TUser.UseXPBust;
Var
    I: Integer;
    Coef: Real;
Begin
    Coef := 1;
    For I := 1 To FCurentLvl Do
        Coef := Coef + Coef * AwardIncrease;

    FXPBust := FXPBust + Trunc(XPBonus * Coef);
End;

Procedure TUser.UseCoinsBust;
Var
    I: Integer;
    Coef: Real;
Begin
    Coef := 1;
    For I := 1 To FCurentLvl Do
        Coef := Coef + Coef * AwardIncrease;

    FCoinsBust := FCoinsBust + Trunc(CoinsBonus * Coef);
End;

Procedure TUser.UseFreeTask();
Begin
    FFreeTaskUsed := True;
End;

Procedure TUser.UseBust(TypeOfBust: TBusts; CountLabel: TLabel);
Begin
    Case TypeOfBust Of
        TBusts.HP:
            Begin
                UseHp;
                TaskListForm.UpDateUserInfo;
            End;
        TBusts.XP:
            Begin
                UseXP;
                TaskListForm.UpDateUserInfo;
            End;
        TBusts.HPBust:
            Begin
                UseHPBust;
                TaskListForm.ShowHPBustVImage.Visible := True;
                TaskListForm.ShowHPBustVImage.Hint := '+' + IntToStr(FHPBust) +
                    ' к здоровью: бонус примениться при завершении любой задачи.';
            End;
        TBusts.XPBust:
            Begin
                UseXPBust;
                TaskListForm.ShowXPBustVImage.Visible := True;
                TaskListForm.ShowXPBustVImage.Hint := '+' + IntToStr(FXPBust) + ' к опыту: бонус примениться при завершении любой задачи.';
            End;
        TBusts.CoinsBust:
            Begin
                UseCoinsBust;
                TaskListForm.ShowCoinsBustVImage.Visible := True;
                TaskListForm.ShowCoinsBustVImage.Hint := '+' + IntToStr(FCoinsBust) +
                    ' к монетам: бонус примениться при завершении любой задачи.';
            End;
        TBusts.Tothem:
            Begin

            End;
        TBusts.FreeTask:
            Begin
                UseFreeTask;
                TaskListForm.FreeTaskVImage.Visible := True;
                TaskListForm.FreeTaskVImage.Hint := '0, 0, 0: Автоматически примениться при просрочке задачи.';
            End;
    Else
        Begin
            Application.CreateForm(TSecreteBoxForm, SecreteBoxForm);
            SecreteBoxForm.ShowModal;
            Inc(FBustBought[TypeOfBust]);
        End;
    End;
    Dec(FBustBought[TypeOfBust]);
    TaskListForm.ChangeBustsCounter(CountLabel, TypeOfBust);
End;

Function TUser.IsCanBuy(ItemCost: Integer): Boolean;
Begin
    IsCanBuy := FCoins >= ItemCost;
End;

Function TUser.SearchCurentValOnLvl(Start: Integer; Increase: Double): Integer;
Var
    I: Integer;
    Val: Double;
Begin
    Val := Start;
    For I := 2 To FCurentLvl Do
        Val := Val * Increase;

    SearchCurentValOnLvl := Trunc(Val);
End;

Constructor TUser.Create;
Var
    I: TBusts;
Begin
    FCurentLvl := 1;
    FNextLvlXP := SearchCurentValOnLvl(StartXP, XPIncrease);
    FXP := 0;
    FNextLvlHP := SearchCurentValOnLvl(StartHP, HPIncrease);
    FHP := FNextLvlHP;
    FCoins := 0;
    FBustsBuyCount := 0;
    FXPBust := 0;
    FHPBust := 0;
    FCoinsBust := 0;
    FFreeTaskUsed := False;
    FIsTotemUsed := False;
    For I := Low(TUser.TBusts) To High(TUser.TBusts) Do
        FBustBought[I] := 0;
End;

Procedure TUser.BuyBust(TypeOfBust: TBusts; CountLabel: TLabel);
Begin
    Inc(FBustBought[TypeOfBust]);
    FCoins := FCoins - FBustsCost[TypeOfBust];
    Inc(FBustsBuyCount);
    TaskListForm.ChangeBustsCounter(CountLabel, TypeOfBust);
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

Function TUser.CalculateAwards(Task: TTask; EasyVal, MediumVal, HardVal: Integer): Integer;
Var
    I: Integer;
    Coef, ResVal: Real;
    CurentDate: TDate;
Begin
    Coef := 1;
    For I := 1 To FCurentLvl Do
        Coef := Coef + Coef * AwardIncrease;

    Case Task.FTaskData.Complexity Of
        Easy:
            ResVal := EasyVal * Coef;
        Medium:
            ResVal := MediumVal * Coef;
    Else
        ResVal := HardVal * Coef;
    End;
    CurentDate := Date + EncodeTime(0, 0, 0, 0);
    If (Task.FTaskData.Date < CurentDate) Then
        ResVal := -1 * (ResVal / 2);

    CalculateAwards := Trunc(ResVal);
End;

Function TUser.GetTaskMoney(Task: TTask): Integer;
Begin
    GetTaskMoney := CalculateAwards(Task, EazyTaskMoney, MediumTaskMoney, HardTaskMoney);
End;

Function TUser.GetTaskXP(Task: TTask): Integer;
Begin
    GetTaskXP := CalculateAwards(Task, EazyTaskXP, MediumTaskXP, HardTaskXP);
End;

Function TUser.GetTaskHP(Task: TTask): Integer;
Begin
    GetTaskHP := CalculateAwards(Task, EazyTaskHP, MediumTaskHP, HardTaskHP);
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
    TempXP := FXP;
    TempHP := FHP;
    If Not(FFreeTaskUsed And (Coins_Val < 0) And (XP_Val < 0) And (HP_Val < 0)) Then
    Begin
        FCoins := FCoins + Coins_Val + FCoinsBust;
        TempXP := FXP + XP_Val + FXPBust;
        TempHp := FHP + HP_Val + FHPBust;
    End
    Else
        FFreeTaskUsed := False;

    If (FBustBought[TBusts.Tothem] <> 0) And (Coins_Val < 0) And (XP_Val < 0) And (HP_Val < 0) Then
    Begin
        FCoins := FCoins + Coins_Val * (-1) + FCoinsBust;
        TempXP := FXP + XP_Val * (-1) + FXPBust;
        TempHp := FHP + HP_Val * (-1) + FHPBust;
        FIsTotemUsed := True;
    End;

    If FCoins < 0 Then
        FCoins := 0;

    While (TempXP > FNextLvlXP) Do
    Begin
        TempXp := TempXp - FNextLvlXP;
        FNextLvlXP := Trunc(XPIncrease * FNextLvlXP);
        FNextLvlHP := Trunc(HPIncrease * FNextLvlHP);
        Inc(FCurentLvl);
    End;
    If (TempXP < 0) Then
        TempXP := 0;
    FXP := TempXp;

    If (TempHP > FNextLvlHP) Then
        FHP := FNextLvlHP
    Else
        If (TempHp < 0) Then
        Begin
            FNextLvlXP := Trunc(FNextLvlXP / XPIncrease);
            FXP := (FNextLvlXP * 2) Div 3;
            FNextLvlHP := Trunc(FNextLvlHP / HPIncrease);
            FHP := (FNextLvlHp * 2) Div 3;
            Dec(FCurentLvl);
        End
        Else
            FHP := TempHp;

    FHPBust := 0;
    FXPBust := 0;
    FCoinsBust := 0;
End;

Procedure TUser.InputDataInField(UserInfo: TUserInfo);
Type
    TArrOfLabel = Array [0 .. 7] Of TLabel;
Var
    BustsLabels: TArrOfLabel;
    I: TUser.TBusts;
    J: Integer;
Begin
    BustsLabels[0] := TaskListForm.HPFrame.CountLabel;
    BustsLabels[1] := TaskListForm.XPFrame.CountLabel;
    BustsLabels[2] := TaskListForm.HPBustFrame.CountLabel;
    BustsLabels[3] := TaskListForm.XPBustFrame.CountLabel;
    BustsLabels[4] := TaskListForm.CoinsFrame.CountLabel;
    BustsLabels[5] := TaskListForm.TotemFrame.CountLabel;
    BustsLabels[6] := TaskListForm.FreeTaskFrame.CountLabel;
    BustsLabels[7] := TaskListForm.SecretboxFrame.CountLabel;

    FCurentLvl := UserInfo.Lvl;
    FXP := UserInfo.XP;
    FHP := UserInfo.HP;
    FCoins := UserInfo.Coins;
    FBustBought := UserInfo.BustBought;
    ApplyNewTask(UserInfo.XPBust, UserInfo.HPBust, UserInfo.CoinsBust);
    FFreeTaskUsed := UserInfo.FreeTaskUsed;
    FBustsBuyCount := UserInfo.BustsBuyCount;

    If (FFreeTaskUsed) Then
    Begin
        TaskListForm.FreeTaskVImage.Visible := True;
        TaskListForm.FreeTaskVImage.Hint := '0, 0, 0: Автоматически примениться при просрочке задачи.';
    End;

    If (FCoinsBust <> 0) Then
    Begin
        TaskListForm.ShowCoinsBustVImage.Visible := True;
        TaskListForm.ShowCoinsBustVImage.Hint := '+' + IntToStr(FCoinsBust) + ' к монетам: бонус примениться при завершении любой задачи.';
    End;

    If (FHPBust <> 0) Then
    Begin
        TaskListForm.ShowHPBustVImage.Visible := True;
        TaskListForm.ShowHPBustVImage.Hint := '+' + IntToStr(FHPBust) + ' к здоровью: бонус примениться при завершении любой задачи.';
    End;

    If (FXPBust <> 0) Then
    Begin
        TaskListForm.ShowXPBustVImage.Visible := True;
        TaskListForm.ShowXPBustVImage.Hint := '+' + IntToStr(FXPBust) + ' к опыту: бонус примениться при завершении любой задачи.';
    End;

    For I := Low(TUser.TBusts) To High(TUser.TBusts) Do
        For J := 1 To FBustBought[I] Do
        Begin
            FBustBought[I] := FBustBought[I] - 1;
            User.BuyBust(I, BustsLabels[Ord(I)]);
        End;
End;

Function TUser.GetUserInfo(): TUserInfo;
Var
    UserInfo: TUserInfo;
Begin
    UserInfo.Lvl := FCurentLvl;
    UserInfo.XP := FXP;
    UserInfo.HP := FHP;
    UserInfo.Coins := FCoins;
    UserInfo.BustBought := FBustBought;
    UserInfo.XPBust := FXPBust;
    UserInfo.HPBust := FHPBust;
    UserInfo.CoinsBust := FCoinsBust;
    UserInfo.FreeTaskUsed := FFreeTaskUsed;
    UserInfo.BustsBuyCount := FBustsBuyCount;

    GetUserInfo := UserInfo;
End;

Procedure TUser.LoadUserDataFromFile;
Var
    UserInfo: TUserInfo;
Begin
    Assign(UserInfoFile, UserinfoPath);
    If Not FileExists(UserinfoPath) Then
        Rewrite(UserInfoFile)
    Else
    Begin
        Try
            Reset(UserInfoFile);
            Try
                Read(UserInfoFile, UserInfo);
                InputDataInField(UserInfo);
            Except
                TaskListForm.ErrorExit('Ошибка при загрузке данных из файла.');
                Rewrite(UserInfoFile);
            End;
        Finally
            Close(UserInfoFile);
        End;
    End;
End;

Procedure TUser.SaveUserDataInFile;
Var
    UserInfo: TUserInfo;
Begin
    UserInfo := GetUserInfo;
    Assign(UserInfoFile, UserinfoPath);
    Try
        Rewrite(UserInfoFile);
        Try
            Write(UserInfoFile, UserInfo);
        Except
            TaskListForm.ErrorExit('Ошибка при выгрузке данных в файл.');
        End;
    Finally
        Close(UserInfoFile);
    End;
End;

End.
