FactoryBot.define do
  factory :tag_1, class: Tag do
    tag_name { 'Factoryで作ったデフォルトのtag１' }
  end

  factory :tag_2, class: Tag do
    tag_name { 'Factoryで作ったデフォルトのtag２' }
  end
end
