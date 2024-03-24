program TaskControlManager;

uses
  Vcl.Forms,
  TasksListScreenUnit in 'TasksListScreenUnit.pas' {TaskListForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TTaskListForm, TaskListForm);
  Application.Run;
end.
