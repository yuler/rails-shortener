class MagicLink < ApplicationRecord
  belongs_to :user

  before_create :generate_token

  def generate_token
    self.token = SecureRandom.hex(10)
  end
end
