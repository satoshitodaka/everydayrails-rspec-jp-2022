FactoryBot.define do
  factory :user do
    first_name { 'satoshi' }
    last_name { 'todaka' }
    sequence(:email) { |n| "test#{n}@example.com" }
    password { 'password' }
  end
end
