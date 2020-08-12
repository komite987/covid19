require 'rails_helper'



RSpec.describe "Admin actions", :type => :request do
  login_admin

  # before(:each) do
    # admin = create(:admin)
    # login_as(admin)
  # end


  it "add user by admin" do
    post "/users" , params: { user: {name: 'komait55', email: 'komait555@gmail.com', mobile:'0988323323', phone: '04188008800', password: '123456', password_confirmation: '123456'}}
      # pp response.methods
      # pp response
      expect(response).to redirect_to('/users')
      follow_redirect!
      expect(response.body).to include("User added successfully")
    end
  end
