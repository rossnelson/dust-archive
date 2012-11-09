class MenuItemsController < ApplicationController
	filter_access_to :all
	
	layout "cms"
	
  def index
    @menu_items = MenuItem.page(params[:search], params[:page]) 
  end
  
  def show
    @menu_item = MenuItem.find(params[:id])
  end
  
  def new
    @menu_item = MenuItem.new
  end
  
  def create
    @menu_item = MenuItem.new(params[:menu_item])
    if @menu_item.save
      flash[:notice] = "Successfully created menu item."
      redirect_to @menu_item
    else
      render :action => 'new'
    end
  end
  
  def edit
    @menu_item = MenuItem.find(params[:id])
  end
  
  def update
    @menu_item = MenuItem.find(params[:id])
    if @menu_item.update_attributes(params[:menu_item])
      flash[:notice] = "Successfully updated menu item."
      redirect_to @menu_item
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @menu_item = MenuItem.find(params[:id])
    @menu_item.destroy
    flash[:notice] = "Successfully destroyed menu item."
    redirect_to menu_items_url
  end

	def manage
		@menu_item_administration = MenuItem.manage(params[:search])
	end
	
	def array
		menu_sort(params[:ul])
    flash[:notice] = "Successfully Sorted Menu."
		redirect_to '/menu-manage.js'
	end
end
