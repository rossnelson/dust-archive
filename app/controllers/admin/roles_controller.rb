class RolesController < ApplicationController
	
	filter_resource_access
	
	layout 'cms'
	
  def index
    @roles = Role.all
  end
  
  def show
	render :layout => 'cms'
  end
  
  def new
	render :layout => 'cms'
  end
  
  def create
    if @role.save
      flash[:notice] = "Successfully created role."
      redirect_to @role
    else
      render :action => 'new', :layout => 'cms'
    end
  end
  
  def edit
	render :layout => 'cms'
  end
  
  def update
    if @role.update_attributes(params[:role])
      flash[:notice] = "Successfully updated role."
      redirect_to @role
    else
      render :action => 'edit', :layout => 'cms'
    end
  end
  
  def destroy
    @role.destroy
    flash[:notice] = "Successfully destroyed role."
    redirect_to roles_url
  end
end
