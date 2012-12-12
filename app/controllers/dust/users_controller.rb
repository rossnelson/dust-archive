module Dust
  class UsersController < ApplicationController
    
    #filter_resource_access
    
    layout 'cms'
    
    def index
      @users = Dust::User.page(params[:search], params[:page])
    end
    
    def show
      @users = Dust::User.page(params[:search], params[:page])
      @user = Dust::User.find(params[:id])
    end
    
    def new
      @user = Dust::User.new(params[:user])
    end
    
    def create
      @user = Dust::User.new(params[:user])
      
      if current_user.nil? || current_user.has_role?(:client)
        @user.role = Role.find_by_name("client")
        @user.approved = false
      end

      if @user.save
        if !current_user.nil? && current_user.has_role?(:dust)
          flash[:notice] = "Successfully created user."
          redirect_to users_url
        else
          flash[:notice] = "Thank you for registering. Your account will be reviewed for approval."
          redirect_to '/place-an-order'
        end
      else
        if !current_user.nil? && current_user.has_role?(:dust)
          render :action => 'new', :layout => 'cms' 
        else
          redirect_to '/place-an-order'
        end
      end
    end
    
    def edit
      @user = Dust::User.find(params[:id])
      respond_to do |format|
        format.html {}
        format.js   { 
          render :layout => false 
          }
      end
    end
    
    def update
      @user = Dust::User.find(params[:id])
      
      if @user.update_attributes(params[:user])
        flash[:notice] = "Successfully updated user information."
        respond_to do |format|
          format.html { 
            
            if !current_user.nil? && current_user.has_role?(:dust)
              redirect_to users_url
            else
              redirect_to '/place-an-order'
            end 
            
          }
          format.js   { redirect_to "/users/#{@user.id}.js" }
        end
      else
        flash.now[:error] = "There was an error in your form."
        respond_to do |format|
          format.html { render :action => 'edit', :layout => 'cms' }
          format.js   { 
            render :action => 'update', :format => 'js'
            }
        end
        
      end
    end
    
    def destroy
      @user = Dust::User.find(params[:id])
      @user.destroy
      flash[:notice] = "Successfully destroyed user."
      redirect_to users_url
    end
    
    def activate
      if (@user = Dust::User.load_from_activation_token(params[:id]))
        @user.activate!
        redirect_to(login_path, :notice => 'User was successfully activated.')
      else
        not_authenticated
      end
    end
  end
end
