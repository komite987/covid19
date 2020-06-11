class SearchesController < ApplicationController
  include ApplicationHelper

  def home
    
  end
  def new
  end

  def show
    country = params['country'].gsub(" ", "-").downcase
    start_date = Date.parse(params['start_date']).yesterday.strftime('%Y-%m-%d')
    end_date =  Date.parse(params['end_date']).strftime('%Y-%m-%d')

    if country == "" || ( Date.parse(end_date) < Date.parse(start_date) ) || check_country(country)
      render 'new'
    else
      @json = get_data(country, start_date,end_date)
      
      @all_data = JSON.parse RestClient.get "https://api.covid19api.com/total/country/#{country}"
    end
  end

end
