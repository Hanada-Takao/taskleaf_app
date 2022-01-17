require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
  let!(:user_a) { create(:user_admin) }
  let!(:task_a) { create(:task_1) }
  let!(:task_b) { create(:task_2) }
  let!(:task_c) { create(:task_3) }

  describe '新規作成機能' do
    before do
      admin_login
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
        admin_login
        visit tasks_path
        current_path
        Task.count
        page.html
        expect(page).to have_content 'Factoryで作ったデフォルトのname１'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        admin_login
        visit tasks_path
        task_test = all('td')
        expect(task_test[1]).to have_content 'Factoryで作ったデフォルトのname３'
    end
    context 'タスクが終了期限の降順に並んでいる場合' do
      it '終了期限が早いタスクが一番上に表示される' do
        admin_login
        visit tasks_path
        click_on '終了期限でソートする'
        task_test = all('td')
        expect(task_test[1]).to have_content 'Factoryで作ったデフォルトのname１'
      end
    end
  end

  describe '詳細表示機能' do
    before do
      admin_login
      visit task_path(task_a)
    end
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        expect(page).to have_content 'Factoryで作ったデフォルトのname１'
      end
    end
  end

  describe '検索機能' do
    # before do
    #   # 必要に応じて、テストデータの内容を変更しても構わない
    # end

    context 'タイトルで曖昧検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        admin_login
        visit tasks_path
        # タスクの検索欄に検索ワードを入力する（例: task）
        fill_in 'search_name', with: 'name１'
        # 検索ボタンを押す
        click_on '検索'
        expect(page).to have_content 'name１'
      end
    end

    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        admin_login
        visit tasks_path
        # ここに実装する
        select '着手', from: 'search_status'
        # プルダウンを選択する「select」について調べてみる
        click_on '検索'
        expect(page).to have_content '着手'
      end
    end

    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスクに絞り込まれる" do
        admin_login
        visit tasks_path
        # ここに実装する
        fill_in 'search_name', with: 'name３'
        select '完了', from: 'search_status'
        click_on '検索'
        expect(page).to have_content 'name３'
        expect(page).to have_content '完了'
      end
    end
  end
end