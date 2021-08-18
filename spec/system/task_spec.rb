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
