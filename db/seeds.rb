100.times do |post|
  Post.create!(date: Date.today, rationale: "#{post} rationale content")
end

User.create(email: "chihyu.jimmy.yeh@gmail.com", password: "40423jimmy", password_confirmation: "40423jimmy", first_name: "ChihYu", last_name: "Yeh")

puts "100 posts have been created"