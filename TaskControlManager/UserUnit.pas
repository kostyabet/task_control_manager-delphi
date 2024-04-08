Unit UserUnit;

Interface

Uses
    System.SysUtils,
    Vcl.Forms,
    Vcl.StdCtrls,
    TaskUnit;

Type
    TPercent = 0 .. 100;

    TUser = Class
    Const
        { начальные значения опыта и здоровья }
        StartXP: Int64 = 50;
        StartHP: Int64 = 25;

        { базовые расценки лёгкой задачи }
        EazyTaskXP: Int64 = 10;
        EazyTaskHP: Int64 = 3;
        EazyTaskMoney: Int64 = 5;

        { базовые расценки средней задачи }
        MediumTaskXP: Int64 = 15;
        MediumTaskHP: Int64 = 5;
        MediumTaskMoney: Int64 = 7;

        { базовые расценки тяжёлой задачи }
        HardTaskXP: Int64 = 20;
        HardTaskHP: Int64 = 7;
        HardTaskMoney: Int64 = 10;

        { коэфициенты }
        EndTimeKoef: Double = 0.6;
        AwardIncrease: Double = 0.1;
        XPIncrease: Double = 1.1;
        HPIncrease: Double = 1.05;
        CostsIncrease: Double = 1.1;

        { стартовые цены бонусов }
        HPCost: Int64 = 50;
        XPCost: Int64 = 75;
        HPBustCost: Int64 = 20;
        XPBustCost: Int64 = 30;
        CoinsBustCost: Int64 = 20;
        TothemBustCost: Int64 = 100;
        FreeTaskBust: Int64 = 80;
        SecretBox: Int64 = 70;

        { расценка бонусов }
        HPBonus: Int64 = 15;
        XPBonus: Int64 = 20;
        CoinsBonus: Int64 = 5;

    Type
        TBusts = (HP, XP, HPBust, XPBust, CoinsBust, Tothem, FreeTask, SecretBox);
        TArrOfLabel = Array [Ord(TBusts.HP) .. Ord(TBusts.SecretBox)] Of TLabel;
        TBustsCost = Array [Low(TBusts) .. High(TBusts)] Of Int64;
        TBustBought = Array [Low(TBusts) .. High(TBusts)] Of Int64;

        TUserInfo = Record
            Lvl: Int64;
            XP: Int64;
            HP: Int64;
            FNextLvlXP: Int64;
            FNextLvlHP: Int64;
            Coins: Int64;
            BustBought: TBustBought;
            XPBust: Int64;
            HPBust: Int64;
            CoinsBust: Int64;
            FreeTaskUsed: Boolean;
            BustsBuyCount: Int64;
        End;

        TUserFile = File Of TUserInfo;

    Const
        UserinfoPath: String = 'userinfo.txt';

    Var
        FArrOfLabel: TArrOfLabel;
        FCurentLvl: Int64;
        FXP: Int64;
        FNextLvlXP: Int64;
        FHP: Int64;
        FNextLvlHP: Int64;
        FCoins: Int64;
        FBustsCost: TBustsCost;
        FBustsBuyCount: Int64;
        FBustBought: TBustBought;
        FXPBust: Int64;
        FHPBust: Int64;
        FCoinsBust: Int64;
        FFreeTaskUsed: Boolean;
        FIsTotemUsed: Boolean;
        UserInfoFile: TUserFile;
    Private
        Function CalculateAwards(Task: TTask; EasyVal, MediumVal, HardVal: Int64): Int64;
        Function SearchCoef(Increase: Double): Double;
        Function FindCost(StartVal: Int64): Int64;
        Function SearchCurentValOnLvl(Start: Int64; Increase: Double): Int64;
        Function GetUserInfo(): TUserInfo;
        Function CheckXP(TempXP: Int64): Int64;
        Function CheckHP(TempHP: Int64): Int64;
        Procedure InputDataInField(UserInfo: TUserInfo);
        Procedure CheckBonuses(XP_Val, HP_Val, Coins_Val: Int64; Var TempXP, TempHP: Int64);
        Procedure CheckUsedBonuses();
        Procedure InputBoughtBonusesInfo();
        Procedure UseHp;
        Procedure UseXP;
        Procedure UseHPBust;
        Procedure UseXPBust;
        Procedure UseCoinsBust;
        Procedure UseFreeTask;
    Public
        Function GetTaskMoney(Task: TTask): Int64;
        Function GetTaskXP(Task: TTask): Int64;
        Function GetTaskHP(Task: TTask): Int64;

        Function GetHpPersent(): TPercent;
        Function GetXpPersent(): TPercent;
        Function GetBustsCost(): TBustsCost;
        Procedure UseBust(TypeOfBust: TBusts; CountLabel: TLabel);

        Procedure ApplyTask(XP_Val, HP_Val, Coins_Val: Int64);
        Procedure BuyBust(TypeOfBust: TBusts; CountLabel: TLabel);
        Procedure SaveUserDataInFile;
        Procedure LoadUserDataFromFile;

        Function IsCanBuy(ItemCost: Int64): Boolean;

        Property CurentLvl: Int64 Read FCurentLvl;
        Property Coins: Int64 Read FCoins;
        Property HP: Int64 Read FHP;
        Property XP: Int64 Read FXP;
        Property MaxHP: Int64 Read FNextLvlHP;
        Property MaxXP: Int64 Read FNextLvlXP;
        Property BustBought: TBustBought Read FBustBought Write FBustBought;
        Property FreeTaskUsed: Boolean Read FFreeTaskUsed Write FFreeTaskUsed;
        Property IsTotemUsed: Boolean Read FIsTotemUsed Write FIsTotemUsed;
        Property ArrOfLabel: TArrOfLabel Read FArrOfLabel;
        Constructor Create;
    End;

