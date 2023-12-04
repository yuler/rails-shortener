module Api
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
      return render json: { message: "Missing `Authorization` in header" }, status: :unauthorized unless token

      authenticate_as(token)
    end

    def authenticate_as(token)
      user = Token.find_by(value: token).user
      return render json: { message: "Unauthorized" }, status: :unauthorized unless token

      Current.user = user
    end
  end
end
