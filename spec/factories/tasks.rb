FactoryBot.define do
  # 作成するテストデータの名前を「task」とします
  # （実際に存在するクラス名と一致するテストデータの名前をつければ、そのクラスのテストデータを自動で作成します）
  factory :task do
    name { '最初のタスク' }
    description { 'Factoryで作ったデフォルトのdescription１' }
  end
end
