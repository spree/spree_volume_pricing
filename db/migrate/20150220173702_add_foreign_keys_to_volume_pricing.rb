class AddForeignKeysToVolumePricing < ActiveRecord::Migration

  def change
    add_reference :spree_volume_prices, :volume_price_model
  end
  
end