class LinksController < ApplicationController
  before_action :set_link, only: [:show, :edit, :update, :destroy]
  before_action :store_url_in_cookie, only: [:create]
  before_action :authenticate_user!, only: [:create]

  def index
    @links = Link.recent_first
    @link ||= Link.new(url: cookies[:link_form_url])
  end

  def show
    redirect_to root_path, alert: "Link expired" and return unless @link
    @link.views.create(ip: request.ip, user_agent: request.user_agent)
    redirect_to @link.url, allow_other_host: true
  end

  def edit
  end

  def create
    @link = Link.new(link_params.with_defaults(user: Current.user))
    if @link.save
      flash[:success] = "link successfully created"
      cookies.deleted(:link_form_url)
      redirect_to root_path
    else
      index
      render :index, status: :unprocessable_entity
    end
  end

  def update
    if @link.update(link_params)
      redirect_to root_path
    else
      flash[:error] = "Something went wrong"
      render "edit"
    end
  end

  def destroy
    if @link.destroy
      flash[:success] = "Link was successfully deleted."
    else
      flash[:error] = "Something went wrong"
    end

    redirect_to root_path
  end

  private

  def set_link
    @link = Link.find_by(id: params[:id]) if params[:id]
    @link = Link.find_by(code: params[:code]) if params[:code]
  end

  def link_params
    params.require(:link).permit(:url)
  end

  def store_url_in_cookie
    return if Current.user

    url = params[:link][:url]
    cookies[:link_form_url] = { value: url, expired: 1.hour.from_now } if url
  end
end
