class ApplicationController < ActionController::Base
  include Authentication
  include SetCurrent

  def login(user)
    authenticate_as(user)
  end

  def logout
    reset_authentication
  end
end
