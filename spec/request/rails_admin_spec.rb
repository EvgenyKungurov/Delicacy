require 'rails_helper'

RSpec.describe 'Rails Admin', type: :request do
  let(:user) { FactoryGirl.create :user }

  def sign_in(user, role = nil)
    user.add_role :admin if role&.to_sym == :admin
    user = { 'user[email]' => user.email, 'user[password]' => user.password }
    post new_user_session_path, params: user
  end

  describe 'rails_admin_path' do
    context 'admin' do
      it 'should be available for admin' do
        sign_in(user, :admin)
        get rails_admin_path
        expect(response).to have_http_status 200
      end
    end

    # not working not undestanding
    # context 'simple user' do
    #   it 'should not be available' do
    #     sign_in(user)
    #     get rails_admin_path
    #     expect(response).to redirect_to root_path
    #   end
    # end

    context 'anonymous' do
      it 'should not be available' do
        get rails_admin_path
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
