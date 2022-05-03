class TodosController < ApplicationController
  def index
    todo_list = TodoList.new
    @todos = todo_list.all
    @todos_by_project = todo_list.by_project
    @overdue_todos = todo_list.overdue
    @due_soon_todos = todo_list.due_soon
  end

  def edit
    todo_uuid = params[:id]
    client = Neovim.attach_unix('/tmp/nvim.sock')
    client.command("e /home/maedana/todotxt/todos/#{todo_uuid}.md")
    head :ok
  end
end
