FactoryBot.define do
  # 作成するテストデータの名前を「task」とします
  # （実際に存在するクラス名と一致するテストデータの名前をつければ、そのクラスのテストデータを自動で作成します）
  factory :task_1 , class: Task do
    # id { 10 }
    name { 'Factoryで作ったデフォルトのname１' }
    description { 'Factoryで作ったデフォルトのdescription１' }
    deadline { '2020-01-01' }
    status { 0 }
    priority { 0 }
    user_id { 1 }
    created_at { '2020-01-01' }
  end

  factory :task_2 , class: Task do
    # id { 20 }
    name { 'Factoryで作ったデフォルトのname２' }
    description { 'Factoryで作ったデフォルトのdescription２' }
    deadline { '2021-01-01' }
    status { 1 }
    priority { 1 }
    user_id { 1 }
    created_at { '2021-01-01' }
  end

  factory :task_3 , class: Task do
    # id { 30 }
    name { 'Factoryで作ったデフォルトのname３' }
    description { 'Factoryで作ったデフォルトのdescription３' }
    deadline { '2022-01-01' }
    status { 2 }
    priority { 2 }
    user_id { 1 }
    created_at { '2022-01-01' }
  end
end
