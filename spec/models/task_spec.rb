require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'タスクモデル機能', type: :model do
    describe 'バリデーションのテスト' do
      context 'タスクのタイトルが空の場合' do
        it 'バリデーションにひっかる' do
          task = Task.new(name: '', description: '失敗テスト')
          expect(task).not_to be_valid
        end
      end

      context 'タスクの詳細が空の場合' do
        it 'バリデーションにひっかかる' do
          task = Task.new(name: '失敗テスト', description: '')
          expect(task).not_to be_valid
        end
      end

      context 'タスクのタイトルと詳細に内容が記載されている場合' do
        it 'バリデーションが通る' do
          task = Task.new(name: '成功テスト', description: '成功テスト', deadline: DateTime.now, status: 1, priority: 1)
          expect(task).to be_valid
        end
      end
    end

    describe '検索機能' do
      # 必要に応じて、テストデータの内容を変更しても構わない
      let!(:task_a) { FactoryBot.create(:task_1) }
      let!(:task_b) { FactoryBot.create(:task_2) }
      let!(:task_c) { FactoryBot.create(:task_3) }

      context 'scopeメソッドでタイトルのあいまい検索をした場合' do
        it "検索キーワードを含むタスクが絞り込まれる" do
          # title_searchはscopeで提示したタイトル検索用メソッドである。メソッド名は任意で構わない。
          expect(Task.name_like('name１')).to include(task_a)
          expect(Task.name_like('name１')).not_to include(task_b)
          expect(Task.name_like('name１').count).to eq 1
        end
      end

      context 'scopeメソッドでステータス検索をした場合' do
        it 'ステータスに完全一致するタスクが絞り込まれる' do
          expect(Task.status('未着手')).to include(task_a)
          expect(Task.status('未着手')).not_to include(task_b)
          expect(Task.status('未着手').count).to eq 1
        end
      end

      context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
        it '検索キーワードをタイトルに含み、かつステータスに完全一致するタスクが絞り込まれる' do
          expect(Task.name_like('name１').status('未着手')).to include(task_a)
          expect(Task.name_like('name１').status('未着手')).not_to include(task_b)
          expect(Task.name_like('name１').status('未着手').count).to eq 1
        end
      end
    end
  end
end
