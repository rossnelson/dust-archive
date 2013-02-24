module Dust
  class MenuItemsController < ApplicationController
    filter_access_to :all

    layout "cms"

    def new
      @menu_item = Dust::MenuItem.new
    end

    def create
      @menu_item = Dust::MenuItem.new(params[:dust_menu_item])
      if params[:menu_id]
        @menu = Dust::Menu.find(params[:menu_id])
        @menu_item.menu = @menu
      end
      if @menu_item.save
        flash[:notice] = "Successfully created menu item."
        try_return_to_previous_page(dust_menu_items_url)
      else
        render :action => 'new'
      end
    end

    def edit
      @menu_item = Dust::MenuItem.find(params[:id])
    end

    def update
      @menu_item = Dust::MenuItem.find(params[:id])
      if params[:menu_id]
        @menu = Dust::Menu.find(params[:menu_id])
        @menu_item.menu = @menu
      end
      if @menu_item.update_attributes(params[:dust_menu_item])
        flash[:notice] = "Successfully updated menu item."
        try_return_to_previous_page(dust_menu_items_url)
      else
        render :action => 'edit'
      end
    end

    def destroy
      @menu_item = Dust::MenuItem.find(params[:id])
      @menu_item.destroy
      flash[:notice] = "Successfully destroyed menu item."
      redirect_to edit_dust_menu_url(@menu_item.menu)
    end

    def sort
      @menu_sort = Dust::MenuSort.new(params[:list], params[:class_name])

      flash[:notice] = "Successfully Sorted Menu."
    end
  end
end
