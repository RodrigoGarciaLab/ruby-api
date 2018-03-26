User.create!(name:  "Rodrigo",
             email: "rgloop@gmail.com",
             password:              "foobar",
             password_confirmation: "foobar",
             admin:     true)

5.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
              email: email,
              password:              password,
              password_confirmation: password)
end

20.times do |n|
  name = Faker::Commerce.product_name
  price = rand() * 100
  Product.create!(name:  name, price: price, image_url: Faker::Avatar.image)
end
