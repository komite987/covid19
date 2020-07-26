require 'rails_helper'


describe SearchesController do
  describe "#home" do

    it "Should return succsess response" do
      get :home
      expect(response).to have_http_status(:ok)
    end
  end

end
