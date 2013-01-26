FactoryGirl.define do
  factory :user do
    sequence(:email) {|i| "example#{i}@example.com"}
    password 'please12'
    password_confirmation 'please12'
  end
end
