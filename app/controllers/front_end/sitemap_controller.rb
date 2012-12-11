class SitemapController < ApplicationController

  def index
    @latest = MenuItem.last
    respond_to do |format|
      format.xml  { @menu_items = MenuItem.sitemap}
      format.html { @menu_items = MenuItem.all }
    end
  end

end
