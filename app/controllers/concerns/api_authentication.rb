module ApiAuthentication
  extend ActiveSupport::Concern

  included do
    before_action :required_authenticate
  end

  class_methods do
    def allow_unauthenticated_access(**)
      skip_before_action(:required_authenticate, **)
    end
  end

  private

  # Authorization: Bearer <Your-Token>
  def required_authenticate
    token = request.headers["Authorization"]&.remove("Bearer ")

    unless token
      render json: { message: "Missing `Authorization` in header" }, status: :unauthorized
      return
    end

    authenticate_as(token)
  end

  def authenticate_as(token)
    user = Token.find_by(value: token)&.user

    unless user
      render json: { message: "Unauthorized" }, status: :unauthorized
      return
    end

    Current.user = user
  end
end
