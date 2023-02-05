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

  def complete
    TodoList.new.do!(params[:id])
    head :ok
  end
end
