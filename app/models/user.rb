class User < ApplicationRecord
  enum role: { member: 0, admin: 1 }

  has_many :links, dependent: :destroy
  has_many :tokens, dependent: :destroy

  # Example: `John.Doe+123@gmail.com` => `johndoe@gmail.com`
  normalizes :email, with: lambda { |email|
    return email if email.exclude?("@")

    username = email.downcase.split("@").first.gsub(/\.|\+.*/, "")
    domain = email.downcase.split("@").last
    "#{username}@#{domain}"
  }

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, presence: true, uniqueness: true

  generates_token_for :magic_link, expires_in: 15.minutes do
    last_logged_at
  end

  def send_magic_link_mail!
    UserMailer.with(user: self).magic_link.deliver_later
  end

  # def normalize_email(email)
  #   username = email.downcase.split("@").first.gsub(/\.|\+.*/, "")
  #   domain = email.split("@").last
  #   "#{username}@#{domain}"
  # end
end
