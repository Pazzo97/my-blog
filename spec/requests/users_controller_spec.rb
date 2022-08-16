require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET #index' do
    before(:example) { get users_path } # get(:index)

    it 'is a success' do
      expect(response).to have_http_status(:success)
    end

    it 'should render correct template' do
      expect(response).to render_template(:index)
    end

    it 'body should includes correct placeholder text' do
      expect(response.body).to include('Here is a list of all users')
    end
  end

  describe 'GET #show' do
    before(:example) { get user_path(10) }

    it 'is a success' do
      expect(response).to have_http_status(:success)
    end

    it 'should render the show template' do
      expect(response).to render_template(:show)
    end

    it 'should display correct content in the views' do
      expect(response.body).to include('Here is a user with given id')
    end
  end
end
