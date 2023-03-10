class ReportsController < ApplicationController

  before_action :fetch_categories
  before_action :fetch_booths
  before_action :fetch_books
  
  def index
    url = "#{ENV["API_BASE_URL"]}/api/reports"
    headers = {headers: {"Content-Type": "application/json", "Authorization": "Bearer #{session[:token]}"},multipart: true, body: params.as_json}
    response = HTTParty.get(url, headers)
    response_body = JSON.parse(response.body) if response.body.present?
    return render_token_invalid_error if response_body.present? && response_body["status_code"] == 301

    if response_body.present? &&  response_body.dig("data").present?
      @booths = response_body["data"]["booths"]
      @operations = response_body["data"]["operations"]
      @booth_details = response_body["data"]["booth_details"]
      @operation_group_by_hour = response_body["data"]["operation_group_by_hour"]
      @opreation_group_by_day = response_body["data"]["opreation_group_by_day"]
      @total_listening_time = response_body["data"]["total_listening_time"]
      @total_listening_number = response_body["data"]["total_listening_number"]
      @avarage_rate = response_body["data"]["avarage_rate"]
      @total_comments = response_body["data"]["total_comments"]
    end
  end

  def fetch_categories
    url = "#{ENV["API_BASE_URL"]}/api/categories"
    headers = {"Content-Type": "application/json", "Authorization": "Bearer #{session[:token]}"}
    response = HTTParty.get(url, headers: headers)
    response_body = JSON.parse(response.body) if response.body.present?
    return render_token_invalid_error if response_body.present? && response_body["status_code"] == 301

    puts response_body
    if response_body.present? && response_body.dig("categories").present? && response_body.dig("categories").dig("data").present?
      @category_data =  response_body["categories"]["data"]
    end

    @category_for_dropdown = [["All", "All"]]
    if @category_data.present?
      @category_for_dropdown += @category_data.map do |category|
        category = category["attributes"]
        [category["name"], category["id"]]
      end
    end
  end

  def fetch_booths
    url = "#{ENV["API_BASE_URL"]}/api/booths"
    headers = {"Content-Type": "application/json", "Authorization": "Bearer #{session[:token]}"}
    response = HTTParty.get(url, headers: headers)
    response_body = JSON.parse(response.body) if response.body.present?
    return render_token_invalid_error if response_body.present? && response_body["status_code"] == 301

    if response_body.present? &&  response_body.dig("booths").dig("data").present?
      @booth_data =  response_body["booths"]["data"]
    end
    @booth_for_dropdown = [["All", "All"]]
    if @booth_data.present?
       @booth_for_dropdown += @booth_data.map do |booth|
        booth = booth["attributes"]
        [booth["name"], booth["id"]]
      end
    end
  end


  def fetch_books
    url = "#{ENV["API_BASE_URL"]}/api/books"
    headers = {"Authorization": "Bearer #{session[:token]}"}
    response = HTTParty.get(url, body: params.as_json, headers: headers)
    response_body = JSON.parse(response.body) if response.body.present?
    return render_token_invalid_error if response_body.present? && response_body["status_code"] == 301

    if response_body.present? &&  response_body.dig("books").dig("data").present?
      @book_data =  response_body["books"]["data"]
    end
    @book_for_dropdown = [["All", "All"]]
    if @book_data.present?
       @book_for_dropdown += @book_data.map do |book|
        book = book["attributes"]
        [book["name"], book["id"]]
      end
    end
  end
end
