class SearchesController < ApplicationController

  def home
  end

  def new
  end

  def show

    if params['country'].blank?
      e = Errors::BadRequest.new("Country can't be blank")
      ErrorSerializer.new(e)
      flash.now[:error] = "#{e.detail}"
      render 'new' , status: e.status and return 
    elsif unfoundCountry(params['country'].gsub(" ", "-").downcase)
      e = Errors::NotFound.new("Country not found")
      ErrorSerializer.new(e)
      flash.now[:error] = "#{e.detail}"
      render 'new' , status: e.status and return 
    else
      country = params['country'].gsub(" ", "-").downcase
    end


    if params['start_date'].blank?
      start_date = "2020-01-22"
    elsif !params['start_date'].blank? && !valid_date?(params['start_date']) 
      e = Errors::BadRequest.new("Start Date invalid")
      ErrorSerializer.new(e)
      flash.now[:error] = "#{e.detail}"
      render 'new' , status: e.status and return 
    else
      start_date = Date.parse(params['start_date']).yesterday.to_s
    end 

    if params['end_date'].blank? 
      end_date =  DateTime.yesterday.strftime("%Y-%m-%d")
    elsif !params['end_date'].blank? && !valid_date?(params['end_date'])
      e = Errors::BadRequest.new("End Date invalid")
      ErrorSerializer.new(e)
      flash.now[:error] = "#{e.detail}"
      render 'new' , status: e.status and return 
    else
     end_date =  Date.parse(params['end_date']).to_s
    end

    if Date.parse(end_date) < Date.parse(start_date) 
      e = Errors::BadRequest.new("Start date is newer than end date")
      ErrorSerializer.new(e)
      flash.now[:error] = "#{e.detail}"
      render 'new' , status: e.status and return 
    else
     @response = getData(country, start_date, end_date)
    end
  end

end
