class UserFilesController < ApplicationController
  def show
    @user = User.find(params[:id])
    @account_file = AccountFile.new
    @new_directory = Directory.new
    @directory_select = @user.directory_select
  end
  
  def edit
    @user = User.find(params[:id])
  end
end
