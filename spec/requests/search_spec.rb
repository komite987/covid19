require 'rails_helper'
include ApplicationHelper



RSpec.describe "Search request", :type => :request do
  before(:each) { user = create(:user);  login_as(user) }
  it 'should go to show page' do 
    post '/search' , params: {country: 'Syria', start_date: "2020-03-22",end_date: '2020-08-11' }
    # expect(response).to render_template('/search')
    # follow_redirect!
    pp response.body
    # expect(response.body).to include("Syria")
  end



end
