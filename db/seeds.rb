# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

first_user = User.create( name:                  "first_user",
                          user_name:             "first",
                          password:              "password",
                          password_confirmation: "password",
                          provider:              "facebook",
                          uid:                   "12344556",
                          image:                 "https://placehold.jp/004070/ffffff/50x50.png",
                          phone_number:          "09011110000" )

20.times do |n|
  user = User.create( name:                  "user#{n}",
                      user_name:             "first#{n}",
                      password:              "password",
                      password_confirmation: "password",
                      provider:              "facebook",
                      uid:                   "#{10000 + n}",
                      image:                 "https://placehold.jp/3d4070/ffffff/50x50.png")
  user_micropost = user.microposts.build(title: "title#{n}")
  user_micropost.image.attach(io: File.open('app/assets/images/test.png'),
                              filename: 'test.png')
  user_micropost.save
  user.follow(first_user)
end

5.times do |n|
  user_micropost = first_user.microposts.build(title: "title")
  user_micropost.image.attach(io: File.open('app/assets/images/test.png'),
                              filename: 'test.png')
  user_micropost.save
end

20.times do |n|
  first_user.follow(User.find_by(uid: "#{10000 + n}"))
end
