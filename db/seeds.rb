# @user = User.create!(
#   name: 'admin@admin.com',
#   email: 'admin@admin.com',
#   password: 'admin@admin.com',
#   password_confirmation:"admin@admin.com",
#   admin: true
# )

5.times do |i|
  Tag.create!(tag_name: "sample#{i + 1}")
end