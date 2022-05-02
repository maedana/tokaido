class TodosController < ApplicationController
  def index
    todo_list = TodoList.new
    @todos = todo_list.all
    @todos_by_project = todo_list.by_project
  end
end
