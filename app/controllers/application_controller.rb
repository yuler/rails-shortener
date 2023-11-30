class ApplicationController < ActionController::Base
  include Authentication
  include SetCurrent

  def login(user)
    user.touch :last_logged_at
    reset_session
    session[:user_id] = user.id
    Current.user = user
  end

  def logout
    reset_session
    Current.user = nil
  end
end
