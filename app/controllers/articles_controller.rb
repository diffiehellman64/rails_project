class ArticlesController < ApplicationController
  
  load_and_authorize_resource

  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    if params[:page]
      t = params[:page]
    else
      t = 1
    end
    @articles = Article.all.paginate(page: t, per_page: 10 ).order(created_at: :desc)
    #@articles = Article.all.order(created_at: :desc)
  end

  def show
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    if @article.save
      redirect_to @article, flash: { success: 'Article was successfully created!' }
    else
      render :new
    end
  end

  def update
    @article.user_id = current_user.id
    if @article.update(article_params)
      redirect_to @article, flash: { success: t('Article was successfully updated!') }
    else
      render :edit
    end
  end

  def destroy
    @article.destroy
    render json: { success: true }
    #ArticlesMailer.article_destroyed(@article).deliver_now
    #redirect_to articles_url, flash: { success: 'Article was successfully destroyed!' }
  end

  private
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :text, :anons)
    end
end
