module Spree
  class PricesCorreio < ActiveRecord::Base
    attr_accessible :zipcode, :weight, :services

    serialize :services, Hash

    validates :zipcode, :weight, :services, presence: true

    belongs_to :order
  end
end
