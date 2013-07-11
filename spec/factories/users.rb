# Read about factories at https://github.com/thoughtbot/factory_girl
FactoryGirl.define do
  sequence :user_seq do |n|
    "testuser.#{n}@example.com"
  end
end

FactoryGirl.define do
  factory :user do
    name "Test User"
    email { FactoryGirl.generate :user_seq }
    password 'changeme'
    password_confirmation 'changeme'
  end
end
