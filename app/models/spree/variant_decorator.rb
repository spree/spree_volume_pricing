Spree::Variant.class_eval do
  has_and_belongs_to_many :volume_price_models
  has_many :volume_prices, -> { order(position: :asc) }, dependent: :destroy
  has_many :model_volume_prices, -> { order(position: :asc) }, class_name: 'Spree::VolumePrice', through: :volume_price_models, source: :volume_prices
  accepts_nested_attributes_for :volume_prices, allow_destroy: true,
    reject_if: proc { |volume_price|
      volume_price[:amount].blank? && volume_price[:range].blank?
    }

  def join_volume_prices(user = nil)
    table = Spree::VolumePrice.arel_table

    if user
      Spree::VolumePrice.where(
        (table[:variant_id].eq(id)
          .or(table[:volume_price_model_id].in(volume_price_models.ids)))
          .and(table[:role_id].eq(user.resolve_role.try(:id)))
        )
        .order(position: :asc)
    else
      Spree::VolumePrice.where(
        (table[:variant_id]
          .eq(id)
          .or(table[:volume_price_model_id].in(volume_price_models.ids)))
          .and(table[:role_id].eq(nil))
        ).order(position: :asc)
    end
  end

  # calculates the price based on quantity
  def volume_price(quantity, user = nil)
    compute_volume_price_quantities :volume_price, price, quantity, user
  end

  # return percent of earning
  def volume_price_earning_percent(quantity, user = nil)
    compute_volume_price_quantities :volume_price_earning_percent, 0, quantity, user
  end

  # return amount of earning
  def volume_price_earning_amount(quantity, user = nil)
    compute_volume_price_quantities :volume_price_earning_amount, 0, quantity, user
  end

  protected

  def use_master_variant_volume_pricing?
    Spree::Config.use_master_variant_volume_pricing && product.master.volume_prices.any?
  end

  def compute_volume_price_quantities(type, default_price, quantity, _user)
    bulk_prices = volume_prices.any? ? volume_prices : product.master.volume_prices
    bulk_prices.each do |bulk_price|
      if bulk_price.include? quantity
        return send "compute_#{type}".to_sym, bulk_price
      end
    end
    default_price
  end

  def compute_volume_price(volume_price)
    case volume_price.discount_type
    when 'price'
      return volume_price.amount
    when 'dollar'
      return price - volume_price.amount
    when 'percent'
      return price * (1 - volume_price.amount)
    end
  end

  def compute_volume_price_earning_percent(volume_price)
    case volume_price.discount_type
    when 'price'
      diff = price - volume_price.amount
      return (diff * 100 / price).round
    when 'dollar'
      return (volume_price.amount * 100 / price).round
    when 'percent'
      return (volume_price.amount * 100).round
    end
  end

  def compute_volume_price_earning_amount(volume_price)
    case volume_price.discount_type
    when 'price'
      return price - volume_price.amount
    when 'dollar'
      return volume_price.amount
    when 'percent'
      return price - (price * (1 - volume_price.amount))
    end
  end
end
