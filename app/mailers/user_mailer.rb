class UserMailer < ApplicationMailer
  def magic_link
    @user = params[:user]
    @magic_token = @user.generate_token_for(:magic_link)

    mail to: @user.email, subject: "Magic sign in link!"
  end
end
