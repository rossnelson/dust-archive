class FrontEnd::SitemapController < ApplicationController

  def index
    @latest = Dust::MenuItem.last
    respond_to do |format|
      format.xml  { @menu_items = Dust::MenuItem.sitemap}
      format.html { @menu_items = Dust::MenuItem.all }
    end
  end

end
