class PhotosController < ApplicationController

  filter_access_to :index, :new, :create, :destroy
  filter_access_to :edit, :update, :attribute_check => true

  layout 'cms'

  def index
    @photos = Photo.page(params[:search], params[:page])
    @photo_albums = @photos.group_by { |photo| photo.album.title }
  end

  def show
    @photo = Photo.find(params[:id], :include => :album)
    @total_uploads = Photo.find(:all, :conditions => { :album_id => @photo.album.id})
    @album = @photo.album
  end

  def new
    @photo = Photo.new
  end

  def create
    newparams = coerce(params)
    @photo = Photo.new(newparams[:photo])
    if @photo.save
      flash[:notice] = "Successfully created photo."
      respond_to do |format|
        format.html { redirect_to @photo.album }
        format.json { render :json => { :result => 'success', :photo => photo_url(@photo) } }
      end
    else
      render :action => 'new'
    end
  end

  def edit
    if params[:edit] == 'photo'
      render :layout => false
      @photo = Photo.find(params[:id])
    else
      @photo = Photo.find(params[:id])
    end
  end

  def update
    @photo = Photo.find(params[:id])
    if @photo.update_attributes(params[:photo])
      flash[:notice] = "Successfully updated photo."
      redirect_to album_url(@photo.album)
    else
      render :action => 'edit'
    end
  end

  def destroy
    if request.post?
      if params[:photo_ids]
        params[:photo_ids].each do |photo|
          @photo = Photo.find photo
        @photo.destroy
        end 
        flash[:notice] = "Photos Successfully deleted!"
      end
      redirect_to(album_path(@photo.album))
    end
  end

  def array
    menu_sort(params[:ul])
    flash[:notice] = "Successfully Sorted Photos."
  end

  private
  def coerce(params)
    if params[:photo].nil?
      h = Hash.new
      h[:photo] = Hash.new
      h[:photo][:album_id] = params[:album_id]
      h[:photo][:title] = params[:title]
      h[:photo][:file] = params[:Filedata]
      h[:photo][:file].content_type = MIME::Types.type_for(h[:photo][:file].original_filename).to_s
      h
    else
      params
    end
  end

end
