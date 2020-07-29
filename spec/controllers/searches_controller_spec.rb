require 'rails_helper'

RSpec.describe SearchesController, type: :controller do

  describe "#home" do

    it "Should return succsess response" do
      get :home
      expect(response).to have_http_status(:ok)
    end
  end

  login_user

  describe "GET #new" do
    it "returns a success response" do
      get :new
            expect(response).to have_http_status(:ok)
          end
        end



      end
