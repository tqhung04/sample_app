User.create!(name: "admin", email: "admin@gmail.com", password: "111111", password_confirmation: "111111", admin: true)

99.times do |n|
  name  = Faker::Name.name
  email = "user-#{n+1}@gmail.com"
  password = "111111"
  User.create!(name: name, email: email, password: password, password_confirmation: password)
end
