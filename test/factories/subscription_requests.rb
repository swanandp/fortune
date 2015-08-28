FactoryGirl.define do
  factory :subscription_request do
    email { FFaker::Internet.email }
  end
end
