RSpec.describe Spree::Variant, type: :model do

  it { is_expected.to have_and_belong_to_many(:volume_price_models) }

  describe '#volume_price' do

    context 'discount_type = price' do

      let(:vp_model) { build(:volume_price_model, volume_prices: [create(:volume_price, amount: 9, discount_type: 'price', range: '(10+)')]) }
      let(:variant) { Spree::Variant.new(price: 10, volume_price_models: [vp_model]) }
      # before :each do
      #   @model = build_stubbed(:volume_price_model)
      #   @model.volume_prices.create! :amount => 9, :discount_type => 'price', :range => '(10+)'
      #   @variant = build_stubbed :variant, :price => 10, :volume_price_model => @model
      #   #@variant.volume_prices(@model.role).create! :amount => 9, :discount_type => 'price', :range => '(10+)'
      # end

      it 'should use the variants price when it does not match a range' do
        expect(variant.volume_price(1).to_f).to eq(10.00)
      end

      it 'should use the volume price when it does match a range' do
        expect(variant.volume_price(10).to_f).to eq(9.00)
      end

      it 'it should give percent of earning' do
        expect(variant.volume_price_earning_percent(10)).to eq(10)
      end

      it 'should give zero percent earning if doesnt match' do
        expect(variant.volume_price_earning_percent(1)).to eq(0)
      end

      it 'should give amount earning' do 
        expect(variant.volume_price_earning_amount(10)).to eq(1)
      end

      it 'should give zero earning amount if doesnt match' do
        expect(variant.volume_price_earning_amount(1)).to eq(0)
      end
    end

    # context 'discount_type = dollar' do
    #   before :each do
    #     @variant = FactoryGirl.create :variant, :price => 10
    #     @variant.volume_prices.create! :amount => 1, :discount_type => 'dollar', :range => '(10+)'
    #   end

    #   it 'should use the variants price when it does not match a range' do
    #     expect(@variant.volume_price(1).to_f).to eq(10.00)
    #   end

    #   it 'should use the volume price when it does match a range' do
    #     expect(@variant.volume_price(10).to_f).to eq(9.00)
    #   end

    #   it 'it should give percent of earning' do
    #     expect(@variant.volume_price_earning_percent(10)).to eq(10)
    #   end

    #   it 'should give zero percent earning if doesnt match' do
    #     expect(@variant.volume_price_earning_percent(1)).to eq(0)
    #   end

    #   it 'should give amount earning' do 
    #     expect(@variant.volume_price_earning_amount(10)).to eq(1)
    #   end

    #   it 'should give zero earning amount if doesnt match' do
    #     expect(@variant.volume_price_earning_amount(1)).to eq(0)
    #   end
    # end

    # context 'discount_type = percent' do
    #   before :each do
    #     @variant = FactoryGirl.create :variant, :price => 10
    #     @variant.volume_prices.create! :amount => 0.1, :discount_type => 'percent', :range => '(10+)'
    #   end

    #   it 'should use the variants price when it does not match a range' do
    #     expect(@variant.volume_price(1).to_f).to eq(10.00)
    #   end

    #   it 'should use the volume price when it does match a range' do
    #     expect(@variant.volume_price(10).to_f).to eq(9.00)
    #   end

    #   it 'should give percent of earning' do
    #     expect(@variant.volume_price_earning_percent(10)).to eq(10)
    #     @variant_five = FactoryGirl.create :variant, :price => 10
    #     @variant_five.volume_prices.create! :amount => 0.5, :discount_type => 'percent', :range => '(1+)'
    #     expect(@variant_five.volume_price_earning_percent(1)).to eq(50)
    #   end

    #   it 'should give zero percent earning if doesnt match' do
    #     expect(@variant.volume_price_earning_percent(1)).to eq(0)
    #   end

    #   it 'should give amount earning' do 
    #     expect(@variant.volume_price_earning_amount(10)).to eq(1)
    #     @variant_five = FactoryGirl.create :variant, :price => 10
    #     @variant_five.volume_prices.create! :amount => 0.5, :discount_type => 'percent', :range => '(1+)'
    #     expect(@variant_five.volume_price_earning_amount(1)).to eq(5)
    #   end

    #   it 'should give zero earning amount if doesnt match' do
    #     expect(@variant.volume_price_earning_amount(1)).to eq(0)
    #   end

    # end

  end
end
