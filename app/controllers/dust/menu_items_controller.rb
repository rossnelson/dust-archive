module Dust
  class MenuItemsController < ApplicationController
    filter_access_to :all
    
    layout "cms"
    
    def index
      @menu_items = Dust::MenuItem.page(params[:search], params[:page]) 
    end
    
    def show
      @menu_item = Dust::MenuItem.find(params[:id])
    end
    
    def new
      @menu_item = Dust::MenuItem.new
    end
    
    def create
      @menu_item = Dust::MenuItem.new(params[:dust_menu_item])
      if @menu_item.save
        flash[:notice] = "Successfully created menu item."
        redirect_to @menu_item
      else
        render :action => 'new'
      end
    end
    
    def edit
      @menu_item = Dust::MenuItem.find(params[:id])
    end
    
    def update
      @menu_item = Dust::MenuItem.find(params[:id])
      if @menu_item.update_attributes(params[:dust_menu_item])
        flash[:notice] = "Successfully updated menu item."
        redirect_to @menu_item
      else
        render :action => 'edit'
      end
    end
    
    def destroy
      @menu_item = Dust::MenuItem.find(params[:id])
      @menu_item.destroy
      flash[:notice] = "Successfully destroyed menu item."
      redirect_to menu_items_url
    end

    def manage
      @menu_item_administration = Dust::MenuItem.manage(params[:search])
    end
    
    def array
      menu_sort(params[:ul])
      flash[:notice] = "Successfully Sorted Menu."
      redirect_to '/menu-manage.js'
    end
  end
end
