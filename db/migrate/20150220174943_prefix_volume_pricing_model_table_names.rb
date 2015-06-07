class PrefixVolumePricingModelTableNames < ActiveRecord::Migration
  def change
    rename_table :volume_price_models, :spree_volume_price_models unless Spree::VolumePriceModel.table_exists?
  end
end