class BoothsController < ApplicationController
  before_action :logged_in?
  before_action :ensure_user_and_category_present, only: [:create, :update]

  def index
    @booth = Booth.new
    per_page = params[:per_page] || 10
    @booths = Booth.all.order('created_at desc').paginate(page: params[:page], per_page: per_page)
  end

  def create
    @booth = Booth.new(booth_params)
    if @booth.save
      # @booth.users << @user
      @booth.categories << @category
      redirect_to booths_path, notice: "Booth Create Successfully!"
    else
      redirect_to booths_path, alert: @booth.errors.full_messages
    end
  end

  def show
    @booth = Booth.find_by(id: params[:id])
  end

  def edit
    @booth = Booth.find_by(id: params[:id])
  end

  def setting
    @booth = Booth.find_by(id: params[:id])
  end

  def update
    @booth = Booth.find_by(id: params[:id])
    if @booth.update(booth_params)
      # @booth.users << @user
      @booth.categories << @category
      redirect_to booths_path, notice: "Booth Update Successfully!"
    else
      redirect_to booths_path, alert: @booth.errors.full_messages
    end
  end

  def destroy
    @booth = Booth.find_by(id: params[:id])
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
    @category = Category.find_by(id: params[:booth][:category_id])
    if @category.blank?
      redirect_to booths_path, alert: t("user_category_record_errors")
    end
  end
end