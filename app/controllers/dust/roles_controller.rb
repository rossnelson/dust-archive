module Dust
  class RolesController < ApplicationController

    filter_access_to :all

    layout 'cms'

    def index
      @roles = Dust::Role.all
    end

    def new
      @role = Dust::Role.new
    end

    def create
      @role = Dust::Role.new(params[:dust_role])
      if @role.save
        flash[:notice] = "Successfully created role."
        redirect_to dust_roles_url
      else
        render :action => 'new', :layout => 'cms'
      end
    end

    def edit
      @role = Dust::Role.find(params[:id])
    end

    def update
      @role = Dust::Role.find(params[:id])
      if @role.update_attributes(params[:dust_role])
        flash[:notice] = "Successfully updated role."
        redirect_to dust_roles_url
      else
        render :action => 'edit', :layout => 'cms'
      end
    end

    def destroy
      @role = Dust::Role.find(params[:id])
      @role.destroy
      flash[:notice] = "Successfully destroyed role."
      redirect_to dust_roles_url
    end
  end
end
