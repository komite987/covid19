module ApplicationHelper

  def removeColony(v=[])
    v.select { |a| a['Province'] == '' && a['City'] == ''}
  end

  def doCalc(s=[],status)
    s.last[status] - s.first[status] 
  end

  def dayStatus(s=[],index,status)
    s[index][status] - s[index-1][status]
  end

  def check_country(name)
    countries = JSON.parse RestClient.get "https://api.covid19api.com/countries"
    found = countries.select { |a| a['Slug'] == name } 
    return true if found.length == 0 
  end

  def china(y=[], start_date, end_date)
    newArray = []
    start_date = Date.parse(params['start_date']).yesterday
    end_date =  Date.parse(params['end_date'])
    newElement = {}
    for date in (start_date..end_date) do
     z = y.select { |a| a['Date'].include? date.strftime('%Y-%m-%d') }
     dayCon = dayDeth = dayRec = dayAct = 0
     z.each do |total| 
       dayCon += total['Confirmed'] 
       dayDeth += total['Deaths'] 
       dayRec += total['Recovered'] 
       dayAct += total['Active']
     end
     newElement = {"Country" => "China",
      "CountryCode"=> "CN",
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

  def get_data(country, start_date,end_date)
    if country == "china"
      china((JSON.parse RestClient.get "https://api.covid19api.com/country/#{country}?from=#{start_date}T00:00:00Z&to=#{end_date}T00:00:00Z"), start_date, end_date)
    else
      JSON.parse RestClient.get "https://api.covid19api.com/country/#{country}?from=#{start_date}T00:00:00Z&to=#{end_date}T00:00:00Z"
    end
  end

  def countries_list
    countriesArray = []
    list = JSON.parse RestClient.get "https://api.covid19api.com/summary"

    list["Countries"].each do |item|
      country = item['Slug']

      countriesArray << country.gsub("-", " ").capitalize
    end
    countriesArray.sort_by { |country| country }
  end


  def chartDataTotal(s=[], status)
    dayArray = []
    s.each_with_index do |day, index|
      if index != 0 && day['Confirmed'] != 0
        # dayData = dayStatus(s,index,status)
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

end
