class NeovimClient
  class << self
    def open(todo_uuid)
      client = attach
      path = File.join(TodoList.todotxt_markdown_dir, "#{todo_uuid}.md")
      begin
        client.command("e #{path}")
      rescue StandardError
        # 編集中の場合別のファイルを開こうとしてエラーになる。その場合は今開いているものを強制保存してから今回のファイルを開く
        client.command('w!')
        client.command("e #{path}")
      end
    end

    private

    def attach
      Neovim.attach_unix(ENV.fetch('NVIM_LISTEN_ADDRESS', '/tmp/nvim.sock'))
    end
  end
end
