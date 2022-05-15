# frozen_string_literal: true

class Todos::DailyElapsedTimeFormComponent < ViewComponent::Base
  def initialize(todo:)
    @todo = todo
  end

  private

  def default_elapsed_time_value
    # N+1だけど一旦直接読み込み
    DailyElapsedTime.find_by(uuid: @todo.tags[:id], target_date: Date.current)&.elapsed_seconds || 0
  end
end
