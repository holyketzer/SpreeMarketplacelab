module Spree
  module Marketplace
    class ListenerController < Spree::Api::BaseController

      def listing
        listing_id = request.POST["ListingId"]

        marketplace_api = ::Marketplace::Api.instance
        listing = marketplace_api.get_listing(listing_id)

        marketplace_api.notify(:listing_created, listing)

        @result = "ok"
      end
    end
  end
end