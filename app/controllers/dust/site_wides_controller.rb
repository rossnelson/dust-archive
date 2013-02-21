module Dust
  class SiteWidesController < ApplicationController

    filter_access_to :all
    layout 'cms'

    def new
      @site_wide = Dust::SiteWide.new
    end

    def create
      @site_wide = Dust::SiteWide.new(params[:dust_site_wide])
      if @site_wide.save
        redirect_to dust_dashboard_path
      else
        render :action => :new
      end
    end

    def destroy
      @site_wide = Dust::SiteWide.find params[:id]
      @site_wide.destroy

      redirect_to dust_dashboard_path
    end

  end
end
