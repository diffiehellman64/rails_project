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
    @menu.title = 'Home'
    @menu.url = '/'
    @menu.weight = '0'
    @menu.active = true
    if @menu.save
      redirect_to menu(@menu.name), flash: { success: 'Menu was successfully created!' }
    else
      render :new
    end
  end

  private
  
  def menu_params
    params.require(:menu).permit(:name, :title, :url, :parent, :weight, :active) 
  end

end
