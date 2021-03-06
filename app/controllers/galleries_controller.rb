class GalleriesController < ApplicationController

  load_and_authorize_resource

  respond_to :html, :js, :only => [:update, :del_image, :destroy]

  def index
    @galleries = Gallery.all.order(:id)
  end

  def show
    @gallery = Gallery.find(params[:id])
    @images = @gallery.image.all.order(:id)
  end

  def new
    @gallery = Gallery.new
  end

  def edit
    @gallery = Gallery.find(params[:id])
    @images = @gallery.image.all.order(:id)
  end

  def create
    @gallery = Gallery.new(gallery_params)
    @gallery.user_id = current_user.id
    if @gallery.save
     # redirect_to edit_gallery_path(@gallery), flash: { success: 'Gallery was successfully created!' }
      pjax_redirect_to edit_gallery_path(@gallery)
    else
      render :new
    end
  end

  def update
    respond_with(@gallery) do |format|
      @gallery = Gallery.find(params[:id])
      @gallery.update(gallery_params)
      params[:images].each do |image|
        @gallery.image.create(file: image, user_id: current_user.id)
      end
      format.js
    end
  end

  def del_image
    @image = Image.find(params[:image_id])
    @image.destroy
    respond_with(@image) do |format|
      format.js { render 'del_image' }
    end
  end

  def destroy
    respond_with(@gallery) do |format|
      @gallery = Gallery.find(params[:id])
      @gallery.destroy
      format.js
      format.html { redirect_to galleries_path, flash: { success: t('Gallery was successfully deleted!') } }
    end
  end

  private

    def gallery_params
      params.require(:gallery).permit(:name, :description)
    end

    def image_params
      params.require(:image).permit(:file)
    end

end
