require 'rails_helper'

RSpec.feature 'Statistics', type: :feature do
  include_examples 'order_with_dependencies'

  describe 'Statistics' do
    it 'should be have_text Статистика' do
      visit statistics_path
      expect(page).to have_text('Статистика')
    end

    it 'should be have_text Составить отчет' do
      visit statistics_path
      expect(page).to have_text('Составить отчет')
    end
  end
end
