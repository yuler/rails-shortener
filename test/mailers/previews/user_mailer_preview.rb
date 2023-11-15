# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def sign_in
    UserMailer.with(user: User.first).sign_in
  end
end
