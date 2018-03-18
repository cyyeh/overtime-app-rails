@user = User.create(email: "guest@gmail.com", 
                    password: "000000", 
                    password_confirmation: "000000", 
                    first_name: "Guest", 
                    last_name: "Mr",
                    phone: "+886922150923")

puts "1 User created"

AdminUser.create(email: "root@gmail.com", 
                password: "000000", 
                password_confirmation: "000000", 
                first_name: "root", 
                last_name: "Mr",
                phone: "+886922150923")

puts "1 Admin User created"

100.times do |post|
  Post.create!(date: Date.today, rationale: "#{post} rationale content", user_id: @user.id, overtime_request: 2.5)
end

puts "100 posts have been created"