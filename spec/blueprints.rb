require 'machinist/active_record'
require 'sham'
require 'faker'

Sham.name  { Faker::Name.name }
Sham.email { Faker::Internet.email }

User.blueprint do
  email
  password "123456"
  password_confirmation "123456"
end
