Deface::Override.new(:virtual_path => "admin/shared/_product_tabs",
                      :name => "add_volume_pricing_admin_tab",
                      :insert_bottom => "[data-hook='admin_product_tabs']",
                      :partial => "admin/shared/vp_product_tab",
                      :disabled => false)

Deface::Override.new(:virtual_path => "admin/variants/edit",
                     :name => "add_volume_pricing_field_to_variant",
                     :insert_after => "[data-hook='admin_variant_edit_form']",
                     :partial => "admin/variants/edit_fields",
                     :disabled => false)

Deface::Override.new(:virtual_path => "shared/_products",
                    :name => "products_list_item",
                    :replace=> "[data-hook='product-listing']",
                    :partial => "shared/product_listing",
                    :disabled => false)