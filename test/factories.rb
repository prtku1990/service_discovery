FactoryGirl.define do
  factory :service do
    name 'service_name'
    description 'Some random service'
    price_per_hour 100.00
  end

  factory :veteran do
    service {FactoryGirl.create(:service)}
    name 'veteran_name'
    contact_number 1024
    expected_service_minutes 20
    expected_travel_minutes_before 20
  end

  factory :veteran_slot do
    veteran {FactoryGirl.create(:veteran)}
    start_time '2015-4-4 00:00:00'
    end_time '2015-4-4 00:15:00'
    is_reserved true
  end

  factory :user do
    email_id 'naam@mail.com'
    password 'hidden'
  end

  factory :address do
    name  'naam'
    line1 'first line'
    city  'sim'
    state 'rajya'
    pincode 102420
    user FactoryGirl.create(:user)
    phone_number 123456789
    is_primary true
  end

  factory :order do
    slot_start_time '2015-05-05 10:00:00'
    status 'created'
    address FactoryGirl.create(:address)
    service FactoryGirl.create(:service)
    actual_start_time '2015-05-05 10:05:00'
    total_price 120.00
  end
end