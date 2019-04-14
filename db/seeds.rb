# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = User.create!([
   {first_name: "Admin", last_name: 'Admin', email: "admin@mail.ru", password: '123456', admin: true},
   {first_name: "John", last_name: 'Doe', email: "john@mail.ru", password: '123456'},
   {first_name: "Jane", last_name: 'Doe', email: "jane@mail.ru", password: '123456'},
])

30.times do
  Post.create!(title:  "User Title", body: 'User Body', author: users[1])
end

30.times do
  Post.create!(title:  "Admin Title", body: 'Admin Body', author: users[0])
end

30.times do
  Post.create!(title:  "Admin Title for guests", body: 'Admin Body for guests', for_guests: true, author: users[1])
end

courses = Course.create!([
    {title: 'История'},
    {title: 'Обществознание'}
])

moduls = Modul.create!([
    {title: 'Древнее время', course: courses[0]},
    {title: 'Новое время', course: courses[0]},

    {title: 'Общество и мы', course: courses[1]},
    {title: 'Социальные группы', course: courses[1]},
])

topics = Topic.create!([
    {title: 'Древние славяне 1', body: 'Жили-поживали', modul: moduls[0]},
    {title: 'Древние славяне 2', body: 'Жили-поживали', modul: moduls[0]},

    {title: 'Новые славяне 1', body: 'Жили-поживали', modul: moduls[1]},
    {title: 'Новые славяне 2', body: 'Жили-поживали', modul: moduls[1]},

    {title: 'Мы в обществе', body: 'Жили-поживали', modul: moduls[2]},
    {title: 'Общество в нас', body: 'Жили-поживали', modul: moduls[2]},

    {title: 'Социум', body: 'Жили-поживали', modul: moduls[3]},
    {title: 'Группы', body: 'Жили-поживали', modul: moduls[3]},
])

Essay.create!([
   {title: 'Опишите древнее время', modul: moduls[0]},
   {title: 'Опишите новое время', modul: moduls[1]},
   {title: 'Опишите общество и нас время', modul: moduls[2]},
   {title: 'Опишите социальные группы', modul: moduls[3]},
])

tests = Test.create!([
   {title: 'Тест Древнее время', modul: moduls[0], timer: 3},
   {title: 'Тест Новое время', modul: moduls[1], timer: 3},
   {title: 'Тест Общество и мы', modul: moduls[2], timer: 3},
   {title: 'Тест Социальные группы', modul: moduls[3], timer: 3},
])

questions = Question.create!([
    {title: 'Сколько будет 100 + 23 ?', questionable: tests[0]},
    {title: 'Сколько будет 100 + 23 ?', questionable: tests[0]},

    {title: 'Сколько будет 100 + 23 ?', questionable: tests[1]},
    {title: 'Сколько будет 100 + 23 ?', questionable: tests[1]},

    {title: 'Сколько будет 100 + 23 ?', questionable: tests[2]},
    {title: 'Сколько будет 100 + 23 ?', questionable: tests[2]},

    {title: 'Сколько будет 100 + 23 ?', questionable: tests[3]},
    {title: 'Сколько будет 100 + 23 ?', questionable: tests[3]},

    {title: 'Сколько будет 100 + 23 ?', questionable: topics[0]},
    {title: 'Сколько будет 100 + 23 ?', questionable: topics[1]},
    {title: 'Сколько будет 100 + 23 ?', questionable: topics[2]},
    {title: 'Сколько будет 100 + 23 ?', questionable: topics[3]},
    {title: 'Сколько будет 100 + 23 ?', questionable: topics[4]},
    {title: 'Сколько будет 100 + 23 ?', questionable: topics[5]},
    {title: 'Сколько будет 100 + 23 ?', questionable: topics[6]},
    {title: 'Сколько будет 100 + 23 ?', questionable: topics[7]},
])

Answer.create!([
    {body: '123', full_accordance: true, points: 2, question: questions[0]},
    {body: '123',                        points: 2, question: questions[1]},
    {body: '123', full_accordance: true, points: 2, question: questions[2]},
    {body: '123',                        points: 2, question: questions[3]},
    {body: '123', full_accordance: true, points: 2, question: questions[4]},
    {body: '123',                        points: 2, question: questions[5]},
    {body: '123', full_accordance: true, points: 2, question: questions[6]},
    {body: '123',                        points: 2, question: questions[7]},
    {body: '123', full_accordance: true, points: 2, question: questions[8]},
    {body: '123', full_accordance: true, points: 2, question: questions[9]},
    {body: '123', full_accordance: true, points: 2, question: questions[10]},
    {body: '123', full_accordance: true, points: 2, question: questions[11]},
    {body: '123', full_accordance: true, points: 2, question: questions[12]},
    {body: '123', full_accordance: true, points: 2, question: questions[13]},
    {body: '123', full_accordance: true, points: 2, question: questions[14]},
    {body: '123', full_accordance: true, points: 2, question: questions[15]},
])

Message.create!([
    {author: users[0], abonent: users[1], body: 'Hello, John! It is Admin.'},
    {author: users[0], abonent: users[1], body: 'How are you doing?'},
    {author: users[1], abonent: users[0], body: 'Fine!'},

    {author: users[0], abonent: users[2], body: 'Hello, Jane!'},
])
