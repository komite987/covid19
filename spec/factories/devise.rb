FactoryBot.define do
  factory :user do
    name {Faker::Name.first_name}
    id {Faker::Number.number(digits: 2)}
    email {"#{Faker::Name.first_name}@user.com"}
    password {"123456"}
    password_confirmation {"123456"}
    phone {"04188008800"}
    mobile {"0988323323"}
  end

  factory :admin, class: User do
    name {Faker::Name.first_name}
    id {Faker::Number.number(digits: 2)}
    email {"#{Faker::Name.first_name}@user.com"}
    password {"123456"}
    password_confirmation {"123456"}
    phone {"04188008800"}
    mobile {"0988323323"}
    admin {true}
  end
end
