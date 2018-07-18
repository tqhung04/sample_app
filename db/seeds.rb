User.create!(name: "admin", email: "admin@gmail.com", password: "111111", password_confirmation: "111111", admin: true, activated: true, activated_at: Time.zone.now)

99.times do |n|
  name  = Faker::Name.name
  email = "user-#{n1}@gmail.com"
  password = "111111"
  User.create!(name: name, email: email, password: password, password_confirmation: password,  activated: true, activated_at: Time.zone.now)
end

users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content) }
end
