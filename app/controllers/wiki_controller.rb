class WikiController < ApplicationController
  def index
    @wiki = Wiki.where(user_id: current_user.id).all
  end

  def new
    @wiki = Wiki.new
  end

  def create
    wiki = permited_params
    wiki[:user_id] = current_user.id
    @wiki= Wiki.create(wiki)

    if @wiki.persisted?
      redirect_to url_for(controller: :wiki, action: :index), flash: {success: "#{params[:wiki][:name]}を作成しました"}
    else
      render action: :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def permited_params
    params.require(:wiki).permit(:name, :slug, :description)
  end
end
