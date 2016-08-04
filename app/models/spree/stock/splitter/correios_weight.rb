module Spree
  module Stock
    module Splitter
      class CorreiosWeight < Spree::Stock::Splitter::Base
        attr_reader :packer, :next_splitter

        #cattr_accessor :threshold do
          #Spree::CorreiosShipping::Config[:max_shipping_weight]
        #end

        def split(packages)
          packages.each do |package|
            removed_contents = reduce package
            packages << build_package(removed_contents) unless removed_contents.empty?
          end
          return_next packages
        end

        private
        def reduce(package)
          removed = []
          while package.weight > self.threshold.to_f
            break if package.contents.size == 1
            removed << package.contents.shift
          end
          removed
        end
      end
    end
  end
end
