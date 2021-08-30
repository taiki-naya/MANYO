# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


15.times do |n|
  name = Faker::Games::Pokemon.name
  email = Faker::Internet.email
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               )
end

15.times do |n|
  name = Faker::Games::Pokemon.name
  due_date = Faker::Date.in_date_period
  priority = Faker::Number.within(range: 1..2)
  user = Faker::Number.within(range: 1..40)
  Task.create!(title: name,
               content: name,
               due_date: due_date,
               priority: priority,
               user_id: user
               )
end

15.times do |n|
name = Faker::Games::Pokemon.name
Label.create!(
  name: name
)
end
