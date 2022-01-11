require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
  let!(:task_a) { FactoryBot.create(:task_1) }
  let!(:task_b) { FactoryBot.create(:task_2) }
  let!(:task_c) { FactoryBot.create(:task_3) }

  describe '新規作成機能' do
    before do
      visit new_task_path
      fill_in 'task_name',	with: '名称'
      fill_in 'task_description', with: '詳細'
      select "2022", from: "task[deadline(1i)]"
      select "1月", from: "task[deadline(2i)]"
      select "7", from: "task[deadline(3i)]"
      select '着手', from: "task[status]"
      select '中', from: "task[priority]"
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
    end
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        visit tasks_path
        current_path
        Task.count
        page.html
        expect(page).to have_content 'Factoryで作ったデフォルトのname１'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        visit tasks_path
        task_test = all('td')
        expect(task_test[0]).to have_content 'Factoryで作ったデフォルトのname３'
    end

    context 'タスクが終了期限の降順に並んでいる場合' do
      it '終了期限が早いタスクが一番上に表示される' do
        visit tasks_path
        click_on '終了期限でソートする'
        task_test = all('td')
        expect(task_test[0]).to have_content 'Factoryで作ったデフォルトのname２'
      end
    end
  end

  describe '詳細表示機能' do
    before do
      visit task_path(task_a)
    end
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        expect(page).to have_content 'Factoryで作ったデフォルトのname１'
      end
    end
  end
end