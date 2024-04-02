Unit SecretBoxUnit;

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
    ButtonFrame,
    Vcl.StdCtrls,
    Vcl.BaseImageCollection,
    Vcl.ImageCollection,
    Vcl.VirtualImage,
    UserUnit,
    TasksListScreenUnit,
    DateUtils;

Type
    TSecreteBoxForm = Class(TForm)
        RandomBustImage: TVirtualImage;
        ImageCollection1: TImageCollection;
        TitleLabel: TLabel;
        OpenButtonFrame: TFrame1;
        Procedure FormCreate(Sender: TObject);
        Procedure SearchRandomBust(Sender: TObject);
    Private
        Function CustomRandom: TUser.TBusts;
    Public
        { Public declarations }
    End;

Type
    TItems = Array [Low(TUser.TBusts) .. TUser.TBusts.FreeTask] Of TUser.TBusts;
    TArrOfLabel = Array [0 .. 7] Of TLabel;

Var
    SecreteBoxForm: TSecreteBoxForm;
    Costs: TUser.TBustsCost;
    BustsLabels: TArrOfLabel;
    Items: TItems = (TUser.TBusts.HP, TUser.TBusts.XP, TUser.TBusts.HPBust, TUser.TBusts.XPBust, TUser.TBusts.CoinsBust,
        TUser.TBusts.Tothem, TUser.TBusts.FreeTask);
    TotalPrice: Int64 = 0;
    RandomValue: Int64;

Implementation

{$R *.dfm}

Function TSecreteBoxForm.CustomRandom: TUser.TBusts;
Var
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

Procedure TSecreteBoxForm.FormCreate(Sender: TObject);
Var
    I: TUser.TBusts;
    MiddlePrice: Integer;
Begin
    BustsLabels[0] := TaskListForm.HPFrame.CountLabel;
    BustsLabels[1] := TaskListForm.XPFrame.CountLabel;
    BustsLabels[2] := TaskListForm.HPBustFrame.CountLabel;
    BustsLabels[3] := TaskListForm.XPBustFrame.CountLabel;
    BustsLabels[4] := TaskListForm.CoinsFrame.CountLabel;
    BustsLabels[5] := TaskListForm.TotemFrame.CountLabel;
    BustsLabels[6] := TaskListForm.FreeTaskFrame.CountLabel;
    BustsLabels[7] := TaskListForm.SecretboxFrame.CountLabel;
    SecreteBoxForm.Color := RGB(202, 205, 221);
    Costs := User.GetBustsCost();
    MiddlePrice := 0;
    For I := Low(TUser.TBusts) To TUser.TBusts.FreeTask Do
        MiddlePrice := MiddlePrice + Costs[I];
    MiddlePrice := MiddlePrice Div Ord(TUser.TBusts.FreeTask);

    For I := Low(TUser.TBusts) To TUser.TBusts.FreeTask Do
    Begin
        If (Costs[I] > MiddlePrice) Then
            Costs[I] := Costs[I] - (Costs[I] - MiddlePrice) * 2
        Else
            Costs[I] := Costs[I] + (MiddlePrice - Costs[I]) * 2;
    End;

    For I := Low(TUser.TBusts) To TUser.TBusts.FreeTask Do
        TotalPrice := TotalPrice + Costs[I];
    RandomValue := UInt64(UInt32(SecondOf(Now)));
End;

Procedure TSecreteBoxForm.SearchRandomBust(Sender: TObject);
Var
    RandomBust: TUser.TBusts;
    TempBought: Tuser.TBustBought;
Begin
    RandomBust := CustomRandom();
    RandomBustImage.ImageIndex := Ord(RandomBust);
    User.BuyBust(RandomBust, BustsLabels[Ord(RandomBust)]);
    TempBought := User.BustBought;
    Dec(TempBought[TUser.TBusts.SecretBox]);
    User.BustBought := TempBought;
    TaskListForm.ChangeBustsCounter(BustsLabels[Ord(TUser.TBusts.SecretBox)], TUser.TBusts.SecretBox);
    OpenButtonFrame.ButtonText.Enabled := False;
    OpenButtonFrame.BackGroundVirtmage.Enabled := False;
End;

End.