Implementation

Uses
    TasksListScreenUnit,
    SecretBoxUnit,
    ColorsUnit;

{ использование бутелька здоровья }
Procedure TUser.UseHp();
Begin
    FHP := FHP + HPBonus;
    If FHP > FNextLvlHP Then
        FHP := FNextLvlHP;
End;

{ использование бутелька опыта }
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

{ поиск текущего коэфициента }
Function TUser.SearchCoef(Increase: Double): Double;
Var
    Coef: Double;
    I: Integer;
Begin
    Coef := 1;
    For I := 1 To FCurentLvl Do
        Coef := Coef + Coef * Increase;

    SearchCoef := Coef;
End;

{ использование бонуса на повышение здоровья }
Procedure TUser.UseHPBust;
Var
    Coef: Real;
Begin
    Coef := SearchCoef(AwardIncrease);

    FHPBust := FHPBust + Trunc(HPBonus * Coef);
End;

{ использование бонуса на повышение опыта }
Procedure TUser.UseXPBust;
Var
    Coef: Real;
Begin
    Coef := SearchCoef(AwardIncrease);

    FXPBust := FXPBust + Trunc(XPBonus * Coef);
End;

{ использование бонуса на повышение здоровья }
Procedure TUser.UseCoinsBust;
Var
    Coef: Real;
Begin
    Coef := SearchCoef(AwardIncrease);

    FCoinsBust := FCoinsBust + Trunc(CoinsBonus * Coef);
End;

{ использование бонуса обнуления просроченой задачи }
Procedure TUser.UseFreeTask();
Begin
    FFreeTaskUsed := True;
End;

{ процедура распределения выбранного бонуса }
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

{ проверка на возможность покупки }
Function TUser.IsCanBuy(ItemCost: Int64): Boolean;
Begin
    IsCanBuy := FCoins >= ItemCost;
End;

{ высчитывание необходимого значения по характеристикам }
Function TUser.SearchCurentValOnLvl(Start: Int64; Increase: Double): Int64;
Var
    I: Int64;
    Val: Double;
Begin
    Val := Start;
    For I := 2 To FCurentLvl Do
        Val := Val * Increase;

    SearchCurentValOnLvl := Trunc(Val);
End;

{ инициализация через конструктор }
Constructor TUser.Create;
Begin
    { инициализация массива frame-ов о бонусах }
    FArrOfLabel[0] := TaskListForm.HPFrame.CountLabel;
    FArrOfLabel[1] := TaskListForm.XPFrame.CountLabel;
    FArrOfLabel[2] := TaskListForm.HPBustFrame.CountLabel;
    FArrOfLabel[3] := TaskListForm.XPBustFrame.CountLabel;
    FArrOfLabel[4] := TaskListForm.CoinsFrame.CountLabel;
    FArrOfLabel[5] := TaskListForm.TotemFrame.CountLabel;
    FArrOfLabel[6] := TaskListForm.FreeTaskFrame.CountLabel;
    FArrOfLabel[7] := TaskListForm.SecretboxFrame.CountLabel;

    { инициализация необходимых базовых переменных }
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
End;

