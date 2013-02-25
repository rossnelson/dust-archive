module Dust
  class UsersController < ApplicationController

    filter_access_to :all

    layout 'cms'

    def index
      @users = Dust::User.page(params[:search], params[:page])
    end

    def new
      @user = Dust::User.new()
    end

    def create
      @user = Dust::User.new(params[:dust_user])

      if @user.save
        flash[:notice] = "Successfully created user."
        redirect_to dust_users_url
      else
        render :action => 'new', :layout => 'cms' 
      end
    end

    def edit
      @user = Dust::User.find(params[:id])
    end

    def update
      @user = Dust::User.find(params[:id])

      if @user.update_attributes(params[:dust_user])
        flash[:notice] = "Successfully updated user information."
        redirect = current_user.is?(:moderator) ? dust_dashboard_url : dust_users_url
        redirect_to redirect
      else
        flash.now[:error] = "There was an error in your form."
        render :action => 'edit', :layout => 'cms'
      end
    end

    def destroy
      @user = Dust::User.find(params[:id])
      @user.destroy
      flash[:notice] = "Successfully destroyed user."
      redirect_to dust_users_url
    end

  end
end
