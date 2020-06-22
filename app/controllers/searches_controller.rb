require 'Errors'
class SearchesController < ApplicationController
  include ApplicationHelper

  def home

  end
  def new
  end

  def show


    if params['country'].blank?
      e = Errors::BadRequest.new("Country can't be blank", source: {file:__FILE__, method: __method__, line: __LINE__ })
      Rails.logger.error e.message
      render json: e.message and return 

    elsif unfoundCountry(params['country'].gsub(" ", "-").downcase)
      e = Errors::PageNotFound.new("No country found", source: {file:__FILE__, method: __method__, line: __LINE__ })
      render json: e.message and return 



    elsif !valid_date?(params['start_date']) 
      e = Errors::BadRequest.new("Start date incorrect", source: {file:__FILE__, method: __method__, line: __LINE__ })
      render json: e.message and return 

    elsif !valid_date?(params['end_date'])
      e = Errors::BadRequest.new("End date incorrect", source: {file:__FILE__, method: __method__, line: __LINE__ })
      render json: e.message and return 

    elsif Date.parse(params['end_date']) < Date.parse(params['start_date']) 
      e = Errors::BadRequest.new("End Date must be bigger than start date", source: {file:__FILE__, method: __method__, line: __LINE__ })
      render json: e.message and return 



    else
      country = params['country'].gsub(" ", "-").downcase

      start_date = Date.parse(params['start_date']).yesterday.to_s
      end_date =  Date.parse(params['end_date']).to_s

      @response = getData(country, start_date, end_date)
    end
  end

end
