10.times do |n|
  name = Faker::Name.name
  email = Faker::Internet.email
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               )
end

User.create!(name: "aiueo", email: "aiueodayo@gmail.com", password: "123456", admin: true)

10.times do |i|
  Label.create!(name: "sample#{i + 1}")
end

10.times do |t|
  Task.create!(
  user_id: t + 1,
  title: "title#{t+1}",
  deadline: "2022/11/11",
  content: "content",
  status: "未着手",
  priority: "高"
  )
end