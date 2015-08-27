# run the following command with your redis URL filled in
# REDISTOGO_URL=xxx thin start -R sidekiq-config.ru -p 3001
# then go to 127.0.0.1:3001 in your browser

require 'sidekiq'

Sidekiq.configure_client do |config|
  config.redis = { :url => ENV["REDISTOGO_URL"] }
end

require 'sidekiq/web'
run Sidekiq::Web
