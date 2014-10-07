FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "TestUser#{n}" }
    sequence(:email) { |n| "foo-#{n}@bar.org" }
    password "swordfish"
    password_confirmation "swordfish"
  end
end
