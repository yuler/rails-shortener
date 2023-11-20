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
      code = generate_nanoid
      return code unless Link.exists?(code: code)
    end
  end

  ALPHABET = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ".freeze

  def generate_nanoid
    Nanoid.generate(size: 10, alphabet: ALPHABET)
  end
end
