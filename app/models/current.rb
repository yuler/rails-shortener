class Current < ActiveSupport::CurrentAttributes
  attribute :request_id, :user_agent, :ip_address
  attribute :user
end
