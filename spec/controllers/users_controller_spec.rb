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
      expect(response).to have_http_status(401) 
    end
  end


end

 #  it "registes a new agency admin user" do
 #   post '/v1/admin/user', params: (Rails.configuration.agency_admin_attributes) , as: :json ,headers:{:Authorization =>ikar_token,:accept => :json, content_type: :json }
 #   resp =JSON.parse(response.body)
 #   Rails.configuration.agency_admin_id = resp["data"]["user"]["id"]
 #   Rails.configuration.agency_admin_agency_ref_id = resp["data"]["user"]["agency_ref_id"]
 #   expect(response.status).to eql(201)
 # end



