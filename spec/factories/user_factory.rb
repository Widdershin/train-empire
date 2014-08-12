FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "foo-#{n}@bar.org" }
    password "swordfish"
    password_confirmation "swordfish"
  end
end