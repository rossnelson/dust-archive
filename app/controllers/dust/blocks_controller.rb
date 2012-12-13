module Dust
  class BlocksController < ApplicationController
    
    filter_access_to :all

    layout 'cms'
    
    def index
      @blocks = Dust::Block.page(params[:search], params[:page]) 
    end
    
    def show
      @block = Dust::Block.find(params[:id])
    end
    
    def new
      if params[:show]
        @block = Dust::Block.new(:show => params[:show])
      end
      @block ||= Dust::Block.new
    end
    
    def create
      @block = Dust::Block.new(params[:dust_block])
      if @block.save
        flash[:notice] = "Successfully created block."
        try_return_to_previous_page(@block)
      else
        render :action => 'new'
      end
    end
    
    def edit
      @block = Dust::Block.find(params[:id])
    end
    
    def update
      @block = Dust::Block.find(params[:id])
      if @block.update_attributes(params[:dust_block])
        flash[:notice] = "Successfully updated block."
        !params[:return].blank? ? redirect_to(params[:return]) : redirect_to(@block)
      else
        render :action => 'edit'
      end
    end


    def destroy
      @block = Dust::Block.find(params[:id])
      @block.destroy
      flash[:notice] = "Successfully destroyed block."
      try_return_to_previous_page(dust_blocks_url)
    end
    
    def try_return_to_previous_page(url)
      !params[:return].blank? ? redirect_to(params[:return]) : redirect_to(url)
    end
    
  end
end
