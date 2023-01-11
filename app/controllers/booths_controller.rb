class BoothsController < ApplicationController
  before_action :logged_in?
  before_action :fetch_categories, only: [:index, :edit]
  before_action :set_booth, except: [:new, :create, :index]
  before_action :ensure_booth_present?, except: [:new, :create, :index]

  def index
    url = "#{ENV["API_BASE_URL"]}/api/booths"
    headers = {"Content-Type": "application/json", "Authorization": "Bearer #{session[:token]}"}
    response = HTTParty.get(url, headers: headers)
    response_body = JSON.parse(response.body) if response.body.present?
    if response_body.present? &&  response_body.dig("booths").dig("data").present?
      @booths =  response_body["booths"]["data"]
      @pagination_data =  response_body["booths"]["meta"]
    end
  end

  def create
    url = "#{ENV["API_BASE_URL"]}/api/booths"
    headers = {headers: {"Content-Type": "application/json", "Authorization": "Bearer #{session[:token]}"},multipart: true, body: params.as_json}
    response = HTTParty.post(url, headers)
    response_body = JSON.parse(response.body) if response.body.present?
    if response_body.present? &&  response_body.dig("booth").dig("data").present?
      redirect_to booths_path
    end
  end

  def show
  end

  def edit
  end

  def setting
  end

  def update
    url = "#{ENV["API_BASE_URL"]}/api/booths/#{params[:id]}"
    headers = {headers: {"Content-Type": "application/json", "Authorization": "Bearer #{session[:token]}"},multipart: true, body: params.as_json}
    response = HTTParty.put(url, headers)
    response_body = JSON.parse(response.body) if response.body.present?
    if response_body.present? &&  response_body.dig("booth").dig("data").present?
      redirect_to booths_path
    end
  end

  def destroy
    url = "#{ENV["API_BASE_URL"]}/api/booths/#{params[:id]}"
    headers = {"Content-Type": "application/json", "Authorization": "Bearer #{session[:token]}"}
    response = HTTParty.delete(url, headers: headers)
    response_body = JSON.parse(response.body) if response.body.present?
    if response_body.present? &&  response_body["status_code"] == 200
      message = t("booth_destroy_message")
      redirect_to booths_path, notice: message
    else
      redirect_to booths_path, notice: t("something_went_wrong")
    end
  end

  private

  def booth_params
    coordinate = params[:booth][:coordinate]
    latitude = coordinate.split(",").first
    longitude = coordinate.split(",").second
    params[:booth].merge!({latitude: latitude, longitude: longitude})
    params.require(:booth).permit(:name, :city, :address, :phone_number, :latitude, :longitude, :communicate_with)
  end


  def set_booth
    url = "#{ENV["API_BASE_URL"]}/api/booths/#{params[:id]}"
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
