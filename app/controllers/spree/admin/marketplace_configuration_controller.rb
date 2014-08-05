module Spree
  module Admin
    class MarketplaceConfigurationController < ResourceController
      def update
        config = Spree::MarketplaceConfiguration.new

        params.each do |name, value|
          next unless config.has_preference? name
          config[name] = value
        end

        # if Spree::Config.has_preference? :show_raw_product_description
        #   Spree::Config[:show_raw_product_description] = config[:enabled]
        # end

        flash[:success] = 'Marketplace configuration saved successfully.'
        render :edit
      end
    end
  end
end