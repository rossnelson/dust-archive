class AlbumsController < ApplicationController

  filter_resource_access

  layout 'cms'

  def index
    @albums = Album.roots.page(params[:search])
  end

  def show
    @album = Album.find(params[:id], :include => :photos)
    @new_photo = Photo.new(:album_id => @album.id)
  end

  def new
    @album = Album.new
  end

  def create
    @album = Album.new(params[:album])
    if @album.save
      flash[:notice] = "Successfully created album."
      redirect_to @album
    else
      render :action => 'new'
    end
  end

  def edit
    @album = Album.find(params[:id])
  end

  def update
    @album = Album.find(params[:id])
    if @album.update_attributes(params[:album])
      flash[:notice] = "Successfully updated album."
      redirect_to view_album_path(@album.filename)
    else
      render :action => 'edit'
    end
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy
    flash[:notice] = "Successfully destroyed album."
    redirect_to albums_url
  end

  def manage
    @album = Album.find(params[:id], :include => :photos)
    @photos = @album.photos
    render :layout => false
  end
end
