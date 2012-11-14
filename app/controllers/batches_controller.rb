class BatchesController < ApplicationController
  filter_access_to :all
  skip_before_filter :verify_authenticity_token, :only => [:create]

  def index
    @batches = Batch.order("created_at DESC")
  end

  def show
    @batch = Batch.find(params[:id])
  end

  def new
    @batch = Batch.new
  end

  def create
    @user = User.find(params[:current_user])
    current_user = @user
    @batch = Batch.find_by_submission_id(params[:batch][:submission_id]) || Batch.new(params[:batch])
    
    if @batch.new_record?
      @batch.save
      
      @batch.send_mail(@user)
    end 

    @account_file = AccountFile.new(params[:account_file])
    @account_file.batch_id = @batch.id

    if @account_file.save
      respond_to do |format|
        format.html { redirect_to @account_file.directory }
        format.json { render :json => { :result => 'success', :account_file => account_file_url(@account_file) } }
      end      
    else
      render :action => 'new'
    end
  end

  def edit
    @batch = Batch.find(params[:id])
  end

  def update
    @batch = Batch.find(params[:id])
    if @batch.update_attributes(params[:batch])
      redirect_to @batch, :notice  => "Successfully updated batch."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @batch = Batch.find(params[:id])
    @batch.destroy
    redirect_to batches_url, :notice => "Successfully destroyed batch."
  end
end
