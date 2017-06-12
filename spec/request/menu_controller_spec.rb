require 'rails_helper'

RSpec.describe MenuController, type: :request do
  let!(:category) { FactoryGirl.create :category }

  describe 'response' do
    it 'should be return 200' do
      get menu_path
      expect(response).to have_http_status 200
    end
  end

  describe 'category' do
    it 'should be displayed menu categories' do

    end
  end
end
