module Spree
  class PricesCorreio < ActiveRecord::Base
    attr_accessible :zipcode, :weight, :services

    serialize :services, Hash

    validates :zipcode, :weight, presence: true

    belongs_to :order
    before_save :compute

    private

    def compute
      services = Spree::CorreiosShipping::Config[:services].split(',')
      services.map! { |s| s.strip.to_sym }
      count = 0
      frete = Correios::Frete::Calculador.new :cep_origem => Spree::CorreiosShipping::Config[:origin_zip_code],
        :cep_destino => zipcode,
        :peso => weight,
        :comprimento => 30,
        :largura => 15,
        :altura => 2,
        :codigo_empresa => Spree::CorreiosShipping::Config[:id_correios],
        :senha => Spree::CorreiosShipping::Config[:password_correios]

      response = begin
                   servico = frete.calcular *services
                 rescue => e
                   count += 1
                   retry unless count > 3
                   nil
                 end

      unless response.nil?
        response_hash = {}
        services.each do |service|
          response_hash[service] = {price: response[service].valor, delivery_time: response[service].prazo_entrega}
        end
        self.services = response_hash
      end

    end

  end
end
