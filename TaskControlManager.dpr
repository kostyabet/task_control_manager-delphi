Program TaskControlManager;

Uses
    Vcl.Forms,
    TasksListScreenUnit In 'TasksListScreenUnit.pas' {TaskListForm} ,
    NewTaskUnit In 'NewTaskUnit.pas' {NewTaskForm} ,
    Vcl.Themes,
    Vcl.Styles,
    StoreUnit In 'StoreUnit.pas' {StoreForm} ,
    ButtonFrame In 'ButtonFrame.pas' {Frame1: TFrame} ,
    SettingsUnit In 'SettingsUnit.pas' {Form1} ,
    TaskUnit In 'TaskUnit.pas',
    InstractionUnit In 'InstractionUnit.pas' {InstractionForm} ,
    ProfileUnit In 'ProfileUnit.pas' {ProfileForm} ,
    TasksLinkedListUnit In 'TasksLinkedListUnit.pas',
    ViewSubTasksUnit In 'ViewSubTasksUnit.pas' {SubTasksForm} ,
    ChangeDataUnit In 'ChangeDataUnit.pas' {ChangeDataForm} ,
    TaskFrame In 'TaskFrame.pas' {TaskOutputFrame: TFrame} ,
    UserUnit In 'UserUnit.pas',
    BustOutputFrame In 'BustOutputFrame.pas' {BustFrame: TFrame} ,
    SecretBoxUnit In 'SecretBoxUnit.pas' {SecreteBoxForm};

{$R *.res}

Begin
    Application.Initialize;
    Application.MainFormOnTaskbar := True;
    Application.CreateForm(TTaskListForm, TaskListForm);
    Application.CreateForm(TForm1, Form1);
    Application.CreateForm(TInstractionForm, InstractionForm);
    Application.CreateForm(TProfileForm, ProfileForm);
    Application.Run;

End.
