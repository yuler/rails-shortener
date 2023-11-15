class User < ApplicationRecord
  before_validation :normalize_email

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true

  private

  def normalize_email
    # example: `john.Doe+123@gmail` => `johndoe@gmail`
    self.email = email.downcase.gsub(/\.|\+.*/, "") if email.present?
  end
end
