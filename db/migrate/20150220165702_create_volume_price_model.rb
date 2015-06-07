class CreateVolumePriceModel < ActiveRecord::Migration

  def change
    create_table :volume_price_models do |t|
      t.string :name
      t.timestamps
      t.belongs_to :role
    end

    create_table :spree_volume_price_model_variant do |t|
      t.belongs_to :volume_price_model
      t.belongs_to :variant
    end

    add_index :spree_volume_price_model_variant, :volume_price_model_id, name: 'volume_price_model_id'
    add_index :spree_volume_price_model_variant, :variant_id, name: 'variant_id'

    remove_reference :spree_volume_prices, :variant
  end

end