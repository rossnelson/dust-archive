class CmsMenuItemsController < ApplicationController
    
    #filter_access_to :all
    
    layout 'cms'
    
  def index
    @cms_menu_item_list = CmsMenuItem.page(params[:search], params[:page]) 
        @roots = CmsMenuItem.roots
  end
  
  def show
    @cms_menu_item = CmsMenuItem.find(params[:id])
        @roots = CmsMenuItem.roots 
  end
  
  def new
    @cms_menu_item = CmsMenuItem.new
        @roots = CmsMenuItem.roots 
  end
  
  def create
    @cms_menu_item = CmsMenuItem.new(params[:cms_menu_item])
        @roots = CmsMenuItem.roots
    if @cms_menu_item.save
      flash[:notice] = "Successfully created cms menu item."
      redirect_to cms_menu_items_url
    else
      render :action => 'new'
    end
  end
  
  def edit
    @cms_menu_item = CmsMenuItem.find(params[:id])
        @roots = CmsMenuItem.roots
  end
  
  def update
    @cms_menu_item = CmsMenuItem.find(params[:id])
        @roots = CmsMenuItem.roots
    if @cms_menu_item.update_attributes(params[:cms_menu_item])
      flash[:notice] = "Successfully updated cms menu item."
      redirect_to cms_menu_items_url
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @cms_menu_item = CmsMenuItem.find(params[:id])
    @cms_menu_item.destroy
    flash[:notice] = "Successfully destroyed cms menu item."
    redirect_to cms_menu_items_url
  end
    
    def array
        menu_sort(params[:ul])
    flash[:notice] = "Successfully Sorted Menu."
        redirect_to cms_menu_items_url, :format => 'js'
    end

end
