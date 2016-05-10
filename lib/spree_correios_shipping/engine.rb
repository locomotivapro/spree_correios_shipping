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

    initializer "spree.correios_shipping.preferences", :before => :load_config_initializers do |app|
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

    initializer "spree_correios_shipping.register.calculators", after: 'spree.register.calculators' do |app|
      Dir[File.join(File.dirname(__FILE__), "../../app/models/spree/calculator/shipping/correios/*.rb")].sort.each do |c|
        Rails.env.production? ? require(c) : load(c)
      end

      #app.config.spree.stock_splitters << Spree::Stock::Splitter::CorreiosWeight

      app.config.spree.calculators.shipping_methods.concat([Spree::Calculator::Shipping::Correios::ESedex,
                                                            Spree::Calculator::Shipping::Correios::ESedexExpress,
                                                            Spree::Calculator::Shipping::Correios::ESedexGrupo1,
                                                            Spree::Calculator::Shipping::Correios::ESedexGrupo2,
                                                            Spree::Calculator::Shipping::Correios::ESedexGrupo3,
                                                            Spree::Calculator::Shipping::Correios::ESedexPrioritario,
                                                            Spree::Calculator::Shipping::Correios::Pac,
                                                            Spree::Calculator::Shipping::Correios::PacComContrato,
                                                            Spree::Calculator::Shipping::Correios::Sedex,
                                                            Spree::Calculator::Shipping::Correios::Sedex10,
                                                            Spree::Calculator::Shipping::Correios::SedexACobrar,
                                                            Spree::Calculator::Shipping::Correios::SedexACobrarComContrato,
                                                            Spree::Calculator::Shipping::Correios::SedexComContrato1,
                                                            Spree::Calculator::Shipping::Correios::SedexComContrato2,
                                                            Spree::Calculator::Shipping::Correios::SedexComContrato3,
                                                            Spree::Calculator::Shipping::Correios::SedexComContrato4,
                                                            Spree::Calculator::Shipping::Correios::SedexComContrato5,
                                                            Spree::Calculator::Shipping::Correios::SedexHoje,
                                                            Spree::Calculator::Shipping::Correios::Overweight
      ])
    end

    initializer "spree.assets.precompile", :group => :all do |app|
      app.config.assets.precompile += %w[
        spree/backend/product_packages/new.js
        spree/backend/product_packages/edit.js
        spree/backend/product_packages/index.js
      ]
    end
  end
end
