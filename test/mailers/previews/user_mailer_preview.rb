# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def sign_in
    @user = User.new(email: "is.yuler@gmail.com")
    @magic_token = "xxx"
  end
end
