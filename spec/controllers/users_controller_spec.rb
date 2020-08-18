require 'rails_helper'

RSpec.describe UsersController do

  context 'when logged in admin' do 
    login_admin

    it "returns a success response" do
      get :index
      expect(response).to have_http_status(:ok) 
    end
  end

  context 'when not logged in admin' do 
    login_user
    it "returns a not authorized response" do
      get :index
      expect(response).to redirect_to('/')
      expect(response).to have_http_status(:found) 
    end
  end


end



