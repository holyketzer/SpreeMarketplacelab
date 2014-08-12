module Spree
  ProductsController.class_eval do
    before_filter :fetch_listings, only: :show

    def fetch_listings
      # accessing listings method would load (and cache) listings from the marketplace
      @product.listings if @product
    end

    def index_with_listings
      index_without_listings
      Product.load_listings(@products)
    end

    alias_method_chain :index, :listings
  end
end