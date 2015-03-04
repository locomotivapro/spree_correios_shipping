module Spree
  class ProductPackage < ActiveRecord::Base

    validates :length, :width, :height, :weight,
              :numericality => { :only_integer => true,
                                 :message => Spree.t('validation.must_be_int'),
                                 :greater_than => 0 }
  end
end
