require 'rails_helper'
RSpec.describe 'Tasks management system', type: :system do

  let!(:user) { FactoryBot.create(:user, name: 'user', email: 'user@user.com', password: 'useruser') }

  describe 'a function of create a new task' do
    context 'case of creating a new task' do
      it 'created task will be displayed' do
        visit root_path
        fill_in 'session[email]', with: 'user@user.com'
        fill_in 'session[password]', with: 'useruser'
        click_on 'Log in'
        click_on 'Tasks index'
        click_on 'Create a New Task', match: :first
        fill_in 'task[title]', with: 'title'
        fill_in 'task[content]', with: 'content'
        select '2021', from: 'task[due_date(1i)]'
        select '8', from: 'task[due_date(2i)]'
        select '15', from: 'task[due_date(3i)]'
        select 'In Progress', from: 'task[status]'
        select 'Middle', from: 'task[priority]'
        click_on '登録する'
        expect(page).to have_content 'content'
      end
    end
    context 'when tasks are ordered by CREATED DATE as descending' do
      it ' the last created task will be displayed the top of tasks' do
        visit root_path
        fill_in 'session[email]', with: 'user@user.com'
        fill_in 'session[password]', with: 'useruser'
        click_on 'Log in'
        click_on 'Tasks index'
        click_on 'Create a New Task', match: :first
        fill_in 'task[title]', with: 'later'
        fill_in 'task[content]', with: 'will do'
        select '2021', from: 'task[due_date(1i)]'
        select '9', from: 'task[due_date(2i)]'
        select '1', from: 'task[due_date(3i)]'
        select 'In Progress', from: 'task[status]'
        select 'High', from: 'task[priority]'
        click_on '登録する'
        click_on 'Create a New Task', match: :first
        fill_in 'task[title]', with: 'immediately'
        fill_in 'task[content]', with: 'doing'
        select '2021', from: 'task[due_date(1i)]'
        select '8', from: 'task[due_date(2i)]'
        select '21', from: 'task[due_date(3i)]'
        select 'Waiting', from: 'task[status]'
        select 'Low', from: 'task[priority]'
        click_on '登録する'
        expect(all('td').first).to have_content 'Low'
      end
    end
    context 'when tasks are ordered by DUE DATE as descending' do
      it ' the created task will be displayed the top of tasks' do
        visit root_path
        fill_in 'session[email]', with: 'user@user.com'
        fill_in 'session[password]', with: 'useruser'
        click_on 'Log in'
        click_on 'Tasks index'
        click_on 'Create a New Task', match: :first
        fill_in 'task[title]', with: 'later'
        fill_in 'task[content]', with: 'will do'
        select '2021', from: 'task[due_date(1i)]'
        select '9', from: 'task[due_date(2i)]'
        select '1', from: 'task[due_date(3i)]'
        select 'In Progress', from: 'task[status]'
        select 'High', from: 'task[priority]'
        click_on '登録する'
        click_on 'Create a New Task', match: :first
        fill_in 'task[title]', with: 'immediately'
        fill_in 'task[content]', with: 'doing'
        select '2021', from: 'task[due_date(1i)]'
        select '8', from: 'task[due_date(2i)]'
        select '21', from: 'task[due_date(3i)]'
        select 'Waiting', from: 'task[status]'
        select 'Low', from: 'task[priority]'
        click_on '登録する'
        click_on '[▼]', match: :first
        click_on '[▼]', match: :first
        expect(all('td').first).to have_content 'High'
      end
    end
    context 'when tasks are ordered by PRIORITY as descending' do
      it ' the created task will be displayed the top of tasks' do
        visit root_path
        fill_in 'session[email]', with: 'user@user.com'
        fill_in 'session[password]', with: 'useruser'
        click_on 'Log in'
        click_on 'Tasks index'
        click_on 'Create a New Task', match: :first
        fill_in 'task[title]', with: 'later'
        fill_in 'task[content]', with: 'will do'
        select '2021', from: 'task[due_date(1i)]'
        select '9', from: 'task[due_date(2i)]'
        select '1', from: 'task[due_date(3i)]'
        select 'In Progress', from: 'task[status]'
        select 'Middle', from: 'task[priority]'
        click_on '登録する'
        click_on 'Create a New Task', match: :first
        fill_in 'task[title]', with: 'immediately'
        fill_in 'task[content]', with: 'doing'
        select '2021', from: 'task[due_date(1i)]'
        select '8', from: 'task[due_date(2i)]'
        select '21', from: 'task[due_date(3i)]'
        select 'Waiting', from: 'task[status]'
        select 'High', from: 'task[priority]'
        click_on '登録する'
        click_on '[▼]', match: :first
        expect(all('td').first).to have_content 'High'
      end
    end
  end

  describe 'a function of displaying task index' do
    context 'case of transiting to index page' do
      it 'tasks index will be displayed' do
        visit root_path
        fill_in 'session[email]', with: 'user@user.com'
        fill_in 'session[password]', with: 'useruser'
        click_on 'Log in'
        click_on 'Tasks index'
        click_on 'Create a New Task', match: :first
        fill_in 'task[title]', with: 'title'
        fill_in 'task[content]', with: 'content'
        select '2021', from: 'task[due_date(1i)]'
        select '9', from: 'task[due_date(2i)]'
        select '1', from: 'task[due_date(3i)]'
        select 'In Progress', from: 'task[status]'
        click_on '登録する'
        visit tasks_path
        expect(page).to have_content 'content'
      end
    end
  end

  describe 'a function of displaying a show page' do
    context 'case of transiting any tasks show page' do
      it 'detail of a applicable task will displayed' do
        visit root_path
        fill_in 'session[email]', with: 'user@user.com'
        fill_in 'session[password]', with: 'useruser'
        click_on 'Log in'
        click_on 'Tasks index'
        click_on 'Create a New Task', match: :first
        fill_in 'task[title]', with: 'transiting to'
        fill_in 'task[content]', with: 'show page'
        select '2021', from: 'task[due_date(1i)]'
        select '9', from: 'task[due_date(2i)]'
        select '1', from: 'task[due_date(3i)]'
        select 'In Progress', from: 'task[status]'
        click_on '登録する'
        click_on 'Show'
        expect(page).to have_content 'show page'
      end
    end
  end

  describe 'a function of searching for a task' do
    context 'case of searching by TITLE' do
      it 'a task containing the searched string will be displayed' do
        visit root_path
        fill_in 'session[email]', with: 'user@user.com'
        fill_in 'session[password]', with: 'useruser'
        click_on 'Log in'
        click_on 'Tasks index'
        click_on 'Create a New Task', match: :first
        fill_in 'task[title]', with: 'later'
        fill_in 'task[content]', with: 'will do'
        select '2021', from: 'task[due_date(1i)]'
        select '9', from: 'task[due_date(2i)]'
        select '1', from: 'task[due_date(3i)]'
        select 'In Progress', from: 'task[status]'
        click_on '登録する'
        click_on 'Create a New Task', match: :first
        fill_in 'task[title]', with: 'immediately'
        fill_in 'task[content]', with: 'doing'
        select '2021', from: 'task[due_date(1i)]'
        select '8', from: 'task[due_date(2i)]'
        select '21', from: 'task[due_date(3i)]'
        select 'Waiting', from: 'task[status]'
        click_on '登録する'
        fill_in 'search', with: 'later'
        click_on 'Search'
        expect(page).to have_content 'will do'
      end
    end
    context 'case of searching by STATUS' do
      it 'a task containing the searched status will be displayed' do
        visit root_path
        fill_in 'session[email]', with: 'user@user.com'
        fill_in 'session[password]', with: 'useruser'
        click_on 'Log in'
        click_on 'Tasks index'
        click_on 'Create a New Task', match: :first
        fill_in 'task[title]', with: 'Summer vacation'
        fill_in 'task[content]', with: 'Go to the USA'
        select '2021', from: 'task[due_date(1i)]'
        select '9', from: 'task[due_date(2i)]'
        select '1', from: 'task[due_date(3i)]'
        select 'Waiting', from: 'task[status]'
        click_on '登録する'
        click_on 'Create a New Task', match: :first
        fill_in 'task[title]', with: 'Winter vacation'
        fill_in 'task[content]', with: 'Pending'
        select '2021', from: 'task[due_date(1i)]'
        select '8', from: 'task[due_date(2i)]'
        select '21', from: 'task[due_date(3i)]'
        select 'To Be Decided', from: 'task[status]'
        click_on '登録する'
        select 'Waiting', from: 'task[status]'
        click_on 'Search'
        expect(page).to have_content 'USA'
      end
    end
    context 'case of searching by TITLE and STATUS' do
      it 'a task containing the searched title and status will be displayed' do
        visit root_path
        fill_in 'session[email]', with: 'user@user.com'
        fill_in 'session[password]', with: 'useruser'
        click_on 'Log in'
        click_on 'Tasks index'
        click_on 'Create a New Task', match: :first
        fill_in 'task[title]', with: 'Summer vacation'
        fill_in 'task[content]', with: 'Go to the USA'
        select '2021', from: 'task[due_date(1i)]'
        select '9', from: 'task[due_date(2i)]'
        select '1', from: 'task[due_date(3i)]'
        select 'Waiting', from: 'task[status]'
        click_on '登録する'
        click_on 'Create a New Task', match: :first
        fill_in 'task[title]', with: 'Winter vacation'
        fill_in 'task[content]', with: 'Pending'
        select '2021', from: 'task[due_date(1i)]'
        select '8', from: 'task[due_date(2i)]'
        select '21', from: 'task[due_date(3i)]'
        select 'To Be Decided', from: 'task[status]'
        click_on '登録する'
        click_on 'Create a New Task', match: :first
        fill_in 'task[title]', with: 'Spring vacation'
        fill_in 'task[content]', with: 'Go sking'
        select '2021', from: 'task[due_date(1i)]'
        select '8', from: 'task[due_date(2i)]'
        select '21', from: 'task[due_date(3i)]'
        select 'To Be Decided', from: 'task[status]'
        click_on '登録する'
        fill_in 'search', with: 'vacation'
        select 'To Be Decided', from: 'task[status]'
        click_on 'Search'
        expect(page).to have_content 'Spring'
      end
    end
  end

end
