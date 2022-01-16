require 'rails_helper'

RSpec.describe User, type: :system do
let!(:user_a) { create(:user_admin) }
let!(:user_b) { create(:user_general) }

  describe 'ユーザ登録のテスト' do
    describe 'ユーザー新規登録' do
      context 'フォームの入力値が正常' do
        it 'ユーザーの新規作成が成功' do
          visit new_user_path
          fill_in 'name-id', with:'general@general.com'
          fill_in 'email-id', with: 'general@general.com'
          fill_in 'password-id', with: 'general@general.com'
          fill_in 'confirmation-id', with: 'general@general.com'
          click_on '登録する'
          expect(page).to have_content 'タスク一覧'
        end
        it 'ログインせずタスク一覧画面に飛ぼうとしたとき、ログイン画面に遷移すること' do
          visit tasks_path
          expect(page).to have_content 'ログイン'
        end
      end
    end
  end

  describe 'セッション機能のテスト' do
    context 'ログインしていない時' do
      it 'ログインができること' do
        general_login
        expect(page).to have_content 'タスク一覧'
      end
    end
    context 'ログインした後' do
      it '自分の詳細画面(マイページ)に飛べること' do
        general_login
        expect(page).to have_content 'ユーザの詳細'
      end
      it '一般ユーザが他人の詳細画面に飛ぶとタスク一覧画面に遷移すること' do
        general_login
        visit  user_path(1)
        expect(page).to have_content 'タスク一覧'
      end
      it 'ログアウトができること' do
        general_login
        click_on 'ログアウト'
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end

  describe '管理画面のテスト' do
    context '管理ユーザーでログインしている' do
      it '管理ユーザは管理画面にアクセスできること' do
        admin_login
        visit admin_users_path
        expect(page).to have_content 'ユーザ一覧'
      end
      it '管理ユーザはユーザの新規登録ができること' do
        admin_login
        visit admin_users_path
        click_on '新規登録'
        fill_in 'name-id', with:'general@general.com'
        fill_in 'email-id', with: 'general@general.com'
        fill_in 'password-id', with: 'general@general.com'
        fill_in 'confirmation-id', with: 'general@general.com'
        click_on '登録する'
        expect(page).to have_content 'タスク一覧'
      end
      it '管理ユーザはユーザの詳細画面にアクセスできること' do
        admin_login
        visit admin_users_path
        click_on 'Factoryで作ったUserGeneral'
        expect(page).to have_content "general@test.com"
      end
      it '管理ユーザはユーザの編集画面からユーザを編集できること' do
        admin_login
        visit admin_users_path
        click_on 'Factoryで作ったUserGeneral'
        click_on '編集'
        fill_in 'password-id', with: 'general@test.com'
        fill_in 'confirmation-id', with: 'general@test.com'
        click_on '登録する'
        expect(page).to have_content "ユーザ「Factoryで作ったUserGeneral」を更新しました。"
      end
      it '管理ユーザはユーザの削除をできること' do
        admin_login
        visit admin_users_path
        click_on 'Factoryで作ったUserGeneral'
        click_on '削除'
        page.accept_confirm 'ユーザー「Factoryで作ったUserGeneral」を削除します。よろしいですか？'
        expect(page).to have_content 'ユーザ「Factoryで作ったUserGeneral」を削除しました。'
      end
    end
    context '一般ユーザーでログインしている' do
      it '一般ユーザは管理画面にアクセスできないこと' do
        general_login
        visit admin_users_path
        expect(page).to have_content '管理者以外はアクセスできません'
      end
    end
  end
end


