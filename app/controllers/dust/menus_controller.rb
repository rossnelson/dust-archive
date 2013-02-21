module Dust
  class MenusController < ApplicationController

    filter_access_to :all

    layout 'cms'

    def index
      @menus = Dust::Menu.all
    end

    def new
      @menu = Dust::Menu.new
    end

    def edit
      @menu = Dust::Menu.find(params[:id])
    end

    def create
      @menu = Dust::Menu.new(params[:dust_menu])

      if @menu.save
        redirect_to edit_dust_menu_path(@menu), notice: 'Menu was successfully created.'
      else
        render action: "new"
      end
    end

    def update
      @menu = Dust::Menu.find(params[:id])

      if @menu.update_attributes(params[:dust_menu])
        redirect_to dust_menus_path, notice: 'Menu was successfully updated.'
      else
        render action: "edit"
      end
    end

    def destroy
      @menu = Dust::Menu.find(params[:id])
      @menu.destroy

      redirect_to dust_menus_url
    end
  end
end
