# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :answer do
    question
    user nil    # filled automatically on save
    uuid nil    # filled automatically on save
    email { FactoryGirl.create(:user).email }
    text "Uhm, I really do not have a clue"
  end
end
