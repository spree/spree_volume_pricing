Deface::Override.new(:virtual_path => "spree/admin/variants/edit",
                     :name => "add_volume_pricing_model_field_to_variant",
                     :insert_after => "[data-hook='admin_variant_edit_form']",
                     :partial => "spree/admin/variants/edit_volume_price_model_fields",
                     :disabled => false)