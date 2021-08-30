require 'rails_helper'
RSpec.describe 'Labelling on Tasks system', type: :system do
  let!(:user) { FactoryBot.create(:user, name: 'user', email: 'user@user.com', password: 'useruser') }
  let!(:label) { FactoryBot.create(:label)}
  let!(:second_label) { FactoryBot.create(:second_label)}
  let!(:third_label) { FactoryBot.create(:third_label)}
  before do
    visit root_path
    fill_in 'session[email]', with: 'user@user.com'
    fill_in 'session[password]', with: 'useruser'
    click_on 'Log in'
    click_on 'Tasks index'
  end
  describe 'a function of creating a new task' do
    context 'case of creating a new task with 1 label' do
      it 'created task will be displayed with 1 label' do
        click_on 'Create a New Task', match: :first
        check 'note'
        fill_in 'task[title]', with: 'title'
        fill_in 'task[content]', with: 'content'
        select '2021', from: 'task[due_date(1i)]'
        select '8', from: 'task[due_date(2i)]'
        select '15', from: 'task[due_date(3i)]'
        select 'In Progress', from: 'task[status]'
        select 'Middle', from: 'task[priority]'
        click_on '登録する'
        expect(page).to have_content 'note'
      end
    end
    context 'case of creating a new task with 2 labels' do
      it 'created task will be displayed with 2 labels' do
        click_on 'Create a New Task', match: :first
        check 'note'
        check 'pending'
        fill_in 'task[title]', with: 'title'
        fill_in 'task[content]', with: 'content'
        select '2021', from: 'task[due_date(1i)]'
        select '8', from: 'task[due_date(2i)]'
        select '15', from: 'task[due_date(3i)]'
        select 'In Progress', from: 'task[status]'
        select 'Middle', from: 'task[priority]'
        click_on '登録する'
        expect(page).to have_content 'note'
        expect(page).to have_content 'pending'
      end
    end
  end
  describe 'a function of editing a task' do
    context 'case of editing a task from 2 labels to 1 label' do
      it 'edited task will be displayed with 1 label' do
        click_on 'Create a New Task', match: :first
        check 'note'
        check 'pending'
        fill_in 'task[title]', with: 'title'
        fill_in 'task[content]', with: 'content'
        select '2021', from: 'task[due_date(1i)]'
        select '8', from: 'task[due_date(2i)]'
        select '15', from: 'task[due_date(3i)]'
        select 'In Progress', from: 'task[status]'
        select 'Middle', from: 'task[priority]'
        click_on '登録する'
        click_on 'Edit'
        check 'confirming'
        click_on '更新する'
        expect(page).to have_content 'confirming'
      end
    end
  end
  describe 'a function of searching a task with labels' do
    context 'case of editing a task from 2 labels to 1 label' do
      it 'edited task will be displayed with 1 label' do
        click_on 'Create a New Task', match: :first
        check 'note'
        check 'pending'
        fill_in 'task[title]', with: 'title'
        fill_in 'task[content]', with: 'content'
        select '2021', from: 'task[due_date(1i)]'
        select '8', from: 'task[due_date(2i)]'
        select '15', from: 'task[due_date(3i)]'
        select 'In Progress', from: 'task[status]'
        select 'Middle', from: 'task[priority]'
        click_on '登録する'
        click_on 'Create a New Task', match: :first
        check 'confirming'
        fill_in 'task[title]', with: 'title'
        fill_in 'task[content]', with: 'content'
        select '2021', from: 'task[due_date(1i)]'
        select '8', from: 'task[due_date(2i)]'
        select '15', from: 'task[due_date(3i)]'
        select 'In Progress', from: 'task[status]'
        select 'Middle', from: 'task[priority]'
        click_on '登録する'
        select 'confirming', from: 'labels[label_id]'
        click_on 'Search'
        expect(page).to have_content 'confirming'
      end
    end
  end

end
