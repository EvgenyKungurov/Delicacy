require 'rails_helper'

RSpec.feature 'Cart', type: :feature do
  include SessionsCapybara
  let!(:user) { FactoryGirl.create :user }

  describe 'cart' do
    context 'loggin in' do
      it 'should be have cart link' do
        sign_in(user)
        expect(page).to have_text('Корзина')
      end
    end
  end
end
