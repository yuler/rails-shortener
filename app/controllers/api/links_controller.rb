module Api
  class LinksController < Api::BaseController
    def index
      @links = Link.all
      render json: @links
    end
  end
end
