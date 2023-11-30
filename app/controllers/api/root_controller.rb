module Api
  class RootController < ActionController::API
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    def test
      @now = Time.now
    end

    private

    def record_not_found
      render json: { error: "Record not found" }, status: :not_found
    end
  end
end
