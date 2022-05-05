class TodoList
  include ActiveModel::Model
  include Turbo::Broadcastable

  class << self
    def todotxt_dir
      @todotxt_dir ||= ENV.fetch('TODOTXT_DIR', "#{ENV.fetch('HOME')}/todotxt")
    end

    def todotxt_path
      @todotxt_path ||= File.join(todotxt_dir, 'todo.txt')
    end

    def donetxt_path
      @donetxt_path ||= File.join(todotxt_dir, 'done.txt')
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

  def do!(uuid)
    raw_todo_tasks = []
    raw_done_tasks = []
    raw_tasks.each do |raw_task|
      task = Todo::Task.new(raw_task)
      if task.tags[:id] == uuid
        task.do!
        raw_done_tasks << task.to_s
      else
        raw_todo_tasks << raw_task
      end
    end
    return if raw_todo_tasks == raw_tasks

    save_todo(raw_todo_tasks)

    # doneは追記でファイルの内容を空にしたりはしないのでロックを加味してもaでよい
    File.open(TodoList.donetxt_path, 'a') do |f|
      f.flock(File::LOCK_EX)
      f.puts(raw_done_tasks.join("\n"))
    end
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

    save_todo(raw_task_with_ids)
  end

  def broadcast_to_dashboard
    broadcast_update_to(
      'todos',
      target: 'dashboard',
      partial: 'todos/dashboard',
      locals: { todo_list: self, todos: self.all, projects: self.projects }
    )
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

  def save_todo(rows)
    # MEMO: 同時アクセスでのファイル消失を防ぐためロックをかけている
    # see also https://docs.ruby-lang.org/ja/latest/method/File/i/flock.html
    # 上記にもある通り、モードwを使うとロック前に中身を空っぽにしてしまい、タイミングによって消失すつため、RDWRにし、自前で書き込み位置やファイルサイズの調整をしている
    File.open(TodoList.todotxt_path, File::RDWR) do |f|
      f.flock(File::LOCK_EX)
      f.rewind
      f.puts(rows.join("\n"))
      f.flush
      f.truncate(f.pos)
    end
  end
end
