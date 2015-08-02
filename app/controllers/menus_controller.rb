class MenusController < ApplicationController

  load_and_authorize_resource

  def index
  end
  
  def show
    @menu_items = Menu.where(name: params[:menu_name]).order(:weight)
  end

  def new
    @menu = Menu.new
  end

  def create
    @menu = Menu.new(menu_params)
    if @menu.save
      redirect_to menu_show_path(@menu.name), flash: { success: 'Menu was successfully created!' }
     # if request.xhr?
     #   render @menu.id
     # end
    else
      render :new
    end
  end

  def update
    @item = Menu.find(params[:id])
    @item.update(menu_params)
    redirect_to menu_show_path(@item.name), flash: { success: 'Menu was successfully updated!' }
  end

  def destroy
    @item = Menu.find(params[:id])
    @item.destroy
    redirect_to menu_show_path(@item.name), flash: { success: 'Item was deleted!' }
  end

  private
  
  def menu_params
    params.require(:menu).permit(:name, :title, :url, :parent, :weight, :active) 
  end

end
