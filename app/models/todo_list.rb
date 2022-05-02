class TodoList
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

  private

  def todos
    @todos ||= Todo::List.new('/home/maedana/todotxt/todo.txt').reject(&:done?).sort.reverse
  end
end
