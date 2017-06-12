require 'rails_helper'

RSpec.feature 'Sessions', type: :feature do
  include SessionsCapybara
  let!(:user) { FactoryGirl.create :user }

  describe 'login button' do
    context 'not loggin in' do
      it 'should be have login link' do
        visit root_path
        expect(page).to have_text('Вход')
      end
    end

    context 'loggin in' do
      it 'should be have logout link' do
        sign_in(user)
        expect(page).to have_text('Выход')
      end
    end
  end
end
