class ApplicationController < ActionController::Base
  before_action :set_neovim_available

  private def set_neovim_available
    @neovim_available = NeovimClient.available?
  end
end
