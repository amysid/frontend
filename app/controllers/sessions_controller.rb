class SessionsController < ApplicationController
	before_action :logged_in?, only: [:destroy]
  before_action :logged_out?, only: [:new, :create]
  def new
  	@user = User.new
  end

  def create
      @user = User.find_by(email: params[:email])
      if !!@user && @user.authenticate(params[:password])
        @user.update(last_login_at: Time.now)
      	session[:user_id] = @user.id
        redirect_to homes_path
      else
      	massage = "Something went wrong"
      	redirect_to root_path, notice: massage
      end
  end

  def show
  	@user = User.find(params[:id])
  end

  def destroy
	session[:user_id] = nil
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
    @user.update(last_login_at: Time.now)
    session[:user_id] = @user.id
  end

  def logged_out?
    redirect_to homes_path if current_user.present?
  end

end
