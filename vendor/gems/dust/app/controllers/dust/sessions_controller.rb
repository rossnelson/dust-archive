module Dust
  class SessionsController < ApplicationController


    layout "sessions"

    def new
      @session = Dust::Session.new
    end

    def create
      @user = login(params[:dust_session][:username], params[:dust_session][:password], params[:dust_session][:remember_me])
      #raise "hey there"
      if @user
        redirect_back_or_to dust_dashboard_path, :notice => "Logged In!"
      else
        @session = Dust::Session.new(params[:dust_session], @user)
        @session.valid?
        render :action => 'new'
        #flash.alert = "Email or Password Invalid!"
      end
    end

    def destroy
      logout
      redirect_to root_url, :notice => "Logged Out!"
    end
  end
end
