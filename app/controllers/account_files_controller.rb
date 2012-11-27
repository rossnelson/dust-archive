class AccountFilesController < ApplicationController
  filter_access_to :all
  filter_access_to [:show, :edit, :update, :destroy], :attribute_check => true

  def index
    @account_files = AccountFile.all
  end

  def show
    @account_file = AccountFile.find(params[:id])
  end

  def new
    @account_file = AccountFile.new
    @user = current_user
  end

  def create
    @batch = Batch.find_or_create_by_submission_id_and_user_id(params[:submission_id], params[:account_file][:user_id]) 

    @account_file = AccountFile.new(params[:account_file])
    @account_file.batch_id = @batch.id
    
    if @account_file.save
      respond_to do |format|
        format.html { redirect_to (@account_file.directory || user_file_path(@account_file.user)) }
        format.json { render :json => { :result => 'success', :account_file => account_file_url(@account_file) } }
      end      
    else
      render :action => 'new'
    end
  end

  def edit
    @account_file = AccountFile.find(params[:id])
  end

  def update
    @account_file = AccountFile.find(params[:id])
    if @account_file.update_attributes(params[:account_file])
      if @account_file.directory.blank?
        redirect_to user_path(@account_file.user), :notice  => "Successfully updated directory."
      else
        redirect_to directory_path(@account_file.directory), :notice  => "Successfully updated account file."
      end
    else
      render :action => 'edit'
    end
  end

  def destroy
    @account_file = AccountFile.find(params[:id])
    @account_file.destroy

    if @account_file.directory
      redirect_to @account_file.directory, :notice => "Successfully destroyed account file."
    else
      redirect_to @account_file.user, :notice => "Successfully destroyed account file."
    end

  end

  SEND_FILE_METHOD = :default

  def download
    head(:not_found) and return if (file = AccountFile.find_by_id(params[:id])).nil?

    path = file.content.path
    head(:bad_request) and return unless File.exist?(path) && params[:format].to_s == File.extname(path).gsub(/^\.+/, '')

    send_file_options = { :type => "pdf" }

    case SEND_FILE_METHOD
      when :apache then send_file_options[:x_sendfile] = true
      when :nginx then head(:x_accel_redirect => path.gsub(Rails.root, ''), :content_type => send_file_options[:type]) and return
    end

    send_file(path, send_file_options)

  end
end
