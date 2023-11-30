module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :required_authenticate
    helper_method :logged_in?
  end

  class_methods do
    def allow_unauthenticated_access(**)
      skip_before_action(:required_authenticate, **)
    end
  end

  private

  def logged_in?
    Current.user.present?
  end

  def required_authenticate
    restore_authentication || request_authentication
  end

  def restore_authentication
    user = User.find_by(id: cookies.signed[:user_id])
    authenticate_as(user) if user
  end

  def request_authentication
    session[:return_to_after_authenticating] = request.url
    redirect_to login_url
  end

  def authenticate_as(user)
    Current.user = user
    cookies.signed.permanent[:user_id] = { value: user.id, httponly: true, same_site: :lax }
  end

  def post_authenticating_url
    session.delete(:return_to_after_authenticating) || root_url
  end

  def reset_authentication
    cookies.delete(:user_id)
  end
end
