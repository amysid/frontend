class Web::BoothsController < Web::WebApplicationController
  before_action :set_booth, only: [:show]
  before_action :ensure_booth_present?, only: [:show]
  
  def index
    url = "#{ENV["API_BASE_URL"]}/web_api/booths"
    headers = {"Content-Type": "application/json"}
    response = HTTParty.get(url, headers: headers)
    response_body = JSON.parse(response.body) if response.body.present?
    if response_body.present? &&  response_body.dig("booths").dig("data").present?
      @booths =  response_body["booths"]["data"]
    end
  end

  def show
    url = "#{ENV["API_BASE_URL"]}/web_api/booths/#{params[:id]}/booth_cover_urls"
    headers = {"Content-Type": "application/json", "Authorization": "Bearer #{session[:token]}"}
    response = HTTParty.get(url, headers: headers)
    response_body = JSON.parse(response.body) if response.body.present?
    if response_body.present? &&  response_body.dig("data").present?
      @book_cover_urls = response_body["data"]["book_cover_urls"]
    end
  end

  private

  def set_booth
    url = "#{ENV["API_BASE_URL"]}/web_api/booths/#{params[:id]}"
    headers = {"Content-Type": "application/json", "Authorization": "Bearer #{session[:token]}"}
    response = HTTParty.get(url, headers: headers)
    response_body = JSON.parse(response.body) if response.body.present?
    if response_body.present? &&  response_body.dig("booth").dig("data").present?
      @booth = response_body["booth"]["data"]["attributes"]
    end
  end

  def ensure_booth_present?
    if @booth.blank?
      redirect_to booths_path, alert: t("booth_not_found")
    end
  end
end
