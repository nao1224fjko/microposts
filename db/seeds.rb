# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user1 = User.create!(name: "yamada"   , email: "test10@example.com" , password: "kirapass")

20.times do |n|
  user1.microposts.create!(content: "これはつぶやき#{n}です。")
end
user2 = User.create(name: "sasaki"   , email: "test11@example.com" , password: "kirapass" , password_confirmation: "kirapass")
user3 = User.create(name: "inoue"    , email: "test12@example.com" , password: "kirapass" , password_confirmation: "kirapass")
user4 = User.create(name: "kimura"   , email: "test13@example.com" , password: "kirapass" , password_confirmation: "kirapass")
user5 = User.create(name: "hayasi"   , email: "test14@example.com" , password: "kirapass" , password_confirmation: "kirapass")
user6 = User.create(name: "saito"    , email: "test15@example.com" , password: "kirapass" , password_confirmation: "kirapass")
user7 = User.create(name: "shimizu"  , email: "test16@example.com" , password: "kirapass" , password_confirmation: "kirapass")
user8 = User.create(name: "yamazaki" , email: "test17@example.com" , password: "kirapass" , password_confirmation: "kirapass")
user9 = User.create(name: "kirito" , email: "test18@example.com" , password: "kirapass" , password_confirmation: "kirapass")
user10 = User.create(name: "asuna" , email: "test19@example.com" , password: "kirapass" , password_confirmation: "kirapass")
user11 = User.create(name: "yui" , email: "test20@example.com" , password: "kirapass" , password_confirmation: "kirapass")
user12 = User.create(name: "shirika" , email: "test21@example.com" , password: "kirapass" , password_confirmation: "kirapass")


user1.follow(user2)
user1.follow(user3)
user1.follow(user4)
user1.follow(user5)
user1.follow(user6)
user1.follow(user7)
user1.follow(user8)
user1.follow(user9)
user1.follow(user10)
user1.follow(user11)
user1.follow(user12)
user1.follow(user13)
