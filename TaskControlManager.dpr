Program TaskControlManager;

Uses
    Vcl.Forms,
    TasksListScreenUnit In 'TasksListScreenUnit.pas' {TaskListForm} ,
    NewTaskUnit In 'NewTaskUnit.pas' {NewTaskForm} ,
    Vcl.Themes,
    Vcl.Styles,
    StoreUnit In 'StoreUnit.pas' {StoreForm} ,
    ButtonFrame In 'ButtonFrame.pas' {Frame1: TFrame} ,
    TaskUnit In 'TaskUnit.pas',
    InstractionUnit In 'InstractionUnit.pas' {InstractionForm} ,
    TasksLinkedListUnit In 'TasksLinkedListUnit.pas',
    ViewSubTasksUnit In 'ViewSubTasksUnit.pas' {SubTasksForm} ,
    ChangeDataUnit In 'ChangeDataUnit.pas' {ChangeDataForm} ,
    TaskFrame In 'TaskFrame.pas' {TaskOutputFrame: TFrame} ,
    UserUnit In 'UserUnit.pas',
    BustOutputFrame In 'BustOutputFrame.pas' {BustFrame: TFrame} ,
    SecretBoxUnit In 'SecretBoxUnit.pas' {SecreteBoxForm} ,
    ColorsUnit In 'ColorsUnit.pas',
    LoadingScreenUnit In 'LoadingScreenUnit.pas' {LoadingScreen};

{$R *.res}

Begin
    Application.Initialize;
    Application.MainFormOnTaskbar := True;
    Application.CreateForm(TTaskListForm, TaskListForm);
    LoadingScreen := TLoadingScreen.Create(Application);
    LoadingScreen.Show;
    While LoadingScreen.EndLoadingScreen.Enabled Do
        Application.ProcessMessages;
    LoadingScreen.Hide;
    LoadingScreen.Free;
    Application.CreateForm(TNewTaskForm, NewTaskForm);
    Application.Run;

End.
