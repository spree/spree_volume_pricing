Spree::Variant.class_eval do
  has_and_belongs_to_many :volume_price_models, class_name: 'Spree::VolumePriceModel', join_table: 'spree_volume_price_model_variant'

  # Resolve the pricing model
  def volume_price_model(user)
    if user
      role = user.resolve_role
    else
      role = Spree::Role.find_by name: 'user'
    end

    self.volume_price_models.by_role(role)
  end

  # Alias volume prices
  def volume_prices(user)
    model = volume_price_model(user).first
    
    if model
      return model.volume_prices
    else
      return []
    end

  end

  # calculates the price based on quantity
  def volume_price(quantity, user)
    if self.volume_prices(user).count == 0
      return self.price
    else
      self.volume_prices(user).each do |volume_price|
        if volume_price.include?(quantity)
          case volume_price.discount_type
          when 'price'
            return volume_price.amount
          when 'dollar'
            return self.price - volume_price.amount
          when 'percent'
            return self.price * (1 - volume_price.amount)
          end
        end
      end
      # No price ranges matched.
      return self.price
    end
  end

  # return percent of earning
  def volume_price_earning_percent(quantity)
    if self.volume_prices.count == 0
      return 0
    else
      self.volume_prices.each do |volume_price|
        if volume_price.include?(quantity)
          case volume_price.discount_type
          when 'price'
            diff = self.price - volume_price.amount
            return (diff * 100 / self.price).round
          when 'dollar'
            return (volume_price.amount * 100 / self.price).round
          when 'percent'
            return (volume_price.amount * 100).round
          end
        end
      end
      # No price ranges matched.
      return 0
    end
  end

  # return amount of earning
  def volume_price_earning_amount(quantity)
    if self.volume_prices.count == 0
      return 0
    else
      self.volume_prices.each do |volume_price|
        if volume_price.include?(quantity)
          case volume_price.discount_type
          when 'price'
            return self.price - volume_price.amount
          when 'dollar'
            return volume_price.amount
          when 'percent'
            return self.price - (self.price * (1 - volume_price.amount))
          end
        end
      end
      # No price ranges matched.
      return 0
    end
  end
end
