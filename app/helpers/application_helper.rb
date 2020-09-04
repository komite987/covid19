module ApplicationHelper

  def parse(url)
    JSON.parse(RestClient.get(url))
  end

  def removeColony(v=[])
    v.select { |a| a['Province'] == '' && a['City'] == ''}
  end

  def periodStatus(s=[],status)
    s.last[status] - s.first[status]
  end

  def dayStatus(s=[],index,status)
    s[index][status] - s[index-1][status]
  end

  def unfoundCountry(name)
    countries = parse(Rails.configuration.country_check)
    found = countries.select { |a| a['Slug'] == name }
    return true if found.length == 0 
  end

  def irrigularStatus(country,y=[],start_date,end_date)
    newArray = []
    startDate = Date.parse(start_date)
    endDate =  Date.parse(end_date)
    newElement = {}
    for date in (startDate..endDate) do
     z = y.select { |a| a['Date'].include? date.strftime('%Y-%m-%d') }
     dayCon = dayDeth = dayRec = dayAct = 0
     z.each do |total| 
       dayCon += total['Confirmed'] 
       dayDeth += total['Deaths'] 
       dayRec += total['Recovered'] 
       dayAct += total['Active']
     end
     newElement = {"Country" => country,
      "CountryCode"=> "",
      "Province"=> "",
      "City"=> "",
      "CityCode"=> "",
      "Confirmed"=> dayCon,
      "Deaths"=> dayDeth,
      "Recovered"=> dayRec,
      "Active"=> dayAct,
      "Date"=> "#{date}T00:00:00Z" }
      newArray << newElement
    end
    newArray 
  end

  def getData(country, start_date,end_date)
    @countryAllstats = parse("#{Rails.configuration.country_all_data}#{country}")
    # if country == "china" || country =="australia" || country =="canada"
    if ['china', 'australia', 'canada'].include? country
      irrigularStatus(country, (parse "https://api.covid19api.com/country/#{country}?from=#{start_date}T00:00:00Z&to=#{end_date}T00:00:00Z"),start_date,end_date)
    else
      parse "https://api.covid19api.com/country/#{country}?from=#{start_date}T00:00:00Z&to=#{end_date}T00:00:00Z"
    end
  end

  def countries_list
    begin
      countriesArray = []
      list = parse(Rails.configuration.country_list)
      list["Countries"].each do |item|
        country = item['Slug']
        countriesArray << country.gsub("-", " ").capitalize
      end
      countriesArray.sort_by { |country| country }
    rescue Exception => e
      e  = ["External api error"]
    end
  end

  def get_currency(country)
    if country == "korea-south"
      country = "Korea (Republic of)"
    else
      country
    end
    begin
      currency = Restcountry::Country.find_by_name("#{country}".gsub('-', ' ')).currencies[0]['code']

    rescue Exception => e
      currency = "Not found"
    end
    currency
  end

  def get_symbol(country)
    if country == "korea-south"
      country = "Korea (Republic of)"
    else
      country
    end
    begin
      symbol = Restcountry::Country.find_by_name("#{country}".gsub('-', ' ')).currencies[0]['symbol']
    rescue Exception => e
      symbol = "Not found"
    end
    symbol
  end

  def sort_currency_rate(s={})
    s.sort_by { |date| Date.parse(date.first) }
  end

  def currencyChartData(s={}, currency)
    currencyArray = []
    s.each do |x|
      rate = x[1][currency]
      currencyArray << rate
    end
    currencyArray
  end

  def currencyChartDate(s={})
    currencyDates = []
    s.each do |x|
      date = x.first
      currencyDates << date
    end
    currencyDates
  end

  # def currencyPairs(s=[], v=[])
  #   pairs = []
  #   (0...s.length).each do |i|
  #     item = [v[i], s[i]]
  #     pairs << item
  #   end
  #   pairs
  # end



  def chartDataTotal(s=[], status)
    dayArray = []
    s.each_with_index do |day, index|
      if index != 0 && day['Confirmed'] != 0
        dayData = day[status]
        dayArray << dayData
      end
    end
    dayArray
  end 

  def chartDataDaily(s=[], status)
    dayArray = []
    s.each_with_index do |day, index|
      if index != 0 && day['Confirmed'] != 0
        dayData = dayStatus(s,index,status)
        dayArray << dayData
      end
    end
    dayArray
  end

  def chartDataDate(s=[])
    dayRange = []
    s.each_with_index do |day, index|
      if index != 0 && day['Confirmed'] != 0
        dayDate = day['Date'].gsub("T00:00:00Z", "")
        dayRange << dayDate
      end
    end
    Date.parse(dayRange.first).prev_month.strftime('%Y,%m,%d') if dayRange.length > 0
  end 

  def bootstrap_class_for flash_type
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }.stringify_keys[flash_type.to_s] || flash_type.to_s
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "fade alert #{bootstrap_class_for(msg_type)}", role: "alert") do 
        concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
        concat message 
      end)
    end
    nil
  end

  def valid_date?(date)
    Date.parse date rescue false
  end

  def total_stats(s=[], stat)
    s.sort_by { |item| item[stat] }.reverse   
  end

  def fix_number(num)
    number_with_precision(num, :precision => 0, :delimiter => ',')      
  end
end




    # currencyCode = Restcountry::Country.find_by_name(params['country']).currencies[0]['code'] if Restcountry::Country.find_by_name(params['country'])
    # @currencyExchange = JSON.parse RestClient.get "https://api.exchangeratesapi.io/history?start_at=#{params['start_date']}&end_at=#{end_date}&symbols=#{currencyCode}&base=USD"
