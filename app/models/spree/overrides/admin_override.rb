Deface::Override.new(:virtual_path  => "spree/admin/configurations/index",
                     :name          => "spree_correios_conf",
                     :insert_bottom => "[data-hook='admin_configurations_menu']",
                     :partial       => "spree/admin/shared/correios_config",
                     :disabled      => false)

