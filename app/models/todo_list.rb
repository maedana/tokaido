class TodoList
  class << self
    def todotxt_dir
      @todotxt_dir ||= ENV.fetch('TODOTXT_DIR', "#{ENV.fetch('HOME')}/todotxt")
    end

    def todotxt_path
      @todotxt_path ||= File.join(todotxt_dir, 'todo.txt')
    end

    def todotxt_markdown_dir
      @todotxt_markdown_dir ||= File.join(TodoList.todotxt_dir, 'todos')
    end
  end

  def all
    todos
  end

  def find(uuid)
    todos.find { |todo| todo.tags[:id] == uuid }
  end

  def by_project
    @by_project ||=
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

  def projects
    todos.map(&:projects).flatten.uniq.sort
  end

  def has_overdue?
    overdue.present?
  end

  def has_due_soon?
    due_soon.present?
  end

  # todo.txtフォーマットを拡張し、各todo識別のためのuuuidをtagとして付与
  def setup
    raw_task_with_ids = raw_tasks.map do |raw_task|
      task = Todo::Task.new(raw_task)
      if task.tags[:id].blank?
        [raw_task, "id:#{SecureRandom.uuid}"].join(' ')
      else
        raw_task
      end
    end
    return if raw_task_with_ids == raw_tasks

    # 変更があったときだけ保存
    File.open(TodoList.todotxt_path, File::RDWR) do |f|
      # MEMO: 同時アクセスでのファイル消失を防ぐためロックをかけている
      # see also https://docs.ruby-lang.org/ja/latest/method/File/i/flock.html
      # 上記にもある通り、モードwを使うと実際に消失した
      f.flock(File::LOCK_EX)
      f.write(raw_task_with_ids.join("\n"))
    end
  end

  private

  def todos
    @todos ||= Todo::List.new(raw_tasks).reject(&:done?).sort
  end

  def raw_tasks
    @raw_tasks ||= File.open(TodoList.todotxt_path, 'r') do |f|
      # MEMO: 同時アクセスでのファイル消失を防ぐためロックをかけている
      # see also https://docs.ruby-lang.org/ja/latest/method/File/i/flock.html
      f.flock(File::LOCK_SH)
      f.read
    end.split("\n")
  end
end
