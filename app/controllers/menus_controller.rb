class MenusController < ApplicationController

  def index
  end
  
  def show
    @menu_items = Menu.where(name: params[:menu_name])
  end

  def new
    @menu = Menu.new
  end

  def create
    @menu = Menu.new(menu_params)
    if @menu.save
      redirect_to menu_show_path(@menu.name), flash: { success: 'Menu was successfully created!' }
    else
      render :new
    end
  end

  def update
    @item = Menu.find(params[:id])
    @item.update(menu_params)
    redirect_to menu_show_path(@item.name), flash: { success: 'Menu was successfully updated!' }
  end

  private
  
  def menu_params
    params.require(:menu).permit(:name, :title, :url, :parent, :weight, :active) 
  end

end
