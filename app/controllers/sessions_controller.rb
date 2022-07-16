class SessionsController < ApplicationController
	before_action :logged_in?, only: [:destroy]
  before_action :logged_out?, only: [:new, :create]
 
  def new
  end

  def create
    url = "#{ENV["API_BASE_URL"]}/api/login"
    headers = {"Content-Type": "application/json", multipart: true, body: params.as_json}
    response = HTTParty.post(url, headers)
    response_body = JSON.parse(response.body) if response.body.present?
    if response_body.present? && response_body.dig("token").present?
      session[:user] = response_body.as_json(except: ["token"])
      session[:token] = response_body.dig("token") 
      redirect_to homes_path
    else
      massage = "Something went wrong"
      redirect_to root_path, notice: massage
    end
  end

  def show
  	# @user = User.find(params[:id])
  end

  def destroy
  	session[:user] = nil
    sessions[:token] = nil
  	flash[:success] = t('logout_successfull')
    redirect_to root_path
  end
  
  def change_password
    if params[:auth_token].present?
      @user = User.find_by(verificatin_link: params[:auth_token])
      if @user
        if params[:user].present? && params[:user][:password].present? && params[:user][:confirm_password].present?
          @user.update(verificatin_link: "",password: params[:user][:password])
          login
          # flash[:notice] = ["تم "]
          redirect_to root_path
        end
      else
        flash[:alert] = ["Invalid link."]
        redirect_to login_path
      end
    else
      flash[:alert] = ["Invalid request."]
      redirect_to login_path
    end
  end

  private
  
  def login
    @user.update(last_login_at: Time.now, status: "Active")
    session[:user_id] = @user.id
  end

  def logged_out?
    redirect_to homes_path if current_user.present?
  end

end
