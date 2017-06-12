require 'rails_helper'

RSpec.feature 'Menu page', :type => :feature do
  let!(:category) { FactoryGirl.create :category }

  scenario 'User go to menu' do
    visit menu_path
    expect(page).to have_text('Меню ресторана')
  end

  scenario 'user go to menu and see categories' do
    visit menu_path
    expect(page).to have_text(category.name)
  end
end
