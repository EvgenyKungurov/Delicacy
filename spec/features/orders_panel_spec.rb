require 'rails_helper'

RSpec.feature 'orders panel', type: :feature do
  include_examples 'order_with_dependencies'

  scenario 'user see orders panel' do
    visit orders_panel_index_path
    expect(page).to have_text('Готовится')
    expect(page).to have_text('Готовые')
    expect(page).to have_text('Отданные')
  end

  scenario 'create order should be add order to orders panel', js: true do
    visit menu_path(category.id)
    click_button('Добавить в заказ', id: "item_#{item.id}")
    wait_for_ajax
    click_button('Распечатать заказ и принять новый')
    wait_for_ajax
    visit orders_panel_index_path
    expect(page).to have_css(
      'tr', text: item.name,
            id: "order_number_#{Order.last.current_number - 1}_item"
    )
  end

  # scenario 'create order should be add order to orders panel', js: true do
  #   order = FactoryGirl.create(:order, status: 1)
  #   order_item = FactoryGirl.create(
  #     :order_item, item_id: item.id, quantity: 1, order_id: order.id,
  #                  total_price: item.id
  #   )
  #   byebug
  #   expect(page).to have_css(
  #     'tr', text: item.name,
  #           id: "order_number_#{order.current_number}_item"
  #   )
  # end

  # scenario 'order panel have input type number', js: true do
  #   visit menu_path(category.id)
  #   click_button('Добавить в заказ', id: "item_#{item.id}")
  #   wait_for_ajax
  #   expect(page).to have_css('input', id: "order_item_#{order_item.id + 1}_quantity")
  # end

  # scenario 'change input type number will be changing value', js: true do
  #   visit menu_path(category.id)
  #   click_button('Добавить в заказ', id: "item_#{item.id}")
  #   wait_for_ajax
  #   find('input', id: "order_item_#{order_item.id + 1}_quantity").set(20)
  #   wait_for_ajax
  #   expect(find('input', id: "order_item_#{order_item.id + 1}_quantity").value).to eq '20'
  # end

  # scenario 'order panel have total_price', js: true do
  #   visit menu_path(category.id)
  #   click_button('Добавить в заказ', id: "item_#{item.id}")
  #   wait_for_ajax
  #   find('input', id: "order_item_#{order_item.id + 1}_quantity").set(2)
  #   wait_for_ajax
  #   expect(find('h2', id: 'total_price').text).to eq "Итого: #{item.price * 2} рублей"
  # end

  # scenario 'add two item to order panel should be equal total_price two items', js: true do
  #   visit menu_path(category.id)
  #   click_button('Добавить в заказ', id: "item_#{item.id}")
  #   click_button('Добавить в заказ', id: "item_#{item_2.id}")
  #   wait_for_ajax
  #   expect(find('h2', id: 'total_price').text).to eq "Итого: #{item.price + item_2.price} рублей"
  # end

  # scenario 'remove item on order panel will be decrease total_price', js: true do
  #   visit menu_path(category.id)
  #   click_button('Добавить в заказ', id: "item_#{item.id}")
  #   wait_for_ajax
  #   click_button('Удалить')
  #   wait_for_ajax
  #   expect(find('h2', id: 'total_price').text).to eq 'Итого: 0 рублей'
  # end

  # scenario 'to print button should be print order and delete order from session', js: true do
  #   visit menu_path(category.id)
  #   click_button('Добавить в заказ', id: "item_#{item.id}")
  #   wait_for_ajax
  #   click_button('Распечатать заказ и принять новый')
  #   visit menu_path(category.id)
  #   expect(find('h2', id: 'order').text).to eq "Заказ № #{Order.order_number_today}"
  # end

  # scenario 'not raise error if order was destroyed on server without delete from cookie', js: true do
  #   visit menu_path(category.id)
  #   click_button('Добавить в заказ', id: "item_#{item.id}")
  #   wait_for_ajax
  #   Order.last.destroy
  #   visit menu_path(category.id)
  #   expect(find('h2', id: 'order').text).to eq "Заказ № #{Order.order_number_today}"
  # end
end
