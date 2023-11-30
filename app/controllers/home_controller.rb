class HomeController < ApplicationController
  allow_unauthenticated_access only: [:index]

  def index
    @link = Link.new
    @links = Current.user.links if Current.user
  end
end
