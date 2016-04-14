FactoryGirl.define do
  factory :user do
    sequence(:last_name) { |n| "last_name#{n}" }
    sequence(:first_name) { |n| "first_name#{n}" }
  end

  factory :number do
    association :user, factory: :user
    sequence(:value) { |n| n }
  end


end
