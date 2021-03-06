require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
# require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
# require "action_mailbox/engine"
# require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Tokaido
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.time_zone = 'Tokyo'
    config.i18n.default_locale = :ja
    config.i18n.available_locales = %i[ja en]

    # Don't generate system test files.
    config.generators.system_tests = nil

    config.after_initialize do
      # 必要なディレクトリ、ファイル類の作成
      FileUtils.mkdir_p(TodoList.todotxt_dir)
      FileUtils.mkdir_p(TodoList.todotxt_markdown_dir)
      FileUtils.touch(TodoList.todotxt_path) unless File.exist?(TodoList.todotxt_path)
      FileUtils.touch(TodoList.donetxt_path) unless File.exist?(TodoList.donetxt_path)
      TodoList.new.setup

      # Todoファイルの監視を行い、変更があれば即時反映
      listener = Listen.to(TodoList.todotxt_dir, only: /todo\.txt$/) do |modified|
        if modified.include?(TodoList.todotxt_path)
          todo_list = TodoList.new
          todo_list.setup
          # TurboStream(WebSocketで画面を自動更新する)
          todo_list.broadcast_to_dashboard
        end
      end
      listener.start

      at_exit do
        listener&.stop
      end
    end
  end
end
