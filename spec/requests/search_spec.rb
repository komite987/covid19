require 'rails_helper'
include ApplicationHelper



RSpec.describe "Search request", :type => :request do
  before(:each) { user = create(:user);  login_as(user) }
  context "With valid params" do 
    it 'should go to show page' do 
      search_params = {country: "Syria", start_date: "2020-7-25",end_date: '2020-8-1'} 
      post '/search' , params: search_params
      getData(search_params[:country], search_params[:start_date],search_params[:end_date])
      expect(response).to render_template('searches/show')
      expect(response.body).to include("Syria")
      expect(response.body).to include("<h5 class=\"card-header\"> All statistics</h5>")
      expect(response.body).to include("<h4 class=\"card-title\">2020-08-01</h4>")
      expect(response.body).not_to include("<h4 class=\"card-title\">2020-08-02</h4>")
    end

  end



end
