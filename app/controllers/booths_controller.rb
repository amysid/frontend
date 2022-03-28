class BoothsController < ApplicationController
  before_action :logged_in?
  before_action :ensure_user_and_category_present, only: [:create, :update]
  before_action :set_booth, except: [:new, :create, :index]
  before_action :ensure_booth_present?, except: [:new, :create, :index]
  before_action :update_category_record, only: [:update]

  def index
    @booth = Booth.new
    per_page = params[:per_page] || 10
    @booths = Booth.all.order('created_at desc').paginate(page: params[:page], per_page: per_page)
  end

  def create
    @booth = Booth.new(booth_params)
    if @booth.save
      # @booth.users << @user
      @booth.categories << @categories
      redirect_to booths_path, notice: "Booth Create Successfully!"
    else
      redirect_to booths_path, alert: @booth.errors.full_messages
    end
  end

  def show
  end

  def edit
  end

  def setting
  end

  def update
    if @booth.update(booth_params)
      # @booth.users << @user
      @booth.categories << @new_categories
      redirect_to booths_path, notice: "Booth Update Successfully!"
    else
      redirect_to booths_path, alert: @booth.errors.full_messages
    end
  end

  def destroy
    if @booth.destroy
      message = t("booth_destroy_message")
      redirect_to booths_path, notice: message
    else
      redirect_to booths_path, alert: @booth.errors.full_messages
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

  def ensure_user_and_category_present
    @user = User.find_by(id:params[:booth][:user_id])
    @categories = Category.where(id: params[:booth][:category_id])
    if @categories.blank?
      redirect_to booths_path, alert: t("user_category_record_errors")
    end
  end

  def set_booth
    @booth = Booth.find_by(id: params[:id])
  end

  def ensure_booth_present?
    if @booth.blank?
      redirect_to booths_path, alert: t("booth_not_found")
    end
  end

  def update_category_record
    existing_category_id = @booth.category_ids
    category_ids_for_remove = existing_category_id - @categories.pluck(:id)
    @booth.category_ids -= category_ids_for_remove
    @new_categories = @categories.where.not(id: existing_category_id)
  end
end
