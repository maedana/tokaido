# frozen_string_literal: true

class Todos::TodoComponent < ViewComponent::Base
  with_collection_parameter :todo

  def initialize(todo:, list_key:)
    @todo = todo
    @list_key = list_key
  end
end
