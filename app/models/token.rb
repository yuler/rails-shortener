class Token < ApplicationRecord
  before_create :assign_value

  validates :name, presence: true, uniqueness: { scope: :user_id }, length: { minimum: 3, maximum: 20 }

  belongs_to :user

  @private

  def assign_value
    self.value = "key-#{SecureRandom.alphanumeric(60)}"
  end
end
