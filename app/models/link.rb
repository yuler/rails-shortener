class Link < ApplicationRecord
  before_create :assign_code

  belongs_to :user
  has_many :views, dependent: :destroy

  default_scope { recent_first }
  scope :recent_first, -> { order(created_at: :desc) }

  validates :url, format: { with: %r{\Ahttps?://.*\z}, message: "must start with http:// or https://" }

  broadcasts_refreshes

  after_save_commit if: :url_previously_changed? do
    MetadataJob.perform_later(self)
  end

  after_update do
    broadcast_replace_to(self)
  end

  private

  def assign_code
    self.code = unique_code
  end

  def unique_code
    loop do
      code = SecureRandom.alphanumeric(10)
      return code unless Link.exists?(code:)
    end
  end
end
