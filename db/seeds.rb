@user = User.create(email: "guest@gmail.com", password: "000000", password_confirmation: "000000", first_name: "Guest", last_name: "Mr")
User.create(email: "root@gmail.com", password: "000000", password_confirmation: "000000", first_name: "root", last_name: "Mr", type: "AdminUser")

puts "1 user created"

100.times do |post|
  Post.create!(date: Date.today, rationale: "#{post} rationale content", user_id: @user.id)
end

puts "100 posts have been created"