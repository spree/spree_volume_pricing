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

    # If we're passed a user try and match the role
    if(user)
      filtered_volume_prices = Spree::VolumePrice
        .where(volume_price_where(table))
        .where(table[:role_id]
          .in(user.spree_roles.pluck(:id))
        )
        .order(position: :asc)

      # If we were able to find volume pricing for their roles then return them
      # else attempt to find volume pricing with no roles specified
      if(filtered_volume_prices.length == 0)
        filtered_volume_prices = fetch_nil_volume_prices table
      end
    else
      # Return volume prices unfiltered by role
      filtered_volume_prices = fetch_nil_volume_prices table
    end

    filtered_volume_prices
    
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

  # create arel query for volume prices which belong to the variant
  def volume_price_where(table)
    table[:variant_id].eq(id).or(table[:volume_price_model_id].in(volume_price_models.ids))
  end

  # fetch all volume prices belonging to the variant with no role specified
  def fetch_nil_volume_prices(table)
    Spree::VolumePrice
      .where(volume_price_where(table))
      .where(table[:role_id].eq(nil))
      .order(position: :asc)
  end

  def use_master_variant_volume_pricing?
    Spree::Config.use_master_variant_volume_pricing && !(product.master.join_volume_prices.count == 0)
  end

  def compute_volume_price_quantities(type, default_price, quantity, user)
    volume_prices = join_volume_prices user
    if volume_prices.count == 0
      if use_master_variant_volume_pricing?
        product.master.send(type, quantity, user)
      else
        return default_price
      end
    else
      volume_prices.each do |volume_price|
        if volume_price.include?(quantity)
          return send "compute_#{type}".to_sym, volume_price
        end
      end

      # No price ranges matched.
      default_price
    end
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
