class PagesController < ApplicationController

	filter_access_to :all
	
	layout 'cms'
	
  def index
		@pages = Page.page(params[:search], params[:page]) 
  end
  
  def new
    @page = Page.new
		
  end
  
  def create
    
    @page = Page.new(params[:page])

    if @page.save
      flash[:notice] = "Successfully created page."
      redirect_to view_page_path(@page.filename	)
    else
      render :action => 'new', :layout => 'cms'
    end
  end
  
  def edit
    @page = Page.find(params[:id])
		
  end
  
  def update
     @page = Page.find(params[:id])
	 		if @page.update_attributes(params[:page])
	      flash[:notice] = "Successfully updated page."
	      redirect_to view_page_path(@page.filename)
	    else
	      render :action => 'edit'
	    end
  end

  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    flash[:notice] = "Successfully destroyed page."
    redirect_to pages_url
  end
end
