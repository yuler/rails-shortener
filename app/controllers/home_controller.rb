class HomeController < ApplicationController
  def index
    @link = Link.new
    @links = Current.user.links if Current.user
  end
end
