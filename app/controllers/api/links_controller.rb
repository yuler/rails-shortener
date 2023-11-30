class Api::LinksController < ActionController::API
  def index
    @links = Link.all
    render json: @links
  end
end
