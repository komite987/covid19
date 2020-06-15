class SearchesController < ApplicationController
  include ApplicationHelper

  def home
    
  end
  def new
  end

  def show
    country = params['country'].gsub(" ", "-").downcase
    start_date = Date.parse(params['start_date']).yesterday.strftime('%Y-%m-%d')
    end_date =  params['end_date']


    if country == "" || ( Date.parse(end_date) < Date.parse(start_date) ) || check_country(country)
      flash.now[:error] = "You Entered invalid info"
      render 'new'
    else
      @response = getData(country, start_date,end_date)

    end
  end

end
