class Projects::TodosController < ApplicationController
  def index
    @project = params[:project_id]
    todo_list = TodoList.new
    @todos = todo_list.by_project[@project] || []
  end
end
