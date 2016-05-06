Spree::LineItem.class_eval do

  # this might not be compatible with spree_sale_products

  def copy_price
    if variant

      self.price = variant.price if price.nil?
      self.cost_price = variant.cost_price if cost_price.nil?
      self.currency = variant.currency if currency.nil?

      #volume_pricing
      vprice = self.variant.volume_price(self.quantity, self.order.user)
      if self.price.present? && vprice != self.variant.price
        self.price = vprice and return
      end
      #volume_pricing

    end
  end

end
