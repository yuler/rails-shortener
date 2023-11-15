class MagicLinksController < ApplicationController
  def show
    @magic_token = params[:id]
    @user = User::find_signed!(@magic_token, purpose: :sign_in)
    x
  end
end
