class TestimonialsController < ApplicationController

  filter_resource_access

  layout 'cms'

  def index
    @testimonials = Testimonial.page(params[:search], params[:page]) 
  end
  
  def show
    @testimonial = Testimonial.find(params[:id])
  end
  
  def new
    @testimonial = Testimonial.new
  end
  
  def create
    @testimonial = Testimonial.new(params[:testimonial])
    if @testimonial.save
      flash[:notice] = "Successfully created testimonial."
      redirect_to root_url
    else
      render :action => 'new'
    end
  end
  
  def edit
    @testimonial = Testimonial.find(params[:id])
  end
  
  def update
    @testimonial = Testimonial.find(params[:id])
    if @testimonial.update_attributes(params[:testimonial])
      flash[:notice] = "Successfully updated testimonial."
      !params[:return].blank? ? redirect_to(params[:return]) : redirect_to(@testimonial)
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @testimonial = Testimonial.find(params[:id])
    @testimonial.destroy
    flash[:notice] = "Successfully destroyed testimonial."
    redirect_to testimonials_url
  end

end
