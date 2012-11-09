class KeysController < ApplicationController
	
	filter_resource_access
	
	layout 'cms'
	
  def index
		@key = Key.new
    @keys = Key.all
  end
  
  def show
    @key = Key.find(params[:id])
  end

  def create
    @key = Key.new(params[:key])
    if @key.save
      flash[:notice] = "Successfully created key."
      redirect_to keys_url
    else
      render :action => 'index'
    end
  end
  
  def edit
    @key = Key.find(params[:id])
  end
  
  def update
    @key = Key.find(params[:id])
    if @key.update_attributes(params[:key])
      flash[:notice] = "Successfully updated key."
      redirect_to keys_url
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @key = Key.find(params[:id])
    @key.destroy
    flash[:notice] = "Successfully destroyed key."
    redirect_to keys_url
  end
end
