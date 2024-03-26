Program TaskControlManager;

uses
  Vcl.Forms,
  TasksListScreenUnit in 'TasksListScreenUnit.pas' {TaskListForm},
  NewTaskUnit in 'NewTaskUnit.pas' {NewTaskForm},
  Vcl.Themes,
  Vcl.Styles,
  StoreUnit in 'StoreUnit.pas' {StoreForm},
  ButtonFrame in 'ButtonFrame.pas' {Frame1: TFrame},
  SettingsUnit in 'SettingsUnit.pas' {Form1};

{$R *.res}

Begin
    Application.Initialize;
    Application.MainFormOnTaskbar := True;
    Application.CreateForm(TTaskListForm, TaskListForm);
  Application.CreateForm(TStoreForm, StoreForm);
  Application.CreateForm(TForm1, Form1);
  Application.Run;

End.
