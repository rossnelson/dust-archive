class DashboardController < ApplicationController

  filter_access_to :all

  layout 'cms'

  def show
    @user = current_user
    @options = @app_config
  end

  def update
    @options = params[:options]
    open("#{Rails.root}/config/app_config.yml", 'w') { |f| YAML::dump(@options, f) }
    flash[:notice] = "Successfully saved site wide options!"
    redirect_to dashboard_url
  end

end
