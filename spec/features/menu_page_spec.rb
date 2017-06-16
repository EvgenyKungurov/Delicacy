require 'rails_helper'

RSpec.feature 'Menu page', type: :feature do
  let!(:category) { FactoryGirl.create :category }
  let!(:subcategory) do
    FactoryGirl.create :category, name: 'чай', parent_id: category.id
  end
  let!(:item) { FactoryGirl.create(:item, category_id: subcategory.id, price: 25) }

  scenario 'User go to menu' do
    visit menu_index_path
    expect(page).to have_text('Меню ресторана')
  end

  scenario 'user go to menu and see categories' do
    visit menu_index_path
    expect(page).to have_text(category.name)
  end

  scenario 'user see button to cart if category have not nested category' do
    visit menu_index_path
    expect(page).to have_button('Добавить в заказ', id: "item_#{item.id}")
  end

  scenario 'add to cart append to order panel and save in session', js: true do
    visit menu_index_path
    click_button('Добавить в заказ')
    wait_for_ajax
    visit menu_index_path
    expect(page).to have_css('p', text: item.name, id: "order_item_#{item.id}")
  end
end
