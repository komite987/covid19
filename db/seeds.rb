  User.create!(
    name: "Komait",
    email: "komait@gmail.com",
    password: "123456",
    password_confirmation: "123456",
    phone: "0418800880",
    mobile: "0988333222",
    address: "Latakia-Jableh",
    photo: "https://place-hold.it/300x200",
    admin: true
    )
puts "Admin user created"


3.times do |user|
  User.create!(
    name: "Komait #{user+1}",
    email: "komait#{user+1}@gmail.com",
    password: "123456",
    password_confirmation: "123456",
    phone: "0418800880",
    mobile: "0988333222",
    address: "Latakia-Jableh",
    photo: "https://place-hold.it/300x200"
    )
end

puts "5 users created"


