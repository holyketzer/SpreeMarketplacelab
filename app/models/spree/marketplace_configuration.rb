# These will be saved with key: marketplace_lab/store_configuration/api_key
module Spree
  class MarketplaceConfiguration < Preferences::Configuration
    preference :apiKey, :string
    preference :accountKey, :string
    preference :apiBaseUrl, :string
  end
end
