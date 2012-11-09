class RefinanceOrdersController < ApplicationController

  filter_resource_access

  layout 'cms'

  def index
    @refinance_orders = RefinanceOrder.page(params[:search], params[:page]) 
  end
  
  def show
    @refinance_order = RefinanceOrder.find(params[:id])
  end
  
  def new
    #@refinance_order = RefinanceOrder.new
    @refinance_order = current_user.refinance_orders.build
  end
  
  def create
    @refinance_order = current_user.refinance_orders.build(params[:refinance_order])
    #@refinance_order = RefinanceOrder.new(params[:refinance_order])
    if @refinance_order.save
      flash[:notice] = "Successfully created refinance order."
      redirect_to '/place-an-order'
    else
      render :action => 'new'
    end
  end
  
  def edit
    @refinance_order = RefinanceOrder.find(params[:id])
  end
  
  def update
    @refinance_order = RefinanceOrder.find(params[:id])
    if @refinance_order.update_attributes(params[:refinance_order])
      flash[:notice] = "Successfully updated refinance order."
      redirect_to @refinance_order
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @refinance_order = RefinanceOrder.find(params[:id])
    @refinance_order.destroy
    flash[:notice] = "Successfully destroyed refinance order."
    redirect_to refinance_orders_url
  end

end
