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
    client = Neovim.attach_unix(ENV.fetch('NVIM_LISTEN_ADDRESS'))
    md_file_path = File.join(TodoList.todotxt_dir, 'todos', "#{todo_uuid}.md")
    client.command("e #{md_file_path}")
    head :ok
  end
end
