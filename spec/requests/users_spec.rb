require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    before(:example) { get users_path }
    it 'should return success status' do
      expect(response).to have_http_status(:ok)
    end

    it 'it renders index template' do
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /show' do
    before(:example) { get('/users/1') }
    it 'should return success status' do
      expect(response).to have_http_status(:ok)
    end

    it 'it renders index template' do
      expect(response).to render_template(:show)
    end
  end
end
