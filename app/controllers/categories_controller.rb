class CategoriesController < ApplicationController
  before_action :logged_in?
  before_action :set_category, except: [:index, :create]
  before_action :ensure_category_present?, except: [:index, :create]

  def index
    url = "#{ENV["API_BASE_URL"]}/api/categories"
    headers = {"Content-Type": "application/json", "Authorization": "Bearer #{session[:token]}"}
    response = HTTParty.get(url, headers: headers)
    response_body = JSON.parse(response.body) if response.body.present?
    puts response_body
    if response_body.present? && response_body.dig("categories").present? && response_body.dig("categories").dig("data").present?
      @categories =  response_body["categories"]["data"]
    end
  end

  def create
    url = "#{ENV["API_BASE_URL"]}/api/categories"
    headers = {headers: {"Content-Type": "application/json", "Authorization": "Bearer #{session[:token]}"},multipart: true, body: params}
    response = HTTParty.post(url, headers)
    response_body = JSON.parse(response.body) if response.body.present?
    if response_body.present? &&  response_body.dig("category").dig("data").present?
      redirect_to categories_path
    end
  end

  def show
  end

  def edit
  end

  def setting
  end

  def update
    url = "#{ENV["API_BASE_URL"]}/api/categories/#{params[:id]}"
    headers = {headers: {"Content-Type": "multipart/form-data", "Authorization": "Bearer #{session[:token]}"},multipart: true, body: params.as_json}
    response = HTTParty.put(url, headers)
    response_body = JSON.parse(response.body) if response.body.present?
    if response_body.present? &&  response_body.dig("category").dig("data").present?
      redirect_to categories_path
    end
  end

  def destroy
    url = "#{ENV["API_BASE_URL"]}/api/categories/#{params[:id]}"
    headers = {"Content-Type": "application/json", "Authorization": "Bearer #{session[:token]}"}
    response = HTTParty.delete(url, headers: headers)
    response_body = JSON.parse(response.body) if response.body.present?
    if response_body.present? &&  response_body["status_code"] == 200
      message = t("category_destroy_message")
      redirect_to categories_path, notice: message
    else
      redirect_to categories_path, notice: t("something_went_wrong")
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :arabic_name, :icon, :white_icon)
  end

  def set_category
    url = "#{ENV["API_BASE_URL"]}/api/categories/#{params[:id]}"
    headers = {"Content-Type": "application/json", "Authorization": "Bearer #{session[:token]}"}
    response = HTTParty.get(url, headers: headers)
    response_body = JSON.parse(response.body) if response.body.present?
    if response_body.present? &&  response_body.dig("category").dig("data").present?
      @category = response_body["category"]["data"]["attributes"]
    end
  end

  def ensure_category_present?
    if @category.blank?
      message = t('category_not_present')
      redirect_to categories_path, alert: message
    end
  end
end
