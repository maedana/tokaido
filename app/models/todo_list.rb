class TodoList
  class << self
    def todotxt_dir
      @todotxt_dir ||= ENV.fetch('TODOTXT_DIR')
    end

    def todotxt_path
      @todotxt_path ||= File.join(todotxt_dir, 'todo.txt')
    end
  end

  def all
    todos
  end

  def by_project
    projects = todos.map(&:projects).flatten.uniq.sort
    {}.tap do |h|
      projects.each do |project|
        h[project] = todos.select { |todo| todo.projects.include?(project) }
      end
    end
  end

  def overdue
    todos.select(&:overdue?).sort_by(&:due_on)
  end

  def due_soon
    todos.reject(&:overdue?).select { |t| t.due_on && t.due_on < 7.days.since }.sort_by(&:due_on)
  end

  private

  def todos
    setup
    @todos ||= Todo::List.new(TodoList.todotxt_path).reject(&:done?).sort
  end

  def setup
    raw_tasks = File.read(TodoList.todotxt_path).split("\n")
    raw_task_with_ids = raw_tasks.map do |raw_task|
      task = Todo::Task.new(raw_task)
      if task.tags[:id].blank?
        [raw_task, "id:#{SecureRandom.uuid}"].join(' ')
      else
        raw_task
      end
    end
    File.write(TodoList.todotxt_path, raw_task_with_ids.join("\n"), mode: 'w')
  end
end
