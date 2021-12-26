require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:task_a) { FactoryBot.create(:task, name: '最初のタスク') }

  describe '新規作成機能' do
    before do
      visit new_task_path
      fill_in 'task_name',	with: '名称'
      fill_in 'task_description', with: '詳細'
      click_button '登録する'
    end
    context 'タスクを新規作成した場合' do
      let(:task_name) { 'タスク「名称」を登録しました。' }
      it '作成したタスクが表示される' do
        expect(page).to have_selector '.alert-success', text: 'タスク「名称」を登録しました。'
      end
    end
  end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        # タスク一覧ページに遷移
        visit tasks_path
        # タスク一覧ページに遷移できているかを確認
        current_path
        # タスクがデータベースに作成されているかを確認
        Task.count
        # 表示するHTMLにタスク情報が入っているかを確認
        page.html
        expect(page).to have_content '最初のタスク'
      end
    end
  end

  describe '詳細表示機能' do
    before do
      visit task_path(task_a)
    end
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        expect(page).to have_content '最初のタスク'
      end
    end
  end
end