FactoryBot.define do
  factory :task do
  end
  factory :second_task, class: Task do
    title { 'create' }
    content { 'detail' }
  end
end
