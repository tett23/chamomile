class PagesController < ApplicationController
  before_filter :fetch_wiki

  def index
    @page = Page.find_by(slug: 'index')

    if @page.nil?
      @page = Page.new(name: @current_wiki.name, slug: 'index', wiki_id: @current_wiki.id, body: '')
      return render :new
    end

    render :show
  end

  def show
    @page = Page.find_by_wiki_slug_and_flagment(@current_wiki.slug, params[:flagment])

    if @page.nil?
      @page = Page.new(name: params[:flagment], wiki_id: @current_wiki.id, body: '')
      render :new
    end
  end

  def create
    @page = Page.new(permited_params.merge(wiki_id: @current_wiki.id))
    @page.estimate_name()
    @page.save()

    if @page.persisted?
      redirect_to url_for(
        controller: :pages,
        action: :show,
        wiki_slug: @current_wiki.slug,
        flagment: @page.flagment
      ), flash: {success: "#{@page.name}を作成しました"}
    else
      render action: :new
    end
  end

  private
  def fetch_wiki
    @current_wiki = Wiki.find_by(slug: params[:wiki_slug])

    if @current_wiki.nil?
      render status: 404
      return false
    end
  end

  def permited_params
    params.require(:page).permit(:name, :slug, :body)
  end
end
