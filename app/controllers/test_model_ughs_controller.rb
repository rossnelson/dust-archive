class TestModelUghsController < ApplicationController

  filter_resource_access

  layout 'cms'

  def index
    @test_model_ughs = TestModelUgh.page(params[:search], params[:page]) 
  end
  
  def show
    @test_model_ugh = TestModelUgh.find(params[:id])
  end
  
  def new
    @test_model_ugh = TestModelUgh.new
  end
  
  def create
    @test_model_ugh = TestModelUgh.new(params[:test_model_ugh])
    if @test_model_ugh.save
      flash[:notice] = "Successfully created test model ugh."
      redirect_to @test_model_ugh
    else
      render :action => 'new'
    end
  end
  
  def edit
    @test_model_ugh = TestModelUgh.find(params[:id])
  end
  
  def update
    @test_model_ugh = TestModelUgh.find(params[:id])
    if @test_model_ugh.update_attributes(params[:test_model_ugh])
      flash[:notice] = "Successfully updated test model ugh."
      redirect_to @test_model_ugh
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @test_model_ugh = TestModelUgh.find(params[:id])
    @test_model_ugh.destroy
    flash[:notice] = "Successfully destroyed test model ugh."
    redirect_to test_model_ughs_url
  end

end
