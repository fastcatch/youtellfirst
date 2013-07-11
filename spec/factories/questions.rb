# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question do
    text "How far is the Moon?"
    user
    after(:create) do |question, evaluator|
      FactoryGirl.create(:answer, question: question, email: evaluator.user.email, text: 'some 400,000 kms')
      FactoryGirl.create(:answer, question: question, text: nil)
    end
  end
end
