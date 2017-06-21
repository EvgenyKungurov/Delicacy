require 'rails_helper'

RSpec.feature 'Menu page', type: :feature do
  let!(:category) { FactoryGirl.create :category }
  let!(:subcategory) do
    FactoryGirl.create :category, name: 'чай', parent_id: category.id
  end
  let!(:item) { FactoryGirl.create(:item, category_id: subcategory.id, price: 25) }
  let!(:item_2) { FactoryGirl.create(:item, name: 'Чай с молоком', category_id: subcategory.id, price: 30) }
  let!(:order) { FactoryGirl.create(:order, id: 5) }
  let!(:order_item) do
    FactoryGirl.create(
      :order_item, item_id: item.id, quantity: 1, order_id: order.id, total_price: item.id
    )
  end

  scenario 'User go to menu' do
    visit menu_index_path
    expect(page).to have_text('Меню ресторана')
  end

  scenario 'user go to menu and see categories' do
    visit menu_index_path
    expect(page).to have_text(category.name)
  end

  scenario 'user see button to cart if category have not nested category' do
    visit menu_path(category.id)
    expect(page).to have_button('Добавить в заказ', id: "item_#{item.id}")
  end

  scenario 'add to cart append to order panel and save in session', js: true do
    visit menu_path(category.id)
    click_button('Добавить в заказ', id: "item_#{item.id}")
    wait_for_ajax
    visit menu_path(category.id)
    expect(page).to have_css('p', text: item.name, id: "order_item_#{order_item.id + 1}")
  end

  scenario 'order panel have input type number', js: true do
    visit menu_path(category.id)
    click_button('Добавить в заказ', id: "item_#{item.id}")
    wait_for_ajax
    expect(page).to have_css('input', id: "order_item_#{order_item.id + 1}_quantity")
  end

  scenario 'change input type number will be changing value', js: true do
    visit menu_path(category.id)
    click_button('Добавить в заказ', id: "item_#{item.id}")
    wait_for_ajax
    find('input', id: "order_item_#{order_item.id + 1}_quantity").set(20)
    wait_for_ajax
    expect(find('input', id: "order_item_#{order_item.id + 1}_quantity").value).to eq '20'
  end

  scenario 'order panel have total_price', js: true do
    visit menu_path(category.id)
    click_button('Добавить в заказ', id: "item_#{item.id}")
    wait_for_ajax
    find('input', id: "order_item_#{order_item.id + 1}_quantity").set(2)
    wait_for_ajax
    expect(find('h2', id: 'total_price').text).to eq "Итого: #{item.price * 2} рублей"
  end

  scenario 'add two item to order panel should be equal total_price two items', js: true do
    visit menu_path(category.id)
    click_button('Добавить в заказ', id: "item_#{item.id}")
    click_button('Добавить в заказ', id: "item_#{item_2.id}")
    wait_for_ajax
    expect(find('h2', id: 'total_price').text).to eq "Итого: #{item.price + item_2.price} рублей"
  end

  scenario 'remove item on order panel will be decrease total_price', js: true do
    visit menu_path(category.id)
    click_button('Добавить в заказ', id: "item_#{item.id}")
    wait_for_ajax
    click_button('Удалить')
    wait_for_ajax
    expect(find('h2', id: 'total_price').text).to eq 'Итого: 0 рублей'
  end

  scenario 'to print button should be print order and delete order from session', js: true do
    visit menu_path(category.id)
    click_button('Добавить в заказ', id: "item_#{item.id}")
    wait_for_ajax
    click_button('Распечатать заказ и принять новый')
    visit menu_path(category.id)
    expect(find('h2', id: 'order').text).to eq "Заказ № #{Order.last.id}"
  end

  scenario 'order should be have number start with 1 for current day', js: true do
    visit menu_path(category.id)
    click_button('Добавить в заказ', id: "item_#{item.id}")
    wait_for_ajax
    expect(find('h2', id: 'order').text).to eq 'Заказ № 1'
  end
end
