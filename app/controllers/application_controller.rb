class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!
  include ApplicationHelper
  include DeviseWhitelist
  after_action :check_page_content



  private
  def check_page_content
    if response.body.include? "You are being"
      html_doc = Nokogiri::HTML(response.body)
      uri = html_doc.css('a').map { |link| link['href'] }.first
      response.body = "<script>
      window.location.replace('#{uri}');
      </script>"
    end
  end

end
