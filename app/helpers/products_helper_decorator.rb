# returns the price of the line to show for display purposes
def line_item_price(line_item, options={})
  options.assert_valid_keys(:format_as_currency, :show_vat_text)
  options.reverse_merge! :format_as_currency => true, :show_vat_text => Spree::Config[:show_price_inc_vat]

  amount = line_item.price
  amount += Calculator::Vat.calculate_tax_on(product_or_variant) if Spree::Config[:show_price_inc_vat]
  options.delete(:format_as_currency) ? format_price(amount, options) : amount
end