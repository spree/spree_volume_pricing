# frozen_string_literal: true

Spree::LineItem.class_eval do
  #from multi_currency
  def update_price
   # currency_price = Spree::Price.where(
   #   currency: order.currency,
   #   variant_id: variant_id
   # ).first

   # self.price = currency_price.price_including_vat_for(tax_zone: tax_zone)

    copy_price
  end

  # pattern grabbed from: http://stackoverflow.com/questions/4470108/

  # the idea here is compatibility with spree_sale_products
  # trying to create a 'calculation stack' wherein the best valid price is
  # chosen for the product. This is mainly for compatibility with spree_sale_products
  #
  # Assumption here is that the volume price currency is the same as the product currency
  old_copy_price = instance_method(:copy_price)
  define_method(:copy_price) do
    #old_copy_price.bind(self).call

    if variant
      if changed? && (changes.keys.include?('quantity') || changes.keys.include?('currency'))
        vprice = self.variant.volume_price(self.quantity, self.order.user, self.currency)
        if self.price.present? && vprice <= self.variant.price
          self.price = vprice and return
        end
      end

      if self.price.nil?
        self.price = self.variant.price
      end
    end
  end

end
