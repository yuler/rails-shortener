class User < ApplicationRecord
  MAILER_FROM_EMAIL = "no-reply@example.com"
  MAGIC_LINK_EXPIRATION = 10.minutes

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validate :unique_email_normalized

  def initialize(attributes = {})
    super(attributes)
    normalize_email if new_record?
  end

  def generate_magic_token
    signed_id expires_in: MAGIC_LINK_EXPIRATION, purpose: :sign_in
  end

  def send_sign_in_mail!
    UserMailer.with(user: self).sign_in.deliver_later
  end

  private

  # example: `John.Doe+123@gmail.com` => `johndoe@gmail.com`
  def normalize_email
    if email.present?
      normalized_part = email.downcase.split("@").first.gsub(/\.|\+.*/, "")
      domain_part = email.split("@").last
      self.email_normalized = normalized_part + "@" + domain_part
    end
  end

  def unique_email_normalized
    if email.present? && User.exists?(email_normalized: email_normalized)
      errors.add(:email, "has already been taken")
    end
  end
end
