class Admin::VersionsController < ApplicationController

  def index
    item_type = params[:item_type].capitalize.constantize
    @items = item_type.all
  end

  def show
    item_type = params[:item_type].capitalize.constantize
    @item = item_type.find(params[:item_id])
  end

  def version
    item_type = params[:item_type].capitalize.constantize
    @item = item_type.find(params[:item_id])
    @version = PaperTrail::Version.find(params[:version_id]).reify
  end

  def rollback
    model = params[:item_type].capitalize.constantize
    @item = model.find(params[:item_id])
    @version = PaperTrail::Version.find(params[:version_id]).reify
    if params[:item_type].capitalize == 'Article'
      if can? :modify, Article
        @item.update(text: @version.text, title: @version.title, user_id: current_user.id)
        PaperTrail::Version.destroy(params[:version_id])
      else
        raise CanCan::AccessDenied.new("Sorry... You cannot rollback this!")
      end
    end
    redirect_to "/admin/versions/#{params[:item_type]}/#{params[:item_id]}", flash: { success: 'Success rolling back!' }
  end
  
  def destroy
    PaperTrail::Version.destroy(params[:version_id])
    redirect_to "/admin/versions/#{params[:item_type]}/#{params[:item_id]}"
  end

end