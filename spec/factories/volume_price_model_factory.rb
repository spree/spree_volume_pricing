FactoryGirl.define do 
  factory :volume_price_model, :class => Spree::VolumePriceModel do |f|
    sequence(:name) { |n| "Volume Price Model ##{n} - #{Kernel.rand(9999)}" }
    f.role {|p| p.association(:role) }
    after(:create) {|vpm| vpm.variants = [build_stubbed(:variant)] }

    factory :volume_price_model_with_volume_prices do

      transient do
        variants_count 4
      end

      after(:create) do |vpm, evaluator|
        create_list(:variant, evaluator.variants_count, volume_price_model: vpm)
      end
    end
  end
end