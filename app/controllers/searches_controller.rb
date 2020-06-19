class SearchesController < ApplicationController
  include ApplicationHelper

  def home

  end
  def new
  end

  def show


    if params['country'].blank?
      flash.now[:error] = "Country name can't be blank"
      render 'new'


    elsif !valid_date?(params['start_date']) 
      flash.now[:error] = "Start date is invalid"
      render 'new'

    elsif !valid_date?(params['end_date'])
      flash.now[:error] = "End date is invalid"
      render 'new'

    elsif Date.parse(params['end_date']) < Date.parse(params['start_date']) 
        flash.now[:error] = "Start date is bigger than end date"

    elsif unfoundCountry(params['country'].downcase)
      flash.now[:error] = "There is no country found"
      render 'new'


    else
      country = params['country'].gsub(" ", "-").downcase
      start_date = Date.parse(params['start_date']).yesterday.to_s
      end_date =  Date.parse(params['end_date']).to_s

      @response = getData(country, start_date,end_date)
    end
  end

end
