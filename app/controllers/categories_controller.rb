class CategoriesController < ApplicationController
  before_action :logged_in?
  before_action :set_category, except: [:index, :create]
  before_action :ensure_category_present?, except: [:index, :create]
  before_action :validate_files, only: [:create, :update]
  before_action :validate_files_using_magic_number, only: [:create, :update]
  include Rails.application.routes.url_helpers

  def index
    url = "#{ENV["API_BASE_URL"]}/api/categories"
    headers = {"Authorization": "Bearer #{session[:token]}"}
    response = HTTParty.get(url, headers: headers, body: params.as_json)
    response_body = JSON.parse(response.body) if response.body.present?
    
    if response_body.present? && response_body.dig("categories").present? && response_body.dig("categories").dig("data").present?
      @categories =  response_body["categories"]["data"]
      @pagination_data =  response_body["categories"]["meta"]
    end
  end

  # def create
  #     @store = Store.new({
  #     model_type: "Category",
  #     name: params[:category][:name],
  #     icon: params[:category][:icon],
  #     white_icon: params[:category][:white_icon]
  #     })
  #   @store.save
  #   url = "#{ENV["API_BASE_URL"]}/api/categories"
  #   data = {}
  #   data["category"] = {}
  #   if params["category"].present?
  #     data["category"] = params.require("category").permit(:name, :arabic_name, :french_name)
  #     data["category"]["dark"] = rails_blob_path(@store.icon, only_path: true) if params["category"]["icon"].present?
  #     data["category"]["white"] = rails_blob_path(@store.white_icon, only_path: true) if params["category"]["white_icon"].present?
  #     data["category"]["icon"] = File.open(params["category"]["icon"].tempfile.path) if params["category"]["icon"].present?
  #     data["category"]["white_icon"] = File.open(params["category"]["white_icon"].tempfile.path) if params["category"]["white_icon"].present?
  #   end
  #   headers = {headers: {"Content-Type": "application/json", "Authorization": "Bearer #{session[:token]}"},multipart: true, body: data}
  #   response = HTTParty.post(url, headers)
  #   response_body = JSON.parse(response.body) if response.body.present?
  #   @store.update(ref_id: response_body["category"]["data"]["id"].to_i)
  #   if response_body.present? &&  response_body.dig("category").dig("data").present?
  #     redirect_to categories_path
  #   end
  # end

  def create
    url = "#{ENV["API_BASE_URL"]}/api/categories"
    data = {}
    data["category"] = {}
    if params["category"].present?
      data["category"] = params.require("category").permit(:name, :arabic_name, :french_name)
      data["category"]["dark"] = upload_file_path_for(params["category"]["icon"]) if params["category"]["icon"].present?
      data["category"]["white"] = upload_file_path_for(params["category"]["white_icon"]) if params["category"]["white_icon"].present?
      data["category"]["icon"] = File.open(params["category"]["icon"].tempfile.path) if params["category"]["icon"].present?
      data["category"]["white_icon"] = File.open(params["category"]["white_icon"].tempfile.path) if params["category"]["white_icon"].present?
    end
    headers = {headers: {"Content-Type": "application/json", "Authorization": "Bearer #{session[:token]}"},multipart: true, body: data}
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
    data = {}
    data["category"] = {}
    if params["category"].present?
      data["category"] =  params.require("category").permit(:name, :arabic_name, :french_name)
      data["category"]["dark"] = upload_file_path_for(params["category"]["icon"]) if  params["category"]["icon"].present?
      data["category"]["white"] = upload_file_path_for(params["category"]["white_icon"]) if  params["category"]["white_icon"].present?
      data["category"]["icon"] = File.open(params["category"]["icon"].tempfile.path) if  params["category"]["icon"].present?
      data["category"]["white_icon"] = File.open(params["category"]["white_icon"].tempfile.path) if  params["category"]["white_icon"].present?
    end
    headers = {headers: {"Content-Type": "multipart/form-data", "Authorization": "Bearer #{session[:token]}"}, multipart: true, body: data}
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
    params.require(:category).permit(:name, :arabic_name, :french_name, :icon, :white_icon)
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

  def validate_files
    status = true
    if params["category"]["icon"].present?
      icon_extention = params["category"]["icon"].original_filename.split(".").last
      status = status && ['gif','png','jpg','jpeg'].include?(icon_extention)
    end
    if params["category"]["white_icon"].present?
      white_icon_extention = params["category"]["white_icon"].original_filename.split(".").last
      status = status && ["mp3"].include?(white_icon_extention)
    end
    return true if status
    redirect_to categories_path, notice: t("File are not valid!")
  end

  def validate_files_using_magic_number
    status = true
    if params["category"]["icon"].present?
      status = status && MagicNumber.is_real?(params["category"]["icon"].tempfile.path)
    end
    if params["category"]["white_icon"].present?
      status = status && MagicNumber.is_real?(params["category"]["white_icon"].tempfile.path)
    end
    return true if status

    redirect_to categories_path, notice: t("dsds File are not valid!") 
  end

  def upload_file_path_for(file, folder_name="assets/images/category/")
    return if file.blank?
    dir = Rails.root.join(folder_name)
    byebug
    Dir.mkdir(dir) unless Dir.exist?(dir)
    begin
      filename = file.original_filename
      path = dir.join(file.original_filename)
      File.open(path, 'wb') do |f|
        f.write(file.read)
      end
      return folder_name + filename
    rescue
      return nil
    end
  end
end
