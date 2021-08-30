FactoryBot.define do
  factory :user do
    name { "Common" }
    email { "user@user.com" }
    password { "useruser" }
  end
  factory :second_user, class: User do
    name { "Admin" }
    email { "super@user.com" }
    password { "adminadmin" }
    admin { true }
  end
end
