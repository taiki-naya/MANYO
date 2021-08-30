require 'rails_helper'
RSpec.describe 'User management system', type: :system do

  describe 'a function of create a new user' do
    context 'case of creating a new user' do
      it 'created user info will be displayed' do
        visit root_path
        click_on 'Sign up'
        fill_in 'user[name]', with: 'user'
        fill_in 'user[email]', with: 'user@user.com'
        fill_in 'user[password]', with: 'useruser'
        fill_in 'user[password_confirmation]', with: 'useruser'
        click_on 'Create my account'
        expect(page).to have_content %(user's page)
      end
    end
    context 'when transit to index page without logged in' do
      it 'forcibly transited to the login page' do
        visit root_path
        visit tasks_path
        expect(page).to have_content 'Log in'
      end
    end
  end

  describe 'functions of login as common user' do
    let!(:user) { FactoryBot.create(:user, name: 'admin', email: 'admin@admin.com', password: 'adminadmin', admin: true) }
    let!(:user) { FactoryBot.create(:user, name: 'common', email: 'common@common.com', password: 'common', id: 99) }
    before do
      visit root_path
      click_on 'Sign up'
      fill_in 'user[name]', with: 'user'
      fill_in 'user[email]', with: 'user@user.com'
      fill_in 'user[password]', with: 'useruser'
      fill_in 'user[password_confirmation]', with: 'useruser'
      click_on 'Create my account'
      click_on 'Logout'
    end
    context 'case of login' do
      it 'log in user info will be displayed' do
        visit root_path
        fill_in 'session[email]', with: 'user@user.com'
        fill_in 'session[password]', with: 'useruser'
        click_on 'Log in'
        expect(page).to have_content %(user's page)
      end
    end
    context %(case of transiting to logged in user's profile) do
      it 'log in user info will be displayed' do
        visit root_path
        fill_in 'session[email]', with: 'user@user.com'
        fill_in 'session[password]', with: 'useruser'
        click_on 'Log in'
        expect(page).to have_content %(user's page)
      end
    end
    context %(case of transiting to another user's profile) do
      it %(finally it is on task index page)  do
        visit root_path
        fill_in 'session[email]', with: 'user@user.com'
        fill_in 'session[password]', with: 'useruser'
        click_on 'Log in'
        visit user_path(99)
        expect(page).to have_content %(Your All Tasks)
      end
    end
    context 'case of logout' do
      it 'finally it is on login page' do
        visit root_path
        fill_in 'session[email]', with: 'user@user.com'
        fill_in 'session[password]', with: 'useruser'
        click_on 'Log in'
        click_on 'Logout'
        expect(page).to have_content 'Log in'
      end
    end
  end
  describe 'functions of login as admin user' do
    let!(:second_user) { FactoryBot.create(:second_user, id: 98) }
    let!(:user) { FactoryBot.create(:user, name: 'フシギダネ', email: '001@pokemon.com', password: '001001', id: 1) }
    let!(:user) { FactoryBot.create(:user, name: 'common', email: 'common@common.com', password: 'common', id: 99) }
    before do
      visit root_path
      click_on 'Sign up'
      fill_in 'user[name]', with: 'user'
      fill_in 'user[email]', with: 'user@user.com'
      fill_in 'user[password]', with: 'useruser'
      fill_in 'user[password_confirmation]', with: 'useruser'
      click_on 'Create my account'
      click_on 'Logout'
    end
    context 'case of transiting to admin index page' do
      it %(common user's info will be desplayed) do
        visit root_path
        fill_in 'session[email]', with: 'super@user.com'
        fill_in 'session[password]', with: 'adminadmin'
        click_on 'Log in'
        click_on 'Administrator ONLY'
        expect(page).to have_content 'common@common.com'
      end
    end
    context 'case of transiting to admin index page logged in as a common user' do
      it %(forcibly transited to the logged in users's index page) do
        visit root_path
        fill_in 'session[email]', with: 'user@user.com'
        fill_in 'session[password]', with: 'useruser'
        click_on 'Log in'
        visit '/admin/users'
        expect(page).to have_content 'This page is for Administrator ONLY'
      end
    end
    context 'case of generating a new common user' do
      it %(common user's info will be desplayed on admin index page) do
        visit root_path
        fill_in 'session[email]', with: 'super@user.com'
        fill_in 'session[password]', with: 'adminadmin'
        click_on 'Log in'
        click_on 'Administrator ONLY'
        click_on 'Create a New User'
        fill_in 'user[name]', with: 'test'
        fill_in 'user[email]', with: 'test@test.com'
        fill_in 'user[password]', with: 'testtest'
        fill_in 'user[password_confirmation]', with: 'testtest'
        click_on '登録する'
        expect(page).to have_content 'test@test.com'
      end
    end
    context %(case of transiting to other user's profile page) do
      it 'tasks created by common user will be desplayed' do
        visit root_path
        fill_in 'session[email]', with: 'super@user.com'
        fill_in 'session[password]', with: 'adminadmin'
        click_on 'Log in'
        click_on 'Administrator ONLY'
        visit '/users/99'
        expect(page).to have_content 'Due'
      end
    end
    context %(case of transiting to common user's edit page) do
      it %(user's info edited by admin user will be desplayed) do
        visit root_path
        fill_in 'session[email]', with: 'super@user.com'
        fill_in 'session[password]', with: 'adminadmin'
        click_on 'Log in'
        click_on 'Administrator ONLY'
        click_on 'Edit', match: :first
        fill_in 'user[name]', with: 'test'
        fill_in 'user[email]', with: 'test@test.com'
        fill_in 'user[password]', with: 'testtest'
        fill_in 'user[password_confirmation]', with: 'testtest'
        click_on '更新する'
        expect(page).to have_content 'test@test.com'
      end
    end
    context 'case of deleting a user' do
      it 'a notification that the user data has been deleted will be flashed' do
        visit root_path
        fill_in 'session[email]', with: 'super@user.com'
        fill_in 'session[password]', with: 'adminadmin'
        click_on 'Log in'
        click_on 'Administrator ONLY'
        click_on 'Delete', match: :first
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content 'data was deleted'
      end
    end
  end

end
