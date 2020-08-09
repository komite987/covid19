class SearchesController < ApplicationController
  skip_before_action :authenticate_user!, except:[:show, :new]

  def home
  end

  def new
    @world_stats = parse('https://api.covid19api.com/summary')
  end

  def show

    if params['country'].blank?
      e = Errors::BadRequest.new("Country can't be blank")
      Rails.logger.error e.detail
      ErrorSerializer.new(e)
      flash.now[:error] = "#{e.detail}"
      render 'new' , status: e.status and return 
    elsif unfoundCountry(params['country'].gsub(" ", "-").downcase)
      e = Errors::NotFound.new("Country not found")
      Rails.logger.error e.detail
      ErrorSerializer.new(e)
      flash.now[:error] = "#{e.detail}"
      render 'new' , status: e.status and return 
    else
      country = params['country'].gsub(" ", "-").downcase
    end


    if params['start_date'].blank?
      Rails.logger.warn "Start at 22-1-2020 if params is blank"
      start_date = "2020-01-22"
    elsif !params['start_date'].blank? && !valid_date?(params['start_date'])
      Rails.logger.error e.detail
      e = Errors::BadRequest.new("Start Date invalid")
      ErrorSerializer.new(e)
      flash.now[:error] = "#{e.detail}"
      render 'new' , status: e.status and return 
    else
      start_date = Date.parse(params['start_date']).yesterday.to_s
    end 

    if params['end_date'].blank? 
      Rails.logger.warn "End at yesterday if params is blank"
      end_date =  DateTime.yesterday.strftime("%Y-%m-%d")
    elsif !params['end_date'].blank? && !valid_date?(params['end_date'])
      Rails.logger.error e.detail
      e = Errors::BadRequest.new("End Date invalid")
      ErrorSerializer.new(e)
      flash.now[:error] = "#{e.detail}"
      render 'new' , status: e.status and return 
    else
      end_date =  Date.parse(params['end_date']).to_s
    end

    if Date.parse(end_date) < Date.parse(start_date) 
      e = Errors::BadRequest.new("Start date is newer than end date")
      Rails.logger.error e.detail
      ErrorSerializer.new(e)
      flash.now[:error] = "#{e.detail}"
      render 'new' , status: e.status and return 
    else
      @response = getData(country, start_date, end_date)
      if !@response.is_a?(Array)
        e = Errors::StandardError.new(detail: "External Api error")
        Rails.logger.error e.detail
        ErrorSerializer.new(e)
        flash.now[:error] = "#{e.detail}"
        render 'new' , status: e.status and return 
      end
    end
    # render json: params
  end

end
