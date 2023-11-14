class LinksController < ApplicationController
  before_action :set_link, only: [:show, :edit, :update, :destroy]

  def index
    @links = Link.all
    @link ||= Link.new
  end

  def show
  end

  def edit
  end

  def create
    @link = Link.new(link_params)
    if @link.save
      flash[:success] = "link successfully created"
      redirect_to root_path
    else
      index
      render :index, status: :unprocessable_entity
    end
  end

  def update
    if @link.update(link_params)
      redirect_to @link
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

  def link_params
    params.require(:link).permit(:url)
  end
end
