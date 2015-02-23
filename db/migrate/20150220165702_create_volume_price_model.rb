class CreateVolumePriceModel < ActiveRecord::Migration

  def self.up
    create_table :volume_price_models do |t|
      t.string :name
    end

    create_table :spree_volume_price_model_variant do |t|
      t.belongs_to :volume_price_model, index: true
      t.belongs_to :variant, index: true
    end

    remove_reference :spree_volume_prices, :variant
    add_reference :spree_volume_prices, :volume_price_models
    add_reference :spree_variants, :volume_price_models
  end


  def self.down
    add_reference :spree_volume_prices, :variant
    remove_reference :spree_volume_prices, :volume_price_models
    remove_reference :spree_variants, :volume_price_models

    drop_table :spree_volume_price_models
    drop_table :spree_volume_price_model_variant
  end
end