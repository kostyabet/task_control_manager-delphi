Program TaskControlManager;

uses
  Vcl.Forms,
  TasksListScreenUnit in 'TasksListScreenUnit.pas' {TaskListForm},
  NewTaskUnit in 'NewTaskUnit.pas' {NewTaskForm},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

Begin
    Application.Initialize;
    Application.MainFormOnTaskbar := True;
    Application.CreateForm(TTaskListForm, TaskListForm);
  Application.Run;

End.
