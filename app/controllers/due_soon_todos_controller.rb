class DueSoonTodosController < ApplicationController
  def index
    todo_list = TodoList.new
    @due_soon_todos = todo_list.due_soon
  end
end
