module Spree
  class ProductPackage < ActiveRecord::Base

    validates :length, :width, :height,
              :numericality => { :only_integer => true,
                                 :message => Spree.t('validation.must_be_int'),
                                 :greater_than => 0 }

    scope :smallest_to_biggest, -> { all.sort }

    def volume
      length * width * height
    end

    def <=>(other)
      volume <=> other.volume
    end

  end
end
