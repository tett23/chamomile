class Api::PagesController < ApplicationController
  def recent
    render json: Page.recent_edit(current_user.id).all.to_json
  end
end
