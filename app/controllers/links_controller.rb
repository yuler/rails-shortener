class LinksController < ApplicationController
  before_action :set_link, only: %i[show edit update destroy short]
  before_action :store_url_in_cookie, only: [:create]
  allow_unauthenticated_access only: %i[short]

  def show; end

  def edit; end

  def create
    @link = Link.new link_params.with_defaults(user: Current.user)
    if @link.save
      cookies.delete(:link_form_url)
      redirect_to root_path, notice: "link successfully created"
    else
      render "home/index", status: :unprocessable_entity
    end
  end

  def update
    @link.update link_params
    redirect_to root_path
  end

  def destroy
    @link.destroy!

    redirect_to root_path, notice: "Link was successfully deleted."
  end

  def short
    redirect_to root_path, alert: "" and return unless @link

    @link.views.create(ip: request.ip, user_agent: request.user_agent)
    redirect_to @link.url, allow_other_host: true
  end

  private

  def set_link
    @link = Link.find(params[:id]) if params[:id]
    @link = Link.find_by(code: params[:code]) if params[:code]
  end

  def link_params
    params.require(:link).permit(:url)
  end

  def store_url_in_cookie
    return if Current.user

    url = params[:link][:url]
    cookies[:link_form_url] = { value: url, expired: 15.minutes.from_now } if url
  end
end
