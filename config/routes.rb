Spree::Core::Engine.routes.draw do
  namespace :admin do
    resource :correios_shipping_settings, only: ['update', 'edit']

    resources :product_packages
  end
end
