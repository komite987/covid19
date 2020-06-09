class SearchesController < ApplicationController
  include ApplicationHelper
  def new
  end

  def show
    country = params['country'].gsub(" ", "-").downcase
    start_date = Date.parse(params['start_date']).yesterday.strftime('%Y-%m-%d')
    end_date =  Date.parse(params['end_date']).strftime('%Y-%m-%d')

    if country == "" || ( Date.parse(end_date) < Date.parse(start_date) ) || check_country(country)
      render 'new'

    elsif country == "china"
      json =  JSON.parse RestClient.get "https://api.covid19api.com/country/#{country}?from=#{start_date}T00:00:00Z&to=#{end_date}T00:00:00Z"
      @json = china(json, start_date ,end_date)

      @all_data = JSON.parse RestClient.get "https://api.covid19api.com/total/country/#{country}"

    else
      @json = JSON.parse RestClient.get "https://api.covid19api.com/country/#{country}?from=#{start_date}T00:00:00Z&to=#{end_date}T00:00:00Z" 
      @all_data = JSON.parse RestClient.get "https://api.covid19api.com/total/country/#{country}"
    end
  end

end
