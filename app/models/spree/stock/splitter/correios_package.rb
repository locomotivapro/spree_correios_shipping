module Spree
  module Stock
    module Splitter
      class CorreiosPackage < Spree::Stock::Splitter::Base
        attr_reader :packer, :next_splitter

        def available_product_packages
          ProductPackage.all
        end

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


        def organize_packages(packages)

        end

        def boxes_volume
          boxes_array = available_product_packages.inject([]) { |arr, box| arr << (box.widht * box.height * box.depth) }
          boxes_array.sort
        end

        def total_package_volume(package)
          package.contents.inject(0.0) { |volume, item| volume += (item.width * item.height * item.depth ) }
        end

        def package_fits_inside_box(package)
          package_volume = total_package_volume(package)
          box = boxes_volume.detect { |box| package_volume <= box }
        end

      end
    end
  end
end
