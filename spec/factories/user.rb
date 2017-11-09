FactoryGirl.define do
  factory :admin do
    name "Admin"
    email "admin@gmail.com"
    birthday Faker::Time.between(DateTime.now - 1, DateTime.now)
    address Faker::Address.street_address
    password "123123"
    password_confirmation "123123"
    status 1
    role 0
    total_coin 400
    number_free 3
    number_upload 0
  end

  factory :user do
    name Faker::Name
    email "example@gmail.com"
    birthday Faker::Time.between(DateTime.now - 1, DateTime.now)
    address Faker::Address.street_address
    password "123123"
    password_confirmation "123123"
    status 1
    role 1
    total_coin 400
    number_free 3
    number_upload 0
  end
end
