class TodosController < ApplicationController
  def index
    todo_list = TodoList.new
    @todos = todo_list.all
    @todos_by_project = todo_list.by_project
    @overdue_todos = todo_list.overdue
    @due_soon_todos = todo_list.due_soon
  end
end
