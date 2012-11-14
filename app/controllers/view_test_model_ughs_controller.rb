class ViewTestModelUghsController < ApplicationController

  def index
    @test_model_ughs = TestModelUgh.page(params[:search], params[:page]) 
  end

  def show
    if TestModelUgh.find_by_name(params[:filename]) == nil
      @test_model_ugh = TestModelUgh.find(:first)
      render :file => "#{RAILS_ROOT}/public/404.html", :layout => false, :status => 404
    else
      @test_model_ugh = TestModelUgh.find_by_name(params[:filename])
    end
  end

end
