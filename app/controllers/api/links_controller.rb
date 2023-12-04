module Api
  class LinksController < Api::BaseController
    before_action :set_link, only: %i[show update destroy]

    def index
      @links = Link.all
      render json: @links
    end

    def show
      if @link
        render json: @link
      else
        render json: { error: "link not found" }, status: :not_found
      end
    end

    def create
      @link = Link.new link_params.with_defaults(user: Current.user)
      if @link.save
        render json: @link, status: :created
      else
        render json: @link.errors, status: :unprocessable_entity
      end
    end

    def update
      @link = Link.new link_params.with_defaults(user: Current.user)
      if @link.save
        render json: @link, status: :created
      else
        render json: @link.errors, status: :unprocessable_entity
      end
    end

    def destroy
      if @link.destroy
        render json: @link, status: :ok
      else
        render json @link.errors, status: :unprocessable_entity
      end
    end

    private

    def link_params
      params.require(:link).permit(:url)
    end

    def set_link
      @link = Link.find(params[:id])
    end
  end
end
