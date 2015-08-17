class ArticlesController < ApplicationController
  
  load_and_authorize_resource
 
  respond_to :html, :pdf, :js

  before_action :set_article, only: [ :show, :edit, :update, :destroy ]

  def index
    if params[:page]
      t = params[:page]
    else
      t = 1
    end
    @articles = Article.all.paginate(page: t, per_page: 10 ).order(created_at: :desc)
  end

  def show
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
   # respond_with do |format|
      @article = Article.new(article_params)
      @article.user_id = current_user.id
      if @article.save
        pjax_redirect_to article_path(@article)
      else
        render :new
      end
    #end
  end

  def update
    @article.user_id = current_user.id
    if @article.update(article_params)
      pjax_redirect_to article_path(@article) 
    else
      render :edit
    end
  end

  def destroy
    respond_with do |format|
      if @article.destroy
        format.js
        #ArticlesMailer.article_destroyed(@article).deliver_now
      end
    end
  end

  private

    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :text, :anons)
    end

    def pjax_redirect_to(url, container = '[pjax-container]')
      render js: "$.pjax({url: '#{url}', container: '#{container}'});"
    end

end
