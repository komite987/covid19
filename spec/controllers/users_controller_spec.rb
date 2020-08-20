require 'rails_helper'

RSpec.describe UsersController do
  describe "Get #index" do 
    context 'when logged in admin' do 
      render_views
      login_admin
      it "returns a success response" do
        get :index
        expect(response).to have_http_status(:ok)
        expect(response.body).to include('<h1 class="text-center">Users List</h1>') 
      end
    end

    context 'when not logged in admin' do 
      login_user
      it "returns a not authorized response" do
        get :index
        expect(response).to redirect_to('/')
        expect(flash[:error]).to match(/Only admins can do this*/)
      end
    end
  end

  describe "Get #new" do 
    context 'when logged in admin' do 
      render_views
      login_admin
      it "returns a success response" do
        get :new
        expect(response).to have_http_status(:ok)
        expect(response.body).to include('<h1 class="text-center">Add new user </h1>') 
      end
    end

    context 'when not logged in admin' do 
      login_user
      it "returns a not authorized response" do
        get :new
        expect(response).to redirect_to('/')
        expect(flash[:error]).to match(/Only admins can do this*/)
      end
    end
  end

  describe "Get #edit" do
  let!(:user1) { create(:user) } 

    context 'when logged in admin' do 
      render_views
      login_admin
      it "returns a success response" do
        get :edit, params: {id: user1.id}
        expect(response).to have_http_status(:ok)
        expect(response.body).to include('Edit user account') 
      end
    end

    context 'when not logged in admin' do 
      login_user
      it "returns a not authorized response" do
        get :edit, params: {id: user1.id}
        expect(response).to redirect_to('/')
        expect(flash[:error]).to match(/Only admins can do this*/)
      end
    end

  end

end

