FactoryGirl.define do
  factory :category do
    
  end
  factory :item do
    name "MyString"
    category nil
  end
  factory :role do
    
  end
  factory :user do
    email 'user@example.com'
    password 'secret'
  end
end
