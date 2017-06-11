require 'rails_helper'

RSpec.feature 'Sessions', type: :feature do
  def sign_in(user, role = nil)
    user.add_role :admin if role == :admin
    visit '/sign_in'
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Log in'
  end

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