{ покупка бонуса }
Procedure TUser.BuyBust(TypeOfBust: TBusts; CountLabel: TLabel);
Begin
    FCoins := FCoins - FBustsCost[TypeOfBust];
    Inc(FBustBought[TypeOfBust]);
    Inc(FBustsBuyCount);
    TaskListForm.ChangeBustsCounter(CountLabel, TypeOfBust);
End;

{ поиск цены }
Function TUser.FindCost(StartVal: Int64): Int64;
Var
    I: Int64;
    ResVal: Double;
Begin
    ResVal := StartVal;
    For I := 1 To FBustsBuyCount Do
        ResVal := ResVal * CostsIncrease;
    FindCost := Trunc(ResVal);
End;

{ функция получения всех цен бонусов }
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

{ функция расчитывания цены задачи }
Function TUser.CalculateAwards(Task: TTask; EasyVal, MediumVal, HardVal: Int64): Int64;
Const
    HalfCoef: Integer = 2;
Var
    Coef, ResVal: Real;
    CurentDate: TDate;
Begin
    Coef := SearchCoef(AwardIncrease);

    { разветвление в зависимости от сложности }
    Case Task.FTaskData.Complexity Of
        Easy:
            ResVal := EasyVal * Coef;
        Medium:
            ResVal := MediumVal * Coef;
    Else
        ResVal := HardVal * Coef;
    End;

    { проверка задачи по сроку выполнения }
    CurentDate := Date + EncodeTime(0, 0, 0, 0);
    If (Task.FTaskData.Date < CurentDate) Then
        ResVal := -1 * (ResVal / HalfCoef);

    CalculateAwards := Trunc(ResVal);
End;

{ получения текущих монет }
Function TUser.GetTaskMoney(Task: TTask): Int64;
Begin
    GetTaskMoney := CalculateAwards(Task, EazyTaskMoney, MediumTaskMoney, HardTaskMoney);
End;

{ получения текущего опыта }
Function TUser.GetTaskXP(Task: TTask): Int64;
Begin
    GetTaskXP := CalculateAwards(Task, EazyTaskXP, MediumTaskXP, HardTaskXP);
End;

{ получения текущего здоровья }
Function TUser.GetTaskHP(Task: TTask): Int64;
Begin
    GetTaskHP := CalculateAwards(Task, EazyTaskHP, MediumTaskHP, HardTaskHP);
End;

{ получение процентного соотношения здоровья }
Function TUser.GetHpPersent: TPercent;
Begin
    GetHpPersent := Trunc((FHP / FNextLvlHP) * 100);
End;

{ получение процентного соотношения опыта }
Function TUser.GetXpPersent: TPercent;
Begin
    GetXpPersent := Trunc((FXP / FNextLvlXP) * 100);
End;

{ проверка на использование бонуса }
Procedure TUser.CheckBonuses(XP_Val, HP_Val, Coins_Val: Int64; Var TempXP, TempHP: Int64);
Begin
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
End;

{ рассчитывание нового опыта }
Function TUser.CheckXP(TempXP: Int64): Int64;
Begin
    { пока текущий опыт больше границы }
    While (TempXP >= FNextLvlXP) Do
    Begin
        TempXp := TempXp - FNextLvlXP; //уменшаем опыт
        FNextLvlXP := Trunc(XPIncrease * FNextLvlXP);
        FNextLvlHP := Trunc(HPIncrease * FNextLvlHP);
        Inc(FCurentLvl); //увеличиваем уровень
    End;
    { проверяем на знак }
    TempXP := Ord(Not(TempXP < 0)) * TempXP;
    { инициализируем результат }
    CheckXP := TempXP;
End;

{ рассчитывание нового здоровья }
Function TUser.CheckHP(TempHP: Int64): Int64;
Var
    Res: Int64;
Begin
    If (TempHP > FNextLvlHP) Then
        Res := FNextLvlHP
    Else
        If (TempHp < 0) And (CurentLvl > 1) Then
        Begin
            FNextLvlXP := Trunc(FNextLvlXP / XPIncrease);
            FXP := (FNextLvlXP * 2) Div 3;
            FNextLvlHP := Trunc(FNextLvlHP / HPIncrease);
            Res := (FNextLvlHp * 2) Div 3;
            Dec(FCurentLvl);
        End
        Else
            If (CurentLvl = 1) Then
                Res := 0
            Else
                Res := TempHp;

    CheckHP := Res;
End;

{ применение новой задачи }
Procedure TUser.ApplyTask(XP_Val, HP_Val, Coins_Val: Int64);
Var
    TempHp, TempXp: Int64;
