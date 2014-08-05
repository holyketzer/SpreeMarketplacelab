module Spree
  ProductsController.class_eval do
    before_filter :fetch_listings, :only => :show

    def fetch_listings
      # accessing listings method would load (and cache) listings from the marketplace
      @product.listings

      @product
    end
  end
end