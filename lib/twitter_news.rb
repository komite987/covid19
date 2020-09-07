class TwitterNews
  def self.twitter_search
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['CONSUMER_KEY']
      config.consumer_secret     = ENV['CONSUMER_SECRET']
      config.access_token        = ENV['ACCESS_TOKEN']
      config.access_token_secret = ENV['ACCESS_SECRET']
    end

    client.search("#covid19" , lang: "en" ,result_type: "recent").take(10).collect do |tweet|
      "<b class = 'tweet'>#{tweet.user.screen_name}</b>: #{tweet.full_text}"
    end

  end
end