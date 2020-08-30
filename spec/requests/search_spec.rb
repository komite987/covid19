require 'rails_helper'
# include ApplicationHelper



RSpec.describe "Search request", :type => :request do
  before(:each) { user = create(:user);  login_as(user) }
  before(:each) do
    @search_params = {country: "Syria", start_date: "2020-7-25",end_date: '2020-8-1'} 
  end

  context "With valid params" do 
    it 'should go to show page and show resault' do 
      post '/search' , params: @search_params
      expect(response).to render_template('searches/show')
      expect(response.body).to include("Syria")
      expect(response.body).to include("All Statistics")
      expect(response.body).to include("<h4 class=\"card-title\">2020-08-01</h4>")
      expect(response.body).not_to include("<h4 class=\"card-title\">2020-08-02</h4>")
    end

    it 'should go to show page and show all statistics if country found without dates' do 
      @search_params[:start_date] = ""
      @search_params[:end_date] = ""
      post '/search' , params: @search_params
      expect(response).to render_template('searches/show')
      expect(response.body).to include("Syria")
      expect(response.body).to include("2020-03-22")
      expect(response.body).to include("#{Time.now.yesterday.yesterday.strftime('%Y-%m-%d')}")
    end


  end

  context "With invalid params" do 
    it 'should render search form if country missing' do 
      @search_params[:country] = ""
      post '/search' , params: @search_params
      expect(response).to have_http_status(400)
      expect(response).to render_template('searches/new')
      expect(response.body).to include("Country can&#39;t be blank")
    end

    it 'should render search form if country not found' do 
      @search_params[:country] = "anything"
      post '/search' , params: @search_params
      expect(response).to have_http_status(404)
      expect(response).to render_template('searches/new')
      expect(response.body).to include("Country not found")
    end

    it 'should render search form if start date format is invalid' do 
      @search_params[:start_date] = "wrong"
      post '/search' , params: @search_params
      expect(response).to have_http_status(400)
      expect(response).to render_template('searches/new')
      expect(response.body).to include("Start Date invalid")
    end

    it 'should render search form if end date format is invalid' do 
      @search_params[:end_date] = "wrong"
      post '/search' , params: @search_params
      expect(response).to have_http_status(400)
      expect(response).to render_template('searches/new')
      expect(response.body).to include("End Date invalid")
    end

    it 'should render search form if start date newer than end date' do 
      @search_params[:start_date] = "2020-08-01"
      @search_params[:end_date] = "2020-07-01"
      post '/search' , params: @search_params
      expect(response).to have_http_status(400)
      expect(response).to render_template('searches/new')
      expect(response.body).to include("Start date is newer than end date")
    end
  end



end
