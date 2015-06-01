FactoryGirl.define do
  factory :contact do
    first_name 'Shane'
    last_name 'Watson'
    sequence(:email) {|n| "shane#{n}@cc.com" }
  end
end
