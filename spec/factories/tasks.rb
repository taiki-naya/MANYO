FactoryBot.define do
  factory :task do
  end
  factory :second_task, class: Task do
    title { '堪え難きを堪え' }
    content { '忍び難きを忍び' }
    due_date { '1945-8-15' }
    status { 3 }
  end
end
