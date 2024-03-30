Program TaskControlManager;

uses
  Vcl.Forms,
  TasksListScreenUnit in 'TasksListScreenUnit.pas' {TaskListForm},
  NewTaskUnit in 'NewTaskUnit.pas' {NewTaskForm},
  Vcl.Themes,
  Vcl.Styles,
  StoreUnit in 'StoreUnit.pas' {StoreForm},
  ButtonFrame in 'ButtonFrame.pas' {Frame1: TFrame},
  SettingsUnit in 'SettingsUnit.pas' {Form1},
  TaskUnit in 'TaskUnit.pas',
  ViewControllerUnit in 'ViewControllerUnit.pas',
  InstractionUnit in 'InstractionUnit.pas' {InstractionForm},
  ProfileUnit in 'ProfileUnit.pas' {ProfileForm},
  TasksLinkedListUnit in 'TasksLinkedListUnit.pas',
  ViewSubTasksUnit in 'ViewSubTasksUnit.pas' {SubTasksForm},
  ChangeDataUnit in 'ChangeDataUnit.pas' {ChangeDataForm},
  TaskFrame in 'TaskFrame.pas' {TaskOutputFrame: TFrame},
  UserUnit in 'UserUnit.pas';

{$R *.res}

Begin
    Application.Initialize;
    Application.MainFormOnTaskbar := True;
    Application.CreateForm(TTaskListForm, TaskListForm);
  Application.CreateForm(TStoreForm, StoreForm);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TInstractionForm, InstractionForm);
  Application.CreateForm(TProfileForm, ProfileForm);
  Application.Run;

End.
