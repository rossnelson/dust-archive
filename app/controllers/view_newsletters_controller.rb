class ViewNewslettersController < ApplicationController

  def index
    @newsletters = Newsletter.page(params[:search], params[:page]) 
  end

  def show
    if Newsletter.find_by_title(params[:filename]) == nil
      @newsletter = Newsletter.find(:first)
      render :file => "#{RAILS_ROOT}/public/404.html", :layout => false, :status => 404
    else
      @newsletter = Newsletter.find_by_title(params[:filename])
    end
  end

end
