FactoryBot.define do
  # 作成するテストデータの名前を「task」とします
  # （実際に存在するクラス名と一致するテストデータの名前をつければ、そのクラスのテストデータを自動で作成します）
  factory :task_1 , class: Task do
    # id { 10 }
    name { 'Factoryで作ったデフォルトのname１' }
    description { 'Factoryで作ったデフォルトのdescription１' }
    deadline { DateTime.now }
    status { 0 }
    priority { 0 }
  end

  factory :task_2 , class: Task do
    # id { 20 }
    name { 'Factoryで作ったデフォルトのname２' }
    description { 'Factoryで作ったデフォルトのdescription２' }
    deadline { DateTime.yesterday }
    status { 1 }
    priority { 1 }
  end

  factory :task_3 , class: Task do
    # id { 30 }
    name { 'Factoryで作ったデフォルトのname３' }
    description { 'Factoryで作ったデフォルトのdescription３' }
    deadline { DateTime.tomorrow }
    status { 2 }
    priority { 2 }
  end
end
