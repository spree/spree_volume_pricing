require 'spec_helper'

describe Spree::LineItem do
  before :each do
    @order = FactoryGirl.create(:order)
    @variant = FactoryGirl.create(:variant, :price => 10)
    @variant.volume_prices.create! :amount => 9, :discount_type => 'price', :range => '(2+)'
    @order.contents.add(@variant, 1)
    @line_item = @order.line_items.first
  end

  it 'should update the line item price when the quantity changes to match a range' do
    expect(@line_item.price.to_f).to eq(10.00)
    @order.contents.add(@variant, 1)
    expect(@order.line_items.first.price.to_f).to eq(9.00)
  end
end
