class ApplicationController < ActionController::Base
  require 'rinku'

  protect_from_forgery

  include MenuSort

  helper :all

  before_filter :load_app_config, :meta_tags, :create_menus, :load_blocks
  before_filter { |c| Authorization.current_user = c.current_user }

  def create_menus
    @application_menu_items = Dust::MenuItem.menu
    @cms_menu_items = Dust::CmsMenuItem.roots
  end

  def meta_tags
    @description = @app_config.default_description
  end

  # Loads blocks and groups them by position in the layout
  def load_blocks
    @blocks = Dust::Block.find_active(request.fullpath)
  end

  def load_app_config
    raw_config = File.read("#{Rails.root}/config/app_config.yml")
    @app_config = Hashie::Mash.new(YAML.load(raw_config))
  end
  
  def permission_denied
    flash[:error] = "Sorry, either you need to log in first, or you do not have permission to view that page."
    if current_user
      redirect_to dust_user_url(current_user)
    else
      redirect_to root_url
    end
  end
  
  def not_authenticated
    redirect_to dust_login_url, :alert => "First log in to view this page."
  end
  
end