Begin
    { присваивание начальных значений из ныне имеющихся }
    TempXP := FXP;
    TempHP := FHP;
    { проверка на возможность и необходимость использования бонусов }
    CheckBonuses(XP_Val, HP_Val, Coins_Val, TempXP, TempHP);
    { изменение монет }
    FCoins := Ord(Not(FCoins < 0)) * FCoins;
    { изменение опыта }
    FXP := CheckXP(TempXp);
    { изменение здоровья }
    FHP := CheckHP(TempHp);
    { обнуление бонусов }
    FHPBust := 0;
    FXPBust := 0;
    FCoinsBust := 0;
End;

{ заполнение информации об активированных бонусах }
Procedure TUser.CheckUsedBonuses();
Begin
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
End;

{ заполенение информации о купленых бонусах }
Procedure TUser.InputBoughtBonusesInfo();
Var
    I: TUser.TBusts;
    J: Integer;
Begin
    For I := Low(TBusts) To High(TBusts) Do
        For J := 1 To FBustBought[I] Do
        Begin
            FBustBought[I] := FBustBought[I] - 1;
            User.BuyBust(I, FArrOfLabel[Ord(I)]);
        End;
End;

{ заполнение информации полученной из файла }
Procedure TUser.InputDataInField(UserInfo: TUserInfo);
Begin
    FCurentLvl := UserInfo.Lvl;
    FXP := UserInfo.XP;
    FHP := UserInfo.HP;
    FNextLvlXP := UserInfo.FNextLvlXP;
    FNextLvlHP := UserInfo.FNextLvlHP;
    FCoins := UserInfo.Coins;
    FBustBought := UserInfo.BustBought;
    ApplyTask(0, 0, 0);
    FXPBust := UserInfo.XPBust;
    FHPBust := UserInfo.HPBust;
    FCoinsBust := UserInfo.CoinsBust;
    FFreeTaskUsed := UserInfo.FreeTaskUsed;
    FBustsBuyCount := UserInfo.BustsBuyCount;
    CheckUsedBonuses;
    InputBoughtBonusesInfo;
End;

{ получение пользовательской информации }
Function TUser.GetUserInfo(): TUserInfo;
Var
    UserInfo: TUserInfo;
Begin
    UserInfo.Lvl := FCurentLvl;
    UserInfo.XP := FXP;
    UserInfo.HP := FHP;
    UserInfo.FNextLvlXP := FNextLvlXP;
    UserInfo.FNextLvlHP := FNextLvlHP;
    UserInfo.Coins := FCoins;
    UserInfo.BustBought := FBustBought;
    UserInfo.XPBust := FXPBust;
    UserInfo.HPBust := FHPBust;
    UserInfo.CoinsBust := FCoinsBust;
    UserInfo.FreeTaskUsed := FFreeTaskUsed;
    UserInfo.BustsBuyCount := FBustsBuyCount;

    GetUserInfo := UserInfo;
End;

{ загрузка данных пользователя из файла }
Procedure TUser.LoadUserDataFromFile;
Var
    UserInfo: TUserInfo;
Begin
    { инициализация файла }
    Assign(UserInfoFile, UserinfoPath);
    If Not FileExists(UserinfoPath) Then //если файл не создан
        Rewrite(UserInfoFile)//создаём его
        { иначе считываем }
    Else
    Begin
        Try
            { подготавливаем к чтению }
            Reset(UserInfoFile);
            Try
                { читаем из файла }
                Read(UserInfoFile, UserInfo);
                { используем полученую информацию }
                InputDataInField(UserInfo);
            Except
                { вызовется в случае ошибки считывания }
                TaskListForm.ErrorExit('Ошибка при загрузке данных из файла.', 'Загрузка');
                Rewrite(UserInfoFile); //создаст пустой файл
            End;
        Finally
            //закрываем далее ненужный файл
            Close(UserInfoFile);
        End;
    End;
End;

{ загрузка данных пользователя в файла }
Procedure TUser.SaveUserDataInFile;
Var
    UserInfo: TUserInfo;
Begin
    { получаем запись информации пользователя }
    UserInfo := GetUserInfo;
    { инициализируем фалй }
    Assign(UserInfoFile, UserinfoPath);
    Try
        { очищаем всё, что есть в файле }
        Rewrite(UserInfoFile);
        Try
            { записываем данные в файл }
            Write(UserInfoFile, UserInfo);
        Except
            { вызывается при ошибке записи в файл }
            TaskListForm.ErrorExit('Ошибка при записи данных в файл.', 'Запись');
        End;
    Finally
        { очищаем далее не нужный файл }
        Close(UserInfoFile);
    End;
End;

End.
