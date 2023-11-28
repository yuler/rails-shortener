class User < ApplicationRecord
  enum role: { member: 0, admin: 1 }

  has_many :links, dependent: :destroy
  has_many :tokens, dependent: :destroy

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, presence: true, uniqueness: true

  # Example: `John.Doe+123@gmail.com` => `johndoe@gmail.com`
  normalizes :email, with: ->email { email.downcase.split("@").first.gsub(/\.|\+.*/, "") + "@" + email.split("@").last }

  generates_token_for :magic_link, expires_in: 15.minutes do
    last_logged_at
  end

  def send_magic_link_mail!
    UserMailer.with(user: self).magic_link.deliver_later
  end
end
