Sidekiq.configure_server do |config|
  config.redis = { url: ENV["REDIS_URL"] || "redis://localhost:6379/0", network_timeout: 5, pool_timeout: 5 }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV["REDIS_URL"] || "redis://localhost:6379/0", network_timeout: 5, pool_timeout: 5 }
end
