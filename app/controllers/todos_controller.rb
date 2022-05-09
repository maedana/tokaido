class TodosController < ApplicationController
  def index
    @todo_list = TodoList.new
    @todos = @todo_list.all
    @projects = @todo_list.projects
  end

  def edit
    todo_uuid = params[:id]
    NeovimClient.open(todo_uuid)
    head :ok
  rescue StandardError => e
    Rails.logger.debug(e.backtrace.join("\n"))
    head :internal_server_error, message: 'Could not open file on Neovim.'
  end

  def save_elapsed_time
    todo_uuid = params[:id]
    @todo = TodoList.new.find(todo_uuid)
    head :not_found unless @todo

    daily_elapsed_time = DailyElapsedTime.find_or_initialize_by(uuid: todo_uuid, target_date: Date.current)
    # MEMO: 失敗は一旦考慮しない
    daily_elapsed_time.update(daily_elapsed_time_params)
  end

  def complete
    TodoList.new.do!(params[:id])
    head :ok
  end

  private

  def daily_elapsed_time_params
    params.require(:daily_elapsed_time).permit(:todo, :elapsed_seconds)
  end
end
