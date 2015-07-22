class Admin::VersionsController < ApplicationController

  before_action :get_model 

  before_action do
    if can? :modify, @model
      true
    else
      raise CanCan::AccessDenied.new("Not allowed")
    end
  end

  def index
#    item_type = params[:item_type].capitalize.constantize
    @items = @model.all
  end

  def show
#    item_type = params[:item_type].capitalize.constantize
    @item = @model.find(params[:item_id])
  end

  def version
#    item_type = params[:item_type].capitalize.constantize
    @item = @model.find(params[:item_id])
    @version = PaperTrail::Version.find(params[:version_id]).reify
  end

  def rollback
#    model = params[:item_type].capitalize.constantize 
#    if can? :modify, @model
     @item = @model.find(params[:item_id])
      @version = PaperTrail::Version.find(params[:version_id]).reify
      if params[:item_type].capitalize == 'Article'
        @item.update(text: @version.text, title: @version.title, user_id: current_user.id)
        PaperTrail::Version.destroy(params[:version_id])
        redirect_to "/admin/versions/#{params[:item_type]}/#{params[:item_id]}", flash: { success: 'Success rolling back!' }
      else  
        redirect_to root_path, flash: { info: 'nothing do...' }
      end
#    else
#      raise CanCan::AccessDenied.new("Sorry... You cannot rollback this!")
#    end
  end
  
  def destroy
    PaperTrail::Version.destroy(params[:version_id])
    redirect_to "/admin/versions/#{params[:item_type]}/#{params[:item_id]}"
  end

  private

  def get_model
    @model = params[:item_type].capitalize.constantize
  end

end
