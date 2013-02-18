module Dust
  class CmsMenuItemsController < ApplicationController

    filter_access_to :all

    layout 'cms'

    def index
      @cms_menu_item_list = Dust::CmsMenuItem.page(params[:search], params[:page])
      @roots = Dust::CmsMenuItem.roots
    end

    def new
      @cms_menu_item = Dust::CmsMenuItem.new
      @roots = Dust::CmsMenuItem.roots 
    end

    def create
      @cms_menu_item = Dust::CmsMenuItem.new(params[:dust_cms_menu_item])
      @roots = Dust::CmsMenuItem.roots
      if @cms_menu_item.save
        flash[:notice] = "Successfully created cms menu item."
        redirect_to dust_cms_menu_items_url
      else
        render :action => 'new'
      end
    end

    def edit
      @cms_menu_item = Dust::CmsMenuItem.find(params[:id])
      @roots = Dust::CmsMenuItem.roots
    end

    def update
      @cms_menu_item = Dust::CmsMenuItem.find(params[:id])
      @roots = Dust::CmsMenuItem.roots
      if @cms_menu_item.update_attributes(params[:dust_cms_menu_item])
        flash[:notice] = "Successfully updated cms menu item."
        redirect_to dust_cms_menu_items_url
      else
        render :action => 'edit'
      end
    end

    def destroy
      @cms_menu_item = Dust::CmsMenuItem.find(params[:id])
      @cms_menu_item.destroy
      flash[:notice] = "Successfully destroyed cms menu item."
      redirect_to dust_cms_menu_items_url
    end

    def array
      @menu_sort = Dust::MenuSort.new(params[:ul])

      flash[:notice] = "Successfully Sorted Menu."
      redirect_to dust_cms_menu_items_url(:format => 'js')
    end

  end
end
