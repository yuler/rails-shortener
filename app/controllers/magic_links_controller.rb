class MagicLinksController < ApplicationController
  def edit
    @magic_link = MagicLink.find(params[:magic_token])
  end
end
