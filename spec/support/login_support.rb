module LoginSupport
  def admin_login
    visit new_session_path
    fill_in 'session_email', with: 'admin@test.com'
    fill_in 'session_password', with: 'admin@test.com'
    click_on 'session_btn'
  end

  def general_login
    visit new_session_path
    fill_in 'session_email', with: 'general@test.com'
    fill_in 'session_password', with: 'general@test.com'
    click_on 'ログインする'
  end
end