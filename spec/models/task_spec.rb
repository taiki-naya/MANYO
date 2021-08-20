require 'rails_helper'

RSpec.describe 'function of task model', type: :model do
  describe 'test for validations' do

    context 'when title is blank' do
      it 'fails to pass a validation' do
        task = Task.new(content: 'title is blank')
        expect(task).not_to be_valid
      end
    end

    context 'when content is blank' do
      it 'fail to pass a validation' do
        task = Task.new(title: 'content is blank')
        expect(task).not_to be_valid
      end
    end

    context 'when title and content are NOT blank' do
      it "success to pass validations" do
        task = Task.create(title: 'title', content: 'content')
        expect(task).to be_valid
      end
    end
  end

  describe 'test for scopes' do
    let!(:task) { FactoryBot.create(:task, title: 'task', content: 'content', status: 0) }
    let!(:second_task) { FactoryBot.create(:second_task, title: "sample") }
    let!(:third_task) { FactoryBot.create(:task, title: 'hoge', content: 'content', status: 3) }
    context 'in case of searching for tasks by TITLE' do
      it 'tasks containing the searched string will be refined' do
        # {'status' => '10'} means status is blank
        expect(Task.search('task', {'status' => '10'})).to include(task)
        expect(Task.search('task', {'status' => '10'})).not_to include(second_task)
        expect(Task.search('task', {'status' => '10'})).not_to include(third_task)
        expect(Task.search('task', {'status' => '10'}).count).to eq 1
      end
    end
    context 'in case of searching for tasks by STATUS' do
      it 'tasks containing the searched status will be refined' do
        # '' means form for searching is blank
        expect(Task.search('', {'status' => '3'})).not_to include(task)
        expect(Task.search('', {'status' => '3'})).to include(second_task)
        expect(Task.search('', {'status' => '3'})).to include(third_task)
        expect(Task.search('', {'status' => '3'}).count).to eq 2
      end
    end
    context 'in case of searching for tasks by TITLE and STATUS' do
      it 'tasks containing the searched string and status will be refined' do
        expect(Task.search('sample', {'status' => '3'})).not_to include(task)
        expect(Task.search('sample', {'status' => '3'})).to include(second_task)
        expect(Task.search('sample', {'status' => '3'})).not_to include(third_task)
        expect(Task.search('sample', {'status' => '3'}).count).to eq 1
      end
    end
  end

end
