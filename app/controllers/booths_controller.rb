class BoothsController < ApplicationController
  before_action :logged_in?
  def index
    @booth = Booth.new
    @booths = Booth.all
  end

  def create
    @booth = Booth.new(booth_params)
    if @booth.save
      redirect_to booths_path, notice: "Booth Create Successfully!"
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
    params.require(:booth).permit(:name, :city, :address, :phone_number, :latitude, :longitude)
  end
end
