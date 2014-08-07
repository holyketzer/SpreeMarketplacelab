require 'httparty'

module Marketplace

  class Api

    def initialize(api_key, account_key, api_base_url)
      @api_key = api_key
      @account_key = account_key
      @api_base_url = api_base_url
    end


    # get listings for a product(s)
    # @product_ids comma separated list of product identifiers
    def get_listings(product_ids)
      get_api_response("/api/products/listings?", "id=" + product_ids)
    end


    private
      def get_api_response(endpoint_url, params)
        response = HTTParty.get(@api_base_url + endpoint_url + params + "&apikey=" + @api_key + "&accountkey=" + @account_key, :verify => false)

        return convert_array_to_ruby_style response unless response == nil
      end



      def convert_array_to_ruby_style(camel_case_arr)

        ruby_arr = []

        camel_case_arr.each do |arr_item|

          ruby_case_hash = {}

          arr_item.each_pair do |key, val|

            # if value is a Hash we convert keys to ruby_style
            val = convert_hash_to_ruby_style val if val.is_a? Hash

            # if value is an Array we iterate over it and change items
            if val.is_a? Array
              val.map! do |item|
                item = convert_hash_to_ruby_style item if item.is_a? Hash
              end
            end

            # add converted hash pair to new has
            ruby_case_hash.merge!({ActiveSupport::Inflector.underscore(key) => val})

          end

          ruby_arr.push(ruby_case_hash)
        end

        ruby_arr
      end

      def convert_hash_to_ruby_style(camel_case_hash)

        ruby_case_hash = {}

        camel_case_hash.each_pair do |key, val|

          # if value is a Hash we convert keys to ruby_style
          val = convert_hash_to_ruby_style val if val.is_a? Hash

          # if value is an Array we iterate over it and change items
          if val.is_a? Array
            val.map! do |item|
              item = convert_hash_to_ruby_style item if item.is_a? Hash
            end
          end

          # add converted hash pair to new has
          ruby_case_hash.merge!({ActiveSupport::Inflector.underscore(key) => val})

        end

        ruby_case_hash

      end


  end

end