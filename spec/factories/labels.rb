FactoryBot.define do
  factory :label do
    name { 'note' }
    id { 1 }
  end
  factory :second_label, class: Label do
    name { 'pending' }
    id { 2 }
  end
  factory :third_label, class: Label do
    name { 'confirming' }
    id { 3 }
  end
end
