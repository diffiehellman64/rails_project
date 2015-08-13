class ArticlesController < ApplicationController
  
  load_and_authorize_resource
 
  respond_to :html, :pdf, :js
  # respond_to :html

  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    if params[:page]
      t = params[:page]
    else
      t = 1
    end
    @articles = Article.all.paginate(page: t, per_page: 10 ).order(created_at: :desc)
  end

  def show
    #if request.url # Check if we are redirected
    #  response.headers['X-PJAX-URL'] = request.url
    #end
    #render :layout => false
    #prawnto prawn: { margin: [20, 20, 20, 20], page_size: "A4"}
    #prawnto prawn: { margin: [20, 20, 20, 20], page_size: "A4", page_layout: :landscape }
    #respond_with(@doc) do |format|
      #format.html
      #format.pdf do
        #@doc.text 'Просто текст'
        #filename = File.join(Rails.root, "public/pdf", "file.pdf")
        #doc.render_file filename
        #send_file filename, :filename => "file.pdf", :type => "application/pdf"
       # render 'show'
      #end #{ render 'show' }
    #end
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
      #redirect_to @article, flash: { success: 'Article was successfully created!' }
      #respond_with(@article, location: @article)
      #render js: "alert('Hello Rails');"
      #render js: "$.pjax.reload('#pjax-container');"
      #  redirect_to @article
      else
        render :new
      end
    #end
  end

  def update
    @article.user_id = current_user.id
    if @article.update(article_params)
      redirect_to @article, flash: { success: t('views.articles.actions.update_success') }
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
