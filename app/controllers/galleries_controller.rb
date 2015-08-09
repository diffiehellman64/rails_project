class GalleriesController < ApplicationController

  load_and_authorize_resource

  respond_to :html, :xml, :json, :only => [:update, :del_image]

  def index
    @galleries = Gallery.all.order(:id)
  end

  def new
    @gallery = Gallery.new
  end

  def create
    @gallery = Gallery.new(gallery_params)
    @gallery.user_id = current_user.id
    if @gallery.save
      redirect_to edit_gallery_path(@gallery), flash: { success: 'Gallery was successfully created!' }
    else
      render :new
    end
  end

  def update
    @gallery = Gallery.find(params[:id])
    @gallery.update(gallery_params)
    params[:images].each do |image|
      @gallery.image.create(file: image)
    end
    respond_with(@gallery) do |format|
      format.js
    end
  end

  def del_image
    @image = Image.find(params[:image_id])
    @image.destroy
    respond_with(@image) do |format|
      format.js { render "del_image" }
    end
  end

  def show
    @gallery = Gallery.find(params[:id])
    @images = @gallery.image.all.order(:id)
  end

  def edit
    @gallery = Gallery.find(params[:id])
    @images = @gallery.image.all.order(:id)
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
