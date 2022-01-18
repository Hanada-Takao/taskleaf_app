5.times do |n|
  User.create!(
    name: "sample_name#{n+1}",
    email: "sample_email#{n+1}@sample.com",
    password: "sample_email#{n+1}@sample.com",
    password_confirmation: "sample_email#{n+1}@sample.com",
    admin: "true"
  )
end
5.times do |n|
  User.create!(
    name: "sample_name#{n+10}",
    email: "sample_email#{n+10}@sample.com",
    password: "sample_email#{n+10}@sample.com",
    password_confirmation: "sample_email#{n+10}@sample.com",
    admin: "false"
  )
end

10.times do |i|
  Tag.create!(tag_name: "sample_tag_name#{i + 1}")
end

10.times do |n|
  Task.create!(
    name: "sample_name#{i + 1}",
    description: "sample_description#{n+1}",
    deadline: "2022-01-#{rand(1..31)}",
    status: "未着手",
    priority: "低",
    user_id: "#{User.all.pluck(:id).sample}"
  )
end

10.times do |n|
  Task_tag.create!(
    task_id: "#{Task.all.pluck(:id).sample}",
    label_id: "#{Label.all.pluck(:id).sample}"
  )
end