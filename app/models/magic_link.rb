class MagicLink < ApplicationRecord
  belongs_to :user

  before_create :generate_token

  def generate_token
    self.token = SecureRandom.hex(10)
  end

  def valid_token?
    (Time.now - self.created_at) < 2.hours
  end
end
