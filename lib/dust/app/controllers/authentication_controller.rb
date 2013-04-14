class AuthenticationController < ActionController::Base
  
  protect_from_forgery
  helper :all

  before_filter { |c| Authorization.current_user = c.current_user }


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
  
  protected
  def _prefixes
    @_prefixes_with_partials ||= super | %w(widgets)
  end

end
