class Spree::VolumePriceModel < ActiveRecord::Base
  has_and_belongs_to_many :variants, class_name: 'Spree::Variant', join_table: 'spree_volume_price_model_variant'
  has_many :volume_prices, -> { order("position ASC") }, :dependent => :destroy
  accepts_nested_attributes_for :volume_prices, :allow_destroy => true,
    :reject_if => proc { |volume_price|
      volume_price[:amount].blank? && volume_price[:range].blank?
    }
    
  validates :name, presence: true, uniqueness: true
  validates :variant, presence: true

end
