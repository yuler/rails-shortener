require "sidekiq/web"

Rails.application.routes.draw do
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Sessions
  get "login" => "sessions#new", as: :login
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy", as: :logout

  # Magic Links
  resources :magic_links, param: :token, only: [:show]

  # Links
  resources :links, only: %i[show create edit update destroy]
  # Short Link
  get "/:code", to: "links#short", as: :short_link, constraints: { code: /[a-zA-Z0-9_-]{10}/ }

  # Settings
  resource :settings do
    resources :tokens
    # member do
    #   get :tokens
    # end
  end

  # Root
  root "home#index"

  # Sidekiq, refs: https://github.com/sidekiq/sidekiq/wiki/Monitoring#rails-http-basic-auth-from-routes
  if Rails.env.production?
    Sidekiq::Web.use Rack::Auth::Basic do |username, password|
      ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username),
                                                  ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_USERNAME"])) &
      ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password),
                                                  ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_PASSWORD"]))
    end
    mount Sidekiq::Web, at: "/sidekiq"
  end
end
