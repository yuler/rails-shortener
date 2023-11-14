class Link < ApplicationRecord
  validates :url, presence: true, format: { with: /\Ahttps?:\/\/.*\z/, message: "must start with http:// or https://" }
end
