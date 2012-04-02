Variant.class_eval do 
  has_many :volume_prices, :order => :position, :dependent => :destroy
  accepts_nested_attributes_for :volume_prices, :allow_destroy => true

  # calculates the price based on quantity
  def volume_price(quantity)
    puts "volume price"
    if self.volume_prices.count == 0
      return self.price
      puts "no volume prices - return #{self.price}"
    else
      puts "foun volume prices"
      self.volume_prices.each do |price|
        if price.include?(quantity)
          case price.discount_type
          when 'price'
            return price.amount
          when 'dollar'
            return self.price - price.amount
          when 'percent'
            return self.price * (1 - price.amount)
          else
            return self.price
          end
        else
          self.price
        end
      end
    end
  end

end
