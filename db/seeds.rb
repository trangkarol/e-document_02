# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
random =  Random.new

#User
User.create!(
  name: "Admin",
  email: "admin@gmail.com",
  birthday: Faker::Time.between(DateTime.now - 1, DateTime.now),
  address: Faker::Address.street_address,
  password: "123123", 
  password_confirmation: "123123",
  status: 1,
  avatar: Faker::Avatar.image,
  role: 0,
  total_coin: 50,
  number_free: 3,
  number_upload: 0
)

10.times do |n|
  User.create!(
    name: Faker::Name.name,
    email: "document#{n+1}@gmail.com",
    birthday: Faker::Time.between(DateTime.now - 1, DateTime.now),
    address: Faker::Address.street_address,
    password: "123123", 
    password_confirmation: "123123",
    status: random.rand(0..1),
    avatar: Faker::Avatar.image,  
    role: random.rand(0..1),
    total_coin: 0,
    number_free: 3,
    number_upload: 0
  )
end

# Category
5.times do |n|
  Category.create! name: Faker::Name.name
end

users = User.all
# Upload document
category_id_first = Category.first.id
category_id_last = Category.last.id
users.each do |user|
  if user.check_upload?
    # documents
    document = user.documents.create!(
      name: Faker::Name.name,
      number_download: 0,
      url: Faker::File.file_name("public/upload", "example", "pdf"),
      size: 1000,
      status: random.rand(0..2)
    )
    # category_documents
    document.category_documents.create! category_id: random.rand(category_id_first..category_id_last)
    # history
    user.histories.create! document_id: document.id, name_action: "upload"
    user.update_number_upload
  end
end

# Create coin
number_coins_default = 0
cost_default = 0

users.each do |user|
  number_coins_default += 50
  cost_default += 20.000
  # create coins
  coin = Coin.create! number_coins: number_coins_default, cost: cost_default
  # create payments
  payment = user.payments.create! number: random.rand(1..3), coin_id: coin.id
  user.update_total_coins payment.number * coin.number_coins
end

users.each do |user|
  # favorites
  user.favorites.create! document_id: Document.first.id
  # comment
  user.comments.create! content: Faker::Lorem.sentence(15), document_id: Document.first.id
end

