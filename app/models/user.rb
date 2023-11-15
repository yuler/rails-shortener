# class User < ApplicationRecord
#   before_validation :normalize_email

#   validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
#   validates :email_normalized, uniqueness: true

#   private

#   # example: `john.Doe+123@gmail.com` => `johndoe@gmail.com`
#   def normalize_email
#     self.email_normalized = email.downcase.split("@").first.gsub(/\.|\+.*/, "") + "@" + email.split("@").last if email.present?
#   end
# end

class User < ApplicationRecord
  before_validation :normalize_email
  validate :unique_normalized_email

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  private

  def normalize_email
    if email.present?
      normalized_part = email.downcase.split("@").first.gsub(/\.|\+.*/, "")
      domain_part = email.split("@").last
      self.email_normalized = normalized_part + "@" + domain_part if email.present?
    end
  end

  def unique_normalized_email
    if email.present? && User.exists?(email_normalized: email_normalized)
      errors.add(:email, "has already been taken")
    end
  end
end
