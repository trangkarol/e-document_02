# config/initializers/carrierwave.rb
CarrierWave.configure do |config|
  config.storage = :file
  config.permissions = 0600
  config.directory_permissions = 0700
  config.storage = :file
  config.asset_host = ActionController::Base.asset_host
end

