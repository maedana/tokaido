namespace :fake_todo do
  desc 'テストtodo生成'
  task generate: :environment do
    (1..100).each do |i|
      puts FakeTodo.new(i)
    end
  end
end

class FakeTodo
  COMPLETIONS = ['', 'x'].freeze
  PRIORITIES = ['', '(A)', '(B)', '(C)', '(D)', '(E)'].freeze
  CREATION_DATES = ((Date.current - 60)..(Date.current - 30)).to_a
  PROJECTS = %w[+prj1 +prj2 +prj3 +prj4 +prj5].freeze
  CONTEXTS = %w[@ctx1 @ctx2 @ctx3 @ctx4 @ctx5].freeze

  def initialize(index)
    @completion = COMPLETIONS.sample
    @priority = PRIORITIES.sample
    @creation_date = CREATION_DATES.sample
    @completion_date = (@completion == 'x' ? @creation_date + 3 : '')
    @description = "Test #{index}"
    @projects = (0..2).to_a.sample.times.map { PROJECTS.sample }.join(' ')
    @contexts = (0..2).to_a.sample.times.map { CONTEXTS.sample }.join(' ')
    @due_date_tag = ['', "due:#{@creation_date + (0..10).to_a.sample}"].sample
  end

  def to_s
    [
      @completion,
      @priority,
      @completion_date.to_s || '',
      @creation_date.to_s,
      @description,
      @projects,
      @contexts,
      @due_date_tag,
    ].reject(&:empty?).join(' ')
  end
end

