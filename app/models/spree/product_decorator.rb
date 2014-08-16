Spree::Product.class_eval do
  def listings
    return @listings if @listings

    marketplace_api = Marketplace::Api.instance

    @listings = marketplace_api.get_listings(sku) if sku.present?
    @listings ||= []
  end

  attr_writer :listings
end

Spree::Product.instance_eval do
  def load_listings(products)
    skus = products.map { |p| p.sku }.select { |sku| sku.present? }.join(',')
    marketplace_api = Marketplace::Api.instance
    listings = marketplace_api.get_listings(skus) if skus.present?
    listings ||= []

    products.each { |p| p.listings = [] }

    listings.each do |listing|
      sku = listing['store_product_id']
      if sku.present?
        product = products.find { |p| p.sku == sku }
        product.listings << listing if product
      end
    end
  end
end