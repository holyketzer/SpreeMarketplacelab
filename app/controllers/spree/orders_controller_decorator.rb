Spree::OrdersController.class_eval do
  before_filter :fetch_listing, only: :populate

  private

  def fetch_listing
    if params[:listing_id]
      api = Marketplace::Api.instance
      @listing = api.get_listing(params[:listing_id])
    end
  end
end