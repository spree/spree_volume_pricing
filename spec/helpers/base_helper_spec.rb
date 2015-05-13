require 'spec_helper'

describe Spree::BaseHelper do
  include Spree::BaseHelper

  context "volume pricing" do
    let(:spree_current_user) { FactoryGirl.create(:wholesale) }
    let(:vp_model) { build(:volume_price_model, role: spree_current_user.resolve_role, volume_prices: [create(:volume_price, :amount => 1, :discount_type => 'dollar', :range => '(10+)')]) }
    let(:variant) { create(:variant, price: 10, volume_price_models: [vp_model]) }

    it "should give discounted price" do
      expect(display_volume_price(variant, 10)).to eq "$9.00"
    end

    it "should give discount percent" do
      expect(display_volume_price_earning_percent(variant, 10)).to eq "10"
    end

    it "should give discount amount" do
      expect(display_volume_price_earning_amount(variant, 10)).to eq "$1.00"
    end
  end
end
