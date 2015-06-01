FactoryGirl.define do
  factory :phone do
    association :contact
    phone '123-45-55'

    factory :offic_phone do
      phone_type 'office'
    end

    factory :home_phone do
      phone_type 'home'
    end
  end
end
