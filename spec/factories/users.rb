FactoryBot.define do
  factory :user_admin, class: User do
    name { 'Factoryで作ったUserAdmin' }
    email {'admin@test.com'}
    password { 'admin@test.com' }
    admin { 'true' }
  end
end

FactoryBot.define do
  factory :user_general, class: User do
    name { 'Factoryで作ったUserGeneral' }
    email {'general@test.com'}
    password { 'general@test.com' }
    admin { 'false' }
  end
end