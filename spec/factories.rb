FactoryGirl.define do
  factory :order_item do
    order nil
  end
  factory :order do
    
  end
  factory :category do
    name "Горячие напитки"
  end
  factory :item do
    name "Зеленый чай"
    category nil
  end
  factory :role do
  end
  factory :user do
    email 'user@example.com'
    password 'secret'
  end
end
