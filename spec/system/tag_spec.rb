require 'rails_helper'

RSpec.describe 'タグ管理機能', type: :system do
  let!(:tag_a) { create(:tag_1) }
  let!(:tag_b) { create(:tag_2) }
  let!(:user_a) { create(:user_admin) }
  let!(:task_a) { create(:task_1) }

  describe 'タスクにタグをつける' do
    context '新規' do
      # it 'タスクにつけられる' do
      # end
      it 'ラベルは、タスクを新規登録するときにタスクと一緒に複数のラベルを登録できる' do
        admin_login
        visit new_task_path
        fill_in 'task_name',	with: '名称'
        fill_in 'task_description', with: '詳細'
        select "2022", from: "task[deadline(1i)]"
        select "1月", from: "task[deadline(2i)]"
        select "7", from: "task[deadline(3i)]"
        select '着手', from: "task[status]"
        select '中', from: "task[priority]"
        # binding.pry
        check 'Factoryで作ったデフォルトのtag１'
        check 'Factoryで作ったデフォルトのtag２'
        click_button '登録する'
        expect(page).to have_content 'Factoryで作ったデフォルトのtag１'
        expect(page).to have_content 'Factoryで作ったデフォルトのtag２'
      end
    end

    context '編集・詳細' do
      it 'ラベルは、タスクを編集するときにタスクと一緒に編集できる
          タスクの詳細画面で、そのタスクに紐づいているラベル一覧を出力できる' do
        admin_login
        visit tasks_path
        click_on '編集'
        check 'Factoryで作ったデフォルトのtag１'
        click_on '更新する'
        tag_test = all('td')
        expect(tag_test[8]).to have_content 'Factoryで作ったデフォルトのtag１'
        click_on '編集'
        uncheck 'Factoryで作ったデフォルトのtag１'
        check 'Factoryで作ったデフォルトのtag２'
        click_on '更新する'
        tag_test = all('td')
        expect(tag_test[8]).not_to have_content 'Factoryで作ったデフォルトのtag１'
        expect(tag_test[8]).to have_content 'Factoryで作ったデフォルトのtag２'
      end
    end

    context '検索' do
      it 'つけたラベルで検索ができる' do
        admin_login
        visit tasks_path
        click_on '編集'
        check 'Factoryで作ったデフォルトのtag１'
        click_on '更新する'
        visit tasks_path
        select 'Factoryで作ったデフォルトのtag１', from: 'search_tag'
        click_on '検索'
        tag_test = all('td')
        expect(tag_test[6]).to have_content 'Factoryで作ったデフォルトのtag１'
      end
    end
  end
end