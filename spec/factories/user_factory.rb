FactoryGirl.define do
  factory :user do
    email "foo@bar.org"
    password "swordfish"
    password_confirmation "swordfish"
  end
end