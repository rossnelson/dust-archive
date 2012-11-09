class ViewPageController < ApplicationController
  def show
    @page = Page.find_by_filename(params[:filename])
    @contact = Contact.new
    
    @album = Album.find_by_filename(params[:gallery])
    if @album
      @photos = @album.photos
    end

    if @page == nil
      raise Exceptions::PageNotFound
    end

    rescue Exceptions::PageNotFound
      render :file => "#{Rails.root}/public/404.html", :layout => false, :status => 404

  end
  
  def search
    if params[:query].present?
      @results = Block.search(params[:query])
    else
      @results = []
    end
  end

end
