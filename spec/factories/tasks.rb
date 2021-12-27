FactoryBot.define do
  # 作成するテストデータの名前を「task」とします
  # （実際に存在するクラス名と一致するテストデータの名前をつければ、そのクラスのテストデータを自動で作成します）
  factory :task do
    id { 1 }
    name { 'Factoryで作ったデフォルトのname１' }
    description { 'Factoryで作ったデフォルトのdescription１' }
  end

  factory :task_2 , class: Task do
    id { 2 }
    name { 'Factoryで作ったデフォルトのname２' }
    description { 'Factoryで作ったデフォルトのdescription２' }
  end

  factory :task_3 , class: Task do
    id { 3 }
    name { 'Factoryで作ったデフォルトのname３' }
    description { 'Factoryで作ったデフォルトのdescription３' }
  end

  factory :task_4 , class: Task do
    id { 4 }
    name { 'Factoryで作ったデフォルトのname４' }
    description { 'Factoryで作ったデフォルトのdescription４' }
  end

end
