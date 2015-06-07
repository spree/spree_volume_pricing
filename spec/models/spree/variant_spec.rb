RSpec.describe Spree::Variant, type: :model do

  it { is_expected.to have_and_belong_to_many(:volume_price_models) }

  describe '#volume_price' do
    let(:user) { FactoryGirl.create(:wholesale) }
    context 'discount_type = price' do

      let(:vp_model) { build(:volume_price_model, role: user.resolve_role, volume_prices: [create(:volume_price, amount: 9, discount_type: 'price', range: '(10+)')]) }
      let(:variant) { create(:variant, price: 10, volume_price_models: [vp_model]) }


      it 'should use the variants price when it does not match a range' do
        expect(variant.volume_price(1, user).to_f).to eq(10.00)
      end

      it 'should use the volume price when it does match a range' do
        expect(variant.volume_price(10, user).to_f).to eq(9.00)
      end

      it 'it should give percent of earning' do
        expect(variant.volume_price_earning_percent(10, user)).to eq(10)
      end

      it 'should give zero percent earning if doesnt match' do
        expect(variant.volume_price_earning_percent(1, user)).to eq(0)
      end

      it 'should give amount earning' do
        expect(variant.volume_price_earning_amount(10, user)).to eq(1)
      end

      it 'should give zero earning amount if doesnt match' do
        expect(variant.volume_price_earning_amount(1, user)).to eq(0)
      end
    end

    context 'discount_type = percent' do

      let(:vp_model) { build(:volume_price_model, role: user.resolve_role, volume_prices: [create(:volume_price, :amount => 0.1, :discount_type => 'percent', :range => '(10+)')]) }
      let(:variant) { create(:variant, price: 10, volume_price_models: [vp_model]) }


      it 'should use the variants price when it does not match a range' do
        expect(variant.volume_price(1, user).to_f).to eq(10.00)
      end

      it 'should use the volume price when it does match a range' do
        expect(variant.volume_price(10, user).to_f).to eq(9.00)
      end

      it 'it should give percent of earning' do
        expect(variant.volume_price_earning_percent(10, user)).to eq(10)
        vp_model_five = build(:volume_price_model, role: user.resolve_role, volume_prices: [create(:volume_price, :amount => 0.5, :discount_type => 'percent', :range => '(1+)')])
        variant_five = create(:variant, price: 10, volume_price_models: [vp_model_five])
        expect(variant_five.volume_price_earning_percent(1, user)).to eq(50)
      end

      it 'should give zero percent earning if doesnt match' do
        expect(variant.volume_price_earning_percent(1, user)).to eq(0)
      end

      it 'should give amount earning' do
        expect(variant.volume_price_earning_amount(10, user)).to eq(1)
        vp_model_five = build(:volume_price_model, role: user.resolve_role, volume_prices: [create(:volume_price, :amount => 0.5, :discount_type => 'percent', :range => '(1+)')])
        variant_five = create(:variant, price: 10, volume_price_models: [vp_model_five])
        expect(variant_five.volume_price_earning_amount(1, user)).to eq(5)
      end

      it 'should give zero earning amount if doesnt match' do
        expect(variant.volume_price_earning_amount(1, user)).to eq(0)
      end
    end

  end
end
