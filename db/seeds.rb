# db/seeds.rb

User.find_or_create_by!(email: "you@example.com") do |u|
  u.name = "You"
  u.password = "password123"
  u.password_confirmation = "password123"
end

User.find_or_create_by!(email: "friend@example.com") do |u|
  u.name = "Friend"
  u.password = "password123"
  u.password_confirmation = "password123"
end
