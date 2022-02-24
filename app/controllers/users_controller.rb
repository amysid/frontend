class UsersController < ApplicationController
  before_action :logged_in?, except: [:create]
  before_action :set_user, only: [:show, :update]
  before_action :ensure_user_present?, only: [:show, :update]
  def index
    @user = User.new
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
  end

  def create
    @user = User.new(user_params)
    if @user.save
      return redirect_to homes_path
    end
    flash[:alert] = @user.errors.full_messages
    render 'new'
  end

  def update
    if not @user.update(user_params)
      flash[:alert] = @user.errors.full_messages
    end
    return redirect_to @user
  end

  private
  
  def user_params
    params.require(:user).permit(:full_name, :mobile, :email, :gender, :role, :status, :password)
  end

  def set_user
    @user = User.where(id: params[:id])
  end

  def ensure_user_present?
    if @user.blank?
      message = t('user_not_present')
      redirect_to homes_path, alert: message
    end
  end

end
