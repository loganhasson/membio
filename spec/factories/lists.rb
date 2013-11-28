# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :list do
    user_id 1
    title "MyString"
    complete false
  end
end
