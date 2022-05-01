class TodosController < ApplicationController
  def index
    @todos = TodoList.all
    @todos_by_project = TodoList.by_project
  end
end
