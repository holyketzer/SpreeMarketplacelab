module Spree
  module Marketplace
    class ListenerController < Spree::Api::BaseController

      def listing
        @result = 42
      end

    end
  end
end