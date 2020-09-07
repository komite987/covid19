class SearchesController < ApplicationController
  skip_before_action :authenticate_user!, except:[:show, :new, :news]

  def home
    begin
      @world_stats = parse("https://api.covid19api.com/summary")
      @top_confirmed = total_stats(@world_stats["Countries"], "TotalConfirmed").first(5)
      @top_death = total_stats(@world_stats["Countries"], "TotalDeaths").first(5)
    rescue Exception => e
      e = Errors::StandardError.new(detail: "External Api error")
      ErrorSerializer.new(e)
      Rails.logger.error e.detail
      render 'errors/internal_error'
    end
  end

  def new
  end

  def news
    @tweets = TwitterNews.twitter_search
  end

  def about
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
      e = Errors::BadRequest.new("Start Date invalid")
      Rails.logger.error e.detail
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
      e = Errors::BadRequest.new("End Date invalid")
      Rails.logger.error e.detail
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
      begin
        @response = getData(country, start_date, end_date)
        @currency = get_currency(country)
        currency_start_date = (Date.parse(start_date).tomorrow).strftime('%Y-%m-%d')
        @symbol = get_symbol(country)
        begin
          @currencyExchange = JSON.parse RestClient.get "https://api.exchangeratesapi.io/history?start_at=#{currency_start_date}&end_at=#{end_date}&symbols=#{@currency}&base=USD" 
        rescue Exception => e
          @currency = "No exchange info for this country"
        end
      rescue Exception => e
        e = Errors::StandardError.new(detail: "External Api error")
        ErrorSerializer.new(e)
        Rails.logger.error e.detail
        render 'errors/internal_error'
      end
    end
  end

end

  #   render json: 
