class OperationsController < ApplicationController
  before_action :logged_in?
  
  def index
    url = "#{ENV["API_BASE_URL"]}/api/operations"
    headers = {"Content-Type": "application/json", "Authorization": "Bearer #{session[:token]}"}
    response = HTTParty.get(url, headers: headers)
    response_body = JSON.parse(response.body) if response.body.present?
    if response_body.present? &&  response_body.dig("operations").dig("data").present?
      @operations =  response_body["operations"]["data"]
      @pagination_data =  response_body["operations"]["meta"]
    end
  end
end
