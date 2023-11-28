class Token < ApplicationRecord
  before_create :assign_value

  belongs_to :user

  validates :name, presence: true, uniqueness: { scope: :user_id }, length: { minimum: 3, maximum: 20 }

  private

  def assign_value
    self.value = "key-#{SecureRandom.alphanumeric(60)}"
  end
end
