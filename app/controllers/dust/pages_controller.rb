module Dust
  class PagesController < ApplicationController

    filter_access_to :all
    
    layout 'cms'
    
    def index
      @pages = Dust::Page.page(params[:search], params[:page]) 
    end
    
    def new
      @page = Dust::Page.new
      
    end
    
    def create
      @page = Dust::Page.new(params[:dust_page])
      @builder = Dust::Builder::Page.new(:page => @page, :sections => params[:sections])

      if @builder.save
        flash[:notice] = "Successfully created page."
        redirect_to front_end_page_path(@page.filename)
      else
        render :action => 'new', :layout => 'cms'
      end
    end
    
    def edit
      @page = Dust::Page.find(params[:id])
      
    end
    
    def update
      @page = Dust::Page.find(params[:id])
      @builder = Dust::Builder::Page.new(:page => @page, :sections => params[:sections], :attrs => params[:dust_page])

      if @builder.update
        flash[:notice] = "Successfully updated page."
        redirect_to front_end_page_path(@page.filename)
      else
        render :action => 'edit'
      end
    end

    def destroy
      @page = Dust::Page.find(params[:id])
      @page.destroy
      flash[:notice] = "Successfully destroyed page."
      redirect_to dust_pages_url
    end
  end
end
