FactoryGirl.define do
  factory :wholesale, parent: :user do
    after(:create) do|user, evaluator|
      user.spree_roles = [create(:role, name: Spree::Config.wholesale_role)]
    end
  end
end
