Spree::Core::Engine.routes.draw do
  namespace :admin do
    #get '/correios_preferences', to: "correios#preferences", as: :correios_preferences
    get 'correios_settings', to: 'correios_settings#show', as: :correios_settings
    get 'correios_settings/edit', to: 'correios_settings#edit', as: :edit_correios_settings
    put 'correios_settings', to: 'correios_settings#update', as: :correios_settings
  end
end
