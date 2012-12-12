module Dust
  class SlidesController < ApplicationController

      filter_access_to :all
      layout 'cms'

    #unloadable

    def index
      @slides = Slide.paginate_all(params[:search]) 
    end

    def show
      @slide = Slide.find(params[:id])
    end

    def new
      @slide = Slide.new
    end

    def create
      @slide = Slide.new(params[:slide])
      if @slide.save
        flash[:notice] = "Successfully created slide."
        redirect_to @slide
      else
        render :action => 'new'
      end
    end

    def edit
      @slide = Slide.find(params[:id])
    end

    def update
      @slide = Slide.find(params[:id])
      if @slide.update_attributes(params[:slide])
        flash[:notice] = "Successfully updated slide."
        !params[:return].blank? ? redirect_to(params[:return]) : redirect_to(@slide)
      else
        render :action => 'edit'
      end
    end

    def destroy
      @slide = Slide.find(params[:id])
      @slide.destroy
      flash[:notice] = "Successfully destroyed slide."
      redirect_to nivo_slides_url
    end

  end
end
