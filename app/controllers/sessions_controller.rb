class SessionsController < ApplicationController
  def new
  end

  def create
    @user = login(params[:username], params[:password], params[:remember_me])
    if @user
      redirect_back_or_to user_path(current_user), :notice => "Logged In!"
    else
      redirect_to login_url
      flash.alert = "Email or Password Invalid!"
    end
  end

  def destroy
    logout
    redirect_to root_url, :notice => "Logged Out!"
  end
end
