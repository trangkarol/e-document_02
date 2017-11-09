FactoryGirl.define do
  factory :document do
    name Faker::Name.name
    number_download 0
    file Rack::Test::UploadedFile.new(File.open('./app/assets/images/default.pdf'))
    description Faker::Lorem.sentence(6)
    size 1000
    status Random.rand(0..2)
  end
end
