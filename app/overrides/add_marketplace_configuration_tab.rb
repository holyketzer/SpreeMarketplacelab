Deface::Override.new(:virtual_path => "spree/admin/shared/_configuration_menu",
                     :name => "add_marketplace_configuration_tab",
                     :insert_bottom => "[data-hook='admin_configurations_sidebar_menu'], #admin_configurations_sidebar_menu[data-hook]",
                     :text => "<li<%== ' class=\"active\"' if controller.controller_name == 'marketplace_configuration' %>><%= link_to 'Marketplace Configuration', admin_marketplace_configuration_path %></li>")