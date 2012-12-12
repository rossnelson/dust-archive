class FrontEnd::PageController < ApplicationController
  def show
    @page = Dust::Page.find_by_filename(params[:filename])
    @contact = Dust::Contact.new
    
    #@album = Album.find_by_filename(params[:gallery])
    #if @album
      #@photos = @album.photos
    #end

    if @page == nil
      raise Exceptions::PageNotFound
    end

    rescue Exceptions::PageNotFound
      render :file => "#{Rails.root}/public/404.html", :layout => false, :status => 404

  end
  
  def search
    if params[:query].present?
      @results = Dust::Block.search(params[:query])
    else
      @results = []
    end
  end

end
