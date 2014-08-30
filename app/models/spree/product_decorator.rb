Spree::Product.class_eval do
  attr_writer :listings

  def listings
    return @listings if @listings

    marketplace_api = Marketplace::Api.instance

    @listings = marketplace_api.get_listings(sku) if sku.present?
    @listings ||= []
  end

  # returns all available prices for current Spree currency
  def listing_prices
    key = 'listing_prices'
    listings.map do |listing|
      if listing[key] && listing[key].any?
        # Find current Spree currency in listing, else use first
        listing[key].find { |price| price['currency_type'] == Spree::Config[:currency] }
      end
    end.compact.map { |price| price['amount'] }
  end
end

Spree::Product.instance_eval do
  def load_listings(products)
    skus = products.map { |p| p.sku }.select { |sku| sku.present? }.uniq.join(',')
    marketplace_api = Marketplace::Api.instance
    listings = marketplace_api.get_listings(skus) if skus.present?
    listings ||= []

    products.each do |product|
      product.listings = listings.select { |l| l['store_product_id'] == product.sku } || []
    end
  end
end