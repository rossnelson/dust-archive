class DirectoriesController < ApplicationController
  filter_access_to :all
  filter_access_to [:edit, :update, :destroy], :attribute_check => true

  def show
    if params[:title]
      @directory = Directory.find_by_title(params[:title])
    else
      @directory = Directory.find(params[:id])
    end
    @account_file = AccountFile.new
    @user = @directory.user
    @new_directory = Directory.new
    @directory_select = @user.directory_select

    add_breadcrumb @user.username, "/users/#{@user.id}"
    @directory.find_all_parents.each do |directory|
      add_breadcrumb directory.title, "/directories/#{directory.id}"
    end
    add_breadcrumb @directory.title, "/directories/#{@directory.id}"
  end

  def new
    @directory = Directory.new
  end

  def create
    @directory = Directory.new(params[:directory])
    if @directory.save
      redirect_to :back, :notice => "Successfully created directory."
    else
      render :action => 'new'
    end
  end

  def edit
    @directory = Directory.find(params[:id])
  end

  def update
    @directory = Directory.find(params[:id])
    if @directory.update_attributes(params[:directory])
      if @directory.parent_directory_id.blank?
        redirect_to user_path(@directory.user), :notice  => "Successfully updated directory."
      else
        redirect_to directory_path(@directory.parent_directory), :notice  => "Successfully updated directory."
      end
    else
      render :action => 'edit'
    end
  end

  def destroy
    @directory = Directory.find(params[:id])
    @directory.destroy
    redirect_to :back, :notice => "Successfully destroyed directory."
  end

end
