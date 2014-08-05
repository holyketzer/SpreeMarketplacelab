require 'httparty'


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


Spree::Product.class_eval do

  def listings

    return @listings if @listings != nil

    # get config parameters for API Key and Account Key
    api_key = SpreeMarketplacelab::Config[:apiKey]
    account_key = SpreeMarketplacelab::Config[:accountKey]
    api_base_url = SpreeMarketplacelab::Config[:apiBaseUrl]

    # grab a listing from marketplace API
    listingsResponseCamelCase = HTTParty.get(api_base_url + "/api/products/listings?id=" + 387.to_s + "&apikey=" + api_key + "&accountkey=" + account_key)

    # convert hash keys to ruby_style_hash_keys from CamelCase
    listingsResponseRubyCase = convert_array_to_ruby_style(listingsResponseCamelCase)

    # assign converted response to an instance variable @listing
    @listings = listingsResponseRubyCase
  end

end