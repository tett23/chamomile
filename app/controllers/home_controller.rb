class HomeController < ApplicationController
  def index
    @pages = Page.recent_edit(current_user.id).all
  end
end
