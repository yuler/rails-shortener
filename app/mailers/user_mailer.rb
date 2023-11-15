class UserMailer < ApplicationMailer
  default from: User::MAILER_FROM_EMAIL

  def sign_in(user, magic_token)
    @user = user
    @token = magic_token

    mail to: @user.email, subject: "Magic sign in link for #{User::APP_NAME}"
  end
end
