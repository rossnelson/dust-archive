class ApplicationController < ActionController::Base

  protect_from_forgery
  helper :all

  before_filter :load_sitewide_data, :meta_tags, :load_blocks
  before_filter { |c| Authorization.current_user = c.current_user }

  def meta_tags
    @description = @site_data.site_info.default_description
  end

  # Loads blocks and groups them by position in the layout
  def load_blocks
    @blocks = Dust::Block.find_active(request.fullpath)
  end

  def load_sitewide_data
    @site_data = Dust::SiteWide.all_to_object
  end

  def permission_denied
    flash[:error] = "Sorry, either you need to log in first to view that page."
    if current_user
      redirect_to dust_dashboard_url
    else
      redirect_to root_url
    end
  end

  def not_authenticated
    redirect_to dust_login_url, :error => "First log in to view this page."
  end

  def try_return_to_previous_page(url)
    !params[:return].blank? ? redirect_to(params[:return]) : redirect_to(url)
  end
  

end
