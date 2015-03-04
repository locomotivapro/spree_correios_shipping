module Spree
  module Admin
    class ProductPackagesController < ResourceController

      private

        def permitted_product_package_attributes
          [:length, :width, :height, :weight]
        end
    end
  end
end
