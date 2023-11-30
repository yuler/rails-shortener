class MagicLinksController < ApplicationController
  allow_unauthenticated_access only: %i[show]

  def show
    user = User.find_by_token_for(:magic_link, params[:token])
    if user
      login(user)
      redirect_to post_authenticating_url, notice: "You're logged!"
    else
      redirect_to post_authenticating_url, alert: "Invalid magic link"
    end
  end
end
