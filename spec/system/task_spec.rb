require 'rails_helper'
RSpec.describe 'Tasks management system', type: :system do

  describe 'a function of create a new task' do
    context 'case of creating a new task' do
      it 'created task will be displayed' do
        visit new_task_path
        task = FactoryBot.create(:task, title: 'title', content: 'content')
        visit tasks_path
        expect(page).to have_content 'content'
      end
    end
    context 'when tasks are ordered by CREATED DATE as descending' do
      it ' the last created task will be displayed the top of tasks' do
        visit new_task_path
        task = FactoryBot.create(:task, title: 'ordered', content: 'desc')
        visit new_task_path
        task = FactoryBot.create(:task, title: 'sort', content: 'reverse')
        visit tasks_path
        expect(all('td').first).to have_content 'sort'
      end
    end
    context 'when tasks are ordered by DUE DATE as descending' do
      it ' the created task will be displayed the top of tasks' do
        visit root_path
        click_on 'Create a New Task', match: :first
        fill_in 'task[title]', with: 'later'
        fill_in 'task[content]', with: 'will do'
        select '2021', from: 'task[due_date(1i)]'
        select '9', from: 'task[due_date(2i)]'
        select '1', from: 'task[due_date(3i)]'
        click_on '登録する'
        click_on 'Create a New Task', match: :first
        fill_in 'task[title]', with: 'immediately'
        fill_in 'task[content]', with: 'doing'
        select '2021', from: 'task[due_date(1i)]'
        select '8', from: 'task[due_date(2i)]'
        select '21', from: 'task[due_date(3i)]'
        click_on '登録する'
        click_on '[▼]'
        expect(all('td').first).to have_content 'later'
      end
    end
  end

  describe 'a function of displaying task index' do
    context 'case of transiting to index page' do
      it 'tasks index will be displayed' do
        task = FactoryBot.create(:second_task, content: 'detail')
        visit tasks_path
        expect(page).to have_content 'detail'
      end
    end
  end

  describe 'a function of displaying a show page' do
    context 'case of transiting any tasks show page' do
      it 'detail of a applicable task will displayed' do
        task = FactoryBot.create(:second_task, title: 'show page')
        visit task_path(task.id)
        expect(page).to have_content 'show page'
      end
    end
  end

end
