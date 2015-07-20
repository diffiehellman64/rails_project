class Admin::ArticlesController < ApplicationController
  
  before_action do check_admin end

  def index
    @articles = Article.all
  end

  def versions
    @article = Article.find(params[:article_id])
    @versions = @article.versions
  end
 
  def show
    @article = Article.find(params[:article_id])
    @article_version = @article.version_at(params[:version_time])
  end

end
