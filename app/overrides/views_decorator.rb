Deface::Override.new(:virtual_path => "spree/admin/variants/edit",
                     :name => "add_volume_pricing_model_field_to_variant",
                     :insert_after => "[data-hook='admin_variant_edit_form']",
                     :partial => "spree/admin/variants/edit_volume_price_model_fields",
                     :disabled => false)

Deface::Override.new(
  virtual_path:  'spree/admin/shared/_configuration_menu',
  name:          'add_volume_price_model_admin_menu_links',
  insert_bottom: "[data-hook='admin_configurations_sidebar_menu']"
) do
  <<-HTML
    <%= configurations_sidebar_menu_item Spree.t('volume_price_models'), admin_volume_price_models_path %>
  HTML
end
