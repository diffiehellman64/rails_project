class VersionsController < ApplicationController

  before_action :get_model 

  before_action do
    if can? :modify, @model
      true
    else
      raise CanCan::AccessDenied.new("Version controll not allowed!")
    end
  end

  def index
    @items = @model.all
  end

  def show
    @item = @model.find(params[:item_id])
  end

  def version
    @item = @model.find(params[:item_id])
    @version = PaperTrail::Version.find(params[:version_id]).reify
  end

  def rollback
     @item = @model.find(params[:item_id])
      @version = PaperTrail::Version.find(params[:version_id]).reify
      if params[:item_type].capitalize == 'Article'
        @item.update(text: @version.text, title: @version.title, user_id: current_user.id)
        PaperTrail::Version.destroy(params[:version_id])
        redirect_pjax_to "/versions/#{params[:item_type]}/#{params[:item_id]}", flash: { success: 'Success rolling back!' }, _pjax: true
      else  
        redirect_to root_path, flash: { info: 'nothing do...' }
      end
  end
  
  def destroy
    PaperTrail::Version.destroy(params[:version_id])
    redirect_to "/versions/#{params[:item_type]}/#{params[:item_id]}"
  end

  private

  def get_model
    @model = params[:item_type].capitalize.constantize
  end

end
