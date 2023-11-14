class Link < ApplicationRecord
  scope :recent_first, -> { order(created_at: :desc) }

  validates :url, format: { with: /\Ahttps?:\/\/.*\z/, message: "must start with http:// or https://" }
end
