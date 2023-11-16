class MagicLinksController < ApplicationController
  def show
    user = User.find_by_token_for(:magic_link, params[:token])
    if user
      login(user)
      redirect_to root_path, notice: "You're signed in!"
    else
      redirect_to root_path, alert: "Invalid magic link"
    end
  end
end
