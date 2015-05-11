class CreateVolumePriceModel < ActiveRecord::Migration

  def self.up
    create_table :volume_price_models do |t|
      t.string :name
      t.timestamps
    end

    create_table :spree_volume_price_model_variant do |t|
      t.belongs_to :volume_price_model, index: true
      t.belongs_to :variant, index: true
    end

    remove_reference :spree_volume_prices, :variant
  end


  def self.down
    add_reference :spree_volume_prices, :variant

    drop_table :spree_volume_price_models
    drop_table :spree_volume_price_model_variant
  end
end