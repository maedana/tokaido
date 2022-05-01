class TodosController < ApplicationController
  def index
    @todos = Todo::List.new('/home/maedana/todotxt/todo.txt')
  end
end
