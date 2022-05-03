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

  def save_elapsed_time
    todo_uuid = params[:id]
    daily_elapsed_time = DailyElapsedTime.find_or_initialize_by(uuid: todo_uuid, target_date: Date.current)
    # MEMO: 失敗は一旦考慮しない
    daily_elapsed_time.update(daily_elapsed_time_params)
    head :ok
  end

  private

  def daily_elapsed_time_params
    params.require(:daily_elapsed_time).permit(:todo, :elapsed_seconds)
  end
end
