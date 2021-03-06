class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!
  include ApplicationHelper
  include DeviseWhitelist
  require 'restcountry'


end
