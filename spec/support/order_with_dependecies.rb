RSpec.shared_examples "order_with_dependencies" do
  let!(:category) { FactoryGirl.create :category }
  let!(:subcategory) do
    FactoryGirl.create :category, name: 'Чай', parent_id: category.id
  end
  let!(:item) { FactoryGirl.create(:item, category_id: subcategory.id, price: 25) }
  let!(:item_2) { FactoryGirl.create(:item, name: 'Чай с молоком', category_id: subcategory.id, price: 30) }
  let!(:only_order) { FactoryGirl.create :order }
  let!(:order) { FactoryGirl.create :order }
  let!(:order_item) do
    FactoryGirl.create(
      :order_item, item_id: item.id, quantity: 1, order_id: order.id, total_price: item.id
    )
  end
  let!(:order_in_kitchen) { FactoryGirl.create(:order, status: 1) }
  let!(:item_3) { FactoryGirl.create(:item, name: 'Чай с лимоном', category_id: subcategory.id, price: 30) }
  let!(:order_item_2) do
    FactoryGirl.create(
      :order_item, item_id: item_3.id, quantity: 1, order_id: order_in_kitchen.id,
                   total_price: item.id
    )
  end
end
