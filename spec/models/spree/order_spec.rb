RSpec.describe Spree::Order, type: :model do

  let(:user) { FactoryGirl.create(:wholesale) }
  let(:vp_model)  { create(:volume_price_model, role: user.resolve_role) }
  let(:vp_model2) { build(:volume_price_model, role: user.resolve_role, volume_prices: [create(:volume_price, :discount_type => 'price', :range => '(1..5)', :amount => 9), create(:volume_price, :discount_type => 'price', :range => '(5..9)', :amount => 8)]) }

  let(:variant) { create(:variant, price: 10, volume_price_models: [vp_model]) }
  let(:variant_with_prices) { create(:variant, price: 10, volume_price_models: [vp_model2]) }
  let(:order) { FactoryGirl.create(:order, user: user) }


  describe "add_variant" do
    it "should use the variant price if there are no volume prices" do
      order.contents.add(variant)
      expect(order.line_items.first.price).to eq(10)
    end

    it "should use the volume price if quantity falls within a quantity range of a volume price" do
      vp_model.volume_prices.create!(:discount_type => 'price', :range => '(5..10)', :amount => 9)
      order.contents.add(variant_with_prices, 7)
      expect(order.line_items.first.price).to eq(8)
    end

    it "should use the variant price if the quantity fails to satisfy any of the volume price ranges" do
      order.contents.add(variant, 10)
      expect(order.line_items.first.price).to eq(10)
    end

    it "should use the first matching volume price in the event of more then one matching volume prices" do
      order.contents.add(variant_with_prices, 5)
      expect(order.line_items.first.price).to eq(9)
    end
  end
end
