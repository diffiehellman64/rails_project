class GalleriesController < ApplicationController

  respond_to :html, :xml, :json, :only => [:add_image]

  def index
    @galleries = Gallery.all
  end

  def new
    @gallery = Gallery.new
  end

  def create
    @gallery = Gallery.new(gallery_params)
    @gallery.user_id = current_user.id
    if @gallery.save
      redirect_to @gallery, flash: { success: 'Gallery was successfully created!' }
    else
      render :new
    end
  end

  def add_image
    @image = Image.new(image_params)
    @image.gallery_id = params[:id]
    @image.save
    respond_with do |format|
      format.js
    end
  end

  def show
    @gallery = Gallery.find(params[:id])
    @images = @gallery.image.all
  end

  def edit
    @gallery = Gallery.find(params[:id])
    @image = Image.new
    @images = @gallery.image.all
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def gallery_params
      params.require(:gallery).permit(:name)
    end

    def image_params
      params.require(:image).permit(:file)
    end

end
