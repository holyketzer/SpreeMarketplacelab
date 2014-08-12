Spree::Product.class_eval do
  def listings
    return @listings if @listings

    marketplace_api = Spree::Product.get_marketplace_api

    @listings = marketplace_api.get_listings(sku) if sku.present?
    @listings ||= []
  end

  attr_writer :listings
end

Spree::Product.instance_eval do
  def get_marketplace_api
    # get config parameters for API Key and Account Key
    api_key = SpreeMarketplacelab::Config[:apiKey]
    account_key = SpreeMarketplacelab::Config[:accountKey]
    api_base_url = SpreeMarketplacelab::Config[:apiBaseUrl]

    Marketplace::Api.new(api_key, account_key, api_base_url)
  end

  def load_listings(products)
    skus = products.map { |p| p.sku }.select { |sku| sku.present? }.join(',')
    marketplace_api = Spree::Product.get_marketplace_api
    listings = marketplace_api.get_listings(skus) if skus.present?
    listings ||= []

    products.each { |p| p.listings = [] }

    listings.each do |listing|
      sku = listing['store_product_id']
      if sku.present?
        product = products.find { |p| p.sku == sku }
        product.listings << listing if product
        puts ">>> loaded listing for #{sku}"
      end
    end
  end
end