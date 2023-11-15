class UserMailer < ApplicationMailer
  default from: User::MAILER_FROM_EMAIL

  def sign_in
    @user = params[:user]
    @magic_token = @user.generate_magic_token

    mail to: @user.email, subject: "Magic sign in link!"
  end
end
