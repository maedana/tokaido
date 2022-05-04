class TodosController < ApplicationController
  before_action :set_nvim_client, only: %i[edit]

  def index
    todo_list = TodoList.new
    @todos = todo_list.all
    @todos_by_project = todo_list.by_project
    @overdue_todos = todo_list.overdue
    @due_soon_todos = todo_list.due_soon
  end

  def edit
    todo_uuid = params[:id]
    md_file_path = File.join(TodoList.todotxt_markdown_dir, "#{todo_uuid}.md")
    begin
      @client.command("e #{md_file_path}")
    rescue StandardError
      # 編集中の場合別のファイルを開こうとしてエラーになる。その場合は今開いているものを強制保存してから今回のファイルを開く
      @client.command('w!')
      @client.command("e #{md_file_path}")
    end
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

  def set_nvim_client
    @client = Neovim.attach_unix(ENV.fetch('NVIM_LISTEN_ADDRESS', '/tmp/nvim.sock'))
  rescue StandardError => e
    Rails.logger.debug(e.backtrace.join("\n"))
    head :internal_server_error, message: 'Could not connect to Neovim.'
  end
end
