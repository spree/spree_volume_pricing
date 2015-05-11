require 'spec_helper'

describe Spree::LineItem do
  let(:user) { FactoryGirl.create(:wholesale) }
  let(:vp_model) { build(:volume_price_model, role: user.resolve_role, volume_prices: [create(:volume_price, :amount => 9, :discount_type => 'price', :range => '(2+)')]) }
  let(:variant) { create(:variant, price: 10, volume_price_models: [vp_model]) }
  let(:order) { FactoryGirl.create(:order, user: user) }
  let(:line_item) { order.line_items.first }

  before :each do
    order.contents.add(variant, 1)
  end

  it 'should update the line item price when the quantity changes to match a range' do
    expect(line_item.price.to_f).to eq(10.00)
    order.contents.add(variant, 1)
    expect(order.line_items.first.price.to_f).to eq(9.00)
  end
end
