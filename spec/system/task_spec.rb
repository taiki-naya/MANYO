require 'rails_helper'
RSpec.describe 'Tasks management system', type: :system do

  describe 'a function of create a new task' do
    context 'case of creating a new task' do
      it 'created task will be displayed' do
        visit new_task_path
        task = FactoryBot.create(:second_task, title: 'title', content: 'content')
        visit tasks_path
        expect(page).to have_content 'content'
      end
    end
    context 'when tasks are ordered by CREATED DATE as descending' do
      it ' the last created task will be displayed the top of tasks' do
        visit new_task_path
        task = FactoryBot.create(:task, title: 'ordered', content: 'desc', status: 2)
        visit new_task_path
        task = FactoryBot.create(:task, title: 'sort', content: 'reverse', status: 1)
        visit tasks_path
        expect(all('td').first).to have_content 'Waiting'
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
        click_on '[▼]'
        expect(all('td').first).to have_content 'In Progress'
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

  describe 'a function of searching for a task' do
    context 'case of searching by TITLE' do
      it 'a task containing the searched string will be displayed' do
        task = FactoryBot.create(:second_task)
        task = FactoryBot.create(:task, title: 'title', content: 'content', status: 1)
        visit tasks_path
        fill_in 'search', with: '堪え難きを堪え'
        click_on 'Search'
        expect(page).to have_content '忍び難きを忍び'
      end
    end
    context 'case of searching by STATUS' do
      it 'a task containing the searched status will be displayed' do
        task = FactoryBot.create(:second_task)
        task = FactoryBot.create(:task, title: 'Summer vacation', content: 'Go to the USA', status: 0)
        visit tasks_path
        select 'To Be Decided', from: 'task[status]'
        click_on 'Search'
        expect(page).to have_content 'USA'
      end
    end
    context 'case of searching by TITLE and STATUS' do
      it 'a task containing the searched title and status will be displayed' do
        task = FactoryBot.create(:second_task)
        task = FactoryBot.create(:second_task, status: 0)
        task = FactoryBot.create(:task, title: 'Summer vacation', content: 'Go to the USA', status: 3)
        visit tasks_path
        fill_in 'search', with: '堪え難きを堪え'
        select 'Completed', from: 'task[status]'
        click_on 'Search'
        expect(page).to have_content '忍び'
      end
    end
  end

end
