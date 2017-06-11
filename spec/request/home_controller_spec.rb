require 'rails_helper'

RSpec.describe HomeController, type: :request do
  describe 'response' do
    it 'should be return 200' do
      get root_path
      expect(response).to have_http_status 200
    end
  end
end
