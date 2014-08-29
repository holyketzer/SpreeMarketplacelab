Spree::Core::Engine.routes.draw do

  get "/listings" => "home#listings"

  namespace :admin do
    get "listings", to: "listings#index"
    get "marketplace_configuration", to: "marketplace_configuration#edit"
    put "marketplace_configuration", to: "marketplace_configuration#update"
    resource :marketplace_configuration, only: [:edit, :update]
  end

  namespace :marketplace, defaults: { format: 'json' } do
    post "/listener/listing" => "listener#listing"
  end
end
