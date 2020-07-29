FactoryBot.define do
  factory :user do
    name {"User1"}
    id {1}
    email {"test@user.com"}
    password {"123456"}
    phone {"04188008800"}
    mobile {"0988323323"}
    admin {false}
  end

  factory :admin, class: User do
    name {"User2"}
    id {2}
    email {"test@admin.com"}
    password {"123456"}
    phone {"04188008800"}
    mobile {"0988323323"}
    admin {true}
  end
end
