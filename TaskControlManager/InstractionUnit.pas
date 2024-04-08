Unit InstractionUnit;

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
    Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.VirtualImage;

Type
    TInstractionForm = Class(TForm)
    InstractionFontPBox: TPaintBox;
    HeadLineLabel: TLabel;
    AboutNewTaskLabel: TLabel;
    ComplexityLabel: TLabel;
    StoreLabel: TLabel;
    VirtualImage1: TVirtualImage;
    Label1: TLabel;
    VirtualImage2: TVirtualImage;
    Label2: TLabel;
    VirtualImage3: TVirtualImage;
    Label3: TLabel;
    VirtualImage4: TVirtualImage;
    Label4: TLabel;
    VirtualImage5: TVirtualImage;
    Label5: TLabel;
    VirtualImage6: TVirtualImage;
    Label6: TLabel;
    VirtualImage7: TVirtualImage;
    Label7: TLabel;
    VirtualImage8: TVirtualImage;
    Label8: TLabel;
    AboutBonusesLabel: TLabel;
    AnotherLabel: TLabel;
    VirtualImage9: TVirtualImage;
    VirtualImage10: TVirtualImage;
    VirtualImage11: TVirtualImage;
    EndLabel: TLabel;
    procedure InstractionFontPBoxPaint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Var
    InstractionForm: TInstractionForm;

Implementation

{$R *.dfm}

uses ColorsUnit, TasksListScreenUnit, TaskUnit;

procedure TInstractionForm.FormCreate(Sender: TObject);
begin
    InstractionForm.Color := ClFont;
    HeadLineLabel.Caption := 'Task Control Manager - приложение, которое призвано побороть вашу лень! Мы опираемся на вашу мотивацию, при этом помогая ей не уга-' + 
    #13#10'сать. Делаем мы это добавляя в простой планировщик игровую ношу, которая даёт пользователю ощущение игры во время выполнения своих'#13#10'задач.';
    AboutNewTaskLabel.Caption := 'Новая задача добавляется на кнопку ''' + TaskListForm.AddTaskFrame.ButtonText.Caption + '''. Вы можете выставить: название задачи; дата; сложность. Это обязательные пункты,' + 
    #13#10'но так же вы можете добавить описание задачи и подзадачи (максимальное кол-во подзадач: ' + IntToStr(SubTasksLimit) + ').';
    ComplexityLabel.Caption := 'Существует 3 сложности задачи: лёгкая, средняя, тяжелая. В зависимости от сложности, вы получите больше игровых бонусов. Если вы не выпо-' + 
    #13#10'лнили задачу в срок - у вас отнимают столько игровых бонусов, сколько вы должны были получить.';
    StoreLabel.Caption := 'Магазин - место, где вы можете поощрить себя. В магазине есть 8 видов бонусов. Расскажем о каждом из них:';
    AboutBonusesLabel.Caption := 'По наведению курсора на бонус вам выпадет подсказка о том, что этот бонус делает.';
    AnotherLabel.Caption := 'Дополнительные возможности:'#13#10 +
    '   - По двойному нажатию на задачу вы откроете редактирование задачи;'#13#10 +
    '   - По наведению на любой бонус вы получите подсказку о том, что он делает;'#13#10 +
    'От уровня к уровню ваши показатели будут рости. Если ваше здоровье будет меньше 0, то ваш уровень понизится на 1-ну позицию.';
    EndLabel.Caption := 'Помните. Это приложение нацелено на самодисциплину пользователя. Мы стимулируем вашу мотивацию к выполнению задач добавляя игро-'#13#10 +
    'вой момент и стримимся это сделать так, как того требуют текущие тренды. Приятного Вам использования!!!';
end;

procedure TInstractionForm.InstractionFontPBoxPaint(Sender: TObject);
Const
    RADIUS: Integer = 30;
    PEN_WIDTH: Integer = 10;
Var
    Rect: TRect;
Begin
    Rect := InstractionFontPBox.ClientRect;
    InstractionFontPBox.Canvas.Brush.Color := ClBackgroundBrush;
    InstractionFontPBox.Canvas.Pen.Color := ClBackgroundPen;
    InstractionFontPBox.Canvas.Pen.Width := PEN_WIDTH;
    InstractionFontPBox.Canvas.RoundRect(Rect.Left, Rect.Top, Rect.Right, Rect.Bottom, RADIUS, RADIUS);
end;

End.
