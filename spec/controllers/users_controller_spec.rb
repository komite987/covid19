require 'rails_helper'

RSpec.describe UsersController do

  context 'when logged in admin' do 
    login_admin
    it "returns a success response" do
      get :index
      expect(response).to have_http_status(:ok) 
    end

  #   it "add user by admin" do
  #     post :create , params: { user: {name: 'komait55', email: 'komait555@gmail.com', mobile:'0988323323', phone: '04188008800', passowrd: '123456', passowrd_confirmation: '123456'}}
  #     expect(response).to have_http_status(201) 
  #     # pp response.methods
  #     expect(response).to render_template("index")
  #   end

  # end

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



