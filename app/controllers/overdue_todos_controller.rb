class OverdueTodosController < ApplicationController
  def index
    todo_list = TodoList.new
    @overdue_todos = todo_list.overdue
  end
end
