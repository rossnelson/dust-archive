class FrontEnd::PageController < ApplicationController

  def show
    @page = Dust::Page.find_by_filename(params[:filename])
    @contact = Dust::Contact.new

    if @page == nil
      raise Exceptions::PageNotFound
    end

    rescue Exceptions::PageNotFound
      render :file => "#{Rails.root}/public/404.html", :layout => false, :status => 404
  end

  def search
    @results = (params[:query].present? ? Dust::Block.search(params[:query]) : [])
  end

end
