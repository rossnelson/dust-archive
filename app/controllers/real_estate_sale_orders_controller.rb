class RealEstateSaleOrdersController < ApplicationController

  filter_resource_access

  layout 'cms'

  def index
    @real_estate_sale_orders = RealEstateSaleOrder.page(params[:search], params[:page]) 
  end
  
  def show
    @real_estate_sale_order = RealEstateSaleOrder.find(params[:id])
  end
  
  def new
    #@real_estate_sale_order = RealEstateSaleOrder.new
    @real_estate_sale_order = current_user.real_estate_sale_orders.build
  end
  
  def create
    #@real_estate_sale_order = RealEstateSaleOrder.new(params[:real_estate_sale_order])
    @real_estate_sale_order = current_user.real_estate_sale_orders.build(params[:real_estate_sale_order])
    if @real_estate_sale_order.save
      flash[:notice] = "Successfully created real estate sale order."
      redirect_to '/place-an-order'
    else
      render :action => 'new'
    end
  end
  
  def edit
    @real_estate_sale_order = RealEstateSaleOrder.find(params[:id])
  end
  
  def update
    @real_estate_sale_order = RealEstateSaleOrder.find(params[:id])
    if @real_estate_sale_order.update_attributes(params[:real_estate_sale_order])
      flash[:notice] = "Successfully updated real estate sale order."
      redirect_to @real_estate_sale_order
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @real_estate_sale_order = RealEstateSaleOrder.find(params[:id])
    @real_estate_sale_order.destroy
    flash[:notice] = "Successfully destroyed real estate sale order."
    redirect_to real_estate_sale_orders_url
  end

end
