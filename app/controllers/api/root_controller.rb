module Api
  class RootController < Api::BaseController
    allow_unauthenticated_access only: :test

    def test
      render json: { now: Time.now.strftime("%Y-%m-%d %H:%M:%S") }
    end

    def protected
      render json: { message: "Protected endpoint" }
    end
  end
end
