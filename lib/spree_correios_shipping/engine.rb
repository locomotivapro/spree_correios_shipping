module Spree::CorreiosShipping
end

module SpreeCorreiosShipping
  class Engine < Rails::Engine
    require 'spree/core'
    isolate_namespace Spree
    engine_name 'spree_correios_shipping'

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end
    
    initializer "spree.active_shipping.preferences", :before => :load_config_initializers do |app|
      Spree::CorreiosShipping::Config = Spree::CorreiosShippingConfiguration.new
    end

    def self.activate      
      Dir[File.join(File.dirname(__FILE__), "../../app/models/spree/calculator/**/base.rb")].sort.each do |c|
        Rails.env.production? ? require(c) : load(c)
      end

      Dir.glob(File.join(File.dirname(__FILE__), "../../app/**/*_decorator*.rb")) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.autoload_paths += %W(#{config.root}/lib)
    config.to_prepare &method(:activate).to_proc

    initializer "spree_correios_shipping.register.calculators" do |app|
      # Dir[File.join(File.dirname(__FILE__), "../../app/models/spree/calculator/**/*.rb")].sort.each do |c|
      #         Rails.env.production? ? require(c) : load(c)
      #       end
      require File.join(File.dirname(__FILE__), '../../app/models/spree/calculator/sedex/base')

      app.config.spree.calculators.shipping_methods << Spree::Calculator::Sedex::Base
    end
      

    config.to_prepare &method(:activate).to_proc
  end
end
