class Link < ApplicationRecord
  before_create :assign_code

  belongs_to :user, optional: true
  has_many :views, dependent: :destroy

  scope :recent_first, -> { order(created_at: :desc) }

  validates :url, format: { with: /\Ahttps?:\/\/.*\z/, message: "must start with http:// or https://" }

  private

  def assign_code
    self.code = unique_code
  end

  def unique_code
    loop do
      code = SecureRandom.alphanumeric(10)
      return code unless Link.exists?(code: code)
    end
  end
end
