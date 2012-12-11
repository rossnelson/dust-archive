class BlocksController < ApplicationController
  
	filter_resource_access

	layout 'cms'
	
	def index
    @blocks = Block.page(params[:search], params[:page]) 
  end
  
  def show
    @block = Block.find(params[:id])
  end
  
  def new
    if params[:show]
      @block = Block.new(:show => params[:show])
    end
    @block ||= Block.new
  end
  
  def create
    @block = Block.new(params[:block])
    if @block.save
      flash[:notice] = "Successfully created block."
      try_return_to_previous_page
    else
      render :action => 'new'
    end
  end
  
  def edit
    @block = Block.find(params[:id])
  end
  
  def update
    @block = Block.find(params[:id])
    if @block.update_attributes(params[:block])
      flash[:notice] = "Successfully updated block."
      !params[:return].blank? ? redirect_to(params[:return]) : redirect_to(@block)
    else
      render :action => 'edit'
    end
  end


  def destroy
    @block = Block.find(params[:id])
    @block.destroy
    flash[:notice] = "Successfully destroyed block."
    redirect_to blocks_url
  end
  
  def try_return_to_previous_page
    !params[:return].blank? ? redirect_to(params[:return]) : redirect_to(@block)
  end
	
end
