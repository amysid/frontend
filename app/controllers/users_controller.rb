class UsersController < ApplicationController
  before_action :logged_in?, except: [:create]
  before_action :set_user, except: [:index, :create]
  before_action :ensure_user_present?, except: [:index, :create]
  
  def index
    url = "#{ENV["API_BASE_URL"]}/api/users"
    headers = {"Content-Type": "application/json", "Authorization": "Bearer #{session[:token]}"}
    response = HTTParty.get(url, headers: headers)
    response_body = JSON.parse(response.body) if response.body.present?
    return render_token_invalid_error if response_body.present? && response_body["status_code"] == 301
    
    if response_body.present? &&  response_body.dig("users").dig("data").present?
      @users =  response_body["users"]["data"]
      @pagination_data =  response_body["users"]["meta"]
    end
      
    #per_page = params[:per_page] || 10
    #@users = User.all.order('created_at desc').paginate(page: params[:page], per_page: per_page)
  end

  def new
    @user = User.new
  end

  def show
    # @user = User.find_by(id: params[:id])
  end

  def edit
    # @user = User.find_by(id: params[:id])
  end

  def setting
    # @user = User.find_by(id: params[:id])
  end

  def create
    url = "#{ENV["API_BASE_URL"]}/api/users"
    headers = {headers: {"Content-Type": "application/json", "Authorization": "Bearer #{session[:token]}"},multipart: true, body: params.as_json}
    response = HTTParty.post(url, headers)
    response_body = JSON.parse(response.body) if response.body.present?
    return render_token_invalid_error if response_body.present? && response_body["status_code"] == 301
    
    if response_body.present? &&  response_body.dig("user").dig("data").present?
      redirect_to users_path
    end
  end

  def change_status
    @user = User.find_by(id: params[:id])
    status = @user.status == "Active" ? "Blocked" : "Active"
    @user.update(status: status)
    message = "User updated successfully!"
    redirect_to users_path, notice: message
  end

  def update
    url = "#{ENV["API_BASE_URL"]}/api/users/#{params[:id]}"
    headers = {headers: {"Content-Type": "application/json", "Authorization": "Bearer #{session[:token]}"},multipart: true, body: params.as_json}
    response = HTTParty.put(url, headers)
    response_body = JSON.parse(response.body) if response.body.present?
    return render_token_invalid_error if response_body.present? && response_body["status_code"] == 301
    
    if response_body.present? &&  response_body.dig("user").dig("data").present?
      redirect_to users_path
    end
  end

  def destroy
    url = "#{ENV["API_BASE_URL"]}/api/users/#{params[:id]}"
    headers = {"Content-Type": "application/json", "Authorization": "Bearer #{session[:token]}"}
    response = HTTParty.delete(url, headers: headers)
    response_body = JSON.parse(response.body) if response.body.present?
    return render_token_invalid_error if response_body.present? && response_body["status_code"] == 301
    
    if response_body.present? &&  response_body["status_code"] == 200
      message = t("user_destroy_message")
      redirect_to categories_path, notice: message
    else
      redirect_to categories_path, notice: t("something_went_wrong")
    end
  end

  private
  
  def user_params
    params.require(:user).permit(:full_name, :mobile, :email, :gender, :role)
  end

  def set_user
    url = "#{ENV["API_BASE_URL"]}/api/users/#{params[:id]}"
    headers = {"Content-Type": "application/json", "Authorization": "Bearer #{session[:token]}"}
    response = HTTParty.get(url, headers: headers)
    response_body = JSON.parse(response.body) if response.body.present?
    return render_token_invalid_error if response_body.present? && response_body["status_code"] == 301
    
    if response_body.present? &&  response_body.dig("user").dig("data").present?
      @user = response_body["user"]["data"]["attributes"]
    end
  end

  def ensure_user_present?
    if @user.blank?
      message = t('user_not_present')
      redirect_to users_path, alert: message
    end
  end

end
