require 'rails_helper'

RSpec.describe 'function of task model', type: :model do
  describe 'test for validations' do

    context 'in case of title is blank' do
      it 'fails to pass a validation' do
        task = Task.new(content: 'title is blank')
        expect(task).not_to be_valid
      end
    end

    context 'in case of content is blank' do
      it 'fail to pass a validation' do
        task = Task.new(title: 'content is blank')
        expect(task).not_to be_valid
      end
    end

    context 'in case of title and content are not blank' do
      it "success to pass validations" do
        task = Task.create(title: 'title', content: 'content')
        expect(task).to be_valid
      end
    end

  end
end
