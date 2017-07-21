require 'rails_helper'

RSpec.feature 'Statistics', type: :feature do
  describe 'Statistics' do
    it 'should be have cart link' do
      visit statistics_path
      expect(page).to have_text('Статистика')
    end
  end
end
