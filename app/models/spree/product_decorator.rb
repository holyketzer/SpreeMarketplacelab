Spree::Product.class_eval do
  def listings
    return @listings unless @listings == nil

    # get config parameters for API Key and Account Key
    api_key = SpreeMarketplacelab::Config[:apiKey]
    account_key = SpreeMarketplacelab::Config[:accountKey]
    api_base_url = SpreeMarketplacelab::Config[:apiBaseUrl]

    marketplace_api = Marketplace::Api.new(api_key, account_key, api_base_url)

    if sku.empty?
      @listings = []
    else
      @listings = marketplace_api.get_listings(sku)
    end
  end
end