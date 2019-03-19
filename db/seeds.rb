# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = User.create!([
   {first_name: "John", last_name: 'Doe', email: "john@mail.ru", password: '123456'},
   {first_name: "Admin", last_name: 'Admin', email: "admin@mail.ru", password: '123456', admin: true},
   {first_name: "Jane", last_name: 'Doe', email: "jane@mail.ru", password: '123456'},
])

10.times do
  Post.create!(title:  "Title", body: 'Body', author: users[0])
end

10.times do
  Post.create!(title:  "Title", body: 'Body', author: users[1])
end
