class UsersController < ApplicationController
  before_action :logged_in?, except: [:create]
  before_action :set_user, only: [:show, :update]
  before_action :ensure_user_present?, only: [:show, :update]
  def index
    @user = User.new
    per_page = params[:per_page] || 10
    @users = User.all.order('created_at desc').paginate(page: params[:page], per_page: per_page)
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def setting
    @user = User.find_by(id: params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      return redirect_to users_path
    end
    flash[:alert] = @user.errors.full_messages
    return redirect_to users_path
  end

  def change_status
    @user = User.find_by(id: params[:id])
    status = @user.status == "Active" ? "Blocked" : "Active"
    @user.update(status: status)
    message = "User updated successfully!"
    redirect_to users_path, notice: message
  end

  def update
    if not @user.update(user_params)
      flash[:alert] = @user.errors.full_messages
    end
    message = "User updated successfully!"
    return redirect_to users_path, notice: message
  end

  def destroy
    @user = User.find_by(id: params[:id])
    if @user.destroy
      message = t("user_destroy_message")
      redirect_to users_path, notice: message
    else
      redirect_to users_path, alert: @user.errors.full_messages
    end
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
      redirect_to users_path, alert: message
    end
  end

end
