class Admin::VersionsController < ApplicationController

  def index
    item_type = params[:item_type].capitalize.constantize
    @items = item_type.all
  end

end
