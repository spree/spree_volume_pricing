require 'spec_helper'

RSpec.describe Spree::Admin::VariantsController, :type => :controller do
  stub_authorization!

  describe "PUT #update" do
    let(:variant) { create :variant }
    let(:model) { create :volume_price_model }

    it "adds a volume price model" do

      # expect do
      #   spree_put :update,
      #     :product_id => variant.product.slug,
      #     :id => variant.id,
      #     :variant_price_model => model
      # end.to change(variant.volume_price_models, :count).by(1)

    end
  end
end
