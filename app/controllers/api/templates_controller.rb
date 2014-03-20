class Api::TemplatesController < ApplicationController
  def recent
    render action: :recent, layout: false
  end
end
