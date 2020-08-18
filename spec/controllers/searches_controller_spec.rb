require 'rails_helper'

RSpec.describe SearchesController, type: :controller do

  describe "#home" do

    it "Should return succsess response" do
      get :home
      expect(response).to have_http_status(:ok)
    end
  end

  context 'when logged in user' do 
    login_user

    describe "GET #new" do
      it "returns a success response" do
        get :new
        expect(response).to have_http_status(:ok)
      end
    end

    describe "POST #show" do
      it "returns a success response" do
        post :show , params: { country: 'syria', start_date: '2020-3-1', end_date: '2020-7-1' }
        expect(response).to have_http_status(200)
      end
    end

  end 

  context 'when not logged in user' do 
    describe "GET #new" do
      it "redirect to login page" do
        get :new
        expect(response).to redirect_to '/login'
      end
    end
  end 



end
