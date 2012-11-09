class LetterReportOrdersController < ApplicationController

  filter_resource_access

  layout 'cms'

  def index
    @letter_report_orders = LetterReportOrder.page(params[:search], params[:page]) 
  end
  
  def show
    @letter_report_order = LetterReportOrder.find(params[:id])
  end
  
  def new
    @letter_report_order = LetterReportOrder.new
    @letter_report_order = current_user.letter_report_orders.build
  end
  
  def create
    @letter_report_order = current_user.letter_report_orders.build(params[:letter_report_order])
    
    if @letter_report_order.save
      flash[:notice] = "Successfully created letter report order."
      redirect_to '/place-an-order'
    else
      render :action => 'new'
    end
  end
  
  def edit
    @letter_report_order = LetterReportOrder.find(params[:id])
  end
  
  def update
    @letter_report_order = LetterReportOrder.find(params[:id])
    if @letter_report_order.update_attributes(params[:letter_report_order])
      flash[:notice] = "Successfully updated letter report order."
      redirect_to @letter_report_order
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @letter_report_order = LetterReportOrder.find(params[:id])
    @letter_report_order.destroy
    flash[:notice] = "Successfully destroyed letter report order."
    redirect_to letter_report_orders_url
  end

end
