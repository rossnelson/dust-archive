module Dust
  class DashboardController < ApplicationController

    filter_access_to :all

    layout 'cms'

    def show
      @options = SiteWide.variables_by_category
    end


    def update
      @site_wide = Dust::Builder::SiteWide.new(:options => params[:options])

      if @site_wide.update
        flash[:notice] = "Successfully saved site wide variables!"
        redirect_to dust_dashboard_url
      else
        @options = @site_wide.variables.group_by{ |i| i.category }
        render :action => :show
      end
    end

  end
end
